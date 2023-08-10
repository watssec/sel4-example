#include <sel4/sel4.h>

typedef struct node{
    char * p;
    char * s;
    struct node * next;
} node_t;

seL4_Bool CheckForNullSecret(char * userp, char * users);
seL4_Bool PwasFound(node_t * free_head, node_t * temp);
seL4_Bool EndOfUsedListFound (node_t *used_head, node_t *free_head, node_t * temp, char * userp, char * users);
seL4_Bool CheckForPresenceOfP (node_t *used_head, node_t *free_head, char * userp, char * users);
