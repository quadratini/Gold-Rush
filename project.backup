# Ronny Ritprasert
# Project
# Last worked on 04/13/2019

.data
intro:
    .ascii "\n=============\n"
    .ascii "  GOLD RUSH\n"
    .ascii "=============\n\n\0"
rules:
    .ascii "Rules:\n"
    .ascii "1. 20 weeks (5 months)\n"
    .ascii "2. Panning for gold yields 0-25 dollars\n"
    .ascii "3. A sluice yields 0-75 dollars (there is a 10% chance a sluice will break).\n"
    .ascii "4. Food costs 10-20 dollars.\0"
prompt:
    .ascii "\nYou have $\0"
prompt2:
    .ascii " and \0"
prompt3:
    .ascii " sluice(s)\0"
option:
    .ascii "\nDo you want to (1) buy a sluice for $100 (2) keep working?\n\0"
week:
    .ascii "\n\nWEEK \0"
panning:
    .ascii "Panning for gold yields $\0"
sluiceT:
    .ascii "Sluice \0"
sluiceY:
    .ascii " yields $\0"    
inGold:
    .ascii " in gold\n\0"
ate:
    .ascii "You ate $\0"
ate2:
    .ascii " in food\n\0"
earned:
    .ascii "\n\nYou earned $\0"    
spent:
    .ascii " and spent $\0"
broke:
    .ascii "\nSLUICE \0"
broke2:
    .ascii " BROKE!\0"
nl:
    .ascii "\n\0"   
ending:
    .ascii "\nYou ended the 20 weeks with $\0"

.text
.global _start

_start:
    mov  $3, %rcx
    call SetForeColor    # Sets color to yellow
    mov  $intro, %rcx
    call PrintCString
    mov  $1, %rcx
    call SetForeColor    # Returns color to white (by re-setting to white)
    mov  $rules, %rcx
    call PrintCString    # End of intro + rules
    mov  $7, %rcx
    call SetForeColor
    mov  $100, %r9       # Money the player starts with

# (if you have to print it, it has to be in rcx) can't use lower registers.. or can u?
# My table
# r8 = amount of weeks
# r9 = total gold so far
# r10 = amount of sluices
# r11 = gold earned that week
# r12 = expenses/spent
# r13 = sluice increment

while:                   # Loops until set number of weeks go by
    mov  $0, %r11        # Reset gold earned that week to 0
    mov  $0, %r12        # Reset gold spent that week to 0
    mov  $0, %r13        # Reset sluice count to 0
    
    mov  $week, %rcx
    call PrintCString    # Prints "WEEK"
    add  $1, %r8         # r8 is the incrementer (weeks that have gone by)
    mov  %r8, %rcx       # move contents of r8 into rcx to print
    call PrintInt        # Prints week number
    mov  %rcx, %r8       # move r8's contents back from rcx
    
    mov  $prompt, %rcx
    call PrintCString
    mov  $3, %rcx
    call SetForeColor    # Yellow
    mov  %r9, %rcx
    call PrintInt        # How much gold the player currently has
    mov  $7, %rcx
    call SetForeColor    # White
    mov  $prompt2, %rcx
    call PrintCString
    mov  %r10, %rcx      # how many sluices
    call PrintInt    
    mov  $prompt3, %rcx
    call PrintCString
    mov  $option, %rcx   # Asks user for option
    call PrintCString
    call ScanInt
    
    cmp  $1, %rcx
    je   buy
        
pan:    
    mov  $panning, %rcx  
    call PrintCString
    mov  $3, %rcx
    call SetForeColor
    mov  $26, %rcx       # Gets random gold 0-25
    call Random
    call PrintInt
    add  %rcx, %r11      # adds to gold earned that week
    add  %rcx, %r9       # Adds gold collected that week to total gold
    mov  $7, %rcx
    call SetForeColor
    mov  $inGold, %rcx 
    call PrintCString    # Prints "of gold"
    cmp  $0, %r10
    jg   sluice
   
eat:
    mov  $ate, %rcx
    call PrintCString	 # you ate...
    mov  $1, %rcx
    call SetForeColor
    mov  $11, %rcx
    call Random
    add  $10, %rcx
    call PrintInt        # (dollars)
    add  %rcx, %r12      # adding to expenses
    sub  %rcx, %r9
    mov  $7, %rcx
    call SetForeColor
    mov  $ate2, %rcx
    call PrintCString    # in food

    mov  $0, %r13           #NEW R13 NOW r13 checks for broken sluices
cont:
    mov  $10, %rcx
    call Random
    add  $1, %r13
    cmp  $0, %rcx         # rcx has 0-9
    je   broken           # broken sluices go here
    cmp  %r10, %r13 
    jle  cont

go:    
    mov  $earned, %rcx
    call PrintCString    # "you earned "
    mov  $3, %rcx
    call SetForeColor
    mov  %r11, %rcx
    call PrintInt        # (dollars)
    mov  $7, %rcx
    call SetForeColor
    mov  $spent, %rcx
    call PrintCString    # "and spent $ "
    mov  $1, %rcx
    call SetForeColor 
    mov  %r12, %rcx
    call PrintInt
    mov  %rcx, %r12
    mov  $7, %rcx
    call SetForeColor

    cmp  $20, %r8         # Total amount of weeks there are (length of game)
    jl   while
    jmp  end             
    			 # r10 is sluices: if r10 > 0 print sluice 1 yields...
                         # gold gained + in gold.
buy:
    cmp $100, %r9
    jl  pan
    add $1, %r10
    sub $100, %r9
    add $100, %r12
    jmp pan

sluice:
    add  $1, %r13
    
    mov  $sluiceT, %rcx
    call PrintCString
    mov  %r13, %rcx
    call PrintInt
    mov  $sluiceY, %rcx    # yields 
    call PrintCString
    mov  $3, %rcx
    call SetForeColor
    mov  $76, %rcx
    call Random
    call PrintInt
    add  %rcx, %r11
    add  %rcx, %r9   
    mov  $7, %rcx
    call SetForeColor
    mov  $inGold, %rcx
    call PrintCString
    
    cmp  %r10, %r13
    jl   sluice    
    jmp  eat

broken:
    cmp  %r10, %r13
    jg   go
    mov  $broke, %rcx
    call PrintCString
    mov  %r13, %rcx
    call PrintInt
    mov  %rcx, %r13
    mov  $1, %rcx
    call SetForeColor
    mov  $broke2, %rcx
    call PrintCString
    mov  $7, %rcx
    call SetForeColor
    sub  $1, %r10
    jmp  cont

end:
    mov  $ending, %rcx
    call PrintCString
    mov  $3, %rcx
    call SetForeColor
    mov  %r9, %rcx
    call PrintInt
    mov  $7, %rcx
    call SetForeColor
    mov  $nl, %rcx
    call PrintCString
    call EndProgram

