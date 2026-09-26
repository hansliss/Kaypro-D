; D.COM reconstructed NASM source
; Kaypro MS-DOS directory utility, recovered from the supplied D.COM image.
; This source was built by comparing ndisasm/objdump output with the bytes,
; tracing the executable in a DOS/BIOS simulation harness, and preserving any
; uncertain or assembler-dependent encoding as raw bytes.
; Every build is checked byte-for-byte against reference/D.COM.

bits 16
org 0x100

; Non-emitting constants used by the reconstructed code.
DOS_TERMINATE equ 0x00
DOS_SET_INTERRUPT_VECTOR equ 0x25
DOS_GET_CURRENT_DRIVE equ 0x19
DOS_GET_DTA equ 0x2F
DOS_CTRL_BREAK equ 0x33
DOS_CTRL_BREAK_GET equ 0x00
DOS_CTRL_BREAK_SET equ 0x01
DOS_GET_CURRENT_DIRECTORY equ 0x47
DOS_GET_FILE_ATTRIBUTES equ 0x43
DOS_SET_DTA equ 0x1A
DOS_FIND_FIRST equ 0x4E
DOS_FIND_NEXT equ 0x4F
DOS_GET_FREE_SPACE equ 0x36
DOS_DIRECT_CONSOLE_INPUT equ 0x07

BIOS_READ_CHAR_ATTRIBUTE equ 0x08
BIOS_SCROLL_UP equ 0x06
BIOS_SET_CURSOR equ 0x02
BIOS_TTY_OUTPUT equ 0x0E

PSP_MEMORY_LIMIT equ 0x0006
PSP_DEFAULT_FCB_DRIVE equ 0x005C
PSP_COMMAND_TAIL_LENGTH equ 0x0080
PSP_COMMAND_TAIL_TEXT equ 0x0081
RECORD_STORAGE equ 0x0DDB

; Entry and initialized data.
entry:
    jmp main_initialize_and_dispatch    ; original bytes E9 EF 05, target load offset 06F2h
initial_line_break_marker:
    db 0x0D, 0x8A    ; load 0103h-0104h
subdir_text:
    db "< sub-dir >"    ; load 0105h-010Fh
bad_path_name_prefix:
    db 0x0D, 0x0A, "Bad Path Name !", 0x0D, 0x8A ; load 0110h-0122h
file_not_found_prefix:
    db 0x0D, 0x0A, "File not Found.", 0x0D, 0x8A ; load 0123h-0135h
path_not_found_prefix:
    db 0x0D, 0x0A, "Path not found.", 0x0D, 0x8A ; load 0136h-0148h
too_many_open_files_prefix:
    db 0x0D, 0x0A, "Too many open files (unable to open another one).", 0x0D, 0x8A ; load 0149h-017Dh
insufficient_memory_prefix:
    db 0x0D, 0x0A, "Insufficient memory.", 0x0D, 0x8A ; load 017Eh-0195h
    db 0x0D, 0x0A, "Insufficient memory for text buffer (need 8k minimum).", 0x0D, 0x8A ; load 0196h-01CFh
invalid_drive_text:
    db "Invalid Drive specified.", 0x0D, 0x8A ; load 01D0h-01E9h
    db "Invalid Directory Specification.", 0x0D, 0x8A ; load 01EAh-020Bh
directory_heading_text:
    db " Directory of                                                                 ", 0x0D, 0x0A ; load 020Ch-025Bh
    db "      Dir's and        Files Occupy               Bytes on Volume:             ", 0x0D, 0x0A ; load 025Ch-02ACh
    db " ==============================================================================", 0x0D, 0x0A ; load 02ADh-02FDh
    db " File    .Ext   KBytes  mm-dd-yy hh:mm | File    .Ext   KBytes  mm-dd-yy hh:mm", 0x0D, 0x0A ; load 02FEh-034Dh
    db " --------------------------------------|---------------------------------------", 0x0D, 0x8A ; load 034Eh-039Eh
equals_separator_totals_text:
    db " ==============================================================================", 0x0D, 0x0A ; load 039Fh-03EFh
    db "                    Bytes Free of                           Bytes Total", 0x0D, 0x0A ; load 03F0h-0438h
    db " ------------------------------------------------------------------------------", 0x0D, 0x0A ; load 0439h-0488h
    db " ==>      Continue =  CR                         Abort =  ^C       ", 0xA0 ; load 048Ah-04CDh
directory_row_buffer:
    ; load 04CEh-04F4h: reusable left directory row field.
    times 35 db 0x20
    db 0x3A, 0x20, 0x20, 0x20
left_column_end_marker:
    db 0x7C                      ; load 04F5h; overwritten with 0xFCh before output
    db 0x20                      ; load 04F6h; separator spacing
right_column_buffer:
    ; load 04F7h-051Bh: reusable right directory row field.
    times 34 db 0x20
    db 0x3A
    times 2 db 0x20
right_column_end_marker:
    db 0xA0                      ; load 051Ch: marked-string terminator
; Runtime variables begin at load 051Dh. The surrounding
; storage is initialized in the image but is mostly populated during startup.
runtime_variables:                  ; load 051Dh-0534h: mutable startup state
RECORD_STORAGE_END:
    db 0x00, 0x00
