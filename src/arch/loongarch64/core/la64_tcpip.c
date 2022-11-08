/*
 * Copyright (c) 2022, Loongson Technology Corporation Limited. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
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

/** @file
 *
 * TCP/IP checksum
 *
 */

#include <strings.h>
#include <ipxe/tcpip.h>

/**
 * Calculate continued TCP/IP checkum
 *
 * @v sum       Checksum of already-summed data, in network byte order
 * @v data      Data buffer
 * @v len       Length of data buffer
 * @ret sum     Updated checksum, in network byte order
 */
uint16_t tcpip_continue_chksum ( uint16_t sum, const void *data,
                 size_t len )
{
    unsigned int cksum = ( ( ~sum) & 0xffff );
    unsigned int value;
    unsigned int i;

    for ( i = 0 ; i < len ; i++ ) {
        value = * ( ( uint8_t * ) data + i );
        if ( i & 1 ) {
            /* Odd bytes: swap on little-endian systems */
            value = be16_to_cpu ( value );
        } else {
            /* Even bytes: swap on big-endian systems */
            value = le16_to_cpu ( value );
        }
        cksum += value;
        if ( cksum > 0xffff )
            cksum -= 0xffff;
    }

    return ( ~cksum );
}
