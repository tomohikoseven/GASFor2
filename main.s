	.file	"main.c"
	.section	.rodata
.LC0:
	.string	"usage : ./main loopNum."
.LC1:
	.string	"i = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc          # main()の開始
	pushl	%ebp            # スタックにベースポインタを積む
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp      # ベースポインタへスタックポインタを代入
	.cfi_def_cfa_register 5
	andl	$-16, %esp      # スタックポインタを-16バイト移動
	subl	$32, %esp       # ローカル変数をスタックに積む
	movl	$1, 24(%esp)    # i の初期化
	movl	$0, 28(%esp)    # loopNum の初期化
	cmpl	$2, 8(%ebp)     # if文条件判定( 2 != argc )
	je	.L2                 # if 2 == argc, jump to .L2
	movl	$.LC0, (%esp)   # usage～のポインタをスタックに代入(積んでいない)
	call	puts            # puts("usage～");
	movl	$1, (%esp)      # exit()の第1引数をスタックに代入
	call	exit            # exit(1)
.L2:
	movl	12(%ebp), %eax  # 12(%ebp) = argv[0]. eax = argv[0]
	addl	$4, %eax        # 4 = sizeof(char*). argv[0] + 0x4(bytes) = argv[1]
	movl	(%eax), %eax    # %eax = %eax = argv[1]
	movl	%eax, (%esp)    # %esp = argv[1]
	call	atoi            # atoi( argv[1] )
	movl	%eax, 28(%esp)  # loopNum = atoi()の戻り値
	movl	$0, 24(%esp)    # for()のi=0
	jmp	.L3                 # for()の1回目部分の処理にjump
.L4:
	movl	$.LC1, %eax     # "i = %d"
	movl	24(%esp), %edx  # edx = i
	movl	%edx, 4(%esp)   # 4(%esp) = i
	movl	%eax, (%esp)    # (%esp) = "i = %d"
	call	printf          # printf( %esp, 4(%esp) )
	addl	$1, 24(%esp)    # i++
.L3:                            # for文の条件判定部分
	movl	24(%esp), %eax  # eax = i
	cmpl	28(%esp), %eax  # loopNum と i の比較
	jl	.L4                 # if loopNum > i, jump .L4
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.1-9ubuntu3) 4.6.1"
	.section	.note.GNU-stack,"",@progbits
