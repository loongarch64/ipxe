# Assembler section type character
#
ASM_TCHAR	:= @
ASM_TCHAR_OPS	:= @

# LoongArch64-specific flags
#
CFLAGS		+= -fstrength-reduce -fomit-frame-pointer
CFLAGS		+= -falign-jumps=1 -falign-loops=1 -falign-functions=1
CFLAGS		+= -fno-strict-aliasing

# check whether _mno_explicit_relocs works
ifeq ($(CCTYPE),gcc)
RELOC_TEST = $(CC) -mno-explicit-relocs -x c -c /dev/null -o /dev/null >/dev/null 2>&1
RELOC_FLAGS := $(shell $(RELOC_TEST) && $(ECHO) '-mno-explicit-relocs')
WORKAROUND_CFLAGS += $(RELOC_FLAGS)
endif

# Debug
NO_WERROR = 1

# EFI requires -fshort-wchar, and nothing else currently uses wchar_t
CFLAGS		+= -fshort-wchar

# breaks building some of the linux-related objects
CFLAGS		+= -Ulinux

# disable valgrind
CFLAGS		+= -DNVALGRIND

# loongArch64-specific directories containing source files
SRCDIRS		+= arch/loongarch64/core

# Include platform-specific Makefile
MAKEDEPS	+= arch/loongarch64/Makefile.$(PLATFORM)
include arch/loongarch64/Makefile.$(PLATFORM)
