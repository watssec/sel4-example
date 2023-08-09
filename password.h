#include <sel4/sel4.h>

typedef struct node{
    int p;
    int s;
    struct node * next;
} node_t;

seL4_Bool CheckForNullSecret(int userp, int users);
seL4_Bool PwasFound(node_t * free_head, node_t * temp);
seL4_Bool EndOfUsedListFound (node_t *used_head, node_t *free_head, node_t * temp, int userp, int users);
seL4_Bool CheckForPresenceOfP (node_t *used_head, node_t *free_head, int userp, int users);
