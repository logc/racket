
/* Set options for the Cocoa file dialog */

#import <Cocoa/Cocoa.h>
#include <Carbon/Carbon.h>

void wx_set_nav_file_types(NavDialogRef dlg, int cnt, char **exts, char *def_ext)
{
  if (cnt) {
    id pool = [[NSAutoreleasePool alloc] init];
    id *objs;
    int i, j, allow_others = 0;
    NSArray *a;
    NSSavePanel *sp = (NSSavePanel *)dlg;

    for (i = 0; i < cnt; i++) {
      if (!strcmp(exts[i], "*"))
        allow_others = 1;
    }
    
    objs = (id *)malloc(sizeof(id) * (1 + (cnt - allow_others)));
    j = 0;
    objs[j++] = [[NSString alloc] initWithUTF8String: def_ext];
    for (i = 0; i < cnt; i++) {
      if (strcmp(exts[i], "*"))
        objs[j++] = [[NSString alloc] initWithUTF8String: exts[i]];
    }
    
    a = [NSArray arrayWithObjects:objs count:j];

    [sp setAllowedFileTypes:a];
    sp.canSelectHiddenExtension = TRUE;
    if (!allow_others)
      sp.allowsOtherFileTypes = FALSE;
    
    for (i = 0; i < j; i++) {
      [objs[i] release];
    }
    free(objs);

    [pool release];
  }
}
