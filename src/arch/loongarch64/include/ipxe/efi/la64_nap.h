#ifndef _IPXE_EFILOONGARCH_NAP_H
#define _IPXE_EFILOONGARCH_NAP_H

/** @file
 *
 * EFI CPU sleeping
 *
 */

FILE_LICENCE ( GPL2_OR_LATER_OR_UBDL );

#ifdef NAP_EFILOONGARCH64
#define NAP_PREFIX_la64
#else
#define NAP_PREFIX_la64 __la64_
#endif

#endif /* _IPXE_EFILOONGARCH_NAP_H */
