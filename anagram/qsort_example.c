#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// SCORES
int scores[] = {543, 323, 32, 554, 11, 3, 112};

// Comparitor function to return scores in ascencing order
int compare_scores(const void* ptr_a, const void* ptr_b)
{
  // Cast the void pointer to an integer pointer
  int int_a = *(int*)ptr_a;
  int int_b = *(int*)ptr_b;

  // Return a positive, negative, or zero value
  return int_a - int_b;
}

// Comparitor function to return scores in descending order
int compare_scores_desc(const void* ptr_a, const void* ptr_b)
{
  // Cast pointers as integer pointers
  int a = *(int*)ptr_a;
  int b = *(int*)ptr_b;

  return b - a;
}

// AREAS
typedef struct {
  int height;
  int width;
} Rectangle;

int Rectangle_area(Rectangle *rect)
{
  return rect->height * rect->width;
}

// Comparitor function to return rectangle areas in ascencing order
int compare_areas(const void* a, const void* b)
{
  Rectangle rect_a = *(Rectangle*)a;
  Rectangle rect_b = *(Rectangle*)b;

  int area_a = Rectangle_area(&rect_a);
  int area_b = Rectangle_area(&rect_b);

  return area_a - area_b;
}

// Comparitor function to return rectangle areas in descending order
int compare_areas_desc(const void* a, const void* b)
{
  Rectangle rect_a = *(Rectangle*)a;
  Rectangle rect_b = *(Rectangle*)b;

  int area_a = Rectangle_area(&rect_a);
  int area_b = Rectangle_area(&rect_b);

  return area_b - area_a;
}


// NAMES
char *names[5] = {"Pat", "Dan", "Julie", "Mom", "Dad"};

int compare_names(const void* a, const void* b)
{

  // NOTE
  // A string is a pointer to a char. So the
  // pointer we're given are pointers to pointers.
  char **sa = (char**)a;
  char **sb = (char**)b;

  // printf("String a: %p (%s)\n", a, *sa);
  // printf("String b: %p (%s)\n", b, *sb);

  return strcmp(*sa, *sb);
}


int main()
{
  // No Sort
  printf("Before sorting: \n");
  for (size_t i = 0; i < 7; i++) {
    printf("%d ", scores[i]);
  }
  printf("\n");

  // Sort ASC
  qsort(scores, 7, sizeof(int), compare_scores);
  printf("After sorting: \n");
  for (size_t i = 0; i < 7; i++) {
    printf("%d ", scores[i]);
  }
  printf("\n");

  // Sort DESC
  qsort(scores, 7, sizeof(int), compare_scores_desc);
  printf("After sorting [DESC]: \n");
  for (size_t i = 0; i < 7; i++) {
    printf("%d ", scores[i]);
  }
  printf("\n");


  // RECTANGLES
  Rectangle rect_a = { .height = 10, .width = 20 };
  Rectangle rect_b = { .height = 12, .width = 16 };
  Rectangle rect_c = { .height = 8,  .width = 3  };
  Rectangle rect_d = { .height = 5,  .width = 9  };

  Rectangle rects[4] = { rect_a, rect_b, rect_c, rect_d };

  printf("The size of a rect is %lu\n", sizeof(Rectangle));
  printf("The size of the rects array is %lu\n", sizeof(rects));

  printf("Before sorting the rectangles:\n");
  for (size_t i = 0; i < 4; i++) {
    int area = Rectangle_area(&rects[i]);
    printf(" %d", area);
  }
  printf("\n");

  qsort(
    rects,
    sizeof(rects) / sizeof(Rectangle),
    sizeof(Rectangle),
    compare_areas);

  printf("After sorting the rectangles [ASC]:\n");
  for (size_t i = 0; i < 4; i++) {
    int area = Rectangle_area(&rects[i]);
    printf(" %d", area);
  }
  printf("\n");

  qsort(
    rects,
    sizeof(rects) / sizeof(Rectangle),
    sizeof(Rectangle),
    compare_areas_desc);

  printf("After sorting the rectangles [DESC]:\n");
  for (size_t i = 0; i < 4; i++) {
    int area = Rectangle_area(&rects[i]);
    printf(" %d", area);
  }
  printf("\n");

  printf("\n\n ------------ \n\n");

  size_t count = sizeof(names) / sizeof(*names);

  printf("Before sorting the names:\n");
  for (size_t i = 0; i < count; i++) {
    printf(" %s", names[i]);
  }
  printf("\n");

  qsort(
    names,
    count,
    sizeof(*names),
    compare_names);

  printf("After sorting the names:\n");
  for (size_t i = 0; i < count; i++) {
    printf(" %s", names[i]);
  }
  printf("\n");

  return 0;
}
