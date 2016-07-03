#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void lowercase(char *p) {
  for ( ; *p; ++p) *p = tolower(*p);
}

int compare(const char *a, const char *b)
{
  if (*a < *b) {
    return -1;
  } else if (*a > *b) {
    return 1;
  } else {
    return 0;
  }
}

int main(int argc, char *argv[])
{
  char a = 'a';
  char b = 'b';
  char c = 'c';

  printf("a is less than b: %d\n", compare(&a, &b));
  printf("b is equal to b: %d\n", compare(&b, &b));
  printf("c is greater than b: %d\n", compare(&c, &b));

  printf("--------\n");

  char before = 'A';
  printf("Before: %c\n", before);
  lowercase(&before);
  printf("After: %c\n", before);
}
