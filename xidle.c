#include <stdio.h>
#include <X11/extensions/scrnsaver.h>
#include <test.h>

int main() 
{
  //printf("Here ");
  XScreenSaverInfo *info = XScreenSaverAllocInfo();
  //printf("Here ");
  Display *display = XOpenDisplay("acer/unix:0");
  if (display == NULL)
  {
    fprintf((void*)2, "Could not open display :0!");
    return 1;
  }

  //printf("Here...");
 
  XScreenSaverQueryInfo(display, DefaultRootWindow(display), info);
  printf("%u\n", (unsigned int) (info->idle / 1000));
  
  XCloseDisplay(display);
  
  return 0;
}
