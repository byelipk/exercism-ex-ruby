#include <stdio.h>
#include <stdlib.h>

int compare(const char *a, const char *b)
{
  printf("%p\n", a);
  printf("%p\n", b);

  return *a < *b;
}

int main(int argc, char *argv[])
{
  char a = 'a';
  char b = 'b';

  printf("a is less than b: %d\n", compare(&a, &b));
}
