#ifndef BITS_STRING_H
#define BITS_STRING_H

FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );

/** @file
 *
 * String functions
 *
 */

extern void la64_memset ( void *dest, int c, size_t len);
extern void* la64_memcpy ( void *dest, const void *src, size_t len );
extern void la64_memmove ( void *dest, const void *src, size_t len );

/**
 * Fill memory region
 *
 * @v dest		Destination region
 * @v character		Fill character
 * @v len		Length
 * @ret dest		Destination region
 */
static inline __attribute__ (( always_inline )) void *
memset ( void *dest, int character, size_t len ) {

	/* Allow gcc to generate inline "stX xzr" instructions for
	 * small, constant lengths.
	 */
	if ( __builtin_constant_p ( character ) && ( character == 0 ) &&
	     __builtin_constant_p ( len ) && ( len <= 64 ) ) {
		__builtin_memset ( dest, 0x0, len );
		return dest;
	}

	/* Not necessarily zeroing: use basic variable-length code */
	la64_memset ( dest, character, len);
	return dest;
}

/**
 * Copy memory region
 *
 * @v dest		Destination region
 * @v src		Source region
 * @v len		Length
 * @ret dest		Destination region
 */
static inline __attribute__ (( always_inline )) void *
memcpy ( void *dest, const void *src, size_t len ) {

	/* Allow gcc to generate inline "ldX"/"stX" instructions for
	 * small, constant lengths.
	 */
	if ( __builtin_constant_p ( len ) && ( len <= 64 ) ) {
		__builtin_memcpy ( dest, src, len );
		return dest;
	}

	/* Otherwise, use variable-length code */
	la64_memcpy ( dest, src, len );
	return dest;
}

/**
 * Copy (possibly overlapping) memory region
 *
 * @v dest		Destination region
 * @v src		Source region
 * @v len		Length
 * @ret dest		Destination region
 */
static inline __attribute__ (( always_inline )) void *
memmove ( void *dest, const void *src, size_t len ) {
	/* Otherwise, use ambidirectional copy */
	la64_memmove ( dest, src, len );
	return dest;
}

#endif /* BITS_STRING_H */
