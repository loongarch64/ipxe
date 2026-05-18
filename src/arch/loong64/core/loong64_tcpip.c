/*
 * Copyright (c) 2026, Xiaotian Wu <wuxiaotian@loongson.cn>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301, USA.
 *
 * You can also choose to distribute this program under the terms of
 * the Unmodified Binary Distribution Licence (as given in the file
 * COPYING.UBDL), provided that you have satisfied its requirements.
 */

FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );
FILE_SECBOOT ( PERMITTED );

/** @file
 *
 * TCP/IP checksum
 *
 */

#include <strings.h>
#include <ipxe/tcpip.h>

/**
 * Calculate continued TCP/IP checksum
 *
 * @v partial		Checksum of already-summed data, in network byte order
 * @v data		Data buffer
 * @v len		Length of data buffer
 * @ret cksum		Updated checksum, in network byte order
 */
uint16_t tcpip_continue_chksum ( uint16_t partial, const void *data,
				 size_t len ) {
	const uint8_t *src = data;
	uint64_t cksum = ( ( ~partial ) & 0xffff );
	size_t i = 0;

	/*
	 * Optimization 1: 16-bit Fast Path (Branchless)
	 * Since i starts at 0 and increments by 2, (i & 1) is unconditionally 0
	 * inside this loop. We can safely eliminate the odd-index 'if' check entirely.
	 * LoongArch64 hardware efficiently accelerates these unaligned 16-bit reads.
	 */
	while ( ( len - i ) >= 2 ) {
		/* Fetch 16-bit little-endian word directly */
		uint64_t word = *( ( const uint16_t * )( src + i ) );
		cksum += word;
		i += 2;
	}

	/* Handle the remaining fragmented single trailing byte if any */
	while ( i < len ) {
		uint64_t value = *( src + i );
		if ( i & 1 ) {
			__asm__ __volatile__ (
				"slli.d  %0, %0, 8 \n\t"
				: "+r"(value)
			);
		}
		cksum += value;
		i++;
	}

	/*
	 * Optimization 2: Zero-overhead bit extraction fold loop
	 * Fully decouples 64-bit carry chains via LoongArch hardware bstrpick.d
	 */
	uint64_t high;
	while ( 1 ) {
		__asm__ __volatile__ (
			"bstrpick.d %0, %1, 63, 16 \n\t"
			: "=r"(high) : "r"(cksum)
		);
		if ( !high )
			break;

		__asm__ __volatile__ (
			"bstrpick.d %0, %0, 15, 0 \n\t"
			: "+r"(cksum)
		);
		cksum += high;
	}

	return ( uint16_t )( ~cksum );
}
