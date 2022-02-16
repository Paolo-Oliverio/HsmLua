# HsmLua
Hierarchical state machine in lua made mainly to add state machines to Crayta
Originally written in ts and then converted automatically with my crayta-typescript toolset.

states are tables who support one or more of these hooks:
*  Enter called on all the newely entered states on state change can be cancelled returning true in case of state change while executing.
*  Update called from root to the current leaf can be cancelled in case of state change while executing.
*  Event called on the current node then bubbling up the hierarchy until a state handles it returning true
    *  undefined behaviour if a state starts a change without stopping event bubbling. e.g. use return sm:switch_to("state") to be safe 
*  Exit called on states switching out starting from current node in root direction cannot be cancelled at the moment( it could change )

plans:
*  use flag to cancel loops on switch_to without proper manual return value.
*  specific regions ( composite, utility ,random etc like in hfsm2)
