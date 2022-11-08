/*
   void *memset(void *s, int c, size_t n);
*/

    .text
    .p2align 3
    .globl  la64_memset
    .type   la64_memset, @function
la64_memset:
    bstrins.d $a1,   $a1, 15, 8
    add.d     $t7,   $a0, $a2
    bstrins.d $a1,   $a1, 31, 16
    move      $t0,   $a0
    bstrins.d $a1,   $a1, 63, 32
    srai.d    $t8,   $a2, 4           #num/16
    beqz      $t8,   less_16bytes     #num<16
    srai.d    $t8,   $a2, 6           #num/64
    bnez      $t8,   more_64bytes     #num>64
    srai.d    $t8,   $a2, 5           #num/32
    beqz      $t8,   less_32bytes     #num<32
    st.d      $a1,   $a0, 0           #32<num<64
    st.d      $a1,   $a0, 8
    st.d      $a1,   $a0, 16
    st.d      $a1,   $a0, 24
    st.d      $a1,   $t7, -32
    st.d      $a1,   $t7, -24
    st.d      $a1,   $t7, -16
    st.d      $a1,   $t7, -8
    jirl      $zero, $ra, 0

less_32bytes:
    st.d    $a1, $a0, 0
    st.d    $a1, $a0, 8
    st.d    $a1, $t7, -16
    st.d    $a1, $t7, -8

    jirl    $zero, $ra, 0

less_16bytes:
    srai.d  $t8, $a2, 3             #num/8
    beqz    $t8, less_8bytes
    st.d    $a1, $a0, 0
    st.d    $a1, $t7, -8
    jirl    $zero, $ra, 0

less_8bytes:
    srai.d  $t8, $a2, 2
    beqz    $t8, less_4bytes
    st.w    $a1, $a0, 0
    st.w    $a1, $t7, -4

    jirl    $zero, $ra, 0

less_4bytes:
    srai.d  $t8, $a2, 1
    beqz    $t8, less_2bytes
    st.h    $a1, $a0, 0
    st.h    $a1, $t7, -2

    jirl    $zero, $ra, 0

less_2bytes:
    beqz    $a2, less_1bytes
    st.b    $a1, $a0, 0

    jirl    $zero, $ra, 0

less_1bytes:
    jirl    $zero, $ra, 0

more_64bytes:
    srli.d  $a0, $a0, 3
    slli.d  $a0, $a0, 3
    addi.d  $a0, $a0, 0x8
    st.d    $a1, $t0, 0
    sub.d   $t2, $t0, $a0
    add.d   $a2, $t2, $a2

    addi.d  $a2, $a2, -0x80
    blt     $a2, $zero, end_unalign_proc

loop_less:
    st.d    $a1, $a0, 0
    st.d    $a1, $a0, 0x8
    st.d    $a1, $a0, 0x10
    st.d    $a1, $a0, 0x18
    st.d    $a1, $a0, 0x20
    st.d    $a1, $a0, 0x28
    st.d    $a1, $a0, 0x30
    st.d    $a1, $a0, 0x38
    st.d    $a1, $a0, 0x40
    st.d    $a1, $a0, 0x48
    st.d    $a1, $a0, 0x50
    st.d    $a1, $a0, 0x58
    st.d    $a1, $a0, 0x60
    st.d    $a1, $a0, 0x68
    st.d    $a1, $a0, 0x70
    st.d    $a1, $a0, 0x78
    addi.d  $a0, $a0, 0x80
    addi.d  $a2, $a2, -0x80
    bge     $a2, $zero, loop_less

end_unalign_proc:
    addi.d  $a2, $a2, 0x80

    pcaddi  $t1, 20
    andi    $t5, $a2, 0x78
    srli.d  $t5, $t5, 1
    sub.d   $t1, $t1, $t5

    jirl    $zero, $t1, 0

end_120_128_unalign:
    st.d    $a1, $a0, 112
end_112_120_unalign:
    st.d    $a1, $a0, 104
end_104_112_unalign:
    st.d    $a1, $a0, 96
end_96_104_unalign:
    st.d    $a1, $a0, 88
end_88_96_unalign:
    st.d    $a1, $a0, 80
end_80_88_unalign:
    st.d    $a1, $a0, 72
end_72_80_unalign:
    st.d    $a1, $a0, 64
end_64_72_unalign:
    st.d    $a1, $a0, 56
end_56_64_unalign:
    st.d    $a1, $a0, 48
end_48_56_unalign:
    st.d    $a1, $a0, 40
end_40_48_unalign:
    st.d    $a1, $a0, 32
end_32_40_unalign:
    st.d    $a1, $a0, 24
end_24_32_unalign:
    st.d    $a1, $a0, 16
end_16_24_unalign:
    st.d    $a1, $a0, 8
end_8_16_unalign:
    st.d    $a1, $a0, 0
end_0_8_unalign:

    st.d    $a1, $t7, -8

    move    $v0, $t0
    jirl    $zero, $ra, 0

    .size   la64_memset, . - la64_memset
