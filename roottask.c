/*
 * Copyright 2021, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */



#include "sel4/sel4.h"
/*
#include "serial_server/parent.h"
#include <serial_server/client.h>

#include "sel4platsupport/io.h"
#include "sel4platsupport/bootinfo.h"

#include "allocman/allocman.h"
#include "allocman/bootstrap.h"
#include "allocman/vka.h"

#include <vka/vka.h>
#include "vka/object.h"
#include <cpio/cpio.h>
#include "simple/simple.h"
#include "simple-default/simple-default.h"

#include <sel4utils/stack.h>
#include <sel4utils/util.h>
#include <sel4utils/time_server/client.h>
*/

// char _cpio_archive[1];
// char _cpio_archive_end[1];
// init array
/*
int array[SIZE];
int free_head = 5;
int used_head = 6;
#define SERSERV_N_CLIENTS (1)

vka_t client_vkas[SERSERV_N_CLIENTS];
cspacepath_t client_server_ep_cspaths[SERSERV_N_CLIENTS];

// parent vka and vspace
// Create vspace object
vka_t parent_vka;

UNUSED static sel4utils_alloc_data_t data;
vspace_t parent_vspace;

// Create new TCB
vka_object_t tcb_object = {0};
int tcb_error;

#define ALLOCATOR_STATIC_POOL_SIZE (BIT(seL4_PageBits) * 10)
UNUSED static char allocator_mem_pool[ALLOCATOR_STATIC_POOL_SIZE];

// Fix linker error


void name_thread(seL4_CPtr tcb, char *name)
{
#ifdef SEL4_DEBUG_KERNEL
    seL4_DebugNameThread(tcb, name);
#endif
}




void client_main(void)
{
    // use the same vka as parent
    vka_t client_vka = parent_vka;
    // use the same my_vspace as parent
    vspace_t client_vspace = parent_vspace;
    serial_client_context_t my_conn;
    // connect!.....
    int error;
    error = serial_server_client_connect(client_server_ep_cspaths[0].capPtr,
    &client_vka,
    &client_vspace,
    &my_conn
    );
    serial_server_printf(&my_conn, "Hello world from %s.\n", "John Doe");
}
*/
int main(void)
{
    /*
    simple_t simple;
    allocman_t *allocman;
    seL4_BootInfo *info;
    
    info = platsupport_get_bootinfo();
    simple_default_init_bootinfo(&simple, info);
    
    allocman = bootstrap_use_current_simple(&simple, ALLOCATOR_STATIC_POOL_SIZE, allocator_mem_pool);
    
    // allocate vka
    allocman_make_vka(&parent_vka, allocman);
    tcb_error = vka_alloc_tcb(&parent_vka, &tcb_object);
    // spawn parent thread
    int error_spawn;
    error_spawn = serial_server_parent_spawn_thread(&simple, &parent_vka, &parent_vspace, seL4_MaxPrio -1);
    
    int err;
    int error;
    
    // There is actually just one client.. 
    for (int i = 0; i < SERSERV_N_CLIENTS; i++){
        // setup client's VKA
        allocman_make_vka(&client_vkas[i], allocman);
        // ask the server to Mint badged endpoints to the clients
        err = serial_server_parent_vka_mint_endpoint(&client_vkas[i],
         &client_server_ep_cspaths[i]);
    // CONFIG_WORD_SIZE);
    }
    
    // spawn the clients
    name_thread(tcb_object.cptr, "example: client_main");
    seL4_UserContext regs = {0};
    size_t regs_size = sizeof(seL4_UserContext) / sizeof(seL4_Word);
    // Hopefully by doing this can spawn the client thread.
    sel4utils_set_instruction_pointer(&regs, (seL4_Word)client_main);
    */
    return 1;
}
