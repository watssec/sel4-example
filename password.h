#include <sel4/sel4.h>
#define SIZE 5000
extern int free_head ;
extern int used_head ;
extern int array[SIZE];
// Make free_head, used_head, array global



seL4_Bool CheckForNullSecret(seL4_Word userp, seL4_Word users);
seL4_Bool PwasFound(int temp);
seL4_Bool EndOfUsedListFound (int temp, int userp, int users);
seL4_Bool CheckForPresenceOfP (int userp, int users);
