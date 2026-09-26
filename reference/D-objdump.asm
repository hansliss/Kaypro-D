
D.COM:     file format binary


Disassembly of section .data:

00000100 <.data>:
 100:	e9 ef 05             	jmp    0x6f2
 103:	0d 8a 3c             	or     ax,0x3c8a
 106:	20 73 75             	and    BYTE PTR [bp+di+0x75],dh
 109:	62 2d                	bound  bp,DWORD PTR [di]
 10b:	64 69 72 20 3e 0d    	imul   si,WORD PTR fs:[bp+si+0x20],0xd3e
 111:	0a 42 61             	or     al,BYTE PTR [bp+si+0x61]
 114:	64 20 50 61          	and    BYTE PTR fs:[bx+si+0x61],dl
 118:	74 68                	je     0x182
 11a:	20 4e 61             	and    BYTE PTR [bp+0x61],cl
 11d:	6d                   	ins    WORD PTR es:[di],dx
 11e:	65 20 21             	and    BYTE PTR gs:[bx+di],ah
 121:	0d 8a 0d             	or     ax,0xd8a
 124:	0a 46 69             	or     al,BYTE PTR [bp+0x69]
 127:	6c                   	ins    BYTE PTR es:[di],dx
 128:	65 20 6e 6f          	and    BYTE PTR gs:[bp+0x6f],ch
 12c:	74 20                	je     0x14e
 12e:	46                   	inc    si
 12f:	6f                   	outs   dx,WORD PTR ds:[si]
 130:	75 6e                	jne    0x1a0
 132:	64 2e 0d 8a 0d       	fs cs or ax,0xd8a
 137:	0a 50 61             	or     dl,BYTE PTR [bx+si+0x61]
 13a:	74 68                	je     0x1a4
 13c:	20 6e 6f             	and    BYTE PTR [bp+0x6f],ch
 13f:	74 20                	je     0x161
 141:	66 6f                	outs   dx,DWORD PTR ds:[si]
 143:	75 6e                	jne    0x1b3
 145:	64 2e 0d 8a 0d       	fs cs or ax,0xd8a
 14a:	0a 54 6f             	or     dl,BYTE PTR [si+0x6f]
 14d:	6f                   	outs   dx,WORD PTR ds:[si]
 14e:	20 6d 61             	and    BYTE PTR [di+0x61],ch
 151:	6e                   	outs   dx,BYTE PTR ds:[si]
 152:	79 20                	jns    0x174
 154:	6f                   	outs   dx,WORD PTR ds:[si]
 155:	70 65                	jo     0x1bc
 157:	6e                   	outs   dx,BYTE PTR ds:[si]
 158:	20 66 69             	and    BYTE PTR [bp+0x69],ah
 15b:	6c                   	ins    BYTE PTR es:[di],dx
 15c:	65 73 20             	gs jae 0x17f
 15f:	28 75 6e             	sub    BYTE PTR [di+0x6e],dh
 162:	61                   	popa
 163:	62 6c 65             	bound  bp,DWORD PTR [si+0x65]
 166:	20 74 6f             	and    BYTE PTR [si+0x6f],dh
 169:	20 6f 70             	and    BYTE PTR [bx+0x70],ch
 16c:	65 6e                	outs   dx,BYTE PTR gs:[si]
 16e:	20 61 6e             	and    BYTE PTR [bx+di+0x6e],ah
 171:	6f                   	outs   dx,WORD PTR ds:[si]
 172:	74 68                	je     0x1dc
 174:	65 72 20             	gs jb  0x197
 177:	6f                   	outs   dx,WORD PTR ds:[si]
 178:	6e                   	outs   dx,BYTE PTR ds:[si]
 179:	65 29 2e 0d 8a       	sub    WORD PTR gs:0x8a0d,bp
 17e:	0d 0a 49             	or     ax,0x490a
 181:	6e                   	outs   dx,BYTE PTR ds:[si]
 182:	73 75                	jae    0x1f9
 184:	66 66 69 63 69 65 6e 	data32 imul esp,DWORD PTR [bp+di+0x69],0x20746e65
 18b:	74 20 
 18d:	6d                   	ins    WORD PTR es:[di],dx
 18e:	65 6d                	gs ins WORD PTR es:[di],dx
 190:	6f                   	outs   dx,WORD PTR ds:[si]
 191:	72 79                	jb     0x20c
 193:	2e 0d 8a 0d          	cs or  ax,0xd8a
 197:	0a 49 6e             	or     cl,BYTE PTR [bx+di+0x6e]
 19a:	73 75                	jae    0x211
 19c:	66 66 69 63 69 65 6e 	data32 imul esp,DWORD PTR [bp+di+0x69],0x20746e65
 1a3:	74 20 
 1a5:	6d                   	ins    WORD PTR es:[di],dx
 1a6:	65 6d                	gs ins WORD PTR es:[di],dx
 1a8:	6f                   	outs   dx,WORD PTR ds:[si]
 1a9:	72 79                	jb     0x224
 1ab:	20 66 6f             	and    BYTE PTR [bp+0x6f],ah
 1ae:	72 20                	jb     0x1d0
 1b0:	74 65                	je     0x217
 1b2:	78 74                	js     0x228
 1b4:	20 62 75             	and    BYTE PTR [bp+si+0x75],ah
 1b7:	66 66 65 72 20       	data32 data32 gs jb 0x1dc
 1bc:	28 6e 65             	sub    BYTE PTR [bp+0x65],ch
 1bf:	65 64 20 38          	gs and BYTE PTR fs:[bx+si],bh
 1c3:	6b 20 6d             	imul   sp,WORD PTR [bx+si],0x6d
 1c6:	69 6e 69 6d 75       	imul   bp,WORD PTR [bp+0x69],0x756d
 1cb:	6d                   	ins    WORD PTR es:[di],dx
 1cc:	29 2e 0d 8a          	sub    WORD PTR ds:0x8a0d,bp
 1d0:	49                   	dec    cx
 1d1:	6e                   	outs   dx,BYTE PTR ds:[si]
 1d2:	76 61                	jbe    0x235
 1d4:	6c                   	ins    BYTE PTR es:[di],dx
 1d5:	69 64 20 44 72       	imul   sp,WORD PTR [si+0x20],0x7244
 1da:	69 76 65 20 73       	imul   si,WORD PTR [bp+0x65],0x7320
 1df:	70 65                	jo     0x246
 1e1:	63 69 66             	arpl   WORD PTR [bx+di+0x66],bp
 1e4:	69 65 64 2e 0d       	imul   sp,WORD PTR [di+0x64],0xd2e
 1e9:	8a 49 6e             	mov    cl,BYTE PTR [bx+di+0x6e]
 1ec:	76 61                	jbe    0x24f
 1ee:	6c                   	ins    BYTE PTR es:[di],dx
 1ef:	69 64 20 44 69       	imul   sp,WORD PTR [si+0x20],0x6944
 1f4:	72 65                	jb     0x25b
 1f6:	63 74 6f             	arpl   WORD PTR [si+0x6f],si
 1f9:	72 79                	jb     0x274
 1fb:	20 53 70             	and    BYTE PTR [bp+di+0x70],dl
 1fe:	65 63 69 66          	arpl   WORD PTR gs:[bx+di+0x66],bp
 202:	69 63 61 74 69       	imul   sp,WORD PTR [bp+di+0x61],0x6974
 207:	6f                   	outs   dx,WORD PTR ds:[si]
 208:	6e                   	outs   dx,BYTE PTR ds:[si]
 209:	2e 0d 8a 20          	cs or  ax,0x208a
 20d:	44                   	inc    sp
 20e:	69 72 65 63 74       	imul   si,WORD PTR [bp+si+0x65],0x7463
 213:	6f                   	outs   dx,WORD PTR ds:[si]
 214:	72 79                	jb     0x28f
 216:	20 6f 66             	and    BYTE PTR [bx+0x66],ch
 219:	20 20                	and    BYTE PTR [bx+si],ah
 21b:	20 20                	and    BYTE PTR [bx+si],ah
 21d:	20 20                	and    BYTE PTR [bx+si],ah
 21f:	20 20                	and    BYTE PTR [bx+si],ah
 221:	20 20                	and    BYTE PTR [bx+si],ah
 223:	20 20                	and    BYTE PTR [bx+si],ah
 225:	20 20                	and    BYTE PTR [bx+si],ah
 227:	20 20                	and    BYTE PTR [bx+si],ah
 229:	20 20                	and    BYTE PTR [bx+si],ah
 22b:	20 20                	and    BYTE PTR [bx+si],ah
 22d:	20 20                	and    BYTE PTR [bx+si],ah
 22f:	20 20                	and    BYTE PTR [bx+si],ah
 231:	20 20                	and    BYTE PTR [bx+si],ah
 233:	20 20                	and    BYTE PTR [bx+si],ah
 235:	20 20                	and    BYTE PTR [bx+si],ah
 237:	20 20                	and    BYTE PTR [bx+si],ah
 239:	20 20                	and    BYTE PTR [bx+si],ah
 23b:	20 20                	and    BYTE PTR [bx+si],ah
 23d:	20 20                	and    BYTE PTR [bx+si],ah
 23f:	20 20                	and    BYTE PTR [bx+si],ah
 241:	20 20                	and    BYTE PTR [bx+si],ah
 243:	20 20                	and    BYTE PTR [bx+si],ah
 245:	20 20                	and    BYTE PTR [bx+si],ah
 247:	20 20                	and    BYTE PTR [bx+si],ah
 249:	20 20                	and    BYTE PTR [bx+si],ah
 24b:	20 20                	and    BYTE PTR [bx+si],ah
 24d:	20 20                	and    BYTE PTR [bx+si],ah
 24f:	20 20                	and    BYTE PTR [bx+si],ah
 251:	20 20                	and    BYTE PTR [bx+si],ah
 253:	20 20                	and    BYTE PTR [bx+si],ah
 255:	20 20                	and    BYTE PTR [bx+si],ah
 257:	20 20                	and    BYTE PTR [bx+si],ah
 259:	20 0d                	and    BYTE PTR [di],cl
 25b:	0a 20                	or     ah,BYTE PTR [bx+si]
 25d:	20 20                	and    BYTE PTR [bx+si],ah
 25f:	20 20                	and    BYTE PTR [bx+si],ah
 261:	20 44 69             	and    BYTE PTR [si+0x69],al
 264:	72 27                	jb     0x28d
 266:	73 20                	jae    0x288
 268:	61                   	popa
 269:	6e                   	outs   dx,BYTE PTR ds:[si]
 26a:	64 20 20             	and    BYTE PTR fs:[bx+si],ah
 26d:	20 20                	and    BYTE PTR [bx+si],ah
 26f:	20 20                	and    BYTE PTR [bx+si],ah
 271:	20 20                	and    BYTE PTR [bx+si],ah
 273:	46                   	inc    si
 274:	69 6c 65 73 20       	imul   bp,WORD PTR [si+0x65],0x2073
 279:	4f                   	dec    di
 27a:	63 63 75             	arpl   WORD PTR [bp+di+0x75],sp
 27d:	70 79                	jo     0x2f8
 27f:	20 20                	and    BYTE PTR [bx+si],ah
 281:	20 20                	and    BYTE PTR [bx+si],ah
 283:	20 20                	and    BYTE PTR [bx+si],ah
 285:	20 20                	and    BYTE PTR [bx+si],ah
 287:	20 20                	and    BYTE PTR [bx+si],ah
 289:	20 20                	and    BYTE PTR [bx+si],ah
 28b:	20 20                	and    BYTE PTR [bx+si],ah
 28d:	20 42 79             	and    BYTE PTR [bp+si+0x79],al
 290:	74 65                	je     0x2f7
 292:	73 20                	jae    0x2b4
 294:	6f                   	outs   dx,WORD PTR ds:[si]
 295:	6e                   	outs   dx,BYTE PTR ds:[si]
 296:	20 56 6f             	and    BYTE PTR [bp+0x6f],dl
 299:	6c                   	ins    BYTE PTR es:[di],dx
 29a:	75 6d                	jne    0x309
 29c:	65 3a 20             	cmp    ah,BYTE PTR gs:[bx+si]
 29f:	20 20                	and    BYTE PTR [bx+si],ah
 2a1:	20 20                	and    BYTE PTR [bx+si],ah
 2a3:	20 20                	and    BYTE PTR [bx+si],ah
 2a5:	20 20                	and    BYTE PTR [bx+si],ah
 2a7:	20 20                	and    BYTE PTR [bx+si],ah
 2a9:	20 20                	and    BYTE PTR [bx+si],ah
 2ab:	0d 0a 20             	or     ax,0x200a
 2ae:	3d 3d 3d             	cmp    ax,0x3d3d
 2b1:	3d 3d 3d             	cmp    ax,0x3d3d
 2b4:	3d 3d 3d             	cmp    ax,0x3d3d
 2b7:	3d 3d 3d             	cmp    ax,0x3d3d
 2ba:	3d 3d 3d             	cmp    ax,0x3d3d
 2bd:	3d 3d 3d             	cmp    ax,0x3d3d
 2c0:	3d 3d 3d             	cmp    ax,0x3d3d
 2c3:	3d 3d 3d             	cmp    ax,0x3d3d
 2c6:	3d 3d 3d             	cmp    ax,0x3d3d
 2c9:	3d 3d 3d             	cmp    ax,0x3d3d
 2cc:	3d 3d 3d             	cmp    ax,0x3d3d
 2cf:	3d 3d 3d             	cmp    ax,0x3d3d
 2d2:	3d 3d 3d             	cmp    ax,0x3d3d
 2d5:	3d 3d 3d             	cmp    ax,0x3d3d
 2d8:	3d 3d 3d             	cmp    ax,0x3d3d
 2db:	3d 3d 3d             	cmp    ax,0x3d3d
 2de:	3d 3d 3d             	cmp    ax,0x3d3d
 2e1:	3d 3d 3d             	cmp    ax,0x3d3d
 2e4:	3d 3d 3d             	cmp    ax,0x3d3d
 2e7:	3d 3d 3d             	cmp    ax,0x3d3d
 2ea:	3d 3d 3d             	cmp    ax,0x3d3d
 2ed:	3d 3d 3d             	cmp    ax,0x3d3d
 2f0:	3d 3d 3d             	cmp    ax,0x3d3d
 2f3:	3d 3d 3d             	cmp    ax,0x3d3d
 2f6:	3d 3d 3d             	cmp    ax,0x3d3d
 2f9:	3d 3d 3d             	cmp    ax,0x3d3d
 2fc:	0d 0a 20             	or     ax,0x200a
 2ff:	46                   	inc    si
 300:	69 6c 65 20 20       	imul   bp,WORD PTR [si+0x65],0x2020
 305:	20 20                	and    BYTE PTR [bx+si],ah
 307:	2e 45                	cs inc bp
 309:	78 74                	js     0x37f
 30b:	20 20                	and    BYTE PTR [bx+si],ah
 30d:	20 4b 42             	and    BYTE PTR [bp+di+0x42],cl
 310:	79 74                	jns    0x386
 312:	65 73 20             	gs jae 0x335
 315:	20 6d 6d             	and    BYTE PTR [di+0x6d],ch
 318:	2d 64 64             	sub    ax,0x6464
 31b:	2d 79 79             	sub    ax,0x7979
 31e:	20 68 68             	and    BYTE PTR [bx+si+0x68],ch
 321:	3a 6d 6d             	cmp    ch,BYTE PTR [di+0x6d]
 324:	20 7c 20             	and    BYTE PTR [si+0x20],bh
 327:	46                   	inc    si
 328:	69 6c 65 20 20       	imul   bp,WORD PTR [si+0x65],0x2020
 32d:	20 20                	and    BYTE PTR [bx+si],ah
 32f:	2e 45                	cs inc bp
 331:	78 74                	js     0x3a7
 333:	20 20                	and    BYTE PTR [bx+si],ah
 335:	20 4b 42             	and    BYTE PTR [bp+di+0x42],cl
 338:	79 74                	jns    0x3ae
 33a:	65 73 20             	gs jae 0x35d
 33d:	20 6d 6d             	and    BYTE PTR [di+0x6d],ch
 340:	2d 64 64             	sub    ax,0x6464
 343:	2d 79 79             	sub    ax,0x7979
 346:	20 68 68             	and    BYTE PTR [bx+si+0x68],ch
 349:	3a 6d 6d             	cmp    ch,BYTE PTR [di+0x6d]
 34c:	0d 0a 20             	or     ax,0x200a
 34f:	2d 2d 2d             	sub    ax,0x2d2d
 352:	2d 2d 2d             	sub    ax,0x2d2d
 355:	2d 2d 2d             	sub    ax,0x2d2d
 358:	2d 2d 2d             	sub    ax,0x2d2d
 35b:	2d 2d 2d             	sub    ax,0x2d2d
 35e:	2d 2d 2d             	sub    ax,0x2d2d
 361:	2d 2d 2d             	sub    ax,0x2d2d
 364:	2d 2d 2d             	sub    ax,0x2d2d
 367:	2d 2d 2d             	sub    ax,0x2d2d
 36a:	2d 2d 2d             	sub    ax,0x2d2d
 36d:	2d 2d 2d             	sub    ax,0x2d2d
 370:	2d 2d 2d             	sub    ax,0x2d2d
 373:	2d 2d 7c             	sub    ax,0x7c2d
 376:	2d 2d 2d             	sub    ax,0x2d2d
 379:	2d 2d 2d             	sub    ax,0x2d2d
 37c:	2d 2d 2d             	sub    ax,0x2d2d
 37f:	2d 2d 2d             	sub    ax,0x2d2d
 382:	2d 2d 2d             	sub    ax,0x2d2d
 385:	2d 2d 2d             	sub    ax,0x2d2d
 388:	2d 2d 2d             	sub    ax,0x2d2d
 38b:	2d 2d 2d             	sub    ax,0x2d2d
 38e:	2d 2d 2d             	sub    ax,0x2d2d
 391:	2d 2d 2d             	sub    ax,0x2d2d
 394:	2d 2d 2d             	sub    ax,0x2d2d
 397:	2d 2d 2d             	sub    ax,0x2d2d
 39a:	2d 2d 2d             	sub    ax,0x2d2d
 39d:	0d 8a 20             	or     ax,0x208a
 3a0:	3d 3d 3d             	cmp    ax,0x3d3d
 3a3:	3d 3d 3d             	cmp    ax,0x3d3d
 3a6:	3d 3d 3d             	cmp    ax,0x3d3d
 3a9:	3d 3d 3d             	cmp    ax,0x3d3d
 3ac:	3d 3d 3d             	cmp    ax,0x3d3d
 3af:	3d 3d 3d             	cmp    ax,0x3d3d
 3b2:	3d 3d 3d             	cmp    ax,0x3d3d
 3b5:	3d 3d 3d             	cmp    ax,0x3d3d
 3b8:	3d 3d 3d             	cmp    ax,0x3d3d
 3bb:	3d 3d 3d             	cmp    ax,0x3d3d
 3be:	3d 3d 3d             	cmp    ax,0x3d3d
 3c1:	3d 3d 3d             	cmp    ax,0x3d3d
 3c4:	3d 3d 3d             	cmp    ax,0x3d3d
 3c7:	3d 3d 3d             	cmp    ax,0x3d3d
 3ca:	3d 3d 3d             	cmp    ax,0x3d3d
 3cd:	3d 3d 3d             	cmp    ax,0x3d3d
 3d0:	3d 3d 3d             	cmp    ax,0x3d3d
 3d3:	3d 3d 3d             	cmp    ax,0x3d3d
 3d6:	3d 3d 3d             	cmp    ax,0x3d3d
 3d9:	3d 3d 3d             	cmp    ax,0x3d3d
 3dc:	3d 3d 3d             	cmp    ax,0x3d3d
 3df:	3d 3d 3d             	cmp    ax,0x3d3d
 3e2:	3d 3d 3d             	cmp    ax,0x3d3d
 3e5:	3d 3d 3d             	cmp    ax,0x3d3d
 3e8:	3d 3d 3d             	cmp    ax,0x3d3d
 3eb:	3d 3d 3d             	cmp    ax,0x3d3d
 3ee:	0d 0a 20             	or     ax,0x200a
 3f1:	20 20                	and    BYTE PTR [bx+si],ah
 3f3:	20 20                	and    BYTE PTR [bx+si],ah
 3f5:	20 20                	and    BYTE PTR [bx+si],ah
 3f7:	20 20                	and    BYTE PTR [bx+si],ah
 3f9:	20 20                	and    BYTE PTR [bx+si],ah
 3fb:	20 20                	and    BYTE PTR [bx+si],ah
 3fd:	20 20                	and    BYTE PTR [bx+si],ah
 3ff:	20 20                	and    BYTE PTR [bx+si],ah
 401:	20 20                	and    BYTE PTR [bx+si],ah
 403:	20 42 79             	and    BYTE PTR [bp+si+0x79],al
 406:	74 65                	je     0x46d
 408:	73 20                	jae    0x42a
 40a:	46                   	inc    si
 40b:	72 65                	jb     0x472
 40d:	65 20 6f 66          	and    BYTE PTR gs:[bx+0x66],ch
 411:	20 20                	and    BYTE PTR [bx+si],ah
 413:	20 20                	and    BYTE PTR [bx+si],ah
 415:	20 20                	and    BYTE PTR [bx+si],ah
 417:	20 20                	and    BYTE PTR [bx+si],ah
 419:	20 20                	and    BYTE PTR [bx+si],ah
 41b:	20 20                	and    BYTE PTR [bx+si],ah
 41d:	20 20                	and    BYTE PTR [bx+si],ah
 41f:	20 20                	and    BYTE PTR [bx+si],ah
 421:	20 20                	and    BYTE PTR [bx+si],ah
 423:	20 20                	and    BYTE PTR [bx+si],ah
 425:	20 20                	and    BYTE PTR [bx+si],ah
 427:	20 20                	and    BYTE PTR [bx+si],ah
 429:	20 20                	and    BYTE PTR [bx+si],ah
 42b:	20 42 79             	and    BYTE PTR [bp+si+0x79],al
 42e:	74 65                	je     0x495
 430:	73 20                	jae    0x452
 432:	54                   	push   sp
 433:	6f                   	outs   dx,WORD PTR ds:[si]
 434:	74 61                	je     0x497
 436:	6c                   	ins    BYTE PTR es:[di],dx
 437:	0d 0a 20             	or     ax,0x200a
 43a:	2d 2d 2d             	sub    ax,0x2d2d
 43d:	2d 2d 2d             	sub    ax,0x2d2d
 440:	2d 2d 2d             	sub    ax,0x2d2d
 443:	2d 2d 2d             	sub    ax,0x2d2d
 446:	2d 2d 2d             	sub    ax,0x2d2d
 449:	2d 2d 2d             	sub    ax,0x2d2d
 44c:	2d 2d 2d             	sub    ax,0x2d2d
 44f:	2d 2d 2d             	sub    ax,0x2d2d
 452:	2d 2d 2d             	sub    ax,0x2d2d
 455:	2d 2d 2d             	sub    ax,0x2d2d
 458:	2d 2d 2d             	sub    ax,0x2d2d
 45b:	2d 2d 2d             	sub    ax,0x2d2d
 45e:	2d 2d 2d             	sub    ax,0x2d2d
 461:	2d 2d 2d             	sub    ax,0x2d2d
 464:	2d 2d 2d             	sub    ax,0x2d2d
 467:	2d 2d 2d             	sub    ax,0x2d2d
 46a:	2d 2d 2d             	sub    ax,0x2d2d
 46d:	2d 2d 2d             	sub    ax,0x2d2d
 470:	2d 2d 2d             	sub    ax,0x2d2d
 473:	2d 2d 2d             	sub    ax,0x2d2d
 476:	2d 2d 2d             	sub    ax,0x2d2d
 479:	2d 2d 2d             	sub    ax,0x2d2d
 47c:	2d 2d 2d             	sub    ax,0x2d2d
 47f:	2d 2d 2d             	sub    ax,0x2d2d
 482:	2d 2d 2d             	sub    ax,0x2d2d
 485:	2d 2d 2d             	sub    ax,0x2d2d
 488:	0d 0a 20             	or     ax,0x200a
 48b:	3d 3d 3e             	cmp    ax,0x3e3d
 48e:	20 20                	and    BYTE PTR [bx+si],ah
 490:	20 20                	and    BYTE PTR [bx+si],ah
 492:	20 20                	and    BYTE PTR [bx+si],ah
 494:	43                   	inc    bx
 495:	6f                   	outs   dx,WORD PTR ds:[si]
 496:	6e                   	outs   dx,BYTE PTR ds:[si]
 497:	74 69                	je     0x502
 499:	6e                   	outs   dx,BYTE PTR ds:[si]
 49a:	75 65                	jne    0x501
 49c:	20 3d                	and    BYTE PTR [di],bh
 49e:	20 20                	and    BYTE PTR [bx+si],ah
 4a0:	43                   	inc    bx
 4a1:	52                   	push   dx
 4a2:	20 20                	and    BYTE PTR [bx+si],ah
 4a4:	20 20                	and    BYTE PTR [bx+si],ah
 4a6:	20 20                	and    BYTE PTR [bx+si],ah
 4a8:	20 20                	and    BYTE PTR [bx+si],ah
 4aa:	20 20                	and    BYTE PTR [bx+si],ah
 4ac:	20 20                	and    BYTE PTR [bx+si],ah
 4ae:	20 20                	and    BYTE PTR [bx+si],ah
 4b0:	20 20                	and    BYTE PTR [bx+si],ah
 4b2:	20 20                	and    BYTE PTR [bx+si],ah
 4b4:	20 20                	and    BYTE PTR [bx+si],ah
 4b6:	20 20                	and    BYTE PTR [bx+si],ah
 4b8:	20 20                	and    BYTE PTR [bx+si],ah
 4ba:	20 41 62             	and    BYTE PTR [bx+di+0x62],al
 4bd:	6f                   	outs   dx,WORD PTR ds:[si]
 4be:	72 74                	jb     0x534
 4c0:	20 3d                	and    BYTE PTR [di],bh
 4c2:	20 20                	and    BYTE PTR [bx+si],ah
 4c4:	5e                   	pop    si
 4c5:	43                   	inc    bx
 4c6:	20 20                	and    BYTE PTR [bx+si],ah
 4c8:	20 20                	and    BYTE PTR [bx+si],ah
 4ca:	20 20                	and    BYTE PTR [bx+si],ah
 4cc:	20 a0 20 20          	and    BYTE PTR [bx+si+0x2020],ah
 4d0:	20 20                	and    BYTE PTR [bx+si],ah
 4d2:	20 20                	and    BYTE PTR [bx+si],ah
 4d4:	20 20                	and    BYTE PTR [bx+si],ah
 4d6:	20 20                	and    BYTE PTR [bx+si],ah
 4d8:	20 20                	and    BYTE PTR [bx+si],ah
 4da:	20 20                	and    BYTE PTR [bx+si],ah
 4dc:	20 20                	and    BYTE PTR [bx+si],ah
 4de:	20 20                	and    BYTE PTR [bx+si],ah
 4e0:	20 20                	and    BYTE PTR [bx+si],ah
 4e2:	20 20                	and    BYTE PTR [bx+si],ah
 4e4:	20 20                	and    BYTE PTR [bx+si],ah
 4e6:	20 20                	and    BYTE PTR [bx+si],ah
 4e8:	20 20                	and    BYTE PTR [bx+si],ah
 4ea:	20 20                	and    BYTE PTR [bx+si],ah
 4ec:	20 20                	and    BYTE PTR [bx+si],ah
 4ee:	20 20                	and    BYTE PTR [bx+si],ah
 4f0:	20 3a                	and    BYTE PTR [bp+si],bh
 4f2:	20 20                	and    BYTE PTR [bx+si],ah
 4f4:	20 7c 20             	and    BYTE PTR [si+0x20],bh
 4f7:	20 20                	and    BYTE PTR [bx+si],ah
 4f9:	20 20                	and    BYTE PTR [bx+si],ah
 4fb:	20 20                	and    BYTE PTR [bx+si],ah
 4fd:	20 20                	and    BYTE PTR [bx+si],ah
 4ff:	20 20                	and    BYTE PTR [bx+si],ah
 501:	20 20                	and    BYTE PTR [bx+si],ah
 503:	20 20                	and    BYTE PTR [bx+si],ah
 505:	20 20                	and    BYTE PTR [bx+si],ah
 507:	20 20                	and    BYTE PTR [bx+si],ah
 509:	20 20                	and    BYTE PTR [bx+si],ah
 50b:	20 20                	and    BYTE PTR [bx+si],ah
 50d:	20 20                	and    BYTE PTR [bx+si],ah
 50f:	20 20                	and    BYTE PTR [bx+si],ah
 511:	20 20                	and    BYTE PTR [bx+si],ah
 513:	20 20                	and    BYTE PTR [bx+si],ah
 515:	20 20                	and    BYTE PTR [bx+si],ah
 517:	20 20                	and    BYTE PTR [bx+si],ah
 519:	3a 20                	cmp    ah,BYTE PTR [bx+si]
 51b:	20 a0 00 00          	and    BYTE PTR [bx+si+0x0],ah
 51f:	00 00                	add    BYTE PTR [bx+si],al
 521:	db 0d                	fisttp DWORD PTR [di]
	...
 52b:	03 00                	add    ax,WORD PTR [bx+si]
 52d:	00 00                	add    BYTE PTR [bx+si],al
 52f:	db 0d                	fisttp DWORD PTR [di]
	...
 5d9:	20 20                	and    BYTE PTR [bx+si],ah
 5db:	20 20                	and    BYTE PTR [bx+si],ah
 5dd:	20 20                	and    BYTE PTR [bx+si],ah
 5df:	20 20                	and    BYTE PTR [bx+si],ah
 5e1:	20 20                	and    BYTE PTR [bx+si],ah
 5e3:	20 20                	and    BYTE PTR [bx+si],ah
 5e5:	20 20                	and    BYTE PTR [bx+si],ah
 5e7:	20 20                	and    BYTE PTR [bx+si],ah
 5e9:	20 20                	and    BYTE PTR [bx+si],ah
 5eb:	20 20                	and    BYTE PTR [bx+si],ah
 5ed:	20 20                	and    BYTE PTR [bx+si],ah
 5ef:	20 20                	and    BYTE PTR [bx+si],ah
 5f1:	20 20                	and    BYTE PTR [bx+si],ah
 5f3:	20 20                	and    BYTE PTR [bx+si],ah
 5f5:	20 20                	and    BYTE PTR [bx+si],ah
 5f7:	20 20                	and    BYTE PTR [bx+si],ah
 5f9:	20 20                	and    BYTE PTR [bx+si],ah
 5fb:	20 20                	and    BYTE PTR [bx+si],ah
 5fd:	20 20                	and    BYTE PTR [bx+si],ah
 5ff:	20 7c 20             	and    BYTE PTR [si+0x20],bh
 602:	20 20                	and    BYTE PTR [bx+si],ah
 604:	20 20                	and    BYTE PTR [bx+si],ah
 606:	20 20                	and    BYTE PTR [bx+si],ah
 608:	20 20                	and    BYTE PTR [bx+si],ah
 60a:	20 20                	and    BYTE PTR [bx+si],ah
 60c:	20 20                	and    BYTE PTR [bx+si],ah
 60e:	20 20                	and    BYTE PTR [bx+si],ah
 610:	20 20                	and    BYTE PTR [bx+si],ah
 612:	20 20                	and    BYTE PTR [bx+si],ah
 614:	20 20                	and    BYTE PTR [bx+si],ah
 616:	20 20                	and    BYTE PTR [bx+si],ah
 618:	20 20                	and    BYTE PTR [bx+si],ah
 61a:	20 20                	and    BYTE PTR [bx+si],ah
 61c:	20 20                	and    BYTE PTR [bx+si],ah
 61e:	20 20                	and    BYTE PTR [bx+si],ah
 620:	20 20                	and    BYTE PTR [bx+si],ah
 622:	20 20                	and    BYTE PTR [bx+si],ah
 624:	20 20                	and    BYTE PTR [bx+si],ah
 626:	20 20                	and    BYTE PTR [bx+si],ah
 628:	0d 8a 00             	or     ax,0x8a
	...
 673:	00 00                	add    BYTE PTR [bx+si],al
 675:	58                   	pop    ax
 676:	3a 5c 00             	cmp    bl,BYTE PTR [si+0x0]
	...
 6bd:	00 58 3a             	add    BYTE PTR [bx+si+0x3a],bl
 6c0:	5c                   	pop    sp
 6c1:	2a 2e 2a 00          	sub    ch,BYTE PTR ds:0x2a
 6c5:	00 00                	add    BYTE PTR [bx+si],al
 6c7:	07                   	pop    es
 6c8:	09 20                	or     WORD PTR [bx+si],sp
 6ca:	2b 2c                	sub    bp,WORD PTR [si]
 6cc:	3a 3b                	cmp    bh,BYTE PTR [bp+di]
 6ce:	3d 0a 00             	cmp    ax,0xa
 6d1:	08 22                	or     BYTE PTR [bp+si],ah
 6d3:	2f                   	das
 6d4:	3c 3e                	cmp    al,0x3e
 6d6:	5b                   	pop    bx
 6d7:	5c                   	pop    sp
 6d8:	5d                   	pop    bp
 6d9:	7c 00                	jl     0x6db
 6db:	2e 21 23             	and    WORD PTR cs:[bp+di],sp
 6de:	24 25                	and    al,0x25
 6e0:	26 27                	es daa
 6e2:	28 29                	sub    BYTE PTR [bx+di],ch
 6e4:	2d 5e 5f             	sub    ax,0x5f5e
 6e7:	60                   	pusha
 6e8:	7b 7d                	jnp    0x767
 6ea:	7e 00                	jle    0x6ec
 6ec:	00 00                	add    BYTE PTR [bx+si],al
 6ee:	00 00                	add    BYTE PTR [bx+si],al
 6f0:	db 0d                	fisttp DWORD PTR [di]
 6f2:	3c ff                	cmp    al,0xff
 6f4:	75 05                	jne    0x6fb
 6f6:	b0 0f                	mov    al,0xf
 6f8:	e9 8b 04             	jmp    0xb86
 6fb:	b4 25                	mov    ah,0x25
 6fd:	b0 23                	mov    al,0x23
 6ff:	ba c4 09             	mov    dx,0x9c4
 702:	cd 21                	int    0x21
 704:	b4 08                	mov    ah,0x8
 706:	bb 07 00             	mov    bx,0x7
 709:	cd 10                	int    0x10
 70b:	88 26 2e 06          	mov    BYTE PTR ds:0x62e,ah
 70f:	b4 33                	mov    ah,0x33
 711:	b0 00                	mov    al,0x0
 713:	cd 21                	int    0x21
 715:	88 16 25 05          	mov    BYTE PTR ds:0x525,dl
 719:	b4 33                	mov    ah,0x33
 71b:	b0 01                	mov    al,0x1
 71d:	b2 00                	mov    dl,0x0
 71f:	cd 21                	int    0x21
 721:	a1 06 00             	mov    ax,ds:0x6
 724:	2d db 0d             	sub    ax,0xddb
 727:	b9 16 00             	mov    cx,0x16
 72a:	33 d2                	xor    dx,dx
 72c:	f7 f1                	div    cx
 72e:	a3 b9 05             	mov    ds:0x5b9,ax
 731:	a3 b7 05             	mov    ds:0x5b7,ax
 734:	33 d2                	xor    dx,dx
 736:	f7 e1                	mul    cx
 738:	a3 1f 05             	mov    ds:0x51f,ax
 73b:	05 db 0d             	add    ax,0xddb
 73e:	a3 1d 05             	mov    ds:0x51d,ax
 741:	fb                   	sti
 742:	fc                   	cld
 743:	be 80 00             	mov    si,0x80
 746:	33 c0                	xor    ax,ax
 748:	ac                   	lods   al,BYTE PTR ds:[si]
 749:	03 f0                	add    si,ax
 74b:	c6 04 00             	mov    BYTE PTR [si],0x0
 74e:	46                   	inc    si
 74f:	89 36 26 05          	mov    WORD PTR ds:0x526,si
 753:	be 81 00             	mov    si,0x81
 756:	89 36 29 05          	mov    WORD PTR ds:0x529,si
 75a:	a1 26 05             	mov    ax,ds:0x526
 75d:	2b c6                	sub    ax,si
 75f:	a2 28 05             	mov    ds:0x528,al
 762:	b4 2f                	mov    ah,0x2f
 764:	cd 21                	int    0x21
 766:	8c c0                	mov    ax,es
 768:	a3 2a 06             	mov    ds:0x62a,ax
 76b:	89 1e 2c 06          	mov    WORD PTR ds:0x62c,bx
 76f:	90                   	nop
 770:	90                   	nop
 771:	a0 5c 00             	mov    al,ds:0x5c
 774:	3c 00                	cmp    al,0x0
 776:	75 06                	jne    0x77e
 778:	b4 19                	mov    ah,0x19
 77a:	cd 21                	int    0x21
 77c:	fe c0                	inc    al
 77e:	04 40                	add    al,0x40
 780:	a2 be 06             	mov    ds:0x6be,al
 783:	a2 75 06             	mov    ds:0x675,al
 786:	90                   	nop
 787:	90                   	nop
 788:	ba 35 05             	mov    dx,0x535
 78b:	8c c8                	mov    ax,cs
 78d:	8e c0                	mov    es,ax
 78f:	b4 1a                	mov    ah,0x1a
 791:	cd 21                	int    0x21
 793:	90                   	nop
 794:	90                   	nop
 795:	ba be 06             	mov    dx,0x6be
 798:	b9 08 00             	mov    cx,0x8
 79b:	b4 4e                	mov    ah,0x4e
 79d:	cd 21                	int    0x21
 79f:	b9 0b 00             	mov    cx,0xb
 7a2:	be 53 05             	mov    si,0x553
 7a5:	bf a0 02             	mov    di,0x2a0
 7a8:	80 3e 4a 05 08       	cmp    BYTE PTR ds:0x54a,0x8
 7ad:	74 0e                	je     0x7bd
 7af:	b4 4f                	mov    ah,0x4f
 7b1:	cd 21                	int    0x21
 7b3:	72 04                	jb     0x7b9
 7b5:	eb e8                	jmp    0x79f
 7b7:	90                   	nop
 7b8:	90                   	nop
 7b9:	b0 2d                	mov    al,0x2d
 7bb:	eb 11                	jmp    0x7ce
 7bd:	fc                   	cld
 7be:	ac                   	lods   al,BYTE PTR ds:[si]
 7bf:	3c 2e                	cmp    al,0x2e
 7c1:	74 fa                	je     0x7bd
 7c3:	aa                   	stos   BYTE PTR es:[di],al
 7c4:	3c 00                	cmp    al,0x0
 7c6:	e0 f5                	loopne 0x7bd
 7c8:	e3 06                	jcxz   0x7d0
 7ca:	4f                   	dec    di
 7cb:	41                   	inc    cx
 7cc:	b0 20                	mov    al,0x20
 7ce:	f3 aa                	rep stos BYTE PTR es:[di],al
 7d0:	be 34 06             	mov    si,0x634
 7d3:	b4 47                	mov    ah,0x47
 7d5:	8b fe                	mov    di,si
 7d7:	8a 16 5c 00          	mov    dl,BYTE PTR ds:0x5c
 7db:	cd 21                	int    0x21
 7dd:	8b f7                	mov    si,di
 7df:	33 c0                	xor    ax,ax
 7e1:	fe cc                	dec    ah
 7e3:	b9 40 00             	mov    cx,0x40
 7e6:	fc                   	cld
 7e7:	fe c4                	inc    ah
 7e9:	ae                   	scas   al,BYTE PTR es:[di]
 7ea:	e0 fb                	loopne 0x7e7
 7ec:	88 64 ff             	mov    BYTE PTR [si-0x1],ah
 7ef:	b4 01                	mov    ah,0x1
 7f1:	b9 46 00             	mov    cx,0x46
 7f4:	be 81 00             	mov    si,0x81
 7f7:	8a 04                	mov    al,BYTE PTR [si]
 7f9:	e8 98 00             	call   0x894
 7fc:	75 05                	jne    0x803
 7fe:	e8 be 00             	call   0x8bf
 801:	e2 f4                	loop   0x7f7
 803:	80 3e 5c 00 00       	cmp    BYTE PTR ds:0x5c,0x0
 808:	74 17                	je     0x821
 80a:	e8 b2 00             	call   0x8bf
 80d:	e8 af 00             	call   0x8bf
 810:	b4 01                	mov    ah,0x1
 812:	b9 46 00             	mov    cx,0x46
 815:	8a 04                	mov    al,BYTE PTR [si]
 817:	e8 7a 00             	call   0x894
 81a:	75 05                	jne    0x821
 81c:	e8 a0 00             	call   0x8bf
 81f:	e2 f4                	loop   0x815
 821:	80 3c 2e             	cmp    BYTE PTR [si],0x2e
 824:	75 46                	jne    0x86c
 826:	80 7c 01 2e          	cmp    BYTE PTR [si+0x1],0x2e
 82a:	75 2c                	jne    0x858
 82c:	8a 1e 33 06          	mov    bl,BYTE PTR ds:0x633
 830:	80 fb 00             	cmp    bl,0x0
 833:	75 05                	jne    0x83a
 835:	b0 0f                	mov    al,0xf
 837:	e9 4c 03             	jmp    0xb86
 83a:	56                   	push   si
 83b:	be 34 06             	mov    si,0x634
 83e:	32 ff                	xor    bh,bh
 840:	b4 02                	mov    ah,0x2
 842:	4b                   	dec    bx
 843:	8a 00                	mov    al,BYTE PTR [bx+si]
 845:	e8 4c 00             	call   0x894
 848:	c6 00 00             	mov    BYTE PTR [bx+si],0x0
 84b:	74 04                	je     0x851
 84d:	0b db                	or     bx,bx
 84f:	75 f1                	jne    0x842
 851:	88 5c ff             	mov    BYTE PTR [si-0x1],bl
 854:	5e                   	pop    si
 855:	e8 67 00             	call   0x8bf
 858:	e8 64 00             	call   0x8bf
 85b:	b4 01                	mov    ah,0x1
 85d:	b9 46 00             	mov    cx,0x46
 860:	8a 04                	mov    al,BYTE PTR [si]
 862:	e8 2f 00             	call   0x894
 865:	75 05                	jne    0x86c
 867:	e8 55 00             	call   0x8bf
 86a:	e2 f4                	loop   0x860
 86c:	b4 02                	mov    ah,0x2
 86e:	b9 46 00             	mov    cx,0x46
 871:	8a 04                	mov    al,BYTE PTR [si]
 873:	e8 1e 00             	call   0x894
 876:	75 5c                	jne    0x8d4
 878:	b4 00                	mov    ah,0x0
 87a:	e8 42 00             	call   0x8bf
 87d:	8a 04                	mov    al,BYTE PTR [si]
 87f:	e8 12 00             	call   0x894
 882:	e1 f6                	loope  0x87a
 884:	bf 78 06             	mov    di,0x678
 887:	80 3e 80 00 00       	cmp    BYTE PTR ds:0x80,0x0
 88c:	74 03                	je     0x891
 88e:	eb 75                	jmp    0x905
 890:	90                   	nop
 891:	e9 93 00             	jmp    0x927
 894:	50                   	push   ax
 895:	51                   	push   cx
 896:	57                   	push   di
 897:	33 c9                	xor    cx,cx
 899:	80 fc 02             	cmp    ah,0x2
 89c:	74 09                	je     0x8a7
 89e:	bf c8 06             	mov    di,0x6c8
 8a1:	8a 0e c7 06          	mov    cl,BYTE PTR ds:0x6c7
 8a5:	eb 07                	jmp    0x8ae
 8a7:	bf d2 06             	mov    di,0x6d2
 8aa:	8a 0e d1 06          	mov    cl,BYTE PTR ds:0x6d1
 8ae:	fc                   	cld
 8af:	f2 ae                	repnz scas al,BYTE PTR es:[di]
 8b1:	e3 04                	jcxz   0x8b7
 8b3:	5f                   	pop    di
 8b4:	59                   	pop    cx
 8b5:	58                   	pop    ax
 8b6:	c3                   	ret
 8b7:	0a e4                	or     ah,ah
 8b9:	75 f8                	jne    0x8b3
 8bb:	fe c4                	inc    ah
 8bd:	eb e8                	jmp    0x8a7
 8bf:	51                   	push   cx
 8c0:	56                   	push   si
 8c1:	57                   	push   di
 8c2:	33 c9                	xor    cx,cx
 8c4:	8a 4c ff             	mov    cl,BYTE PTR [si-0x1]
 8c7:	fe 4c ff             	dec    BYTE PTR [si-0x1]
 8ca:	8b fe                	mov    di,si
 8cc:	46                   	inc    si
 8cd:	fc                   	cld
 8ce:	f3 a4                	rep movs BYTE PTR es:[di],BYTE PTR ds:[si]
 8d0:	5f                   	pop    di
 8d1:	5e                   	pop    si
 8d2:	59                   	pop    cx
 8d3:	c3                   	ret
 8d4:	be 34 06             	mov    si,0x634
 8d7:	8a 64 ff             	mov    ah,BYTE PTR [si-0x1]
 8da:	80 3e 80 00 00       	cmp    BYTE PTR ds:0x80,0x0
 8df:	75 13                	jne    0x8f4
 8e1:	0a e4                	or     ah,ah
 8e3:	bf 78 06             	mov    di,0x678
 8e6:	74 3f                	je     0x927
 8e8:	33 c9                	xor    cx,cx
 8ea:	8a cc                	mov    cl,ah
 8ec:	f3 a4                	rep movs BYTE PTR es:[di],BYTE PTR ds:[si]
 8ee:	c6 05 5c             	mov    BYTE PTR [di],0x5c
 8f1:	47                   	inc    di
 8f2:	eb 33                	jmp    0x927
 8f4:	0a e4                	or     ah,ah
 8f6:	bf 78 06             	mov    di,0x678
 8f9:	74 0a                	je     0x905
 8fb:	33 c9                	xor    cx,cx
 8fd:	8a cc                	mov    cl,ah
 8ff:	f3 a4                	rep movs BYTE PTR es:[di],BYTE PTR ds:[si]
 901:	c6 05 5c             	mov    BYTE PTR [di],0x5c
 904:	47                   	inc    di
 905:	be 81 00             	mov    si,0x81
 908:	33 c9                	xor    cx,cx
 90a:	8a 4c ff             	mov    cl,BYTE PTR [si-0x1]
 90d:	f3 a4                	rep movs BYTE PTR es:[di],BYTE PTR ds:[si]
 90f:	89 3e b8 06          	mov    WORD PTR ds:0x6b8,di
 913:	b4 43                	mov    ah,0x43
 915:	ba 75 06             	mov    dx,0x675
 918:	b0 00                	mov    al,0x0
 91a:	cd 21                	int    0x21
 91c:	72 1c                	jb     0x93a
 91e:	f6 c1 10             	test   cl,0x10
 921:	74 17                	je     0x93a
 923:	c6 05 5c             	mov    BYTE PTR [di],0x5c
 926:	47                   	inc    di
 927:	c6 05 2a             	mov    BYTE PTR [di],0x2a
 92a:	47                   	inc    di
 92b:	c6 05 2e             	mov    BYTE PTR [di],0x2e
 92e:	47                   	inc    di
 92f:	c6 05 2a             	mov    BYTE PTR [di],0x2a
 932:	47                   	inc    di
 933:	c6 05 00             	mov    BYTE PTR [di],0x0
 936:	89 3e b8 06          	mov    WORD PTR ds:0x6b8,di
 93a:	bf 75 06             	mov    di,0x675
 93d:	8b f7                	mov    si,di
 93f:	33 c0                	xor    ax,ax
 941:	b9 50 00             	mov    cx,0x50
 944:	fe c4                	inc    ah
 946:	ae                   	scas   al,BYTE PTR es:[di]
 947:	e0 fb                	loopne 0x944
 949:	33 c9                	xor    cx,cx
 94b:	8a cc                	mov    cl,ah
 94d:	bf 1b 02             	mov    di,0x21b
 950:	f3 a4                	rep movs BYTE PTR es:[di],BYTE PTR ds:[si]
 952:	ba 75 06             	mov    dx,0x675
 955:	b4 4e                	mov    ah,0x4e
 957:	b9 f1 00             	mov    cx,0xf1
 95a:	cd 21                	int    0x21
 95c:	73 03                	jae    0x961
 95e:	e9 25 02             	jmp    0xb86
 961:	e8 8c 00             	call   0x9f0
 964:	be bf 05             	mov    si,0x5bf
 967:	bf db 0d             	mov    di,0xddb
 96a:	b9 0b 00             	mov    cx,0xb
 96d:	f3 a5                	rep movs WORD PTR es:[di],WORD PTR ds:[si]
 96f:	83 06 21 05 16       	add    WORD PTR ds:0x521,0x16
 974:	ff 0e b7 05          	dec    WORD PTR ds:0x5b7
 978:	b4 4f                	mov    ah,0x4f
 97a:	cd 21                	int    0x21
 97c:	72 0c                	jb     0x98a
 97e:	e8 6f 00             	call   0x9f0
 981:	e8 e0 00             	call   0xa64
 984:	ff 0e b7 05          	dec    WORD PTR ds:0x5b7
 988:	75 ee                	jne    0x978
 98a:	3c 12                	cmp    al,0x12
 98c:	74 03                	je     0x991
 98e:	e9 f5 01             	jmp    0xb86
 991:	e8 a8 01             	call   0xb3c
 994:	e8 4c 01             	call   0xae3
 997:	a1 bc 06             	mov    ax,ds:0x6bc
 99a:	a3 31 05             	mov    ds:0x531,ax
 99d:	b8 db 0d             	mov    ax,0xddb
 9a0:	a3 2f 05             	mov    ds:0x52f,ax
 9a3:	e8 1c 02             	call   0xbc2
 9a6:	b4 02                	mov    ah,0x2
 9a8:	bb 07 00             	mov    bx,0x7
 9ab:	b6 1a                	mov    dh,0x1a
 9ad:	b2 00                	mov    dl,0x0
 9af:	cd 10                	int    0x10
 9b1:	e8 fe 01             	call   0xbb2
 9b4:	eb ed                	jmp    0x9a3
 9b6:	b4 02                	mov    ah,0x2
 9b8:	bb 07 00             	mov    bx,0x7
 9bb:	b6 1a                	mov    dh,0x1a
 9bd:	b2 00                	mov    dl,0x0
 9bf:	cd 10                	int    0x10
 9c1:	e8 ee 01             	call   0xbb2
 9c4:	b8 00 06             	mov    ax,0x600
 9c7:	8a 3e 2e 06          	mov    bh,BYTE PTR ds:0x62e
 9cb:	b3 07                	mov    bl,0x7
 9cd:	b9 00 15             	mov    cx,0x1500
 9d0:	b6 18                	mov    dh,0x18
 9d2:	b2 4f                	mov    dl,0x4f
 9d4:	cd 10                	int    0x10
 9d6:	b4 02                	mov    ah,0x2
 9d8:	bb 07 00             	mov    bx,0x7
 9db:	ba 00 15             	mov    dx,0x1500
 9de:	cd 10                	int    0x10
 9e0:	b4 33                	mov    ah,0x33
 9e2:	b0 01                	mov    al,0x1
 9e4:	8a 16 25 05          	mov    dl,BYTE PTR ds:0x525
 9e8:	cd 21                	int    0x21
 9ea:	33 c0                	xor    ax,ax
 9ec:	cd 21                	int    0x21
 9ee:	90                   	nop
 9ef:	90                   	nop
 9f0:	fc                   	cld
 9f1:	be 4a 05             	mov    si,0x54a
 9f4:	bf bf 05             	mov    di,0x5bf
 9f7:	ac                   	lods   al,BYTE PTR ds:[si]
 9f8:	8a e0                	mov    ah,al
 9fa:	b0 01                	mov    al,0x1
 9fc:	ff 06 bc 06          	inc    WORD PTR ds:0x6bc
 a00:	ff 06 b5 05          	inc    WORD PTR ds:0x5b5
 a04:	f6 c4 10             	test   ah,0x10
 a07:	74 0a                	je     0xa13
 a09:	32 c0                	xor    al,al
 a0b:	ff 0e b5 05          	dec    WORD PTR ds:0x5b5
 a0f:	ff 06 33 05          	inc    WORD PTR ds:0x533
 a13:	aa                   	stos   BYTE PTR es:[di],al
 a14:	be 53 05             	mov    si,0x553
 a17:	b9 0d 00             	mov    cx,0xd
 a1a:	ac                   	lods   al,BYTE PTR ds:[si]
 a1b:	3c 61                	cmp    al,0x61
 a1d:	72 06                	jb     0xa25
 a1f:	3c 7b                	cmp    al,0x7b
 a21:	73 0a                	jae    0xa2d
 a23:	2c 20                	sub    al,0x20
 a25:	3c 30                	cmp    al,0x30
 a27:	72 04                	jb     0xa2d
 a29:	3c 5b                	cmp    al,0x5b
 a2b:	72 1c                	jb     0xa49
 a2d:	57                   	push   di
 a2e:	51                   	push   cx
 a2f:	bf da 06             	mov    di,0x6da
 a32:	b9 12 00             	mov    cx,0x12
 a35:	f2 ae                	repnz scas al,BYTE PTR es:[di]
 a37:	e3 0a                	jcxz   0xa43
 a39:	41                   	inc    cx
 a3a:	f7 d9                	neg    cx
 a3c:	83 c1 12             	add    cx,0x12
 a3f:	8a c1                	mov    al,cl
 a41:	eb 04                	jmp    0xa47
 a43:	4f                   	dec    di
 a44:	aa                   	stos   BYTE PTR es:[di],al
 a45:	b0 12                	mov    al,0x12
 a47:	59                   	pop    cx
 a48:	5f                   	pop    di
 a49:	aa                   	stos   BYTE PTR es:[di],al
 a4a:	e2 ce                	loop   0xa1a
 a4c:	be 4f 05             	mov    si,0x54f
 a4f:	ad                   	lods   ax,WORD PTR ds:[si]
 a50:	ab                   	stos   WORD PTR es:[di],ax
 a51:	01 06 bb 05          	add    WORD PTR ds:0x5bb,ax
 a55:	ad                   	lods   ax,WORD PTR ds:[si]
 a56:	ab                   	stos   WORD PTR es:[di],ax
 a57:	11 06 bd 05          	adc    WORD PTR ds:0x5bd,ax
 a5b:	be 4d 05             	mov    si,0x54d
 a5e:	a5                   	movs   WORD PTR es:[di],WORD PTR ds:[si]
 a5f:	be 4b 05             	mov    si,0x54b
 a62:	a5                   	movs   WORD PTR es:[di],WORD PTR ds:[si]
 a63:	c3                   	ret
 a64:	fc                   	cld
 a65:	bf db 0d             	mov    di,0xddb
 a68:	89 3e c5 06          	mov    WORD PTR ds:0x6c5,di
 a6c:	8b 0e bc 06          	mov    cx,WORD PTR ds:0x6bc
 a70:	be bf 05             	mov    si,0x5bf
 a73:	b4 0e                	mov    ah,0xe
 a75:	fe cc                	dec    ah
 a77:	74 22                	je     0xa9b
 a79:	a6                   	cmps   BYTE PTR ds:[si],BYTE PTR es:[di]
 a7a:	74 f9                	je     0xa75
 a7c:	72 1d                	jb     0xa9b
 a7e:	83 06 c5 06 16       	add    WORD PTR ds:0x6c5,0x16
 a83:	8b 3e c5 06          	mov    di,WORD PTR ds:0x6c5
 a87:	49                   	dec    cx
 a88:	75 e6                	jne    0xa70
 a8a:	be bf 05             	mov    si,0x5bf
 a8d:	8b 3e 21 05          	mov    di,WORD PTR ds:0x521
 a91:	b9 0b 00             	mov    cx,0xb
 a94:	f3 a5                	rep movs WORD PTR es:[di],WORD PTR ds:[si]
 a96:	89 3e 21 05          	mov    WORD PTR ds:0x521,di
 a9a:	c3                   	ret
 a9b:	f7 d9                	neg    cx
 a9d:	03 0e bc 06          	add    cx,WORD PTR ds:0x6bc
 aa1:	d1 e1                	shl    cx,1
 aa3:	8b c1                	mov    ax,cx
 aa5:	d1 e0                	shl    ax,1
 aa7:	d1 e0                	shl    ax,1
 aa9:	d1 e0                	shl    ax,1
 aab:	03 c1                	add    ax,cx
 aad:	d1 e1                	shl    cx,1
 aaf:	03 c8                	add    cx,ax
 ab1:	81 c1 db 0d          	add    cx,0xddb
 ab5:	89 0e d7 05          	mov    WORD PTR ds:0x5d7,cx
 ab9:	f7 d9                	neg    cx
 abb:	03 0e 21 05          	add    cx,WORD PTR ds:0x521
 abf:	d1 e9                	shr    cx,1
 ac1:	8b 3e 21 05          	mov    di,WORD PTR ds:0x521
 ac5:	8b f7                	mov    si,di
 ac7:	4e                   	dec    si
 ac8:	4e                   	dec    si
 ac9:	83 c7 16             	add    di,0x16
 acc:	89 3e 21 05          	mov    WORD PTR ds:0x521,di
 ad0:	4f                   	dec    di
 ad1:	4f                   	dec    di
 ad2:	fd                   	std
 ad3:	f3 a5                	rep movs WORD PTR es:[di],WORD PTR ds:[si]
 ad5:	fc                   	cld
 ad6:	be bf 05             	mov    si,0x5bf
 ad9:	8b 3e d7 05          	mov    di,WORD PTR ds:0x5d7
 add:	b9 0b 00             	mov    cx,0xb
 ae0:	f3 a5                	rep movs WORD PTR es:[di],WORD PTR ds:[si]
 ae2:	c3                   	ret
 ae3:	b4 02                	mov    ah,0x2
 ae5:	b6 15                	mov    dh,0x15
 ae7:	b2 00                	mov    dl,0x0
 ae9:	bb 07 00             	mov    bx,0x7
 aec:	cd 10                	int    0x10
 aee:	8a 16 be 06          	mov    dl,BYTE PTR ds:0x6be
 af2:	80 ea 40             	sub    dl,0x40
 af5:	b4 36                	mov    ah,0x36
 af7:	cd 21                	int    0x21
 af9:	52                   	push   dx
 afa:	f7 e1                	mul    cx
 afc:	52                   	push   dx
 afd:	50                   	push   ax
 afe:	8b ca                	mov    cx,dx
 b00:	f7 e3                	mul    bx
 b02:	8b fa                	mov    di,dx
 b04:	8b f0                	mov    si,ax
 b06:	8b c1                	mov    ax,cx
 b08:	f7 e3                	mul    bx
 b0a:	03 c7                	add    ax,di
 b0c:	8b d0                	mov    dx,ax
 b0e:	8b c6                	mov    ax,si
 b10:	b9 0d 00             	mov    cx,0xd
 b13:	bf f6 03             	mov    di,0x3f6
 b16:	e8 28 01             	call   0xc41
 b19:	58                   	pop    ax
 b1a:	59                   	pop    cx
 b1b:	5b                   	pop    bx
 b1c:	f7 e3                	mul    bx
 b1e:	8b fa                	mov    di,dx
 b20:	8b f0                	mov    si,ax
 b22:	8b c1                	mov    ax,cx
 b24:	f7 e3                	mul    bx
 b26:	03 c7                	add    ax,di
 b28:	8b d0                	mov    dx,ax
 b2a:	8b c6                	mov    ax,si
 b2c:	b9 0d 00             	mov    cx,0xd
 b2f:	bf 1e 04             	mov    di,0x41e
 b32:	e8 0c 01             	call   0xc41
 b35:	be 9f 03             	mov    si,0x39f
 b38:	e8 8d 02             	call   0xdc8
 b3b:	c3                   	ret
 b3c:	b4 06                	mov    ah,0x6
 b3e:	32 c0                	xor    al,al
 b40:	b7 0e                	mov    bh,0xe
 b42:	33 c9                	xor    cx,cx
 b44:	b6 18                	mov    dh,0x18
 b46:	b2 4f                	mov    dl,0x4f
 b48:	cd 10                	int    0x10
 b4a:	b4 02                	mov    ah,0x2
 b4c:	33 d2                	xor    dx,dx
 b4e:	bb 07 00             	mov    bx,0x7
 b51:	cd 10                	int    0x10
 b53:	33 d2                	xor    dx,dx
 b55:	a1 33 05             	mov    ax,ds:0x533
 b58:	b9 05 00             	mov    cx,0x5
 b5b:	bf 5c 02             	mov    di,0x25c
 b5e:	e8 e0 00             	call   0xc41
 b61:	33 d2                	xor    dx,dx
 b63:	a1 b5 05             	mov    ax,ds:0x5b5
 b66:	b9 05 00             	mov    cx,0x5
 b69:	bf 6d 02             	mov    di,0x26d
 b6c:	e8 d2 00             	call   0xc41
 b6f:	8b 16 bd 05          	mov    dx,WORD PTR ds:0x5bd
 b73:	a1 bb 05             	mov    ax,ds:0x5bb
 b76:	b9 0d 00             	mov    cx,0xd
 b79:	bf 80 02             	mov    di,0x280
 b7c:	e8 c2 00             	call   0xc41
 b7f:	be 0c 02             	mov    si,0x20c
 b82:	e8 43 02             	call   0xdc8
 b85:	c3                   	ret
 b86:	3c 02                	cmp    al,0x2
 b88:	be 23 01             	mov    si,0x123
 b8b:	74 1f                	je     0xbac
 b8d:	3c 03                	cmp    al,0x3
 b8f:	be 36 01             	mov    si,0x136
 b92:	74 18                	je     0xbac
 b94:	3c 04                	cmp    al,0x4
 b96:	be 49 01             	mov    si,0x149
 b99:	74 11                	je     0xbac
 b9b:	3c 08                	cmp    al,0x8
 b9d:	be 7e 01             	mov    si,0x17e
 ba0:	74 0a                	je     0xbac
 ba2:	3c 0f                	cmp    al,0xf
 ba4:	be d0 01             	mov    si,0x1d0
 ba7:	74 03                	je     0xbac
 ba9:	be 10 01             	mov    si,0x110
 bac:	e8 19 02             	call   0xdc8
 baf:	e9 38 fe             	jmp    0x9ea
 bb2:	b4 07                	mov    ah,0x7
 bb4:	cd 21                	int    0x21
 bb6:	3c 03                	cmp    al,0x3
 bb8:	75 03                	jne    0xbbd
 bba:	e9 07 fe             	jmp    0x9c4
 bbd:	3c 0d                	cmp    al,0xd
 bbf:	75 f1                	jne    0xbb2
 bc1:	c3                   	ret
 bc2:	b8 00 06             	mov    ax,0x600
 bc5:	b7 71                	mov    bh,0x71
 bc7:	b9 00 05             	mov    cx,0x500
 bca:	b6 14                	mov    dh,0x14
 bcc:	b2 4f                	mov    dl,0x4f
 bce:	cd 10                	int    0x10
 bd0:	b4 02                	mov    ah,0x2
 bd2:	bb 07 00             	mov    bx,0x7
 bd5:	ba 00 05             	mov    dx,0x500
 bd8:	cd 10                	int    0x10
 bda:	b9 0f 00             	mov    cx,0xf
 bdd:	51                   	push   cx
 bde:	e8 28 00             	call   0xc09
 be1:	be 03 01             	mov    si,0x103
 be4:	e8 e1 01             	call   0xdc8
 be7:	59                   	pop    cx
 be8:	e2 f3                	loop   0xbdd
 bea:	e8 1c 00             	call   0xc09
 bed:	bb 07 00             	mov    bx,0x7
 bf0:	b9 10 00             	mov    cx,0x10
 bf3:	b6 05                	mov    dh,0x5
 bf5:	b2 29                	mov    dl,0x29
 bf7:	52                   	push   dx
 bf8:	51                   	push   cx
 bf9:	53                   	push   bx
 bfa:	b4 02                	mov    ah,0x2
 bfc:	cd 10                	int    0x10
 bfe:	e8 25 00             	call   0xc26
 c01:	5b                   	pop    bx
 c02:	59                   	pop    cx
 c03:	5a                   	pop    dx
 c04:	fe c6                	inc    dh
 c06:	e2 ef                	loop   0xbf7
 c08:	c3                   	ret
 c09:	bf cf 04             	mov    di,0x4cf
 c0c:	e8 7f 00             	call   0xc8e
 c0f:	c6 06 f5 04 fc       	mov    BYTE PTR ds:0x4f5,0xfc
 c14:	be ce 04             	mov    si,0x4ce
 c17:	e8 ae 01             	call   0xdc8
 c1a:	83 06 2f 05 16       	add    WORD PTR ds:0x52f,0x16
 c1f:	ff 0e 31 05          	dec    WORD PTR ds:0x531
 c23:	74 19                	je     0xc3e
 c25:	c3                   	ret
 c26:	bf f7 04             	mov    di,0x4f7
 c29:	e8 62 00             	call   0xc8e
 c2c:	be f7 04             	mov    si,0x4f7
 c2f:	e8 96 01             	call   0xdc8
 c32:	83 06 2f 05 16       	add    WORD PTR ds:0x52f,0x16
 c37:	ff 0e 31 05          	dec    WORD PTR ds:0x531
 c3b:	74 01                	je     0xc3e
 c3d:	c3                   	ret
 c3e:	e9 75 fd             	jmp    0x9b6
 c41:	c6 06 2b 05 03       	mov    BYTE PTR ds:0x52b,0x3
 c46:	53                   	push   bx
 c47:	51                   	push   cx
 c48:	57                   	push   di
 c49:	56                   	push   si
 c4a:	8b d8                	mov    bx,ax
 c4c:	8b f2                	mov    si,dx
 c4e:	fd                   	std
 c4f:	03 f9                	add    di,cx
 c51:	4f                   	dec    di
 c52:	33 d2                	xor    dx,dx
 c54:	8b c6                	mov    ax,si
 c56:	f7 36 cf 06          	div    WORD PTR ds:0x6cf
 c5a:	8b f0                	mov    si,ax
 c5c:	8b c3                	mov    ax,bx
 c5e:	f7 36 cf 06          	div    WORD PTR ds:0x6cf
 c62:	8b d8                	mov    bx,ax
 c64:	80 3e 2b 05 00       	cmp    BYTE PTR ds:0x52b,0x0
 c69:	75 0a                	jne    0xc75
 c6b:	c6 06 2b 05 03       	mov    BYTE PTR ds:0x52b,0x3
 c70:	c6 05 2c             	mov    BYTE PTR [di],0x2c
 c73:	4f                   	dec    di
 c74:	49                   	dec    cx
 c75:	fe 0e 2b 05          	dec    BYTE PTR ds:0x52b
 c79:	80 c2 30             	add    dl,0x30
 c7c:	88 15                	mov    BYTE PTR [di],dl
 c7e:	4f                   	dec    di
 c7f:	0b c6                	or     ax,si
 c81:	e0 cf                	loopne 0xc52
 c83:	e3 04                	jcxz   0xc89
 c85:	b0 20                	mov    al,0x20
 c87:	f3 aa                	rep stos BYTE PTR es:[di],al
 c89:	5e                   	pop    si
 c8a:	5f                   	pop    di
 c8b:	59                   	pop    cx
 c8c:	5b                   	pop    bx
 c8d:	c3                   	ret
 c8e:	89 3e 2d 05          	mov    WORD PTR ds:0x52d,di
 c92:	b9 25 00             	mov    cx,0x25
 c95:	b0 20                	mov    al,0x20
 c97:	fc                   	cld
 c98:	f3 aa                	rep stos BYTE PTR es:[di],al
 c9a:	8b 3e 2d 05          	mov    di,WORD PTR ds:0x52d
 c9e:	8b 36 2f 05          	mov    si,WORD PTR ds:0x52f
 ca2:	ac                   	lods   al,BYTE PTR ds:[si]
 ca3:	a2 2c 05             	mov    ds:0x52c,al
 ca6:	ac                   	lods   al,BYTE PTR ds:[si]
 ca7:	3c 01                	cmp    al,0x1
 ca9:	75 0d                	jne    0xcb8
 cab:	ac                   	lods   al,BYTE PTR ds:[si]
 cac:	3c 01                	cmp    al,0x1
 cae:	72 03                	jb     0xcb3
 cb0:	b0 2e                	mov    al,0x2e
 cb2:	aa                   	stos   BYTE PTR es:[di],al
 cb3:	b0 2e                	mov    al,0x2e
 cb5:	aa                   	stos   BYTE PTR es:[di],al
 cb6:	eb 33                	jmp    0xceb
 cb8:	bb da 06             	mov    bx,0x6da
 cbb:	b9 08 00             	mov    cx,0x8
 cbe:	3c 41                	cmp    al,0x41
 cc0:	73 0f                	jae    0xcd1
 cc2:	3c 30                	cmp    al,0x30
 cc4:	73 0d                	jae    0xcd3
 cc6:	d7                   	xlat   BYTE PTR ds:[bx]
 cc7:	3c 2e                	cmp    al,0x2e
 cc9:	75 08                	jne    0xcd3
 ccb:	b0 20                	mov    al,0x20
 ccd:	f3 aa                	rep stos BYTE PTR es:[di],al
 ccf:	eb 0a                	jmp    0xcdb
 cd1:	04 20                	add    al,0x20
 cd3:	aa                   	stos   BYTE PTR es:[di],al
 cd4:	ac                   	lods   al,BYTE PTR ds:[si]
 cd5:	0a c0                	or     al,al
 cd7:	74 0b                	je     0xce4
 cd9:	e2 e3                	loop   0xcbe
 cdb:	b0 2e                	mov    al,0x2e
 cdd:	aa                   	stos   BYTE PTR es:[di],al
 cde:	b9 03 00             	mov    cx,0x3
 ce1:	ac                   	lods   al,BYTE PTR ds:[si]
 ce2:	eb da                	jmp    0xcbe
 ce4:	80 3e 2c 05 00       	cmp    BYTE PTR ds:0x52c,0x0
 ce9:	75 10                	jne    0xcfb
 ceb:	8b 3e 2d 05          	mov    di,WORD PTR ds:0x52d
 cef:	83 c7 11             	add    di,0x11
 cf2:	be 05 01             	mov    si,0x105
 cf5:	b9 0b 00             	mov    cx,0xb
 cf8:	f3 a4                	rep movs BYTE PTR es:[di],BYTE PTR ds:[si]
 cfa:	c3                   	ret
 cfb:	8b 3e 2d 05          	mov    di,WORD PTR ds:0x52d
 cff:	83 c7 0f             	add    di,0xf
 d02:	8b 36 2f 05          	mov    si,WORD PTR ds:0x52f
 d06:	83 c6 0e             	add    si,0xe
 d09:	ad                   	lods   ax,WORD PTR ds:[si]
 d0a:	8b d0                	mov    dx,ax
 d0c:	ad                   	lods   ax,WORD PTR ds:[si]
 d0d:	8b c8                	mov    cx,ax
 d0f:	0b c2                	or     ax,dx
 d11:	74 1f                	je     0xd32
 d13:	8b da                	mov    bx,dx
 d15:	80 e7 03             	and    bh,0x3
 d18:	8a c6                	mov    al,dh
 d1a:	8a e1                	mov    ah,cl
 d1c:	8a d5                	mov    dl,ch
 d1e:	32 f6                	xor    dh,dh
 d20:	d1 ea                	shr    dx,1
 d22:	d1 d8                	rcr    ax,1
 d24:	d1 ea                	shr    dx,1
 d26:	d1 d8                	rcr    ax,1
 d28:	0a fb                	or     bh,bl
 d2a:	74 06                	je     0xd32
 d2c:	05 01 00             	add    ax,0x1
 d2f:	83 d2 00             	adc    dx,0x0
 d32:	b9 06 00             	mov    cx,0x6
 d35:	e8 09 ff             	call   0xc41
 d38:	fc                   	cld
 d39:	ad                   	lods   ax,WORD PTR ds:[si]
 d3a:	8a d8                	mov    bl,al
 d3c:	80 e3 1f             	and    bl,0x1f
 d3f:	d1 e8                	shr    ax,1
 d41:	8a f8                	mov    bh,al
 d43:	d0 ef                	shr    bh,1
 d45:	d0 ef                	shr    bh,1
 d47:	d0 ef                	shr    bh,1
 d49:	d0 ef                	shr    bh,1
 d4b:	8a c4                	mov    al,ah
 d4d:	98                   	cbw
 d4e:	05 bc 07             	add    ax,0x7bc
 d51:	50                   	push   ax
 d52:	8a c7                	mov    al,bh
 d54:	98                   	cbw
 d55:	33 d2                	xor    dx,dx
 d57:	83 c7 08             	add    di,0x8
 d5a:	b9 02 00             	mov    cx,0x2
 d5d:	e8 e1 fe             	call   0xc41
 d60:	e8 4b 00             	call   0xdae
 d63:	03 f9                	add    di,cx
 d65:	b0 2d                	mov    al,0x2d
 d67:	fc                   	cld
 d68:	aa                   	stos   BYTE PTR es:[di],al
 d69:	8a c3                	mov    al,bl
 d6b:	98                   	cbw
 d6c:	33 d2                	xor    dx,dx
 d6e:	e8 d0 fe             	call   0xc41
 d71:	e8 3a 00             	call   0xdae
 d74:	03 f9                	add    di,cx
 d76:	b0 2d                	mov    al,0x2d
 d78:	fc                   	cld
 d79:	aa                   	stos   BYTE PTR es:[di],al
 d7a:	58                   	pop    ax
 d7b:	33 d2                	xor    dx,dx
 d7d:	e8 c1 fe             	call   0xc41
 d80:	fc                   	cld
 d81:	ad                   	lods   ax,WORD PTR ds:[si]
 d82:	d1 e8                	shr    ax,1
 d84:	d1 e8                	shr    ax,1
 d86:	d1 e8                	shr    ax,1
 d88:	8a d8                	mov    bl,al
 d8a:	8a c4                	mov    al,ah
 d8c:	98                   	cbw
 d8d:	33 d2                	xor    dx,dx
 d8f:	83 c7 03             	add    di,0x3
 d92:	e8 ac fe             	call   0xc41
 d95:	e8 16 00             	call   0xdae
 d98:	03 f9                	add    di,cx
 d9a:	c6 05 3a             	mov    BYTE PTR [di],0x3a
 d9d:	8a c3                	mov    al,bl
 d9f:	d0 e8                	shr    al,1
 da1:	d0 e8                	shr    al,1
 da3:	98                   	cbw
 da4:	33 d2                	xor    dx,dx
 da6:	47                   	inc    di
 da7:	e8 97 fe             	call   0xc41
 daa:	e8 01 00             	call   0xdae
 dad:	c3                   	ret
 dae:	8a 05                	mov    al,BYTE PTR [di]
 db0:	3c 20                	cmp    al,0x20
 db2:	75 03                	jne    0xdb7
 db4:	c6 05 30             	mov    BYTE PTR [di],0x30
 db7:	c3                   	ret
 db8:	53                   	push   bx
 db9:	b4 0e                	mov    ah,0xe
 dbb:	bb 07 00             	mov    bx,0x7
 dbe:	51                   	push   cx
 dbf:	24 7f                	and    al,0x7f
 dc1:	50                   	push   ax
 dc2:	cd 10                	int    0x10
 dc4:	58                   	pop    ax
 dc5:	59                   	pop    cx
 dc6:	5b                   	pop    bx
 dc7:	c3                   	ret
 dc8:	fc                   	cld
 dc9:	2e ac                	lods   al,BYTE PTR cs:[si]
 dcb:	b4 0e                	mov    ah,0xe
 dcd:	bb 07 00             	mov    bx,0x7
 dd0:	50                   	push   ax
 dd1:	24 7f                	and    al,0x7f
 dd3:	cd 10                	int    0x10
 dd5:	58                   	pop    ax
 dd6:	24 80                	and    al,0x80
 dd8:	74 ee                	je     0xdc8
 dda:	c3                   	ret
	...
