/*
   void *memmove(void *dest, const void *src, size_t n);
 */
    .text
    .p2align 3
    .globl  la64_memmove
    .type   la64_memmove, @function
la64_memmove:

//1st $var: dest ptr: $void *str1 $r4 a0
//2nd $var: src  ptr: $void *str2 $r5 a1
//3rd $var: size_t num
//t0~t9 registers as $temp

    add.d   $a4, $a1, $a2
    add.d   $a3, $a0, $a2
    beq     $a1, $a0, less_1bytes
    move    $t8, $a0
    srai.d  $a6, $a2, 4             #num/16
    beqz    $a6, less_16bytes       #num<16
    srai.d  $a6, $a2, 6             #num/64
    bnez    $a6, more_64bytes       #num>64
    srai.d  $a6, $a2, 5
    beqz    $a6, less_32bytes       #num<32

    ld.d    $t0, $a1, 0             #32<num<64
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
    srai.d  $a6, $a2, 3 #num/8
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

more_64bytes:
    sub.d   $a7, $a0, $a1
    bltu    $a7, $a2, copy_backward

copy_forward:
    srli.d  $a0, $a0, 3
    slli.d  $a0, $a0, 3
    beq     $a0, $t8, all_align
    addi.d  $a0, $a0, 0x8
    sub.d   $a7, $t8, $a0
    sub.d   $a1, $a1, $a7
    add.d   $a2, $a7, $a2

start_unalign_proc:
    pcaddi  $t1, 18
    slli.d  $a6, $a7, 3
    add.d   $t1, $t1, $a6
    jirl    $zero, $t1, 0

start_7_unalign:
    ld.b    $t0, $a1, -7
    st.b    $t0, $a0, -7
start_6_unalign:
    ld.b    $t0, $a1, -6
    st.b    $t0, $a0, -6
start_5_unalign:
    ld.b    $t0, $a1, -5
    st.b    $t0, $a0, -5
start_4_unalign:
    ld.b    $t0, $a1, -4
    st.b    $t0, $a0, -4
start_3_unalign:
    ld.b    $t0, $a1, -3
    st.b    $t0, $a0, -3
start_2_unalign:
    ld.b    $t0, $a1, -2
    st.b    $t0, $a0, -2
start_1_unalign:
    ld.b    $t0, $a1, -1
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

    addi.d  $a0, $a0, 0x80
    addi.d  $a1, $a1, 0x80
    addi.d  $a2, $a2, -0x80
    bge     $a2, $zero, loop_less

end_unalign_proc:
    addi.d  $a2, $a2, 0x80

    pcaddi  $t1, 36
    andi    $t2, $a2, 0x78
    add.d   $a1, $a1, $t2
    add.d   $a0, $a0, $t2
    sub.d   $t1, $t1, $t2
    jirl    $zero, $t1, 0

end_120_128_unalign:
    ld.d    $t0, $a1, -120
    st.d    $t0, $a0, -120
end_112_120_unalign:
    ld.d    $t0, $a1, -112
    st.d    $t0, $a0, -112
end_104_112_unalign:
    ld.d    $t0, $a1, -104
    st.d    $t0, $a0, -104
end_96_104_unalign:
    ld.d    $t0, $a1, -96
    st.d    $t0, $a0, -96
end_88_96_unalign:
    ld.d    $t0, $a1, -88
    st.d    $t0, $a0, -88
end_80_88_unalign:
    ld.d    $t0, $a1, -80
    st.d    $t0, $a0, -80
end_72_80_unalign:
    ld.d    $t0, $a1, -72
    st.d    $t0, $a0, -72
end_64_72_unalign:
    ld.d    $t0, $a1, -64
    st.d    $t0, $a0, -64
end_56_64_unalign:
    ld.d    $t0, $a1, -56
    st.d    $t0, $a0, -56
end_48_56_unalign:
    ld.d    $t0, $a1, -48
    st.d    $t0, $a0, -48
end_40_48_unalign:
    ld.d    $t0, $a1, -40
    st.d    $t0, $a0, -40
end_32_40_unalign:
    ld.d    $t0, $a1, -32
    st.d    $t0, $a0, -32
end_24_32_unalign:
    ld.d    $t0, $a1, -24
    st.d    $t0, $a0, -24
end_16_24_unalign:
    ld.d    $t0, $a1, -16
    st.d    $t0, $a0, -16
end_8_16_unalign:
    ld.d    $t0, $a1, -8
    st.d    $t0, $a0, -8
end_0_8_unalign:

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
    addi.d  $a1, $a1, 0x8
    addi.d  $a0, $a0, 0x8
    ld.d    $t0, $a1, -8
    st.d    $t0, $a0, -8
    addi.d  $a2, $a2, -8
    b       start_over

all_align_back:
    addi.d  $a4, $a4, -0x8
    addi.d  $a3, $a3, -0x8
    ld.d    $t0, $a4, 0
    st.d    $t0, $a3, 0
    addi.d  $a2, $a2, -8
    b       start_over_back

