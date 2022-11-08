/*
   void *memcpy(void *dest, const void *src, size_t n);
*/
    .text
    .p2align 3
    .globl  la64_memcpy
    .type   la64_memcpy, @function
la64_memcpy:
    add.d   $a4, $a1, $a2
    add.d   $a3, $a0, $a2
    move    $t8, $a0
    move    $a5, $a1
    srai.d  $a6, $a2, 4         #num/16
    beqz    $a6, less_16bytes   #num<16
    slti    $a6, $a2, 137
    beqz    $a6, more_137bytes  #num>137
    srai.d  $a6, $a2, 6
    beqz    $a6, less_64bytes   #num<64

    srli.d  $a0, $a0, 3
    slli.d  $a0, $a0, 3
    addi.d  $a0, $a0, 0x8
    sub.d   $a7, $t8, $a0
    ld.d    $t0, $a1, 0
    sub.d   $a1, $a1, $a7
    st.d    $t0, $t8, 0

    add.d   $a7, $a7, $a2
    addi.d  $a7, $a7, -0x20
loop_32:
    ld.d    $t0, $a1, 0
    ld.d    $t1, $a1, 8
    ld.d    $t2, $a1, 16
    ld.d    $t3, $a1, 24
    st.d    $t0, $a0, 0
    st.d    $t1, $a0, 8
    st.d    $t2, $a0, 16
    st.d    $t3, $a0, 24

    addi.d  $a0,  $a0,   0x20
    addi.d  $a1,  $a1,   0x20
    addi.d  $a7,  $a7,  -0x20
    blt     $zero, $a7, loop_32

    ld.d    $t4, $a4, -32
    ld.d    $t5, $a4, -24
    ld.d    $t6, $a4, -16
    ld.d    $t7, $a4, -8
    st.d    $t4, $a3, -32
    st.d    $t5, $a3, -24
    st.d    $t6, $a3, -16
    st.d    $t7, $a3, -8

    move    $v0,   $t8
    jirl    $zero, $ra, 0

less_64bytes:
    srai.d  $a6, $a2, 5
    beqz    $a6, less_32bytes

    ld.d    $t0, $a1, 0
    ld.d    $t1, $a1, 8
    ld.d    $t2, $a1, 16
    ld.d    $t3, $a1, 24
    ld.d    $t4, $a4, -32
    ld.d    $t5, $a4, -24
    ld.d    $t6, $a4, -16
    ld.d    $t7, $a4, -8
    st.d    $t0, $a0, 0
    st.d    $t1, $a0, 8
    st.d    $t2, $a0, 16
    st.d    $t3, $a0, 24
    st.d    $t4, $a3, -32
    st.d    $t5, $a3, -24
    st.d    $t6, $a3, -16
    st.d    $t7, $a3, -8

    jirl    $zero, $ra, 0

less_32bytes:
    ld.d    $t0, $a1, 0
    ld.d    $t1, $a1, 8
    ld.d    $t2, $a4, -16
    ld.d    $t3, $a4, -8
    st.d    $t0, $a0, 0
    st.d    $t1, $a0, 8
    st.d    $t2, $a3, -16
    st.d    $t3, $a3, -8

    jirl    $zero, $ra, 0

less_16bytes:
    srai.d  $a6, $a2, 3         #num/8
    beqz    $a6, less_8bytes

    ld.d    $t0, $a1, 0
    ld.d    $t1, $a4, -8
    st.d    $t0, $a0, 0
    st.d    $t1, $a3, -8

    jirl    $zero, $ra, 0

less_8bytes:
    srai.d  $a6, $a2, 2
    beqz    $a6, less_4bytes

    ld.w    $t0, $a1, 0
    ld.w    $t1, $a4, -4
    st.w    $t0, $a0, 0
    st.w    $t1, $a3, -4

    jirl    $zero, $ra, 0

less_4bytes:
    srai.d  $a6, $a2, 1
    beqz    $a6, less_2bytes

    ld.h    $t0, $a1, 0
    ld.h    $t1, $a4, -2
    st.h    $t0, $a0, 0
    st.h    $t1, $a3, -2

    jirl    $zero, $ra, 0

