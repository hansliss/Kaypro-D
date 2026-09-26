00000100  E9EF05            jmp 0x6f2
00000103  0D8A3C            or ax,0x3c8a
00000106  207375            and [bp+di+0x75],dh
00000109  622D              bound bp,[di]
0000010B  646972203E0D      imul si,[fs:bp+si+0x20],word 0xd3e
00000111  0A4261            or al,[bp+si+0x61]
00000114  64205061          and [fs:bx+si+0x61],dl
00000118  7468              jz 0x182
0000011A  204E61            and [bp+0x61],cl
0000011D  6D                insw
0000011E  652021            and [gs:bx+di],ah
00000121  0D8A0D            or ax,0xd8a
00000124  0A4669            or al,[bp+0x69]
00000127  6C                insb
00000128  65206E6F          and [gs:bp+0x6f],ch
0000012C  7420              jz 0x14e
0000012E  46                inc si
0000012F  6F                outsw
00000130  756E              jnz 0x1a0
00000132  642E0D8A0D        cs or ax,0xd8a
00000137  0A5061            or dl,[bx+si+0x61]
0000013A  7468              jz 0x1a4
0000013C  206E6F            and [bp+0x6f],ch
0000013F  7420              jz 0x161
00000141  666F              outsd
00000143  756E              jnz 0x1b3
00000145  642E0D8A0D        cs or ax,0xd8a
0000014A  0A546F            or dl,[si+0x6f]
0000014D  6F                outsw
0000014E  206D61            and [di+0x61],ch
00000151  6E                outsb
00000152  7920              jns 0x174
00000154  6F                outsw
00000155  7065              jo 0x1bc
00000157  6E                outsb
00000158  206669            and [bp+0x69],ah
0000015B  6C                insb
0000015C  657320            gs jnc 0x17f
0000015F  28756E            sub [di+0x6e],dh
00000162  61                popa
00000163  626C65            bound bp,[si+0x65]
00000166  20746F            and [si+0x6f],dh
00000169  206F70            and [bx+0x70],ch
0000016C  656E              gs outsb
0000016E  20616E            and [bx+di+0x6e],ah
00000171  6F                outsw
00000172  7468              jz 0x1dc
00000174  657220            gs jc 0x197
00000177  6F                outsw
00000178  6E                outsb
00000179  65292E0D8A        sub [gs:0x8a0d],bp
0000017E  0D0A49            or ax,0x490a
00000181  6E                outsb
00000182  7375              jnc 0x1f9
00000184  6666696369656E74  imul esp,[bp+di+0x69],dword 0x20746e65
         -20
0000018D  6D                insw
0000018E  656D              gs insw
00000190  6F                outsw
00000191  7279              jc 0x20c
00000193  2E0D8A0D          cs or ax,0xd8a
00000197  0A496E            or cl,[bx+di+0x6e]
0000019A  7375              jnc 0x211
0000019C  6666696369656E74  imul esp,[bp+di+0x69],dword 0x20746e65
         -20