RECORD_CAPACITY_BYTES:
    db 0x00, 0x00
NEXT_RECORD_POINTER:
    db 0xDB, 0x0D
    db 0x00, 0x00
SAVED_CTRL_BREAK_STATE:
    db 0x00
COMMAND_TAIL_END:
    db 0x00, 0x00
COMMAND_TAIL_LENGTH:
    db 0x00
COMMAND_TAIL_START:
    db 0x00, 0x00
FORMAT_FIELD_STATE:
    db 0x03
FORMAT_RECORD_ATTRIBUTE:
    db 0x00
FORMAT_RECORD_POINTER:
    db 0x00, 0x00
DISPLAY_RECORD_POINTER:
    db 0xDB, 0x0D
DISPLAY_RECORD_COUNT:
    db 0x00, 0x00
DIRECTORY_COUNT:
    db 0x00, 0x00
PROGRAM_DTA:                       ; load 0535h-055Fh: DOS find-result area
    times 21 db 0x00
PROGRAM_DTA_ATTRIBUTE:
    times 9 db 0x00
PROGRAM_DTA_NAME:
    times 13 db 0x00
DTA_ADJACENT_WORKSPACE:             ; load 0560h-05B4h: untouched DOS-adjacent workspace
    times 85 db 0x00
FILE_COUNT:
    db 0x00, 0x00
REMAINING_RECORD_CAPACITY:
    db 0x00, 0x00
RECORD_CAPACITY:
    db 0x00, 0x00
TOTAL_BYTES_LOW:
    db 0x00, 0x00
TOTAL_BYTES_HIGH:
    db 0x00, 0x00
TEMPORARY_RECORD:                   ; load 05BFh-05D6h: 22-byte sort candidate
    times 24 db 0x00
INSERTION_DESTINATION_POINTER:
    db 0x00, 0x00
insertion_display_workspace:        ; load 05D9h-0629h: initialized display template
    times 36 db 0x20
    db 0x20, 0x20, 0x20, 0x7C
    times 39 db 0x20
    db 0x0D, 0x8A
SAVED_DTA_SEGMENT:
    db 0x00, 0x00
SAVED_DTA_OFFSET:
    db 0x00
    db 0x00
SAVED_VIDEO_ATTRIBUTE:
    db 0x00
    db 0x00, 0x00, 0x00, 0x00
PATH_STATE_BYTE:
    db 0x00
PATH_BUFFER:                       ; load 0634h-0674h: DOS current-directory buffer
    times 65 db 0x00
CURRENT_SEARCH_PATH:
    db 0x58, 0x3A, 0x5C
    times 64 db 0x00
SEARCH_PATH_END_POINTER:
    db 0x00, 0x00
    db 0x00, 0x00
RECORD_COUNT:
    db 0x00
    db 0x00
SEARCH_SPECIFICATION:
    db 0x58, 0x3A, 0x5C, 0x2A, 0x2E, 0x2A, 0x00
COMPARISON_POINTER:
    db 0x00, 0x00
SEPARATOR_TABLE_LENGTH:
    db 0x07
SEPARATOR_TABLE:
    db 0x09, 0x20, 0x2B, 0x2C, 0x3A
    db 0x3B, 0x3D
SIZE_OR_DATE_DIVISOR:
    db 0x0A, 0x00
SPECIAL_TABLE_LENGTH:
    db 0x08
SPECIAL_TABLE:
    db 0x22, 0x2F, 0x3C, 0x3E, 0x5B, 0x5C, 0x5D, 0x7C
CHARACTER_MAPPING_TABLE:
    db 0x00, 0x2E, 0x21
    db 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2D, 0x5E, 0x5F, 0x60, 0x7B, 0x7D, 0x7E, 0x00
    db 0x00
    db 0x00, 0x00, 0x00, 0xDB, 0x0D
; load 06F2h: confirmed executable entry
code:
main_initialize_and_dispatch:
    cmp al, 0xFF
    jnz main_normal_initialize
    mov al, 0x0F                 ; error selector, not DOS AH=00h itself
    jmp report_error             ; AL=0Fh selects the error/exit message
