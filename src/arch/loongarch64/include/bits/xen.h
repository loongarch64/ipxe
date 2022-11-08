#ifndef _BITS_XEN_H
#define _BITS_XEN_H

/** @file
 *
 * Xen interface
 *
 */

FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );

/* Hypercall registers */
#define XEN_HC   "a7"
#define XEN_REG1 "a0"
#define XEN_REG2 "a1"
#define XEN_REG3 "a2"
#define XEN_REG4 "a3"
#define XEN_REG5 "a4"

/**
 * Issue hypercall with one argument
 *
 * @v xen		Xen hypervisor
 * @v hypercall		Hypercall number
 * @v arg1		First argument
 * @ret retval		Return value
 */
static inline __attribute__ (( always_inline )) unsigned long
xen_hypercall_1 ( struct xen_hypervisor *xen __unused, unsigned int hypercall,
		  unsigned long arg1 ) {
	register unsigned long hc asm ( XEN_HC ) = hypercall;
	register unsigned long r asm("a0");
	register unsigned long reg1 asm ( XEN_REG1 ) = arg1;

	__asm__ __volatile__ ( ".word 0x002b8000"
			       : "=r" ( r )
			       : "r" ( hc ), "r" (reg1)
			       : "memory" );
	return r;
}

/**
 * Issue hypercall with two arguments
 *
 * @v xen		Xen hypervisor
 * @v hypercall		Hypercall number
 * @v arg1		First argument
 * @v arg2		Second argument
 * @ret retval		Return value
 */
static inline __attribute__ (( always_inline )) unsigned long
xen_hypercall_2 ( struct xen_hypervisor *xen __unused, unsigned int hypercall,
		  unsigned long arg1, unsigned long arg2 ) {
	register unsigned long hc asm ( XEN_HC ) = hypercall;
	register unsigned long r asm("a0");
	register unsigned long reg1 asm ( XEN_REG1 ) = arg1;
	register unsigned long reg2 asm ( XEN_REG2 ) = arg2;

	__asm__ __volatile__ ( ".word 0x002b8000"
			       : "=r" ( r )
			       : "r" ( hc ), "r" (reg1), "r" (reg2)
			       : "memory");
	return r;
}

/**
 * Issue hypercall with three arguments
 *
 * @v xen		Xen hypervisor
 * @v hypercall		Hypercall number
 * @v arg1		First argument
 * @v arg2		Second argument
 * @v arg3		Third argument
 * @ret retval		Return value
 */
static inline __attribute__ (( always_inline )) unsigned long
xen_hypercall_3 ( struct xen_hypervisor *xen __unused, unsigned int hypercall,
		  unsigned long arg1, unsigned long arg2, unsigned long arg3 ) {
	register unsigned long hc asm ( XEN_HC ) = hypercall;
	register unsigned long r asm("a0");
	register unsigned long reg1 asm ( XEN_REG1 ) = arg1;
	register unsigned long reg2 asm ( XEN_REG2 ) = arg2;
	register unsigned long reg3 asm ( XEN_REG3 ) = arg3;

	__asm__ __volatile__ ( ".word 0x002b8000"
			       : "=r" ( r )
			       : "r" ( hc ), "r" (reg1), "r" (reg2), "r" (reg3)
			       : "memory");
	return r;
}

/**
 * Issue hypercall with four arguments
 *
 * @v xen		Xen hypervisor
 * @v hypercall		Hypercall number
 * @v arg1		First argument
 * @v arg2		Second argument
 * @v arg3		Third argument
 * @v arg4		Fourth argument
 * @ret retval		Return value
 */
static inline __attribute__ (( always_inline )) unsigned long
xen_hypercall_4 ( struct xen_hypervisor *xen __unused, unsigned int hypercall,
		  unsigned long arg1, unsigned long arg2, unsigned long arg3,
		  unsigned long arg4 ) {
	register unsigned long hc asm ( XEN_HC ) = hypercall;
	register unsigned long r asm("a0");
	register unsigned long reg1 asm ( XEN_REG1 ) = arg1;
	register unsigned long reg2 asm ( XEN_REG2 ) = arg2;
	register unsigned long reg3 asm ( XEN_REG3 ) = arg3;
	register unsigned long reg4 asm ( XEN_REG4 ) = arg4;

	__asm__ __volatile__ ( ".word 0x002b8000"
			       : "=r" ( r )
			       : "r" ( hc ), "r" (reg1), "r" (reg2), "r" (reg3), "r" (reg4)
			       : "memory");
	return r;
}

/**
 * Issue hypercall with five arguments
 *
 * @v xen		Xen hypervisor
 * @v hypercall		Hypercall number
 * @v arg1		First argument
 * @v arg2		Second argument
 * @v arg3		Third argument
 * @v arg4		Fourth argument
 * @v arg5		Fifth argument
 * @ret retval		Return value
 */
static inline __attribute__ (( always_inline )) unsigned long
xen_hypercall_5 ( struct xen_hypervisor *xen __unused, unsigned int hypercall,
		  unsigned long arg1, unsigned long arg2, unsigned long arg3,
		  unsigned long arg4, unsigned long arg5 ) {
	register unsigned long hc asm ( XEN_HC ) = hypercall;
	register unsigned long r asm("a0");
	register unsigned long reg1 asm ( XEN_REG1 ) = arg1;
	register unsigned long reg2 asm ( XEN_REG2 ) = arg2;
	register unsigned long reg3 asm ( XEN_REG3 ) = arg3;
	register unsigned long reg4 asm ( XEN_REG4 ) = arg4;
	register unsigned long reg5 asm ( XEN_REG5 ) = arg5;

	__asm__ __volatile__ ( ".word 0x002b8000"
			       : "=r" ( r )
			       : "r" ( hc ), "r" (reg1), "r" (reg2), "r" (reg3), "r" (reg4), "r" (reg5)
			       : "memory");
	return r;
}

#endif /* _BITS_XEN_H */