000001A5  6D                insw
000001A6  656D              gs insw
000001A8  6F                outsw
000001A9  7279              jc 0x224
000001AB  20666F            and [bp+0x6f],ah
000001AE  7220              jc 0x1d0
000001B0  7465              jz 0x217
000001B2  7874              js 0x228
000001B4  206275            and [bp+si+0x75],ah
000001B7  6666657220        gs o32 jc 0x1dc
000001BC  286E65            sub [bp+0x65],ch
000001BF  65642038          and [fs:bx+si],bh
000001C3  6B206D            imul sp,[bx+si],byte +0x6d
000001C6  696E696D75        imul bp,[bp+0x69],word 0x756d
000001CB  6D                insw
000001CC  292E0D8A          sub [0x8a0d],bp
000001D0  49                dec cx
000001D1  6E                outsb
000001D2  7661              jna 0x235
000001D4  6C                insb
000001D5  6964204472        imul sp,[si+0x20],word 0x7244
000001DA  6976652073        imul si,[bp+0x65],word 0x7320
000001DF  7065              jo 0x246
000001E1  636966            arpl [bx+di+0x66],bp
000001E4  6965642E0D        imul sp,[di+0x64],word 0xd2e
000001E9  8A496E            mov cl,[bx+di+0x6e]
000001EC  7661              jna 0x24f
000001EE  6C                insb
000001EF  6964204469        imul sp,[si+0x20],word 0x6944
000001F4  7265              jc 0x25b
000001F6  63746F            arpl [si+0x6f],si
000001F9  7279              jc 0x274
000001FB  205370            and [bp+di+0x70],dl
000001FE  65636966          arpl [gs:bx+di+0x66],bp
00000202  6963617469        imul sp,[bp+di+0x61],word 0x6974
00000207  6F                outsw
00000208  6E                outsb
00000209  2E0D8A20          cs or ax,0x208a
0000020D  44                inc sp
0000020E  6972656374        imul si,[bp+si+0x65],word 0x7463
00000213  6F                outsw
00000214  7279              jc 0x28f
00000216  206F66            and [bx+0x66],ch
00000219  2020              and [bx+si],ah
0000021B  2020              and [bx+si],ah
0000021D  2020              and [bx+si],ah
0000021F  2020              and [bx+si],ah
00000221  2020              and [bx+si],ah
00000223  2020              and [bx+si],ah
00000225  2020              and [bx+si],ah
00000227  2020              and [bx+si],ah
00000229  2020              and [bx+si],ah
0000022B  2020              and [bx+si],ah
0000022D  2020              and [bx+si],ah
0000022F  2020              and [bx+si],ah
00000231  2020              and [bx+si],ah
00000233  2020              and [bx+si],ah
00000235  2020              and [bx+si],ah
00000237  2020              and [bx+si],ah
00000239  2020              and [bx+si],ah
0000023B  2020              and [bx+si],ah
0000023D  2020              and [bx+si],ah
0000023F  2020              and [bx+si],ah
00000241  2020              and [bx+si],ah
00000243  2020              and [bx+si],ah
00000245  2020              and [bx+si],ah
00000247  2020              and [bx+si],ah
00000249  2020              and [bx+si],ah
0000024B  2020              and [bx+si],ah
0000024D  2020              and [bx+si],ah
0000024F  2020              and [bx+si],ah
00000251  2020              and [bx+si],ah
00000253  2020              and [bx+si],ah
00000255  2020              and [bx+si],ah
00000257  2020              and [bx+si],ah
00000259  200D              and [di],cl
0000025B  0A20              or ah,[bx+si]
0000025D  2020              and [bx+si],ah
0000025F  2020              and [bx+si],ah
00000261  204469            and [si+0x69],al
00000264  7227              jc 0x28d
00000266  7320              jnc 0x288
00000268  61                popa
00000269  6E                outsb
0000026A  642020            and [fs:bx+si],ah
0000026D  2020              and [bx+si],ah
0000026F  2020              and [bx+si],ah
00000271  2020              and [bx+si],ah
00000273  46                inc si
00000274  696C657320        imul bp,[si+0x65],word 0x2073
00000279  4F                dec di
0000027A  636375            arpl [bp+di+0x75],sp
0000027D  7079              jo 0x2f8
0000027F  2020              and [bx+si],ah
00000281  2020              and [bx+si],ah
00000283  2020              and [bx+si],ah
00000285  2020              and [bx+si],ah
00000287  2020              and [bx+si],ah
00000289  2020              and [bx+si],ah
0000028B  2020              and [bx+si],ah
0000028D  204279            and [bp+si+0x79],al
00000290  7465              jz 0x2f7
00000292  7320              jnc 0x2b4
00000294  6F                outsw
00000295  6E                outsb
00000296  20566F            and [bp+0x6f],dl
00000299  6C                insb
0000029A  756D              jnz 0x309
0000029C  653A20            cmp ah,[gs:bx+si]
0000029F  2020              and [bx+si],ah
000002A1  2020              and [bx+si],ah
000002A3  2020              and [bx+si],ah
000002A5  2020              and [bx+si],ah
000002A7  2020              and [bx+si],ah
000002A9  2020              and [bx+si],ah
000002AB  0D0A20            or ax,0x200a
000002AE  3D3D3D            cmp ax,0x3d3d
000002B1  3D3D3D            cmp ax,0x3d3d
000002B4  3D3D3D            cmp ax,0x3d3d
000002B7  3D3D3D            cmp ax,0x3d3d
000002BA  3D3D3D            cmp ax,0x3d3d
000002BD  3D3D3D            cmp ax,0x3d3d
000002C0  3D3D3D            cmp ax,0x3d3d
000002C3  3D3D3D            cmp ax,0x3d3d
000002C6  3D3D3D            cmp ax,0x3d3d
000002C9  3D3D3D            cmp ax,0x3d3d
000002CC  3D3D3D            cmp ax,0x3d3d
000002CF  3D3D3D            cmp ax,0x3d3d
000002D2  3D3D3D            cmp ax,0x3d3d
000002D5  3D3D3D            cmp ax,0x3d3d
000002D8  3D3D3D            cmp ax,0x3d3d
000002DB  3D3D3D            cmp ax,0x3d3d
000002DE  3D3D3D            cmp ax,0x3d3d
000002E1  3D3D3D            cmp ax,0x3d3d
000002E4  3D3D3D            cmp ax,0x3d3d
000002E7  3D3D3D            cmp ax,0x3d3d
000002EA  3D3D3D            cmp ax,0x3d3d
000002ED  3D3D3D            cmp ax,0x3d3d
000002F0  3D3D3D            cmp ax,0x3d3d
000002F3  3D3D3D            cmp ax,0x3d3d
000002F6  3D3D3D            cmp ax,0x3d3d
000002F9  3D3D3D            cmp ax,0x3d3d
000002FC  0D0A20            or ax,0x200a
000002FF  46                inc si
00000300  696C652020        imul bp,[si+0x65],word 0x2020
00000305  2020              and [bx+si],ah
00000307  2E45              cs inc bp
00000309  7874              js 0x37f
0000030B  2020              and [bx+si],ah
0000030D  204B42            and [bp+di+0x42],cl
00000310  7974              jns 0x386
00000312  657320            gs jnc 0x335
00000315  206D6D            and [di+0x6d],ch
00000318  2D6464            sub ax,0x6464
0000031B  2D7979            sub ax,0x7979
0000031E  206868            and [bx+si+0x68],ch
00000321  3A6D6D            cmp ch,[di+0x6d]
00000324  207C20            and [si+0x20],bh
00000327  46                inc si
00000328  696C652020        imul bp,[si+0x65],word 0x2020
0000032D  2020              and [bx+si],ah
0000032F  2E45              cs inc bp
00000331  7874              js 0x3a7
00000333  2020              and [bx+si],ah
00000335  204B42            and [bp+di+0x42],cl
00000338  7974              jns 0x3ae
0000033A  657320            gs jnc 0x35d
0000033D  206D6D            and [di+0x6d],ch
00000340  2D6464            sub ax,0x6464
00000343  2D7979            sub ax,0x7979
00000346  206868            and [bx+si+0x68],ch
00000349  3A6D6D            cmp ch,[di+0x6d]
0000034C  0D0A20            or ax,0x200a
0000034F  2D2D2D            sub ax,0x2d2d
00000352  2D2D2D            sub ax,0x2d2d
00000355  2D2D2D            sub ax,0x2d2d
00000358  2D2D2D            sub ax,0x2d2d
0000035B  2D2D2D            sub ax,0x2d2d
0000035E  2D2D2D            sub ax,0x2d2d
00000361  2D2D2D            sub ax,0x2d2d
00000364  2D2D2D            sub ax,0x2d2d
00000367  2D2D2D            sub ax,0x2d2d
0000036A  2D2D2D            sub ax,0x2d2d
0000036D  2D2D2D            sub ax,0x2d2d
00000370  2D2D2D            sub ax,0x2d2d
00000373  2D2D7C            sub ax,0x7c2d
00000376  2D2D2D            sub ax,0x2d2d
00000379  2D2D2D            sub ax,0x2d2d
0000037C  2D2D2D            sub ax,0x2d2d
0000037F  2D2D2D            sub ax,0x2d2d
00000382  2D2D2D            sub ax,0x2d2d
00000385  2D2D2D            sub ax,0x2d2d
00000388  2D2D2D            sub ax,0x2d2d
0000038B  2D2D2D            sub ax,0x2d2d
0000038E  2D2D2D            sub ax,0x2d2d
00000391  2D2D2D            sub ax,0x2d2d
00000394  2D2D2D            sub ax,0x2d2d
00000397  2D2D2D            sub ax,0x2d2d
0000039A  2D2D2D            sub ax,0x2d2d
0000039D  0D8A20            or ax,0x208a
000003A0  3D3D3D            cmp ax,0x3d3d
000003A3  3D3D3D            cmp ax,0x3d3d
000003A6  3D3D3D            cmp ax,0x3d3d
000003A9  3D3D3D            cmp ax,0x3d3d
000003AC  3D3D3D            cmp ax,0x3d3d
000003AF  3D3D3D            cmp ax,0x3d3d
000003B2  3D3D3D            cmp ax,0x3d3d
000003B5  3D3D3D            cmp ax,0x3d3d
000003B8  3D3D3D            cmp ax,0x3d3d
000003BB  3D3D3D            cmp ax,0x3d3d
000003BE  3D3D3D            cmp ax,0x3d3d
000003C1  3D3D3D            cmp ax,0x3d3d
000003C4  3D3D3D            cmp ax,0x3d3d
000003C7  3D3D3D            cmp ax,0x3d3d
000003CA  3D3D3D            cmp ax,0x3d3d
000003CD  3D3D3D            cmp ax,0x3d3d
000003D0  3D3D3D            cmp ax,0x3d3d
000003D3  3D3D3D            cmp ax,0x3d3d
000003D6  3D3D3D            cmp ax,0x3d3d
000003D9  3D3D3D            cmp ax,0x3d3d
000003DC  3D3D3D            cmp ax,0x3d3d
000003DF  3D3D3D            cmp ax,0x3d3d
000003E2  3D3D3D            cmp ax,0x3d3d
000003E5  3D3D3D            cmp ax,0x3d3d
000003E8  3D3D3D            cmp ax,0x3d3d
000003EB  3D3D3D            cmp ax,0x3d3d
000003EE  0D0A20            or ax,0x200a
000003F1  2020              and [bx+si],ah
000003F3  2020              and [bx+si],ah
000003F5  2020              and [bx+si],ah
000003F7  2020              and [bx+si],ah
000003F9  2020              and [bx+si],ah
000003FB  2020              and [bx+si],ah
000003FD  2020              and [bx+si],ah
000003FF  2020              and [bx+si],ah
00000401  2020              and [bx+si],ah
00000403  204279            and [bp+si+0x79],al
00000406  7465              jz 0x46d
00000408  7320              jnc 0x42a
0000040A  46                inc si
0000040B  7265              jc 0x472
0000040D  65206F66          and [gs:bx+0x66],ch
00000411  2020              and [bx+si],ah
00000413  2020              and [bx+si],ah
00000415  2020              and [bx+si],ah
00000417  2020              and [bx+si],ah
00000419  2020              and [bx+si],ah
0000041B  2020              and [bx+si],ah
0000041D  2020              and [bx+si],ah
0000041F  2020              and [bx+si],ah
00000421  2020              and [bx+si],ah
00000423  2020              and [bx+si],ah
00000425  2020              and [bx+si],ah
00000427  2020              and [bx+si],ah
00000429  2020              and [bx+si],ah
0000042B  204279            and [bp+si+0x79],al
0000042E  7465              jz 0x495
00000430  7320              jnc 0x452
00000432  54                push sp
00000433  6F                outsw
00000434  7461              jz 0x497
00000436  6C                insb
00000437  0D0A20            or ax,0x200a
0000043A  2D2D2D            sub ax,0x2d2d
0000043D  2D2D2D            sub ax,0x2d2d
00000440  2D2D2D            sub ax,0x2d2d
00000443  2D2D2D            sub ax,0x2d2d
00000446  2D2D2D            sub ax,0x2d2d
00000449  2D2D2D            sub ax,0x2d2d
0000044C  2D2D2D            sub ax,0x2d2d
0000044F  2D2D2D            sub ax,0x2d2d
00000452  2D2D2D            sub ax,0x2d2d
00000455  2D2D2D            sub ax,0x2d2d
00000458  2D2D2D            sub ax,0x2d2d
0000045B  2D2D2D            sub ax,0x2d2d
0000045E  2D2D2D            sub ax,0x2d2d
00000461  2D2D2D            sub ax,0x2d2d
00000464  2D2D2D            sub ax,0x2d2d
00000467  2D2D2D            sub ax,0x2d2d
0000046A  2D2D2D            sub ax,0x2d2d
0000046D  2D2D2D            sub ax,0x2d2d
00000470  2D2D2D            sub ax,0x2d2d
00000473  2D2D2D            sub ax,0x2d2d
00000476  2D2D2D            sub ax,0x2d2d
00000479  2D2D2D            sub ax,0x2d2d
0000047C  2D2D2D            sub ax,0x2d2d
0000047F  2D2D2D            sub ax,0x2d2d
00000482  2D2D2D            sub ax,0x2d2d
00000485  2D2D2D            sub ax,0x2d2d
00000488  0D0A20            or ax,0x200a
0000048B  3D3D3E            cmp ax,0x3e3d
0000048E  2020              and [bx+si],ah
00000490  2020              and [bx+si],ah
00000492  2020              and [bx+si],ah
00000494  43                inc bx
00000495  6F                outsw
00000496  6E                outsb
00000497  7469              jz 0x502
00000499  6E                outsb
0000049A  7565              jnz 0x501
0000049C  203D              and [di],bh
0000049E  2020              and [bx+si],ah
000004A0  43                inc bx
000004A1  52                push dx
000004A2  2020              and [bx+si],ah
000004A4  2020              and [bx+si],ah
000004A6  2020              and [bx+si],ah
000004A8  2020              and [bx+si],ah
000004AA  2020              and [bx+si],ah
000004AC  2020              and [bx+si],ah
000004AE  2020              and [bx+si],ah
000004B0  2020              and [bx+si],ah
000004B2  2020              and [bx+si],ah
000004B4  2020              and [bx+si],ah
000004B6  2020              and [bx+si],ah
000004B8  2020              and [bx+si],ah
000004BA  204162            and [bx+di+0x62],al
000004BD  6F                outsw
000004BE  7274              jc 0x534
000004C0  203D              and [di],bh
000004C2  2020              and [bx+si],ah
000004C4  5E                pop si
000004C5  43                inc bx
000004C6  2020              and [bx+si],ah
000004C8  2020              and [bx+si],ah
000004CA  2020              and [bx+si],ah
000004CC  20A02020          and [bx+si+0x2020],ah
000004D0  2020              and [bx+si],ah
000004D2  2020              and [bx+si],ah
000004D4  2020              and [bx+si],ah
000004D6  2020              and [bx+si],ah
000004D8  2020              and [bx+si],ah
000004DA  2020              and [bx+si],ah
000004DC  2020              and [bx+si],ah
000004DE  2020              and [bx+si],ah
000004E0  2020              and [bx+si],ah
000004E2  2020              and [bx+si],ah
000004E4  2020              and [bx+si],ah
000004E6  2020              and [bx+si],ah
000004E8  2020              and [bx+si],ah
000004EA  2020              and [bx+si],ah
000004EC  2020              and [bx+si],ah
000004EE  2020              and [bx+si],ah
000004F0  203A              and [bp+si],bh
000004F2  2020              and [bx+si],ah
000004F4  207C20            and [si+0x20],bh
000004F7  2020              and [bx+si],ah
000004F9  2020              and [bx+si],ah
000004FB  2020              and [bx+si],ah
000004FD  2020              and [bx+si],ah
000004FF  2020              and [bx+si],ah
00000501  2020              and [bx+si],ah
00000503  2020              and [bx+si],ah
00000505  2020              and [bx+si],ah
00000507  2020              and [bx+si],ah
00000509  2020              and [bx+si],ah
0000050B  2020              and [bx+si],ah
0000050D  2020              and [bx+si],ah
0000050F  2020              and [bx+si],ah
00000511  2020              and [bx+si],ah
00000513  2020              and [bx+si],ah
00000515  2020              and [bx+si],ah
00000517  2020              and [bx+si],ah
00000519  3A20              cmp ah,[bx+si]
0000051B  20A00000          and [bx+si+0x0],ah
0000051F  0000              add [bx+si],al
00000521  DB0D              fisttp dword [di]
00000523  0000              add [bx+si],al
00000525  0000              add [bx+si],al
00000527  0000              add [bx+si],al
00000529  0000              add [bx+si],al
0000052B  0300              add ax,[bx+si]
0000052D  0000              add [bx+si],al
0000052F  DB0D              fisttp dword [di]
00000531  0000              add [bx+si],al
00000533  0000              add [bx+si],al
00000535  0000              add [bx+si],al
00000537  0000              add [bx+si],al
00000539  0000              add [bx+si],al
0000053B  0000              add [bx+si],al
0000053D  0000              add [bx+si],al
0000053F  0000              add [bx+si],al
00000541  0000              add [bx+si],al
00000543  0000              add [bx+si],al
00000545  0000              add [bx+si],al
00000547  0000              add [bx+si],al
00000549  0000              add [bx+si],al
0000054B  0000              add [bx+si],al
0000054D  0000              add [bx+si],al
0000054F  0000              add [bx+si],al
00000551  0000              add [bx+si],al
00000553  0000              add [bx+si],al
00000555  0000              add [bx+si],al
00000557  0000              add [bx+si],al
00000559  0000              add [bx+si],al
0000055B  0000              add [bx+si],al
0000055D  0000              add [bx+si],al
0000055F  0000              add [bx+si],al
00000561  0000              add [bx+si],al
00000563  0000              add [bx+si],al
00000565  0000              add [bx+si],al
00000567  0000              add [bx+si],al
00000569  0000              add [bx+si],al
0000056B  0000              add [bx+si],al
0000056D  0000              add [bx+si],al
0000056F  0000              add [bx+si],al
00000571  0000              add [bx+si],al
00000573  0000              add [bx+si],al
00000575  0000              add [bx+si],al
00000577  0000              add [bx+si],al
00000579  0000              add [bx+si],al
0000057B  0000              add [bx+si],al
0000057D  0000              add [bx+si],al
0000057F  0000              add [bx+si],al
00000581  0000              add [bx+si],al
00000583  0000              add [bx+si],al
00000585  0000              add [bx+si],al
00000587  0000              add [bx+si],al
00000589  0000              add [bx+si],al
0000058B  0000              add [bx+si],al
0000058D  0000              add [bx+si],al
0000058F  0000              add [bx+si],al
00000591  0000              add [bx+si],al
00000593  0000              add [bx+si],al
00000595  0000              add [bx+si],al
00000597  0000              add [bx+si],al
00000599  0000              add [bx+si],al
0000059B  0000              add [bx+si],al
0000059D  0000              add [bx+si],al
0000059F  0000              add [bx+si],al
000005A1  0000              add [bx+si],al
000005A3  0000              add [bx+si],al
000005A5  0000              add [bx+si],al
000005A7  0000              add [bx+si],al
000005A9  0000              add [bx+si],al
000005AB  0000              add [bx+si],al
000005AD  0000              add [bx+si],al
000005AF  0000              add [bx+si],al
000005B1  0000              add [bx+si],al
000005B3  0000              add [bx+si],al
000005B5  0000              add [bx+si],al
000005B7  0000              add [bx+si],al
000005B9  0000              add [bx+si],al
000005BB  0000              add [bx+si],al
000005BD  0000              add [bx+si],al
000005BF  0000              add [bx+si],al
000005C1  0000              add [bx+si],al
000005C3  0000              add [bx+si],al
000005C5  0000              add [bx+si],al
000005C7  0000              add [bx+si],al
000005C9  0000              add [bx+si],al
000005CB  0000              add [bx+si],al
000005CD  0000              add [bx+si],al
000005CF  0000              add [bx+si],al
000005D1  0000              add [bx+si],al
000005D3  0000              add [bx+si],al
000005D5  0000              add [bx+si],al
000005D7  0000              add [bx+si],al
000005D9  2020              and [bx+si],ah
000005DB  2020              and [bx+si],ah
000005DD  2020              and [bx+si],ah
000005DF  2020              and [bx+si],ah
000005E1  2020              and [bx+si],ah
000005E3  2020              and [bx+si],ah
000005E5  2020              and [bx+si],ah
000005E7  2020              and [bx+si],ah
000005E9  2020              and [bx+si],ah
000005EB  2020              and [bx+si],ah
000005ED  2020              and [bx+si],ah
000005EF  2020              and [bx+si],ah
000005F1  2020              and [bx+si],ah
000005F3  2020              and [bx+si],ah
000005F5  2020              and [bx+si],ah
000005F7  2020              and [bx+si],ah
000005F9  2020              and [bx+si],ah
000005FB  2020              and [bx+si],ah
000005FD  2020              and [bx+si],ah
000005FF  207C20            and [si+0x20],bh
00000602  2020              and [bx+si],ah
00000604  2020              and [bx+si],ah
00000606  2020              and [bx+si],ah
00000608  2020              and [bx+si],ah
0000060A  2020              and [bx+si],ah
0000060C  2020              and [bx+si],ah
0000060E  2020              and [bx+si],ah
00000610  2020              and [bx+si],ah
00000612  2020              and [bx+si],ah
00000614  2020              and [bx+si],ah
00000616  2020              and [bx+si],ah
00000618  2020              and [bx+si],ah
0000061A  2020              and [bx+si],ah
0000061C  2020              and [bx+si],ah
0000061E  2020              and [bx+si],ah
00000620  2020              and [bx+si],ah
00000622  2020              and [bx+si],ah
00000624  2020              and [bx+si],ah
00000626  2020              and [bx+si],ah
00000628  0D8A00            or ax,0x8a
0000062B  0000              add [bx+si],al
0000062D  0000              add [bx+si],al
0000062F  0000              add [bx+si],al
00000631  0000              add [bx+si],al
00000633  0000              add [bx+si],al
00000635  0000              add [bx+si],al
00000637  0000              add [bx+si],al
00000639  0000              add [bx+si],al
0000063B  0000              add [bx+si],al
0000063D  0000              add [bx+si],al
0000063F  0000              add [bx+si],al
00000641  0000              add [bx+si],al
00000643  0000              add [bx+si],al
00000645  0000              add [bx+si],al
00000647  0000              add [bx+si],al
00000649  0000              add [bx+si],al
0000064B  0000              add [bx+si],al
0000064D  0000              add [bx+si],al
0000064F  0000              add [bx+si],al
00000651  0000              add [bx+si],al
00000653  0000              add [bx+si],al
00000655  0000              add [bx+si],al
00000657  0000              add [bx+si],al
00000659  0000              add [bx+si],al
0000065B  0000              add [bx+si],al
0000065D  0000              add [bx+si],al
0000065F  0000              add [bx+si],al
00000661  0000              add [bx+si],al
00000663  0000              add [bx+si],al
00000665  0000              add [bx+si],al
00000667  0000              add [bx+si],al
00000669  0000              add [bx+si],al
0000066B  0000              add [bx+si],al
0000066D  0000              add [bx+si],al
0000066F  0000              add [bx+si],al
00000671  0000              add [bx+si],al
00000673  0000              add [bx+si],al
00000675  58                pop ax
00000676  3A5C00            cmp bl,[si+0x0]
00000679  0000              add [bx+si],al
0000067B  0000              add [bx+si],al
0000067D  0000              add [bx+si],al
0000067F  0000              add [bx+si],al
00000681  0000              add [bx+si],al
00000683  0000              add [bx+si],al
00000685  0000              add [bx+si],al
00000687  0000              add [bx+si],al
00000689  0000              add [bx+si],al
0000068B  0000              add [bx+si],al
0000068D  0000              add [bx+si],al
0000068F  0000              add [bx+si],al
00000691  0000              add [bx+si],al
00000693  0000              add [bx+si],al
00000695  0000              add [bx+si],al
00000697  0000              add [bx+si],al
00000699  0000              add [bx+si],al
0000069B  0000              add [bx+si],al
0000069D  0000              add [bx+si],al
0000069F  0000              add [bx+si],al
000006A1  0000              add [bx+si],al
000006A3  0000              add [bx+si],al
000006A5  0000              add [bx+si],al
000006A7  0000              add [bx+si],al
000006A9  0000              add [bx+si],al
000006AB  0000              add [bx+si],al
000006AD  0000              add [bx+si],al
000006AF  0000              add [bx+si],al
000006B1  0000              add [bx+si],al
000006B3  0000              add [bx+si],al
000006B5  0000              add [bx+si],al
000006B7  0000              add [bx+si],al
000006B9  0000              add [bx+si],al
000006BB  0000              add [bx+si],al
000006BD  00583A            add [bx+si+0x3a],bl
000006C0  5C                pop sp
000006C1  2A2E2A00          sub ch,[0x2a]
000006C5  0000              add [bx+si],al
000006C7  07                pop es
000006C8  0920              or [bx+si],sp
000006CA  2B2C              sub bp,[si]
000006CC  3A3B              cmp bh,[bp+di]
000006CE  3D0A00            cmp ax,0xa
000006D1  0822              or [bp+si],ah
000006D3  2F                das
000006D4  3C3E              cmp al,0x3e
000006D6  5B                pop bx
000006D7  5C                pop sp
000006D8  5D                pop bp
000006D9  7C00              jl 0x6db
000006DB  2E2123            and [cs:bp+di],sp
000006DE  2425              and al,0x25
000006E0  2627              es daa
000006E2  2829              sub [bx+di],ch
000006E4  2D5E5F            sub ax,0x5f5e
000006E7  60                pusha
000006E8  7B7D              jpo 0x767
000006EA  7E00              jng 0x6ec
000006EC  0000              add [bx+si],al
000006EE  0000              add [bx+si],al
000006F0  DB0D              fisttp dword [di]
000006F2  3CFF              cmp al,0xff
000006F4  7505              jnz 0x6fb
000006F6  B00F              mov al,0xf
000006F8  E98B04            jmp 0xb86
000006FB  B425              mov ah,0x25
000006FD  B023              mov al,0x23
000006FF  BAC409            mov dx,0x9c4
00000702  CD21              int 0x21
00000704  B408              mov ah,0x8
00000706  BB0700            mov bx,0x7
00000709  CD10              int 0x10
0000070B  88262E06          mov [0x62e],ah
0000070F  B433              mov ah,0x33
00000711  B000              mov al,0x0
00000713  CD21              int 0x21
00000715  88162505          mov [0x525],dl
00000719  B433              mov ah,0x33
0000071B  B001              mov al,0x1
0000071D  B200              mov dl,0x0
0000071F  CD21              int 0x21
00000721  A10600            mov ax,[0x6]
00000724  2DDB0D            sub ax,0xddb
00000727  B91600            mov cx,0x16
0000072A  33D2              xor dx,dx
0000072C  F7F1              div cx
0000072E  A3B905            mov [0x5b9],ax
00000731  A3B705            mov [0x5b7],ax
00000734  33D2              xor dx,dx
00000736  F7E1              mul cx
00000738  A31F05            mov [0x51f],ax
0000073B  05DB0D            add ax,0xddb
0000073E  A31D05            mov [0x51d],ax
00000741  FB                sti
00000742  FC                cld
00000743  BE8000            mov si,0x80
00000746  33C0              xor ax,ax
00000748  AC                lodsb
00000749  03F0              add si,ax
0000074B  C60400            mov byte [si],0x0
0000074E  46                inc si
0000074F  89362605          mov [0x526],si
00000753  BE8100            mov si,0x81
00000756  89362905          mov [0x529],si
0000075A  A12605            mov ax,[0x526]
0000075D  2BC6              sub ax,si
0000075F  A22805            mov [0x528],al
00000762  B42F              mov ah,0x2f
00000764  CD21              int 0x21
00000766  8CC0              mov ax,es
00000768  A32A06            mov [0x62a],ax
0000076B  891E2C06          mov [0x62c],bx
0000076F  90                nop
00000770  90                nop
00000771  A05C00            mov al,[0x5c]
00000774  3C00              cmp al,0x0
00000776  7506              jnz 0x77e
00000778  B419              mov ah,0x19
0000077A  CD21              int 0x21
0000077C  FEC0              inc al
0000077E  0440              add al,0x40
00000780  A2BE06            mov [0x6be],al
00000783  A27506            mov [0x675],al
00000786  90                nop
00000787  90                nop
00000788  BA3505            mov dx,0x535
0000078B  8CC8              mov ax,cs
0000078D  8EC0              mov es,ax
0000078F  B41A              mov ah,0x1a
00000791  CD21              int 0x21
00000793  90                nop
00000794  90                nop
00000795  BABE06            mov dx,0x6be
00000798  B90800            mov cx,0x8
0000079B  B44E              mov ah,0x4e
0000079D  CD21              int 0x21
0000079F  B90B00            mov cx,0xb
000007A2  BE5305            mov si,0x553
000007A5  BFA002            mov di,0x2a0
000007A8  803E4A0508        cmp byte [0x54a],0x8
000007AD  740E              jz 0x7bd
000007AF  B44F              mov ah,0x4f
000007B1  CD21              int 0x21
000007B3  7204              jc 0x7b9
000007B5  EBE8              jmp short 0x79f
000007B7  90                nop
000007B8  90                nop
000007B9  B02D              mov al,0x2d
000007BB  EB11              jmp short 0x7ce
000007BD  FC                cld
000007BE  AC                lodsb
000007BF  3C2E              cmp al,0x2e
000007C1  74FA              jz 0x7bd
000007C3  AA                stosb
000007C4  3C00              cmp al,0x0
000007C6  E0F5              loopne 0x7bd
000007C8  E306              jcxz 0x7d0
000007CA  4F                dec di
000007CB  41                inc cx
000007CC  B020              mov al,0x20
000007CE  F3AA              rep stosb
000007D0  BE3406            mov si,0x634
000007D3  B447              mov ah,0x47
000007D5  8BFE              mov di,si
000007D7  8A165C00          mov dl,[0x5c]
000007DB  CD21              int 0x21
000007DD  8BF7              mov si,di
000007DF  33C0              xor ax,ax
000007E1  FECC              dec ah
000007E3  B94000            mov cx,0x40
000007E6  FC                cld
000007E7  FEC4              inc ah
000007E9  AE                scasb
000007EA  E0FB              loopne 0x7e7
000007EC  8864FF            mov [si-0x1],ah
000007EF  B401              mov ah,0x1
000007F1  B94600            mov cx,0x46
000007F4  BE8100            mov si,0x81
000007F7  8A04              mov al,[si]
000007F9  E89800            call 0x894
000007FC  7505              jnz 0x803
000007FE  E8BE00            call 0x8bf
00000801  E2F4              loop 0x7f7
00000803  803E5C0000        cmp byte [0x5c],0x0
00000808  7417              jz 0x821
0000080A  E8B200            call 0x8bf
0000080D  E8AF00            call 0x8bf
00000810  B401              mov ah,0x1
00000812  B94600            mov cx,0x46
00000815  8A04              mov al,[si]
00000817  E87A00            call 0x894
0000081A  7505              jnz 0x821
0000081C  E8A000            call 0x8bf
0000081F  E2F4              loop 0x815
00000821  803C2E            cmp byte [si],0x2e
00000824  7546              jnz 0x86c
00000826  807C012E          cmp byte [si+0x1],0x2e
0000082A  752C              jnz 0x858
0000082C  8A1E3306          mov bl,[0x633]
00000830  80FB00            cmp bl,0x0
00000833  7505              jnz 0x83a
00000835  B00F              mov al,0xf
00000837  E94C03            jmp 0xb86
0000083A  56                push si
0000083B  BE3406            mov si,0x634
0000083E  32FF              xor bh,bh
00000840  B402              mov ah,0x2
00000842  4B                dec bx
00000843  8A00              mov al,[bx+si]
00000845  E84C00            call 0x894
00000848  C60000            mov byte [bx+si],0x0
0000084B  7404              jz 0x851
0000084D  0BDB              or bx,bx
0000084F  75F1              jnz 0x842
00000851  885CFF            mov [si-0x1],bl
00000854  5E                pop si
00000855  E86700            call 0x8bf
00000858  E86400            call 0x8bf
0000085B  B401              mov ah,0x1
0000085D  B94600            mov cx,0x46
00000860  8A04              mov al,[si]
00000862  E82F00            call 0x894
00000865  7505              jnz 0x86c
00000867  E85500            call 0x8bf
0000086A  E2F4              loop 0x860
0000086C  B402              mov ah,0x2
0000086E  B94600            mov cx,0x46
00000871  8A04              mov al,[si]
00000873  E81E00            call 0x894
00000876  755C              jnz 0x8d4
00000878  B400              mov ah,0x0
0000087A  E84200            call 0x8bf
0000087D  8A04              mov al,[si]
0000087F  E81200            call 0x894
00000882  E1F6              loope 0x87a
00000884  BF7806            mov di,0x678
00000887  803E800000        cmp byte [0x80],0x0
0000088C  7403              jz 0x891
0000088E  EB75              jmp short 0x905
00000890  90                nop
00000891  E99300            jmp 0x927
00000894  50                push ax
00000895  51                push cx
00000896  57                push di
00000897  33C9              xor cx,cx
00000899  80FC02            cmp ah,0x2
0000089C  7409              jz 0x8a7
0000089E  BFC806            mov di,0x6c8
000008A1  8A0EC706          mov cl,[0x6c7]
000008A5  EB07              jmp short 0x8ae
000008A7  BFD206            mov di,0x6d2
000008AA  8A0ED106          mov cl,[0x6d1]
000008AE  FC                cld
000008AF  F2AE              repne scasb
000008B1  E304              jcxz 0x8b7
000008B3  5F                pop di
000008B4  59                pop cx
000008B5  58                pop ax
000008B6  C3                ret
000008B7  0AE4              or ah,ah
000008B9  75F8              jnz 0x8b3
000008BB  FEC4              inc ah
000008BD  EBE8              jmp short 0x8a7
000008BF  51                push cx
000008C0  56                push si
000008C1  57                push di
000008C2  33C9              xor cx,cx
000008C4  8A4CFF            mov cl,[si-0x1]
000008C7  FE4CFF            dec byte [si-0x1]
000008CA  8BFE              mov di,si
000008CC  46                inc si
000008CD  FC                cld
000008CE  F3A4              rep movsb
000008D0  5F                pop di
000008D1  5E                pop si
000008D2  59                pop cx
000008D3  C3                ret
000008D4  BE3406            mov si,0x634
000008D7  8A64FF            mov ah,[si-0x1]
000008DA  803E800000        cmp byte [0x80],0x0
000008DF  7513              jnz 0x8f4
000008E1  0AE4              or ah,ah
000008E3  BF7806            mov di,0x678
000008E6  743F              jz 0x927
000008E8  33C9              xor cx,cx
000008EA  8ACC              mov cl,ah
000008EC  F3A4              rep movsb
000008EE  C6055C            mov byte [di],0x5c
000008F1  47                inc di
000008F2  EB33              jmp short 0x927
000008F4  0AE4              or ah,ah
000008F6  BF7806            mov di,0x678
000008F9  740A              jz 0x905
000008FB  33C9              xor cx,cx
000008FD  8ACC              mov cl,ah
000008FF  F3A4              rep movsb
00000901  C6055C            mov byte [di],0x5c
00000904  47                inc di
00000905  BE8100            mov si,0x81
00000908  33C9              xor cx,cx
0000090A  8A4CFF            mov cl,[si-0x1]
0000090D  F3A4              rep movsb
0000090F  893EB806          mov [0x6b8],di
00000913  B443              mov ah,0x43
00000915  BA7506            mov dx,0x675
00000918  B000              mov al,0x0
0000091A  CD21              int 0x21
0000091C  721C              jc 0x93a
0000091E  F6C110            test cl,0x10
00000921  7417              jz 0x93a
00000923  C6055C            mov byte [di],0x5c
00000926  47                inc di
00000927  C6052A            mov byte [di],0x2a
0000092A  47                inc di
0000092B  C6052E            mov byte [di],0x2e
0000092E  47                inc di
0000092F  C6052A            mov byte [di],0x2a
00000932  47                inc di
00000933  C60500            mov byte [di],0x0
00000936  893EB806          mov [0x6b8],di
0000093A  BF7506            mov di,0x675
0000093D  8BF7              mov si,di
0000093F  33C0              xor ax,ax
00000941  B95000            mov cx,0x50
00000944  FEC4              inc ah
00000946  AE                scasb
00000947  E0FB              loopne 0x944
00000949  33C9              xor cx,cx
0000094B  8ACC              mov cl,ah
0000094D  BF1B02            mov di,0x21b
00000950  F3A4              rep movsb
00000952  BA7506            mov dx,0x675
00000955  B44E              mov ah,0x4e
00000957  B9F100            mov cx,0xf1
0000095A  CD21              int 0x21
0000095C  7303              jnc 0x961
0000095E  E92502            jmp 0xb86
00000961  E88C00            call 0x9f0
00000964  BEBF05            mov si,0x5bf
00000967  BFDB0D            mov di,0xddb
0000096A  B90B00            mov cx,0xb
0000096D  F3A5              rep movsw
0000096F  8306210516        add word [0x521],byte +0x16
00000974  FF0EB705          dec word [0x5b7]
00000978  B44F              mov ah,0x4f
0000097A  CD21              int 0x21
0000097C  720C              jc 0x98a
0000097E  E86F00            call 0x9f0
00000981  E8E000            call 0xa64
00000984  FF0EB705          dec word [0x5b7]
00000988  75EE              jnz 0x978
0000098A  3C12              cmp al,0x12
0000098C  7403              jz 0x991
0000098E  E9F501            jmp 0xb86
00000991  E8A801            call 0xb3c
00000994  E84C01            call 0xae3
00000997  A1BC06            mov ax,[0x6bc]
0000099A  A33105            mov [0x531],ax
0000099D  B8DB0D            mov ax,0xddb
000009A0  A32F05            mov [0x52f],ax
000009A3  E81C02            call 0xbc2
000009A6  B402              mov ah,0x2
000009A8  BB0700            mov bx,0x7
000009AB  B61A              mov dh,0x1a
000009AD  B200              mov dl,0x0
000009AF  CD10              int 0x10
000009B1  E8FE01            call 0xbb2
000009B4  EBED              jmp short 0x9a3
000009B6  B402              mov ah,0x2
000009B8  BB0700            mov bx,0x7
000009BB  B61A              mov dh,0x1a
000009BD  B200              mov dl,0x0
000009BF  CD10              int 0x10
000009C1  E8EE01            call 0xbb2
000009C4  B80006            mov ax,0x600
000009C7  8A3E2E06          mov bh,[0x62e]
000009CB  B307              mov bl,0x7
000009CD  B90015            mov cx,0x1500
000009D0  B618              mov dh,0x18
000009D2  B24F              mov dl,0x4f
000009D4  CD10              int 0x10
000009D6  B402              mov ah,0x2
000009D8  BB0700            mov bx,0x7
000009DB  BA0015            mov dx,0x1500
000009DE  CD10              int 0x10
000009E0  B433              mov ah,0x33
000009E2  B001              mov al,0x1
000009E4  8A162505          mov dl,[0x525]
000009E8  CD21              int 0x21
000009EA  33C0              xor ax,ax
000009EC  CD21              int 0x21
000009EE  90                nop
000009EF  90                nop
000009F0  FC                cld
000009F1  BE4A05            mov si,0x54a
000009F4  BFBF05            mov di,0x5bf
000009F7  AC                lodsb
000009F8  8AE0              mov ah,al
000009FA  B001              mov al,0x1
000009FC  FF06BC06          inc word [0x6bc]
00000A00  FF06B505          inc word [0x5b5]
00000A04  F6C410            test ah,0x10
00000A07  740A              jz 0xa13
00000A09  32C0              xor al,al
00000A0B  FF0EB505          dec word [0x5b5]
00000A0F  FF063305          inc word [0x533]
00000A13  AA                stosb
00000A14  BE5305            mov si,0x553
00000A17  B90D00            mov cx,0xd
00000A1A  AC                lodsb
00000A1B  3C61              cmp al,0x61
00000A1D  7206              jc 0xa25
00000A1F  3C7B              cmp al,0x7b
00000A21  730A              jnc 0xa2d
00000A23  2C20              sub al,0x20
00000A25  3C30              cmp al,0x30
00000A27  7204              jc 0xa2d
00000A29  3C5B              cmp al,0x5b
00000A2B  721C              jc 0xa49
00000A2D  57                push di
00000A2E  51                push cx
00000A2F  BFDA06            mov di,0x6da
00000A32  B91200            mov cx,0x12
00000A35  F2AE              repne scasb
00000A37  E30A              jcxz 0xa43
00000A39  41                inc cx
00000A3A  F7D9              neg cx
00000A3C  83C112            add cx,byte +0x12
00000A3F  8AC1              mov al,cl
00000A41  EB04              jmp short 0xa47
00000A43  4F                dec di
00000A44  AA                stosb
00000A45  B012              mov al,0x12
00000A47  59                pop cx
00000A48  5F                pop di
00000A49  AA                stosb
00000A4A  E2CE              loop 0xa1a
00000A4C  BE4F05            mov si,0x54f
00000A4F  AD                lodsw
00000A50  AB                stosw
00000A51  0106BB05          add [0x5bb],ax
00000A55  AD                lodsw
00000A56  AB                stosw
00000A57  1106BD05          adc [0x5bd],ax
00000A5B  BE4D05            mov si,0x54d
00000A5E  A5                movsw
00000A5F  BE4B05            mov si,0x54b
00000A62  A5                movsw
00000A63  C3                ret
00000A64  FC                cld
00000A65  BFDB0D            mov di,0xddb
00000A68  893EC506          mov [0x6c5],di
00000A6C  8B0EBC06          mov cx,[0x6bc]
00000A70  BEBF05            mov si,0x5bf
00000A73  B40E              mov ah,0xe
00000A75  FECC              dec ah
00000A77  7422              jz 0xa9b
00000A79  A6                cmpsb
00000A7A  74F9              jz 0xa75
00000A7C  721D              jc 0xa9b
00000A7E  8306C50616        add word [0x6c5],byte +0x16
00000A83  8B3EC506          mov di,[0x6c5]
00000A87  49                dec cx
00000A88  75E6              jnz 0xa70
00000A8A  BEBF05            mov si,0x5bf
00000A8D  8B3E2105          mov di,[0x521]
00000A91  B90B00            mov cx,0xb
00000A94  F3A5              rep movsw
00000A96  893E2105          mov [0x521],di
00000A9A  C3                ret
00000A9B  F7D9              neg cx
00000A9D  030EBC06          add cx,[0x6bc]
00000AA1  D1E1              shl cx,1
00000AA3  8BC1              mov ax,cx
00000AA5  D1E0              shl ax,1
00000AA7  D1E0              shl ax,1
00000AA9  D1E0              shl ax,1
00000AAB  03C1              add ax,cx
00000AAD  D1E1              shl cx,1
00000AAF  03C8              add cx,ax
00000AB1  81C1DB0D          add cx,0xddb
00000AB5  890ED705          mov [0x5d7],cx
00000AB9  F7D9              neg cx
00000ABB  030E2105          add cx,[0x521]
00000ABF  D1E9              shr cx,1
00000AC1  8B3E2105          mov di,[0x521]
00000AC5  8BF7              mov si,di
00000AC7  4E                dec si
00000AC8  4E                dec si
00000AC9  83C716            add di,byte +0x16
00000ACC  893E2105          mov [0x521],di
00000AD0  4F                dec di
00000AD1  4F                dec di
00000AD2  FD                std
00000AD3  F3A5              rep movsw
00000AD5  FC                cld
00000AD6  BEBF05            mov si,0x5bf
00000AD9  8B3ED705          mov di,[0x5d7]
00000ADD  B90B00            mov cx,0xb
00000AE0  F3A5              rep movsw
00000AE2  C3                ret
00000AE3  B402              mov ah,0x2
00000AE5  B615              mov dh,0x15
00000AE7  B200              mov dl,0x0
00000AE9  BB0700            mov bx,0x7
00000AEC  CD10              int 0x10
00000AEE  8A16BE06          mov dl,[0x6be]
00000AF2  80EA40            sub dl,0x40
00000AF5  B436              mov ah,0x36
00000AF7  CD21              int 0x21
00000AF9  52                push dx
00000AFA  F7E1              mul cx
00000AFC  52                push dx
00000AFD  50                push ax
00000AFE  8BCA              mov cx,dx
00000B00  F7E3              mul bx
00000B02  8BFA              mov di,dx
00000B04  8BF0              mov si,ax
00000B06  8BC1              mov ax,cx
00000B08  F7E3              mul bx
00000B0A  03C7              add ax,di
00000B0C  8BD0              mov dx,ax
00000B0E  8BC6              mov ax,si
00000B10  B90D00            mov cx,0xd
00000B13  BFF603            mov di,0x3f6
00000B16  E82801            call 0xc41
00000B19  58                pop ax
00000B1A  59                pop cx
00000B1B  5B                pop bx
00000B1C  F7E3              mul bx
00000B1E  8BFA              mov di,dx
00000B20  8BF0              mov si,ax
00000B22  8BC1              mov ax,cx
00000B24  F7E3              mul bx
00000B26  03C7              add ax,di
00000B28  8BD0              mov dx,ax
00000B2A  8BC6              mov ax,si
00000B2C  B90D00            mov cx,0xd
00000B2F  BF1E04            mov di,0x41e
00000B32  E80C01            call 0xc41
00000B35  BE9F03            mov si,0x39f
00000B38  E88D02            call 0xdc8
00000B3B  C3                ret
00000B3C  B406              mov ah,0x6
00000B3E  32C0              xor al,al
00000B40  B70E              mov bh,0xe
00000B42  33C9              xor cx,cx
00000B44  B618              mov dh,0x18
00000B46  B24F              mov dl,0x4f
00000B48  CD10              int 0x10
00000B4A  B402              mov ah,0x2
00000B4C  33D2              xor dx,dx
00000B4E  BB0700            mov bx,0x7
00000B51  CD10              int 0x10
00000B53  33D2              xor dx,dx
00000B55  A13305            mov ax,[0x533]
00000B58  B90500            mov cx,0x5
00000B5B  BF5C02            mov di,0x25c
00000B5E  E8E000            call 0xc41
00000B61  33D2              xor dx,dx
00000B63  A1B505            mov ax,[0x5b5]
00000B66  B90500            mov cx,0x5
00000B69  BF6D02            mov di,0x26d
00000B6C  E8D200            call 0xc41
00000B6F  8B16BD05          mov dx,[0x5bd]
00000B73  A1BB05            mov ax,[0x5bb]
00000B76  B90D00            mov cx,0xd
00000B79  BF8002            mov di,0x280
00000B7C  E8C200            call 0xc41
00000B7F  BE0C02            mov si,0x20c
00000B82  E84302            call 0xdc8
00000B85  C3                ret
00000B86  3C02              cmp al,0x2
00000B88  BE2301            mov si,0x123
00000B8B  741F              jz 0xbac
00000B8D  3C03              cmp al,0x3
00000B8F  BE3601            mov si,0x136
00000B92  7418              jz 0xbac
00000B94  3C04              cmp al,0x4
00000B96  BE4901            mov si,0x149
00000B99  7411              jz 0xbac
00000B9B  3C08              cmp al,0x8
00000B9D  BE7E01            mov si,0x17e
00000BA0  740A              jz 0xbac
00000BA2  3C0F              cmp al,0xf
00000BA4  BED001            mov si,0x1d0
00000BA7  7403              jz 0xbac
00000BA9  BE1001            mov si,0x110
00000BAC  E81902            call 0xdc8
00000BAF  E938FE            jmp 0x9ea
00000BB2  B407              mov ah,0x7
00000BB4  CD21              int 0x21
00000BB6  3C03              cmp al,0x3
00000BB8  7503              jnz 0xbbd
00000BBA  E907FE            jmp 0x9c4
00000BBD  3C0D              cmp al,0xd
00000BBF  75F1              jnz 0xbb2
00000BC1  C3                ret
00000BC2  B80006            mov ax,0x600
00000BC5  B771              mov bh,0x71
00000BC7  B90005            mov cx,0x500
00000BCA  B614              mov dh,0x14
00000BCC  B24F              mov dl,0x4f
00000BCE  CD10              int 0x10
00000BD0  B402              mov ah,0x2
00000BD2  BB0700            mov bx,0x7
00000BD5  BA0005            mov dx,0x500
00000BD8  CD10              int 0x10
00000BDA  B90F00            mov cx,0xf
00000BDD  51                push cx
00000BDE  E82800            call 0xc09
00000BE1  BE0301            mov si,0x103
00000BE4  E8E101            call 0xdc8
00000BE7  59                pop cx
00000BE8  E2F3              loop 0xbdd
00000BEA  E81C00            call 0xc09
00000BED  BB0700            mov bx,0x7
00000BF0  B91000            mov cx,0x10
00000BF3  B605              mov dh,0x5
00000BF5  B229              mov dl,0x29
00000BF7  52                push dx
00000BF8  51                push cx
00000BF9  53                push bx
00000BFA  B402              mov ah,0x2
00000BFC  CD10              int 0x10
00000BFE  E82500            call 0xc26
00000C01  5B                pop bx
00000C02  59                pop cx
00000C03  5A                pop dx
00000C04  FEC6              inc dh
00000C06  E2EF              loop 0xbf7
00000C08  C3                ret
00000C09  BFCF04            mov di,0x4cf
00000C0C  E87F00            call 0xc8e
00000C0F  C606F504FC        mov byte [0x4f5],0xfc
00000C14  BECE04            mov si,0x4ce
00000C17  E8AE01            call 0xdc8
00000C1A  83062F0516        add word [0x52f],byte +0x16
00000C1F  FF0E3105          dec word [0x531]
00000C23  7419              jz 0xc3e
00000C25  C3                ret
00000C26  BFF704            mov di,0x4f7
00000C29  E86200            call 0xc8e
00000C2C  BEF704            mov si,0x4f7
00000C2F  E89601            call 0xdc8
00000C32  83062F0516        add word [0x52f],byte +0x16
00000C37  FF0E3105          dec word [0x531]
00000C3B  7401              jz 0xc3e
00000C3D  C3                ret
00000C3E  E975FD            jmp 0x9b6
00000C41  C6062B0503        mov byte [0x52b],0x3
00000C46  53                push bx
00000C47  51                push cx
00000C48  57                push di
00000C49  56                push si
00000C4A  8BD8              mov bx,ax
00000C4C  8BF2              mov si,dx
00000C4E  FD                std
00000C4F  03F9              add di,cx
00000C51  4F                dec di
00000C52  33D2              xor dx,dx
00000C54  8BC6              mov ax,si
00000C56  F736CF06          div word [0x6cf]
00000C5A  8BF0              mov si,ax
00000C5C  8BC3              mov ax,bx
00000C5E  F736CF06          div word [0x6cf]
00000C62  8BD8              mov bx,ax
00000C64  803E2B0500        cmp byte [0x52b],0x0
00000C69  750A              jnz 0xc75
00000C6B  C6062B0503        mov byte [0x52b],0x3
00000C70  C6052C            mov byte [di],0x2c
00000C73  4F                dec di
00000C74  49                dec cx
00000C75  FE0E2B05          dec byte [0x52b]
00000C79  80C230            add dl,0x30
00000C7C  8815              mov [di],dl
00000C7E  4F                dec di
00000C7F  0BC6              or ax,si
00000C81  E0CF              loopne 0xc52
00000C83  E304              jcxz 0xc89
00000C85  B020              mov al,0x20
00000C87  F3AA              rep stosb
00000C89  5E                pop si
00000C8A  5F                pop di
00000C8B  59                pop cx
00000C8C  5B                pop bx
00000C8D  C3                ret
00000C8E  893E2D05          mov [0x52d],di
00000C92  B92500            mov cx,0x25
00000C95  B020              mov al,0x20
00000C97  FC                cld
00000C98  F3AA              rep stosb
00000C9A  8B3E2D05          mov di,[0x52d]
00000C9E  8B362F05          mov si,[0x52f]
00000CA2  AC                lodsb
00000CA3  A22C05            mov [0x52c],al
00000CA6  AC                lodsb
00000CA7  3C01              cmp al,0x1
00000CA9  750D              jnz 0xcb8
00000CAB  AC                lodsb
00000CAC  3C01              cmp al,0x1
00000CAE  7203              jc 0xcb3
00000CB0  B02E              mov al,0x2e
00000CB2  AA                stosb
00000CB3  B02E              mov al,0x2e
00000CB5  AA                stosb
00000CB6  EB33              jmp short 0xceb
00000CB8  BBDA06            mov bx,0x6da
00000CBB  B90800            mov cx,0x8
00000CBE  3C41              cmp al,0x41
00000CC0  730F              jnc 0xcd1
00000CC2  3C30              cmp al,0x30
00000CC4  730D              jnc 0xcd3
00000CC6  D7                xlatb
00000CC7  3C2E              cmp al,0x2e
00000CC9  7508              jnz 0xcd3
00000CCB  B020              mov al,0x20
00000CCD  F3AA              rep stosb
00000CCF  EB0A              jmp short 0xcdb
00000CD1  0420              add al,0x20
00000CD3  AA                stosb
00000CD4  AC                lodsb
00000CD5  0AC0              or al,al
00000CD7  740B              jz 0xce4
00000CD9  E2E3              loop 0xcbe
00000CDB  B02E              mov al,0x2e
00000CDD  AA                stosb
00000CDE  B90300            mov cx,0x3
00000CE1  AC                lodsb
00000CE2  EBDA              jmp short 0xcbe
00000CE4  803E2C0500        cmp byte [0x52c],0x0
00000CE9  7510              jnz 0xcfb
00000CEB  8B3E2D05          mov di,[0x52d]
00000CEF  83C711            add di,byte +0x11
00000CF2  BE0501            mov si,0x105
00000CF5  B90B00            mov cx,0xb
00000CF8  F3A4              rep movsb
00000CFA  C3                ret
00000CFB  8B3E2D05          mov di,[0x52d]
00000CFF  83C70F            add di,byte +0xf
00000D02  8B362F05          mov si,[0x52f]
00000D06  83C60E            add si,byte +0xe
00000D09  AD                lodsw
00000D0A  8BD0              mov dx,ax
00000D0C  AD                lodsw
00000D0D  8BC8              mov cx,ax
00000D0F  0BC2              or ax,dx
00000D11  741F              jz 0xd32
00000D13  8BDA              mov bx,dx
00000D15  80E703            and bh,0x3
00000D18  8AC6              mov al,dh
00000D1A  8AE1              mov ah,cl
00000D1C  8AD5              mov dl,ch
00000D1E  32F6              xor dh,dh
00000D20  D1EA              shr dx,1
00000D22  D1D8              rcr ax,1
00000D24  D1EA              shr dx,1
00000D26  D1D8              rcr ax,1
00000D28  0AFB              or bh,bl
00000D2A  7406              jz 0xd32
00000D2C  050100            add ax,0x1
00000D2F  83D200            adc dx,byte +0x0
00000D32  B90600            mov cx,0x6
00000D35  E809FF            call 0xc41
00000D38  FC                cld
00000D39  AD                lodsw
00000D3A  8AD8              mov bl,al
00000D3C  80E31F            and bl,0x1f
00000D3F  D1E8              shr ax,1
00000D41  8AF8              mov bh,al
00000D43  D0EF              shr bh,1
00000D45  D0EF              shr bh,1
00000D47  D0EF              shr bh,1
00000D49  D0EF              shr bh,1
00000D4B  8AC4              mov al,ah
00000D4D  98                cbw
00000D4E  05BC07            add ax,0x7bc
00000D51  50                push ax
00000D52  8AC7              mov al,bh
00000D54  98                cbw
00000D55  33D2              xor dx,dx
00000D57  83C708            add di,byte +0x8
00000D5A  B90200            mov cx,0x2
00000D5D  E8E1FE            call 0xc41
00000D60  E84B00            call 0xdae
00000D63  03F9              add di,cx
00000D65  B02D              mov al,0x2d
00000D67  FC                cld
00000D68  AA                stosb
00000D69  8AC3              mov al,bl
00000D6B  98                cbw
00000D6C  33D2              xor dx,dx
00000D6E  E8D0FE            call 0xc41
00000D71  E83A00            call 0xdae
00000D74  03F9              add di,cx
00000D76  B02D              mov al,0x2d
00000D78  FC                cld
00000D79  AA                stosb
00000D7A  58                pop ax
00000D7B  33D2              xor dx,dx
00000D7D  E8C1FE            call 0xc41
00000D80  FC                cld
00000D81  AD                lodsw
00000D82  D1E8              shr ax,1
00000D84  D1E8              shr ax,1
00000D86  D1E8              shr ax,1
00000D88  8AD8              mov bl,al
00000D8A  8AC4              mov al,ah
00000D8C  98                cbw
00000D8D  33D2              xor dx,dx
00000D8F  83C703            add di,byte +0x3
00000D92  E8ACFE            call 0xc41
00000D95  E81600            call 0xdae
00000D98  03F9              add di,cx
00000D9A  C6053A            mov byte [di],0x3a
00000D9D  8AC3              mov al,bl
00000D9F  D0E8              shr al,1
00000DA1  D0E8              shr al,1
00000DA3  98                cbw
00000DA4  33D2              xor dx,dx
00000DA6  47                inc di
00000DA7  E897FE            call 0xc41
00000DAA  E80100            call 0xdae
00000DAD  C3                ret
00000DAE  8A05              mov al,[di]
00000DB0  3C20              cmp al,0x20
00000DB2  7503              jnz 0xdb7
00000DB4  C60530            mov byte [di],0x30
00000DB7  C3                ret
00000DB8  53                push bx
00000DB9  B40E              mov ah,0xe
00000DBB  BB0700            mov bx,0x7
00000DBE  51                push cx
00000DBF  247F              and al,0x7f
00000DC1  50                push ax
00000DC2  CD10              int 0x10
00000DC4  58                pop ax
00000DC5  59                pop cx
00000DC6  5B                pop bx
00000DC7  C3                ret
00000DC8  FC                cld
00000DC9  2EAC              cs lodsb
00000DCB  B40E              mov ah,0xe
00000DCD  BB0700            mov bx,0x7
00000DD0  50                push ax
00000DD1  247F              and al,0x7f
00000DD3  CD10              int 0x10
00000DD5  58                pop ax
00000DD6  2480              and al,0x80
00000DD8  74EE              jz 0xdc8
00000DDA  C3                ret
00000DDB  0000              add [bx+si],al
00000DDD  0000              add [bx+si],al
00000DDF  0000              add [bx+si],al
00000DE1  0000              add [bx+si],al
00000DE3  0000              add [bx+si],al
00000DE5  0000              add [bx+si],al
00000DE7  0000              add [bx+si],al
00000DE9  0000              add [bx+si],al
00000DEB  0000              add [bx+si],al
00000DED  0000              add [bx+si],al
00000DEF  0000              add [bx+si],al
00000DF1  0000              add [bx+si],al
00000DF3  0000              add [bx+si],al
00000DF5  0000              add [bx+si],al
00000DF7  0000              add [bx+si],al
00000DF9  0000              add [bx+si],al
00000DFB  0000              add [bx+si],al
00000DFD  0000              add [bx+si],al
00000DFF  0000              add [bx+si],al
00000E01  0000              add [bx+si],al
00000E03  0000              add [bx+si],al
00000E05  0000              add [bx+si],al
00000E07  0000              add [bx+si],al
00000E09  0000              add [bx+si],al
00000E0B  0000              add [bx+si],al
00000E0D  0000              add [bx+si],al
00000E0F  0000              add [bx+si],al
00000E11  0000              add [bx+si],al
00000E13  0000              add [bx+si],al
00000E15  0000              add [bx+si],al
00000E17  0000              add [bx+si],al
00000E19  0000              add [bx+si],al
00000E1B  0000              add [bx+si],al
00000E1D  0000              add [bx+si],al
00000E1F  0000              add [bx+si],al
00000E21  0000              add [bx+si],al
00000E23  0000              add [bx+si],al
00000E25  0000              add [bx+si],al
00000E27  0000              add [bx+si],al
00000E29  0000              add [bx+si],al
00000E2B  0000              add [bx+si],al
00000E2D  0000              add [bx+si],al
00000E2F  0000              add [bx+si],al
00000E31  0000              add [bx+si],al
00000E33  0000              add [bx+si],al
00000E35  0000              add [bx+si],al
00000E37  0000              add [bx+si],al
00000E39  0000              add [bx+si],al
00000E3B  0000              add [bx+si],al
00000E3D  0000              add [bx+si],al
00000E3F  0000              add [bx+si],al
00000E41  0000              add [bx+si],al
00000E43  0000              add [bx+si],al
00000E45  0000              add [bx+si],al
00000E47  0000              add [bx+si],al
00000E49  0000              add [bx+si],al
00000E4B  0000              add [bx+si],al
00000E4D  0000              add [bx+si],al
00000E4F  0000              add [bx+si],al
00000E51  0000              add [bx+si],al
00000E53  0000              add [bx+si],al
00000E55  0000              add [bx+si],al
00000E57  0000              add [bx+si],al
00000E59  0000              add [bx+si],al
00000E5B  0000              add [bx+si],al
00000E5D  0000              add [bx+si],al
00000E5F  0000              add [bx+si],al
00000E61  0000              add [bx+si],al
00000E63  0000              add [bx+si],al
00000E65  0000              add [bx+si],al
00000E67  0000              add [bx+si],al
00000E69  0000              add [bx+si],al
00000E6B  0000              add [bx+si],al
00000E6D  0000              add [bx+si],al
00000E6F  0000              add [bx+si],al
00000E71  0000              add [bx+si],al
00000E73  0000              add [bx+si],al
00000E75  0000              add [bx+si],al
00000E77  0000              add [bx+si],al
00000E79  0000              add [bx+si],al
00000E7B  0000              add [bx+si],al
00000E7D  0000              add [bx+si],al
00000E7F  0000              add [bx+si],al
00000E81  0000              add [bx+si],al
00000E83  0000              add [bx+si],al
00000E85  0000              add [bx+si],al
00000E87  0000              add [bx+si],al
00000E89  0000              add [bx+si],al
00000E8B  0000              add [bx+si],al
00000E8D  0000              add [bx+si],al
00000E8F  0000              add [bx+si],al
00000E91  0000              add [bx+si],al
00000E93  0000              add [bx+si],al
00000E95  0000              add [bx+si],al
00000E97  0000              add [bx+si],al
00000E99  0000              add [bx+si],al
00000E9B  0000              add [bx+si],al
00000E9D  0000              add [bx+si],al
00000E9F  0000              add [bx+si],al
00000EA1  0000              add [bx+si],al
00000EA3  0000              add [bx+si],al
00000EA5  0000              add [bx+si],al
00000EA7  0000              add [bx+si],al
00000EA9  0000              add [bx+si],al
00000EAB  0000              add [bx+si],al
00000EAD  0000              add [bx+si],al
00000EAF  0000              add [bx+si],al
00000EB1  0000              add [bx+si],al
00000EB3  0000              add [bx+si],al
00000EB5  0000              add [bx+si],al
00000EB7  0000              add [bx+si],al
00000EB9  0000              add [bx+si],al
00000EBB  0000              add [bx+si],al
00000EBD  0000              add [bx+si],al
00000EBF  0000              add [bx+si],al
00000EC1  0000              add [bx+si],al
00000EC3  0000              add [bx+si],al
00000EC5  0000              add [bx+si],al
00000EC7  0000              add [bx+si],al
00000EC9  0000              add [bx+si],al
00000ECB  0000              add [bx+si],al
00000ECD  0000              add [bx+si],al
00000ECF  0000              add [bx+si],al
00000ED1  0000              add [bx+si],al
00000ED3  0000              add [bx+si],al
00000ED5  0000              add [bx+si],al
00000ED7  0000              add [bx+si],al
00000ED9  0000              add [bx+si],al
00000EDB  0000              add [bx+si],al
00000EDD  0000              add [bx+si],al
00000EDF  00                db 0x00