main_normal_initialize:
    mov ah, DOS_SET_INTERRUPT_VECTOR
    mov al, 0x23                 ; Ctrl-C / Ctrl-Break vector
    mov dx, 0x09C4               ; DS:DX = replacement handler
    int 0x21                     ; installs the program's Ctrl-C handler
    mov ah, BIOS_READ_CHAR_ATTRIBUTE
    mov bx, 0x0007               ; BH=display page 7; BL is ignored by AH=08h
    int 0x10                     ; returns the current screen attribute in AH
    mov [SAVED_VIDEO_ATTRIBUTE], ah ; save the attribute used by the program
    mov ah, DOS_CTRL_BREAK
    mov al, DOS_CTRL_BREAK_GET
    int 0x21                     ; returns Ctrl-Break state in DL
    mov [0x0525], dl
    mov ah, DOS_CTRL_BREAK
    mov al, DOS_CTRL_BREAK_SET
    mov dl, 0x00                 ; disable Ctrl-Break checking during setup
    int 0x21
    mov ax, [PSP_MEMORY_LIMIT]   ; paragraph limit recorded by the PSP
    sub ax, RECORD_STORAGE       ; leave the sorted-record area out of the count
    mov cx, 0x0016               ; 22 paragraphs per display record slot
    db 0x33, 0xD2                ; xor dx, dx (original encoding)
    div cx                       ; AX = available slots; DX = remainder
    mov [RECORD_CAPACITY], ax
    mov [REMAINING_RECORD_CAPACITY], ax
    db 0x33, 0xD2                ; xor dx, dx (original encoding)
    mul cx                       ; AX = rounded slot allocation in paragraphs
    mov [RECORD_CAPACITY_BYTES], ax
    add ax, RECORD_STORAGE
    mov [RECORD_STORAGE_END], ax
    sti
    cld
    mov si, PSP_COMMAND_TAIL_LENGTH ; PSP command-tail length byte
    db 0x33, 0xC0                ; xor ax, ax (original encoding)
    lodsb                        ; AL = command-tail length
    db 0x03, 0xF0                ; add si, ax (original encoding)
    mov byte [si], 0x00          ; terminate command tail with NUL
    inc si
    mov [COMMAND_TAIL_END], si   ; end of command tail / next free byte
    mov si, PSP_COMMAND_TAIL_TEXT ; start of command-tail text
    mov [COMMAND_TAIL_START], si
    mov ax, [COMMAND_TAIL_END]
    db 0x2B, 0xC6                ; sub ax, si (original encoding)
    mov [COMMAND_TAIL_LENGTH], al ; command-tail text length
    mov ah, DOS_GET_DTA
    int 0x21                     ; returns current DTA address in ES:BX
    mov ax, es
    mov [SAVED_DTA_SEGMENT], ax
    mov [SAVED_DTA_OFFSET], bx
    nop                           ; preserved alignment/no-op bytes
    nop
    mov al, [PSP_DEFAULT_FCB_DRIVE]
    cmp al, 0x00
    jnz main_drive_already_selected
    mov ah, DOS_GET_CURRENT_DRIVE
    int 0x21                     ; returns zero-based current drive in AL
    inc al
main_drive_already_selected:
    add al, 0x40                 ; convert 1-based drive number to ASCII
    mov [SEARCH_SPECIFICATION], al ; search path drive letter
    mov [CURRENT_SEARCH_PATH], al  ; displayed/current drive letter
    nop
    nop
enumerate_directory_entries:
    mov dx, PROGRAM_DTA
    mov ax, cs
    mov es, ax
    mov ah, DOS_SET_DTA
    int 0x21                    ; DS:DX = CS:0535h; installs the program DTA
    nop
    nop
    mov dx, SEARCH_SPECIFICATION
    mov cx, 0x0008
    mov ah, DOS_FIND_FIRST
    int 0x21                    ; DS:DX = CS:06BEh, CX = 0008h attributes
enumerate_search_record_setup:
    mov cx, 0x000B
    mov si, PROGRAM_DTA_NAME
    mov di, 0x02A0
    cmp byte [PROGRAM_DTA_ATTRIBUTE], 0x08
    jz enumerate_directory_continue_target
    mov ah, DOS_FIND_NEXT
    int 0x21                    ; continues the search using the installed DTA
enumerate_directory_continue:
    jc enumerate_no_more_entries
    jmp short enumerate_search_record_setup
    nop
    nop
enumerate_no_more_entries:
    mov al, 0x2D                 ; display a dash when enumeration ends
    jmp short enumerate_fill_name_padding
enumerate_directory_continue_target:
    cld
    lodsb
    cmp al, 0x2E
    jz enumerate_directory_continue_target
enumerate_copy_name_character:
    stosb
    cmp al, 0x00
    loopne enumerate_directory_continue_target
    jcxz enumerate_pad_name
    dec di
    inc cx
    mov al, 0x20
enumerate_fill_name_padding:
    rep stosb
enumerate_prepare_path:
enumerate_pad_name:
    mov si, PATH_BUFFER
    mov ah, DOS_GET_CURRENT_DIRECTORY
    db 0x8B, 0xFE                ; mov di, si (original encoding)
    mov dl, [PSP_DEFAULT_FCB_DRIVE]
    int 0x21                     ; DL=drive (0=current), returns path at DS:SI
    db 0x8B, 0xF7                ; mov si, di (original encoding)
    db 0x33, 0xC0                ; xor ax, ax (original encoding)
    dec ah
    mov cx, 0x0040
    cld
enumerate_find_path_end:
    inc ah
    scasb
    loopne enumerate_find_path_end
    mov [si-0x01], ah
    mov ah, 0x01
    mov cx, 0x0046
    mov si, PSP_COMMAND_TAIL_TEXT
enumerate_first_command_scan:
    mov al, [si]
    call classify_command_character
    jnz enumerate_first_command_unrecognized
    call delete_command_character
    loop enumerate_first_command_scan
enumerate_first_command_unrecognized:
    cmp byte [PSP_DEFAULT_FCB_DRIVE], 0x00
    jz enumerate_after_first_command_scan
    call delete_command_character
    call delete_command_character
    mov ah, 0x01
    mov cx, 0x0046
