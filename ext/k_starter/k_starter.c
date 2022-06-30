#include "k_starter.h"

VALUE rb_mKStarter;

void
Init_k_starter(void)
{
  rb_mKStarter = rb_define_module("KStarter");
}
