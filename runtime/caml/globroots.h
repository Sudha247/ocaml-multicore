/**************************************************************************/
/*                                                                        */
/*                                 OCaml                                  */
/*                                                                        */
/*            Xavier Leroy, projet Cristal, INRIA Rocquencourt            */
/*                                                                        */
/*   Copyright 2001 Institut National de Recherche en Informatique et     */
/*     en Automatique.                                                    */
/*                                                                        */
/*   All rights reserved.  This file is distributed under the terms of    */
/*   the GNU Lesser General Public License version 2.1, with the          */
/*   special exception on linking described in the file LICENSE.          */
/*                                                                        */
/**************************************************************************/

/* Registration of global memory roots */

#ifndef CAML_GLOBROOTS_H
#define CAML_GLOBROOTS_H

#ifdef CAML_INTERNALS

#include "mlvalues.h"
#include "roots.h"
#include "skiplist.h"

typedef struct domain_roots
{
  struct skiplist caml_global_roots;
  struct skiplist caml_global_roots_young;
  struct skiplist caml_global_roots_old;
} domain_roots;

void caml_scan_global_young_roots(scanning_action f, void* fdata);
void caml_split_global_roots(struct domain* curr_domain);
void caml_scan_global_roots(scanning_action f, void* fdata, struct domain* d); 


#ifdef NATIVE_CODE
void caml_register_dyn_global(void *v);
#endif

#endif /* CAML_INTERNALS */

#endif /* CAML_GLOBROOTS_H */