enumerate_second_command_scan:
    mov al, [si]
    call classify_command_character
    jnz enumerate_after_first_command_scan
    call delete_command_character
    loop enumerate_second_command_scan
enumerate_after_first_command_scan:
    cmp byte [si], 0x2E
    jnz enumerate_option_scan
    cmp byte [si+0x01], 0x2E
    jnz enumerate_non_parent_command
    mov bl, [PATH_STATE_BYTE]
    cmp bl, 0x00
    jnz enumerate_parent_directory_ready
    mov al, 0x0F
    jmp report_error             ; invalid parent-directory request
enumerate_parent_directory_ready:
    push si
    mov si, PATH_BUFFER
    db 0x32, 0xFF                ; xor bh, bh (original encoding)
    mov ah, 0x02
enumerate_parent_directory_scan:
    dec bx
    mov al, [bx+si]
    call classify_command_character
    mov byte [bx+si], 0x00
    jz enumerate_parent_directory_done
    db 0x0B, 0xDB                ; or bx, bx (original encoding)
    jnz enumerate_parent_directory_scan
enumerate_parent_directory_done:
    mov [si-0x01], bl
    pop si
enumerate_single_dot_command:
    call delete_command_character
    ; fall through to the common second deletion
enumerate_non_parent_command:
    call delete_command_character
    mov ah, 0x01
    mov cx, 0x0046
enumerate_third_command_scan:
    mov al, [si]
    call classify_command_character
    jnz enumerate_non_parent_done
    call delete_command_character
    loop enumerate_third_command_scan
enumerate_non_parent_done:
enumerate_option_scan:
    mov ah, 0x02
    mov cx, 0x0046
enumerate_option_character:
    mov al, [si]
    call classify_command_character
    jnz construct_search_path_and_check_attributes
    mov ah, 0x00
enumerate_option_loop_body:
    call delete_command_character
    mov al, [si]
    call classify_command_character
    loope enumerate_option_loop_body
enumerate_command_end:
    mov di, 0x0678
    cmp byte [PSP_COMMAND_TAIL_LENGTH], 0x00
    jz enumerate_no_command_tail
    jmp short enumerate_command_tail_present
    nop
enumerate_no_command_tail:
    jmp construct_path_append_search_star ; existing path-building continuation
classify_command_character:
    push ax
    push cx
    push di
    db 0x33, 0xC9                  ; xor cx, cx (original encoding)
    cmp ah, 0x02
    jz classify_secondary_table
    mov di, SEPARATOR_TABLE
    mov cl, [SEPARATOR_TABLE_LENGTH]
    jmp classify_scan
classify_secondary_table:
    mov di, SPECIAL_TABLE
    mov cl, [SPECIAL_TABLE_LENGTH]
classify_scan:
    cld
    repne scasb
    jcxz classify_not_found
classify_restore_return:
    pop di
    pop cx
    pop ax
    ret
classify_not_found:
    db 0x0A, 0xE4                  ; or ah, ah (original encoding)
    jnz classify_restore_return
    inc ah
    jmp classify_secondary_table
delete_command_character:
    push cx
    push si
    push di
    db 0x33, 0xC9                  ; xor cx, cx (original encoding)
    mov cl, [si-1]
    dec byte [si-1]
    db 0x8B, 0xFE                  ; mov di, si (original encoding)
    inc si
    cld
    rep movsb
    pop di
    pop si
    pop cx
    ret
construct_search_path_and_check_attributes:
    mov si, PATH_BUFFER
    mov ah, [si-1]
    cmp byte [PSP_COMMAND_TAIL_LENGTH], 0x00
    jnz construct_path_copy_tail
    db 0x0A, 0xE4                  ; or ah, ah (original encoding)
    mov di, 0x0678
    jz construct_path_append_search_star
    db 0x33, 0xC9                  ; xor cx, cx (original encoding)
    db 0x8A, 0xCC                  ; mov cl, ah (original encoding)
    rep movsb
    mov byte [di], 0x5C
    inc di
    jmp construct_path_append_search_star
construct_path_copy_tail:
    db 0x0A, 0xE4                  ; or ah, ah (original encoding)
    mov di, 0x0678
    jz construct_path_copy_command
    db 0x33, 0xC9                  ; xor cx, cx (original encoding)
    db 0x8A, 0xCC                  ; mov cl, ah (original encoding)
    rep movsb
    mov byte [di], 0x5C
    inc di
enumerate_command_tail_present:
construct_path_copy_command:
    mov si, PSP_COMMAND_TAIL_TEXT
    db 0x33, 0xC9                  ; xor cx, cx (original encoding)
    mov cl, [si-1]
    rep movsb
    mov [SEARCH_PATH_END_POINTER], di
    mov ah, DOS_GET_FILE_ATTRIBUTES
    mov dx, CURRENT_SEARCH_PATH
    mov al, 0x00
    int 0x21                    ; DS:DX = CS:0675h, AL=00h; returns CF and CL attributes
    jc construct_path_finish
    test cl, 0x10
    jz construct_path_finish
