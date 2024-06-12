# HsmLua
Hierarchical state machine in lua made mainly for games.
Originally written in ts and then converted programmatically to lua.

states are tables who support one or more of these hooks:
*  Enter called on all the newely entered states on state change can be cancelled returning true in case of state change while executing.
*  Update called from root to the current leaf can be cancelled in case of state change while executing.
*  Event called on the current node then bubbling up the hierarchy until a state handles it returning true
    
*  Exit called on states switching out starting from current node in root direction cannot be cancelled at the moment( it could change )

plans:
*  specific regions ( composite, utility ,random etc like in hfsm2)

latest changes:
* use next to cancel loops on switch_to without proper manual return value e.g. in Enter hook
* no new array on deep hooks. Same array get reused every time.
* fixed undefined behaviour when a state starts a change without stopping event bubbling. now a parents can overwrite switches during event bubbling so you could check .self:next before to make a new switch.
