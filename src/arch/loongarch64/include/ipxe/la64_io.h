#ifndef _IPXE_LOONGARCH_IO_H
#define _IPXE_LOONGARCH_IO_H

/** @file
 *
 * iPXE I/O API for LOONGARCH
 *
 */

FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );

#ifdef IOAPI_LOONGARCH64
#define IOAPI_PREFIX_loongarch64
#else
#define IOAPI_PREFIX_loongarch64 __loongarch64_
#endif

/*
 * Memory space mappings
 *
 */

/** Page shift */
#define PAGE_SHIFT 12

/*
 * Physical<->Bus address mappings
 *
 */

static inline __always_inline unsigned long
IOAPI_INLINE ( loongarch64, phys_to_bus ) ( unsigned long phys_addr ) {
	return phys_addr;
}

static inline __always_inline unsigned long
IOAPI_INLINE ( loongarch64, bus_to_phys ) ( unsigned long bus_addr ) {
	return bus_addr;
}

/*
 * MMIO reads and writes up to native word size
 *
 */

#define LOONGARCH_READX( _suffix, _type, _insn_suffix )		      \
static inline __always_inline _type					      \
IOAPI_INLINE ( loongarch64, read ## _suffix ) ( volatile _type *io_addr ) {	      \
	_type data;							      \
	__asm__ __volatile__ ( "ld." _insn_suffix " %0, %1"    \
			       : "=r" ( data ) : "m" ( *io_addr ) );	      \
	return data;							      \
}
LOONGARCH_READX ( b, uint8_t, "bu");
LOONGARCH_READX ( w, uint16_t, "hu");
LOONGARCH_READX ( l, uint32_t, "wu");
LOONGARCH_READX ( q, uint64_t, "d");

#define LOONGARCH_WRITEX( _suffix, _type, _insn_suffix )		      \
static inline __always_inline void					      \
IOAPI_INLINE ( loongarch64, write ## _suffix ) ( _type data,			      \
					 volatile _type *io_addr ) {	      \
	__asm__ __volatile__ ( "st." _insn_suffix " %0, %1"    \
			       : : "r" ( data ), "m" ( *io_addr ) );	      \
}
LOONGARCH_WRITEX ( b, uint8_t, "b");
LOONGARCH_WRITEX ( w, uint16_t, "h");
LOONGARCH_WRITEX ( l, uint32_t, "w" );
LOONGARCH_WRITEX ( q, uint64_t, "d");

/*
 * Dummy PIO reads and writes up to 32 bits
 *
 * There is no common standard for I/O-space access for LOONGARCH, and
 * non-MMIO peripherals are vanishingly rare.  Provide dummy
 * implementations that will allow code to link and should cause
 * drivers to simply fail to detect hardware at runtime.
 *
 */

#define LOONGARCH_INX( _suffix, _type )					      \
static inline __always_inline _type					      \
IOAPI_INLINE ( loongarch64, in ## _suffix ) ( volatile _type *io_addr __unused) {     \
	return ~( (_type) 0 );						      \
}									      \
static inline __always_inline void					      \
IOAPI_INLINE ( loongarch64, ins ## _suffix ) ( volatile _type *io_addr __unused,      \
				       _type *data, unsigned int count ) {    \
	memset ( data, 0xff, count * sizeof ( *data ) );		      \
}
LOONGARCH_INX ( b, uint8_t );
LOONGARCH_INX ( w, uint16_t );
LOONGARCH_INX ( l, uint32_t );

#define LOONGARCH_OUTX( _suffix, _type )					      \
static inline __always_inline void					      \
IOAPI_INLINE ( loongarch64, out ## _suffix ) ( _type data __unused,		      \
				       volatile _type *io_addr __unused ) {   \
	/* Do nothing */						      \
}									      \
static inline __always_inline void					      \
IOAPI_INLINE ( loongarch64, outs ## _suffix ) ( volatile _type *io_addr __unused,     \
					const _type *data __unused,	      \
					unsigned int count __unused ) {	      \
	/* Do nothing */						      \
}
LOONGARCH_OUTX ( b, uint8_t );
LOONGARCH_OUTX ( w, uint16_t );
LOONGARCH_OUTX ( l, uint32_t );

/*
 * Slow down I/O
 *
 */
static inline __always_inline void
IOAPI_INLINE ( loongarch64, iodelay ) ( void ) {
	/* Nothing to do */
}

/*
 * Memory barrier
 *
 */
static inline __always_inline void
IOAPI_INLINE ( loongarch64, mb ) ( void ) {

__asm__ __volatile__ ( "dbar 0" );
}

#endif /* _IPXE_LOONGARCH_IO_H */