construct_path_append_separator:
    mov byte [di], 0x5C
    inc di
construct_path_append_search_star:
    mov byte [di], 0x2A
    inc di
    mov byte [di], 0x2E
    inc di
    mov byte [di], 0x2A
    inc di
    mov byte [di], 0x00
    mov [SEARCH_PATH_END_POINTER], di
construct_path_finish:
directory_processing_start:
    mov di, CURRENT_SEARCH_PATH  ; current/display drive path
    db 0x8B, 0xF7                ; mov si, di (original encoding)
    db 0x33, 0xC0                ; xor ax, ax (original encoding)
    mov cx, 0x0050
directory_find_drive_end:
    inc ah
    scasb
    loopne directory_find_drive_end
    db 0x33, 0xC9                ; xor cx, cx (original encoding)
    db 0x8A, 0xCC                ; mov cl, ah (original encoding)
    mov di, 0x021B
    rep movsb                     ; copy drive/path prefix to display buffer
    mov dx, CURRENT_SEARCH_PATH
    mov ah, DOS_FIND_FIRST
    mov cx, 0x00F1               ; include directory entries and hidden/system files
    int 0x21                     ; DS:DX=search path, returns first DTA record
    jnc directory_first_entry_found
    jmp report_error             ; no matching file/path error
directory_first_entry_found:
    call ingest_dta_record
    mov si, TEMPORARY_RECORD
    mov di, RECORD_STORAGE
    mov cx, 0x000B
    rep movsw                     ; copy the 22-byte temporary record
    db 0x83, 0x06, 0x21, 0x05, 0x16 ; add word [0521h],16h (original encoding)
    dec word [REMAINING_RECORD_CAPACITY]
directory_find_next:
    mov ah, DOS_FIND_NEXT
    int 0x21                     ; returns the next matching DTA record
    jc directory_enumeration_done
    call ingest_dta_record
    call insert_or_reject_sorted_record
    dec word [REMAINING_RECORD_CAPACITY]
    jnz directory_find_next
directory_enumeration_done:
    cmp al, 0x12                 ; DOS error 12h: no more files
    jz directory_display_summary
    jmp report_error
directory_display_summary:
    call print_summary_totals
    call calculate_volume_totals
    mov ax, [RECORD_COUNT]
    mov [DISPLAY_RECORD_COUNT], ax ; total record count for display
    mov ax, RECORD_STORAGE
    mov [DISPLAY_RECORD_POINTER], ax ; reset display record pointer
directory_render_again:
    call render_directory_screen
directory_wait_for_input:
    mov ah, BIOS_SET_CURSOR
    mov bx, 0x0007
    mov dh, 0x1A
    mov dl, 0x00
    int 0x10                     ; position cursor below the directory listing
    call wait_for_enter_or_abort
    jmp short directory_render_again
directory_abort_screen:
    mov ah, BIOS_SET_CURSOR
    mov bx, 0x0007
    mov dh, 0x1A
    mov dl, 0x00
    int 0x10
    call wait_for_enter_or_abort
ctrl_break_handler:
    mov ax, 0x0600               ; BIOS scroll-up, AL=00h clear window
    mov bh, [SAVED_VIDEO_ATTRIBUTE] ; saved screen attribute
    mov bl, 0x07
    mov cx, 0x1500
    mov dh, 0x18
    mov dl, 0x4F
    int 0x10                     ; clear the main display area
    mov ah, BIOS_SET_CURSOR
    mov bx, 0x0007
    mov dx, 0x1500
    int 0x10
    mov ah, DOS_CTRL_BREAK
    mov al, DOS_CTRL_BREAK_SET
    mov dl, [SAVED_CTRL_BREAK_STATE] ; restore the caller's Ctrl-Break state
    int 0x21
    db 0x33, 0xC0                ; xor ax, ax (original encoding)
    int 0x21                     ; terminate through DOS AH=00h
    nop
    nop
ingest_dta_record:
    cld
    mov si, PROGRAM_DTA_ATTRIBUTE
    mov di, TEMPORARY_RECORD
    lodsb
    db 0x8A, 0xE0                  ; mov ah, al (original encoding)
    mov al, 0x01
    inc word [RECORD_COUNT]
    inc word [FILE_COUNT]
    test ah, 0x10
    jz ingest_not_directory
    db 0x32, 0xC0                  ; xor al, al (original encoding)
    dec word [FILE_COUNT]
    inc word [DIRECTORY_COUNT]
ingest_not_directory:
    stosb
    mov si, PROGRAM_DTA_NAME
    mov cx, 0x000D
ingest_name_loop:
    lodsb
    cmp al, 0x61
    jc ingest_name_character_ready
    cmp al, 0x7B
    jnc ingest_name_character_scan
    sub al, 0x20
ingest_name_character_ready:
    cmp al, 0x30
    jc ingest_name_character_scan
    cmp al, 0x5B
    jc ingest_name_character_done
ingest_name_character_scan:
    push di
    push cx
    mov di, CHARACTER_MAPPING_TABLE
    mov cx, 0x0012
    repne scasb
    jcxz ingest_unknown_character
    inc cx
    neg cx
    add cx, 0x0012
    db 0x8A, 0xC1                  ; mov al, cl (original encoding)
    jmp ingest_store_character