copy_backward:
    move    $a5, $a3
    srli.d  $a3, $a3, 3
    slli.d  $a3, $a3, 3
    beq     $a3, $a5, all_align_back
    sub.d   $a7, $a3, $a5
    add.d   $a4, $a4, $a7
    add.d   $a2, $a7, $a2

    pcaddi  $t1, 18
    slli.d  $a6, $a7, 3
    add.d   $t1, $t1, $a6
    jirl    $zero, $t1, 0

    ld.b    $t0, $a4, 6
    st.b    $t0, $a3, 6
    ld.b    $t0, $a4, 5
    st.b    $t0, $a3, 5
    ld.b    $t0, $a4, 4
    st.b    $t0, $a3, 4
    ld.b    $t0, $a4, 3
    st.b    $t0, $a3, 3
    ld.b    $t0, $a4, 2
    st.b    $t0, $a3, 2
    ld.b    $t0, $a4, 1
    st.b    $t0, $a3, 1
    ld.b    $t0, $a4, 0
    st.b    $t0, $a3, 0
start_over_back:

    addi.d  $a2, $a2, -0x80
    blt     $a2, $zero, end_unalign_proc_back

loop_less_back:
    ld.d    $t0, $a4, -64;
    ld.d    $t1, $a4, -64 +8;
    ld.d    $t2, $a4, -64 +16;
    ld.d    $t3, $a4, -64 +24;
    ld.d    $t4, $a4, -64 +32;
    ld.d    $t5, $a4, -64 +40;
    ld.d    $t6, $a4, -64 +48;
    ld.d    $t7, $a4, -64 +56;

    st.d    $t0, $a3, -64;
    st.d    $t1, $a3, -64 +8;
    st.d    $t2, $a3, -64 +16;
    st.d    $t3, $a3, -64 +24;
    st.d    $t4, $a3, -64 +32;
    st.d    $t5, $a3, -64 +40;
    st.d    $t6, $a3, -64 +48;
    st.d    $t7, $a3, -64 +56;

    ld.d    $t0, $a4, -128;
    ld.d    $t1, $a4, -128 +8;
    ld.d    $t2, $a4, -128 +16;
    ld.d    $t3, $a4, -128 +24;
    ld.d    $t4, $a4, -128 +32;
    ld.d    $t5, $a4, -128 +40;
    ld.d    $t6, $a4, -128 +48;
    ld.d    $t7, $a4, -128 +56;

    st.d    $t0, $a3, -128;
    st.d    $t1, $a3, -128 +8;
    st.d    $t2, $a3, -128 +16;
    st.d    $t3, $a3, -128 +24;
    st.d    $t4, $a3, -128 +32;
    st.d    $t5, $a3, -128 +40;
    st.d    $t6, $a3, -128 +48;
    st.d    $t7, $a3, -128 +56;

    addi.d $a4, $a4, -0x80
    addi.d $a3, $a3, -0x80
    addi.d $a2, $a2, -0x80
    bge    $a2, $zero, loop_less_back

end_unalign_proc_back:
    addi.d  $a2, $a2, 0x80

    pcaddi  $t1, 36
    andi    $t2, $a2, 0x78
    sub.d   $a4, $a4, $t2
    sub.d   $a3, $a3, $t2
    sub.d   $t1, $t1, $t2
    jirl    $zero, $t1, 0

    ld.d    $t0, $a4, 112
    st.d    $t0, $a3, 112
    ld.d    $t0, $a4, 104
    st.d    $t0, $a3, 104
    ld.d    $t0, $a4, 96
    st.d    $t0, $a3, 96
    ld.d    $t0, $a4, 88
    st.d    $t0, $a3, 88
    ld.d    $t0, $a4, 80
    st.d    $t0, $a3, 80
    ld.d    $t0, $a4, 72
    st.d    $t0, $a3, 72
    ld.d    $t0, $a4, 64
    st.d    $t0, $a3, 64
    ld.d    $t0, $a4, 56
    st.d    $t0, $a3, 56
    ld.d    $t0, $a4, 48
    st.d    $t0, $a3, 48
    ld.d    $t0, $a4, 40
    st.d    $t0, $a3, 40
    ld.d    $t0, $a4, 32
    st.d    $t0, $a3, 32
    ld.d    $t0, $a4, 24
    st.d    $t0, $a3, 24
    ld.d    $t0, $a4, 16
    st.d    $t0, $a3, 16
    ld.d    $t0, $a4, 8
    st.d    $t0, $a3, 8
    ld.d    $t0, $a4, 0
    st.d    $t0, $a3, 0

    andi    $a2, $a2, 0x7
    pcaddi  $t1, 18
    slli.d  $a2, $a2, 3
    sub.d   $t1, $t1, $a2
    jirl    $zero, $t1, 0

    ld.b    $t0, $a1, 6
    st.b    $t0, $a0, 6
    ld.b    $t0, $a1, 5
    st.b    $t0, $a0, 5
    ld.b    $t0, $a1, 4
    st.b    $t0, $a0, 4
    ld.b    $t0, $a1, 3
    st.b    $t0, $a0, 3
    ld.b    $t0, $a1, 2
    st.b    $t0, $a0, 2
    ld.b    $t0, $a1, 1
    st.b    $t0, $a0, 1
    ld.b    $t0, $a1, 0
    st.b    $t0, $a0, 0

    move    $v0, $t8
    jirl    $zero, $ra, 0

    .size   la64_memmove, . - la64_memmove
