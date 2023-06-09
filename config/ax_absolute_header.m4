# ===========================================================================
#       http://www.nongnu.org/autoconf-archive/ax_absolute_header.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_ABSOLUTE_HEADER(HEADER1 HEADER2 ...)
#
# DESCRIPTION
#
#   Find the absolute name of a header file, assuming the header exists. If
#   the header were sys/inttypes.h, this macro would define
#   ABSOLUTE_SYS_INTTYPES_H to the `""' quoted absolute name of
#   sys/inttypes.h in config.h (e.g. `#define ABSOLUTE_SYS_INTTYPES_H
#   "///usr/include/sys/inttypes.h"'). The three "///" are to pacify Sun C
#   5.8, which otherwise would say "warning: #include of /usr/include/...
#   may be non-portable". Use `""', not `<>', so that the /// cannot be
#   confused with a C99 comment.
#
# LICENSE
#
#   Copyright (c) 2009 Derek Price
#   Copyright (c) 2009 Rhys Ulerich <rhys.ulerich@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

dnl Copyright (C) 2006, 2007 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Derek Price.
dnl Modified by Rhys Ulerich to use AC_CHECK_HEADERS instead of _ONCE

AC_DEFUN([AX_ABSOLUTE_HEADER],
[AC_LANG_PREPROC_REQUIRE()dnl
m4_foreach_w([gl_HEADER_NAME],[$1],[AS_VAR_PUSHDEF([gl_absolute_header],
                  [gl_cv_absolute_]m4_quote(m4_defn([gl_HEADER_NAME])))dnl
  AC_CACHE_CHECK([absolute name of <]m4_quote(m4_defn([gl_HEADER_NAME]))[>],
    m4_quote(m4_defn([gl_absolute_header])),
    [AS_VAR_PUSHDEF([ac_header_exists],
                    [ac_cv_header_]m4_quote(m4_defn([gl_HEADER_NAME])))dnl
    AC_CHECK_HEADERS(m4_quote(m4_defn([gl_HEADER_NAME])))dnl
    if test AS_VAR_GET(ac_header_exists) = yes; then
      AC_LANG_CONFTEST([AC_LANG_SOURCE([[#include <]]m4_dquote(m4_defn([gl_HEADER_NAME]))[[>]])])
dnl eval is necessary to expand ac_cpp.
dnl Ultrix and Pyramid sh refuse to redirect output of eval, so use subshell.
      AS_VAR_SET(gl_absolute_header,
[`(eval "$ac_cpp conftest.$ac_ext") 2>&AS_MESSAGE_LOG_FD |
sed -n '\#/]m4_quote(m4_defn([gl_HEADER_NAME]))[#{
        s#.*"\(.*/]m4_quote(m4_defn([gl_HEADER_NAME]))[\)".*#\1#
        s#^/[^/]#//&#
        p
        q
}'`])
    fi
    AS_VAR_POPDEF([ac_header_exists])dnl
    ])dnl
  AC_DEFINE_UNQUOTED(AS_TR_CPP([ABSOLUTE_]m4_quote(m4_defn([gl_HEADER_NAME]))),
                     ["AS_VAR_GET(gl_absolute_header)"],
                     [Define this to an absolute name of <]m4_quote(m4_defn([gl_HEADER_NAME]))[>.])
  AS_VAR_POPDEF([gl_absolute_header])dnl
])dnl
])# AX_ABSOLUTE_HEADER