ingest_unknown_character:
    dec di
    stosb
    mov al, 0x12
ingest_store_character:
    pop cx
    pop di
ingest_name_character_done:
    stosb
    loop ingest_name_loop
    mov si, 0x054F
    lodsw
    stosw
    add word [TOTAL_BYTES_LOW], ax
    lodsw
    stosw
    adc word [TOTAL_BYTES_HIGH], ax
    mov si, 0x054D
    movsw
    mov si, 0x054B
    movsw
    ret
insert_or_reject_sorted_record:
    cld
    mov di, 0x0DDB
    mov [COMPARISON_POINTER], di
    mov cx, [RECORD_COUNT]
insert_scan_records:
    mov si, TEMPORARY_RECORD
    mov ah, 0x0E
insert_compare_loop:
    dec ah
    jz insert_at_position
    cmpsb
    jz insert_compare_loop
    jc insert_at_position
    add word [COMPARISON_POINTER], 0x0016
    mov di, [COMPARISON_POINTER]
    dec cx
    jnz insert_scan_records
insert_copy_record:
    mov si, TEMPORARY_RECORD
    mov di, [0x0521]
    mov cx, 0x000B
    rep movsw
    mov [0x0521], di
    ret
insert_at_position:
    neg cx
    add cx, [RECORD_COUNT]
    shl cx, 1
    db 0x8B, 0xC1                  ; mov ax, cx (original encoding)
    shl ax, 1
    shl ax, 1
    shl ax, 1
    db 0x03, 0xC1                  ; add ax, cx (original encoding)
    shl cx, 1
    db 0x03, 0xC8                  ; add cx, ax (original encoding)
    add cx, 0x0DDB
    mov [INSERTION_DESTINATION_POINTER], cx
    neg cx
    add cx, [0x0521]
    shr cx, 1
    mov di, [0x0521]
    db 0x8B, 0xF7                  ; mov si, di (original encoding)
    dec si
    dec si
    add di, 0x0016
    mov [0x0521], di
    dec di
    dec di
    std
    rep movsw
    cld
    mov si, TEMPORARY_RECORD
    mov di, [INSERTION_DESTINATION_POINTER]
    mov cx, 0x000B
    rep movsw
    ret
calculate_volume_totals:
    mov ah, BIOS_SET_CURSOR
    mov dh, 0x15
    mov dl, 0x00
    mov bx, 0x0007
    int 0x10                    ; BH=07h, DH=15h, DL=00h positions totals output
    db 0x8A, 0x16, 0xBE, 0x06      ; mov dl, [SEARCH_SPECIFICATION] (original encoding)
    sub dl, 0x40
    mov ah, DOS_GET_FREE_SPACE
    int 0x21                    ; DL = drive; returns cluster/sector data in AX,BX,CX,DX
    push dx
    mul cx
    push dx
    push ax
    db 0x8B, 0xCA                  ; mov cx, dx (original encoding)
    mul bx
    db 0x8B, 0xFA                  ; mov di, dx (original encoding)
    db 0x8B, 0xF0                  ; mov si, ax (original encoding)
    db 0x8B, 0xC1                  ; mov ax, cx (original encoding)
    mul bx
    db 0x03, 0xC7                  ; add ax, di (original encoding)
    db 0x8B, 0xD0                  ; mov dx, ax (original encoding)
    db 0x8B, 0xC6                  ; mov ax, si (original encoding)
    mov cx, 0x000D
    mov di, 0x03F6
    call format_decimal_with_commas
    pop ax
    pop cx
    pop bx
    mul bx
    db 0x8B, 0xFA                  ; mov di, dx (original encoding)
    db 0x8B, 0xF0                  ; mov si, ax (original encoding)
    db 0x8B, 0xC1                  ; mov ax, cx (original encoding)
    mul bx
    db 0x03, 0xC7                  ; add ax, di (original encoding)
    db 0x8B, 0xD0                  ; mov dx, ax (original encoding)
    db 0x8B, 0xC6                  ; mov ax, si (original encoding)
    mov cx, 0x000D
    mov di, 0x041E
    call format_decimal_with_commas
    mov si, equals_separator_totals_text
    call bios_output_marked_string
    ret
print_summary_totals:
    mov ah, BIOS_SCROLL_UP
    db 0x32, 0xC0                  ; xor al, al (original encoding)
    mov bh, 0x0E
    db 0x33, 0xC9                  ; xor cx, cx (original encoding)
    mov dh, 0x18
    mov dl, 0x4F
    int 0x10                    ; AL=00h, BH=0Eh, CX=0000h, DX=184Fh clears output
    mov ah, BIOS_SET_CURSOR
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    mov bx, 0x0007
    int 0x10                    ; BH=07h, DX=0000h positions summary output
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    mov ax, [DIRECTORY_COUNT]
    mov cx, 0x0005
    mov di, 0x025C
    call format_decimal_with_commas
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    mov ax, [FILE_COUNT]
    mov cx, 0x0005
    mov di, 0x026D
    call format_decimal_with_commas
    db 0x8B, 0x16, 0xBD, 0x05      ; mov dx, [0x05BD] (original encoding)
    mov ax, [TOTAL_BYTES_LOW]
    mov cx, 0x000D
    mov di, 0x0280
    call format_decimal_with_commas
    mov si, directory_heading_text
    call bios_output_marked_string
    ret