less_2bytes:
    beqz    $a2, less_1bytes

    ld.b    $t0, $a1, 0
    st.b    $t0, $a0, 0

    jirl    $zero, $ra, 0

less_1bytes:
    jirl    $zero, $ra, 0

more_137bytes:
    li.w      $a6, 64
    andi    $t1, $a0, 7
    srli.d  $a0, $a0, 3
    andi    $t2, $a2, 7
    slli.d  $a0, $a0, 3
    add.d   $t1, $t1, $t2
    beqz    $t1, all_align
    beq     $a0, $t8, start_over
    addi.d  $a0, $a0, 0x8
    sub.d   $a7, $t8, $a0
    sub.d   $a1, $a1, $a7
    add.d   $a2, $a7, $a2

start_unalign_proc:
    ld.d    $t0, $a5, 0
    slli.d  $t0, $t0, 8
    pcaddi  $t1, 18
    slli.d  $t2, $a7, 3
    add.d   $t1, $t1, $t2
    jirl    $zero, $t1, 0

start_7_unalign:
    srli.d  $t0, $t0, 8
    st.b    $t0, $a0, -7
start_6_unalign:
    srli.d  $t0, $t0, 8
    st.b    $t0, $a0, -6
start_5_unalign:
    srli.d  $t0, $t0, 8
    st.b    $t0, $a0, -5
start_4_unalign:
    srli.d  $t0, $t0, 8
    st.b    $t0, $a0, -4
start_3_unalign:
    srli.d  $t0, $t0, 8
    st.b    $t0, $a0, -3
start_2_unalign:
    srli.d  $t0, $t0, 8
    st.b    $t0, $a0, -2
start_1_unalign:
    srli.d  $t0, $t0, 8
    st.b    $t0, $a0, -1
start_over:

    addi.d  $a2, $a2, -0x80
    blt     $a2, $zero, end_unalign_proc

loop_less:
    ld.d    $t0, $a1, 0x0
    ld.d    $t1, $a1, 0x8
    ld.d    $t2, $a1, 0x10
    ld.d    $t3, $a1, 0x18
    ld.d    $t4, $a1, 0x20
    ld.d    $t5, $a1, 0x28
    ld.d    $t6, $a1, 0x30
    ld.d    $t7, $a1, 0x38

    st.d    $t0, $a0, 0x0
    st.d    $t1, $a0, 0x8
    st.d    $t2, $a0, 0x10
    st.d    $t3, $a0, 0x18
    st.d    $t4, $a0, 0x20
    st.d    $t5, $a0, 0x28
    st.d    $t6, $a0, 0x30
    st.d    $t7, $a0, 0x38

    ld.d    $t0, $a1, 0x40
    ld.d    $t1, $a1, 0x48
    ld.d    $t2, $a1, 0x50
    ld.d    $t3, $a1, 0x58
    ld.d    $t4, $a1, 0x60
    ld.d    $t5, $a1, 0x68
    ld.d    $t6, $a1, 0x70
    ld.d    $t7, $a1, 0x78

    st.d    $t0, $a0, 0x40
    st.d    $t1, $a0, 0x48
    st.d    $t2, $a0, 0x50
    st.d    $t3, $a0, 0x58
    st.d    $t4, $a0, 0x60
    st.d    $t5, $a0, 0x68
    st.d    $t6, $a0, 0x70
    st.d    $t7, $a0, 0x78

    addi.d  $a0, $a0,  0x80
    addi.d  $a1, $a1,  0x80
    addi.d  $a2, $a2, -0x80
    bge     $a2, $zero, loop_less

end_unalign_proc:
    addi.d  $a2, $a2, 0x80

    pcaddi  $t1, 34
    andi    $t2, $a2, 0x78
    sub.d   $t1, $t1, $t2
    jirl    $zero, $t1, 0

end_120_128_unalign:
    ld.d    $t0, $a1, 112
    st.d    $t0, $a0, 112
