/******************************************************************************
 * arch-loongarch.h
 *
 * Guest OS interface to LoongArch.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#ifndef __XEN_PUBLIC_ARCH_LOONGARCH_H__
#define __XEN_PUBLIC_ARCH_LOONGARCH_H__

FILE_LICENCE ( MIT );

#define XEN_HYPERCALL_TAG   0XEA1

#define uint64_aligned_t uint64_t __attribute__((aligned(8)))

#ifndef __ASSEMBLY__
#define ___DEFINE_XEN_GUEST_HANDLE(name, type)                  \
    typedef union { type *p; unsigned long q; }                 \
        __guest_handle_ ## name;                                \
    typedef union { type *p; uint64_aligned_t q; }              \
        __guest_handle_64_ ## name;

#define __DEFINE_XEN_GUEST_HANDLE(name, type) \
    ___DEFINE_XEN_GUEST_HANDLE(name, type);   \
    ___DEFINE_XEN_GUEST_HANDLE(const_##name, const type)
#define DEFINE_XEN_GUEST_HANDLE(name)   __DEFINE_XEN_GUEST_HANDLE(name, name)
#define __XEN_GUEST_HANDLE(name)        __guest_handle_64_ ## name
#define XEN_GUEST_HANDLE(name)          __XEN_GUEST_HANDLE(name)
/* this is going to be changed on 64 bit */
#define XEN_GUEST_HANDLE_PARAM(name)    __guest_handle_ ## name
#define set_xen_guest_handle_raw(hnd, val)                  \
    do {                                                    \
        typeof(&(hnd)) _sxghr_tmp = &(hnd);                 \
        _sxghr_tmp->q = 0;                                  \
        _sxghr_tmp->p = val;                                \
    } while ( 0 )
#ifdef __XEN_TOOLS__
#define get_xen_guest_handle(val, hnd)  do { val = (hnd).p; } while (0)
#endif
#define set_xen_guest_handle(hnd, val) set_xen_guest_handle_raw(hnd, val)

#if defined(__loongarch64)
#define __DECL_REG(name) uint64_t name
#else
#define __DECL_REG(name) uint32_t name
#endif

struct cpu_user_regs
{
    __DECL_REG(r0);
    __DECL_REG(r1);
    __DECL_REG(r2);
    __DECL_REG(r3);
    __DECL_REG(r4);
    __DECL_REG(r5);
    __DECL_REG(r6);
    __DECL_REG(r7);
    __DECL_REG(r8);
    __DECL_REG(r9);
    __DECL_REG(r10);
    __DECL_REG(r11);
    __DECL_REG(r12);
    __DECL_REG(r13);
    __DECL_REG(r14);
    __DECL_REG(r15);
    __DECL_REG(r16);
    __DECL_REG(r17);
    __DECL_REG(r18);
    __DECL_REG(r19);
    __DECL_REG(r20);
    __DECL_REG(r21);
    __DECL_REG(r22);
    __DECL_REG(r23);
    __DECL_REG(r24);
    __DECL_REG(r25);
    __DECL_REG(r26);
    __DECL_REG(r27);
    __DECL_REG(r28);
    __DECL_REG(r29);
    __DECL_REG(r30);
    __DECL_REG(r31);
};
typedef struct cpu_user_regs cpu_user_regs_t;
DEFINE_XEN_GUEST_HANDLE(cpu_user_regs_t);

#undef __DECL_REG

typedef uint64_t xen_pfn_t;
#define PRI_xen_pfn PRIx64

/* Maximum number of virtual CPUs in legacy multi-processor guests. */
/* Only one. All other VCPUS must use VCPUOP_register_vcpu_info */
#define XEN_LEGACY_MAX_VCPUS 1

typedef uint64_t xen_ulong_t;
#define PRI_xen_ulong PRIx64

#if defined(__XEN__) || defined(__XEN_TOOLS__)
struct vcpu_guest_context {
#define _VGCF_online                   0
#define VGCF_online                    (1<<_VGCF_online)
    uint32_t flags;                    /* VGCF_* flags                 */
    struct cpu_user_regs user_regs;    /* User-level CPU registers     */
};
typedef struct vcpu_guest_context vcpu_guest_context_t;
DEFINE_XEN_GUEST_HANDLE(vcpu_guest_context_t);
#endif

struct arch_vcpu_info {
};
typedef struct arch_vcpu_info arch_vcpu_info_t;

struct arch_shared_info {
};
typedef struct arch_shared_info arch_shared_info_t;
typedef uint64_t xen_callback_t;

#endif

#endif /*  __XEN_PUBLIC_ARCH_LOONGARCH_H__ */

/*
 * Local variables:
 * mode: C
 * c-file-style: "BSD"
 * c-basic-offset: 4
 * tab-width: 4
 * indent-tabs-mode: nil
 * End:
 */