report_error:
    cmp al, 0x02
    mov si, file_not_found_prefix
    jz report_error_print
    cmp al, 0x03
    mov si, path_not_found_prefix
    jz report_error_print
    cmp al, 0x04
    mov si, too_many_open_files_prefix
    jz report_error_print
    cmp al, 0x08
    mov si, insufficient_memory_prefix
    jz report_error_print
    cmp al, 0x0F
    mov si, invalid_drive_text
    jz report_error_print
    mov si, bad_path_name_prefix
report_error_print:
    call bios_output_marked_string
    jmp 0x09EA
wait_for_enter_or_abort:
    mov ah, DOS_DIRECT_CONSOLE_INPUT
    int 0x21                    ; returns an unechoed key in AL
    cmp al, 0x03
    jnz wait_for_enter
    jmp 0x09C4
wait_for_enter:
    cmp al, 0x0D
    jnz wait_for_enter_or_abort
    ret
render_directory_screen:
    mov ax, BIOS_SCROLL_UP << 8
    mov bh, 0x71
    mov cx, 0x0500
    mov dh, 0x14
    mov dl, 0x4F
    int 0x10                    ; AL=00h, BH=71h, CX=0500h, DX=144Fh clears window
    mov ah, BIOS_SET_CURSOR
    mov bx, 0x0007
    mov dx, 0x0500
    int 0x10                    ; BH=07h, DX=0500h positions the heading
    mov cx, 0x000F
render_left_rows:
    push cx
    call render_left_entry
    mov si, initial_line_break_marker
    call bios_output_marked_string
    pop cx
    loop render_left_rows
    call render_left_entry
    mov bx, 0x0007
    mov cx, 0x0010
    mov dh, 0x05
    mov dl, 0x29
render_right_rows:
    push dx
    push cx
    push bx
    mov ah, BIOS_SET_CURSOR
    int 0x10                    ; BH=07h, DX selects each right-column row
    call render_right_entry
    pop bx
    pop cx
    pop dx
    inc dh
    loop render_right_rows
    ret
render_left_entry:
    mov di, 0x04CF
    call format_directory_record
    mov byte [0x04F5], 0xFC
    mov si, 0x04CE
    call bios_output_marked_string
    add word [DISPLAY_RECORD_POINTER], 0x0016
    dec word [DISPLAY_RECORD_COUNT]
    jz render_right_last
    ret
render_right_entry:
    mov di, 0x04F7
    call format_directory_record
    mov si, 0x04F7
    call bios_output_marked_string
    add word [DISPLAY_RECORD_POINTER], 0x0016
    dec word [DISPLAY_RECORD_COUNT]
    jz render_right_last
    ret
render_right_last:
    jmp 0x09B6
format_decimal_with_commas:
    mov byte [FORMAT_FIELD_STATE], 0x03
    push bx
    push cx
    push di
    push si
    db 0x8B, 0xD8                  ; mov bx, ax (original encoding)
    db 0x8B, 0xF2                  ; mov si, dx (original encoding)
    std
    db 0x03, 0xF9                  ; add di, cx (original encoding)
    dec di
format_decimal_digit:
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    db 0x8B, 0xC6                  ; mov ax, si (original encoding)
    div word [SIZE_OR_DATE_DIVISOR]
    db 0x8B, 0xF0                  ; mov si, ax (original encoding)
    db 0x8B, 0xC3                  ; mov ax, bx (original encoding)
    div word [SIZE_OR_DATE_DIVISOR]
    db 0x8B, 0xD8                  ; mov bx, ax (original encoding)
    cmp byte [FORMAT_FIELD_STATE], 0x00
    jnz format_decimal_no_separator
    mov byte [FORMAT_FIELD_STATE], 0x03
    mov byte [di], 0x2C
    dec di
    dec cx
format_decimal_no_separator:
    dec byte [FORMAT_FIELD_STATE]
    add dl, 0x30
    mov [di], dl
    dec di
    db 0x0B, 0xC6                  ; or ax, si (original encoding)
    loopne format_decimal_digit
    jcxz format_decimal_done
    mov al, 0x20
    rep stosb
format_decimal_done:
    pop si
    pop di
    pop cx
    pop bx
    ret
format_directory_record:
    mov [FORMAT_RECORD_POINTER], di
    mov cx, 0x0025
    mov al, 0x20
    cld
    rep stosb
    mov di, [FORMAT_RECORD_POINTER]
    mov si, [DISPLAY_RECORD_POINTER]
    lodsb
    mov [FORMAT_RECORD_ATTRIBUTE], al
    lodsb
    cmp al, 0x01
    jnz format_record_name
    lodsb
    cmp al, 0x01
    jc format_record_directory_marker
    mov al, 0x2E
    stosb
format_record_directory_marker:
    mov al, 0x2E
    stosb
    jmp format_record_directory_output
