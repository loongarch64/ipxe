/*
 * Copyright (C) 2016 Michael Brown <mbrown@fensystems.co.uk>.
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

#include <ipxe/io.h>
#include <ipxe/la64_io.h>

/** @file
 *
 * iPXE I/O API for LOONGARCH
 *
 */
PROVIDE_IOAPI_INLINE ( loongarch64, phys_to_bus );
PROVIDE_IOAPI_INLINE ( loongarch64, bus_to_phys );
PROVIDE_IOAPI_INLINE ( loongarch64, readb );
PROVIDE_IOAPI_INLINE ( loongarch64, readw );
PROVIDE_IOAPI_INLINE ( loongarch64, readl );
PROVIDE_IOAPI_INLINE ( loongarch64, readq );
PROVIDE_IOAPI_INLINE ( loongarch64, writeb );
PROVIDE_IOAPI_INLINE ( loongarch64, writew );
PROVIDE_IOAPI_INLINE ( loongarch64, writel );
PROVIDE_IOAPI_INLINE ( loongarch64, writeq );
PROVIDE_IOAPI_INLINE ( loongarch64, inb );
PROVIDE_IOAPI_INLINE ( loongarch64, inw );
PROVIDE_IOAPI_INLINE ( loongarch64, inl );
PROVIDE_IOAPI_INLINE ( loongarch64, outb );
PROVIDE_IOAPI_INLINE ( loongarch64, outw );
PROVIDE_IOAPI_INLINE ( loongarch64, outl );
PROVIDE_IOAPI_INLINE ( loongarch64, iodelay );
PROVIDE_IOAPI_INLINE ( loongarch64, mb );