end_112_120_unalign:
    ld.d    $t0, $a1, 104
    st.d    $t0, $a0, 104
end_104_112_unalign:
    ld.d    $t0, $a1, 96
    st.d    $t0, $a0, 96
end_96_104_unalign:
    ld.d    $t0, $a1, 88
    st.d    $t0, $a0, 88
end_88_96_unalign:
    ld.d    $t0, $a1, 80
    st.d    $t0, $a0, 80
end_80_88_unalign:
    ld.d    $t0, $a1, 72
    st.d    $t0, $a0, 72
end_72_80_unalign:
    ld.d    $t0, $a1, 64
    st.d    $t0, $a0, 64
end_64_72_unalign:
    ld.d    $t0, $a1, 56
    st.d    $t0, $a0, 56
end_56_64_unalign:
    ld.d    $t0, $a1, 48
    st.d    $t0, $a0, 48
end_48_56_unalign:
    ld.d    $t0, $a1, 40
    st.d    $t0, $a0, 40
end_40_48_unalign:
    ld.d    $t0, $a1, 32
    st.d    $t0, $a0, 32
end_32_40_unalign:
    ld.d    $t0, $a1, 24
    st.d    $t0, $a0, 24
end_24_32_unalign:
    ld.d    $t0, $a1, 16
    st.d    $t0, $a0, 16
end_16_24_unalign:
    ld.d    $t0, $a1, 8
    st.d    $t0, $a0, 8
end_8_16_unalign:
    ld.d    $t0, $a1, 0
    st.d    $t0, $a0, 0
end_0_8_unalign:

    mod.d   $t0, $a3, $a6
    srli.d  $t1, $t0, 3
    slti    $t0, $t0, 1
    add.d   $t0, $t0, $t1
    blt     $zero, $t0, end_8_without_cross_cache_line

    andi    $a2, $a2, 0x7
    pcaddi  $t1, 18
    slli.d  $a2, $a2, 3
    sub.d   $t1, $t1, $a2
    jirl    $zero, $t1, 0

end_7_unalign:
    ld.b    $t0, $a4, -7
    st.b    $t0, $a3, -7
end_6_unalign:
    ld.b    $t0, $a4, -6
    st.b    $t0, $a3, -6
end_5_unalign:
    ld.b    $t0, $a4, -5
    st.b    $t0, $a3, -5
end_4_unalign:
    ld.b    $t0, $a4, -4
    st.b    $t0, $a3, -4
end_3_unalign:
    ld.b    $t0, $a4, -3
    st.b    $t0, $a3, -3
end_2_unalign:
    ld.b    $t0, $a4, -2
    st.b    $t0, $a3, -2
end_1_unalign:
    ld.b    $t0, $a4, -1
    st.b    $t0, $a3, -1
end:
    move    $v0, $t8
    jirl    $zero, $ra, 0

all_align:
    addi.d  $a2, $a2, -0x20

align_loop_less:
    ld.d    $t0, $a1, 0
    ld.d    $t1, $a1, 8
    ld.d    $t2, $a1, 16
    ld.d    $t3, $a1, 24
    st.d    $t0, $a0, 0
    st.d    $t1, $a0, 8
    st.d    $t2, $a0, 16
    st.d    $t3, $a0, 24

    addi.d  $a0,  $a0,   0x20
    addi.d  $a1,  $a1,   0x20
    addi.d  $a2,  $a2,  -0x20
    blt     $zero, $a2, align_loop_less

    ld.d    $t4, $a4, -32
    ld.d    $t5, $a4, -24
    ld.d    $t6, $a4, -16
    ld.d    $t7, $a4, -8
    st.d    $t4, $a3, -32
    st.d    $t5, $a3, -24
    st.d    $t6, $a3, -16
    st.d    $t7, $a3, -8

    move    $v0, $t8
    jirl    $zero, $ra, 0

end_8_without_cross_cache_line:
    ld.d    $t0, $a4, -8
    st.d    $t0, $a3, -8

    move    $v0, $t8
    jirl    $zero, $ra, 0

    .size   la64_memcpy, . - la64_memcpy