format_record_name:
    mov bx, CHARACTER_MAPPING_TABLE
    mov cx, 0x0008
format_record_name_loop:
    cmp al, 0x41
    jnc format_record_lowercase
    cmp al, 0x30
    jnc format_record_copy_char
    xlatb
    cmp al, 0x2E
    jnz format_record_copy_char
    mov al, 0x20
    rep stosb
    jmp format_record_name_done
format_record_lowercase:
    add al, 0x20
format_record_copy_char:
    stosb
    lodsb
    db 0x0A, 0xC0                  ; or al, al (original encoding)
    jz format_record_no_size
    loop format_record_name_loop
format_record_name_done:
    mov al, 0x2E
    stosb
    mov cx, 0x0003
    lodsb
    jmp format_record_name_loop
format_record_no_size:
    cmp byte [FORMAT_RECORD_ATTRIBUTE], 0x00
    jnz format_record_date_time
format_record_directory_output:
    mov di, [FORMAT_RECORD_POINTER]
    add di, 0x0011
    mov si, subdir_text
    mov cx, 0x000B
    rep movsb
    ret
format_record_date_time:
    mov di, [FORMAT_RECORD_POINTER]
    add di, 0x000F
    mov si, [DISPLAY_RECORD_POINTER]
    add si, 0x000E
    lodsw
    db 0x8B, 0xD0                  ; mov dx, ax (original encoding)
    lodsw
    db 0x8B, 0xC8                  ; mov cx, ax (original encoding)
    db 0x0B, 0xC2                  ; or ax, dx (original encoding)
    jz format_record_date_done
    db 0x8B, 0xDA                  ; mov bx, dx (original encoding)
    and bh, 0x03
    db 0x8A, 0xC6                  ; mov al, dh (original encoding)
    db 0x8A, 0xE1                  ; mov ah, cl (original encoding)
    db 0x8A, 0xD5                  ; mov dl, ch (original encoding)
    db 0x32, 0xF6                  ; xor dh, dh (original encoding)
    shr dx, 1
    rcr ax, 1
    shr dx, 1
    rcr ax, 1
    db 0x0A, 0xFB                  ; or bh, bl (original encoding)
    jz format_record_date_done
    db 0x05, 0x01, 0x00           ; add ax, 0x0001 (original encoding)
    adc dx, 0x0000
format_record_date_done:
    mov cx, 0x0006
    call format_decimal_with_commas
    cld
    lodsw
    db 0x8A, 0xD8                  ; mov bl, al (original encoding)
    and bl, 0x1F
    shr ax, 1
    db 0x8A, 0xF8                  ; mov bh, al (original encoding)
    shr bh, 1
    shr bh, 1
    shr bh, 1
    shr bh, 1
    db 0x8A, 0xC4                  ; mov al, ah (original encoding)
    cbw
    add ax, 0x07BC
    push ax
    db 0x8A, 0xC7                  ; mov al, bh (original encoding)
    cbw
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    add di, 0x0008
    mov cx, 0x0002
    call format_decimal_with_commas
    call replace_leading_space_with_zero
    db 0x03, 0xF9                  ; add di, cx (original encoding)
    mov al, 0x2D
    cld
    stosb
    db 0x8A, 0xC3                  ; mov al, bl (original encoding)
    cbw
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    call format_decimal_with_commas
    call replace_leading_space_with_zero
    db 0x03, 0xF9                  ; add di, cx (original encoding)
    mov al, 0x2D
    cld
    stosb
    pop ax
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    call format_decimal_with_commas
    cld
    lodsw
    shr ax, 1
    shr ax, 1
    shr ax, 1
    db 0x8A, 0xD8                  ; mov bl, al (original encoding)
    db 0x8A, 0xC4                  ; mov al, ah (original encoding)
    cbw
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    add di, 0x0003
    call format_decimal_with_commas
    call replace_leading_space_with_zero
    db 0x03, 0xF9                  ; add di, cx (original encoding)
    mov byte [di], 0x3A
    db 0x8A, 0xC3                  ; mov al, bl (original encoding)
    shr al, 1
    shr al, 1
    cbw
    db 0x33, 0xD2                  ; xor dx, dx (original encoding)
    inc di
    call format_decimal_with_commas
    call replace_leading_space_with_zero
    ret
replace_leading_space_with_zero:
    mov al, [di]
    cmp al, 0x20
    jnz leading_space_done
    mov byte [di], 0x30
leading_space_done:
    ret
bios_output_character:
    push bx
    mov ah, BIOS_TTY_OUTPUT
    mov bx, 0x0007
    push cx
    and al, 0x7F
    push ax
    int 0x10                    ; AL=masked character, BH=07h display page
    pop ax
    pop cx
    pop bx
    ret
bios_output_marked_string:
    cld
    cs lodsb
    mov ah, BIOS_TTY_OUTPUT
    mov bx, 0x0007
    push ax
    and al, 0x7F
    int 0x10                    ; AL=low seven bits of CS:SI byte, BH=07h page
    pop ax
    and al, 0x80
    jz bios_output_marked_string
    ret
sorted_record_storage:                ; load 0DDBh-0EDFh: sorted records/free space
    times 261 db 0x00
