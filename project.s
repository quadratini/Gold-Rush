# Ronny Ritprasert
# Project

.data
intro:
    .ascii "\n================\n"
    .ascii "  ALIEN DIGGER \n"
    .ascii "================\n\n\0"
rules:
    .ascii "Rules:\n"
    .ascii "1. 25 weeks\n"
    .ascii "2. Farming eggs yields 0-25 minerals\n"
    .ascii "3. A nest yields 0-75 minerals (there is a 10% chance a nest will deplete).\n"
    .ascii "4. Food costs 10-20 minerals.\n"
    .ascii "6. Going to the brothel gives \"intelligence\" (1-2 levels)\n"
    .ascii "7. Higher intelligence = more minerals gained when farming eggs!(0-25 * intelligence)\n"
    .ascii "8. At 10 intelliigence, you can invade Earth. However, there is a 30% chance you die.\n"
    .ascii "9. If you run out of minerals, you die.\n"
    .ascii "10. Beware, humans lurk about. (20% chance)\n"
    .ascii "11. There's a chance you run into a camp and KILL it(20% chance)\0"
    
prompt:
    .ascii "\nYou have $\0"
prompt2:
    .ascii ", \0"
prompt3:
    .ascii " nest(s), and \0"
prompt4:
    .ascii " intelligence\0"
option:
    .ascii "\nDo you want to (1) build a nest for $100 (2) keep working\n"
    .ascii "(3) visit the brothel, (4) invade Earth? (requires 10 intelligence)\n\0"
week:
    .ascii "\n\nWEEK \0"
panning:
    .ascii "Farming eggs yields $\0"
nestT:
    .ascii "Nest \0"
nestY:
    .ascii " yields $\0"    
inGold:
    .ascii " in minerals\n\0"
ate:
    .ascii "You devoured $\0"
ate2:
    .ascii " in food\n\0"
earned:
    .ascii "\n\nYou earned $\0"    
spent:
    .ascii " and lost $\0"
broke:
    .ascii "\nNEST \0"
broke2:
    .ascii " DEPLETED!\0"
robbedT:
    .ascii "\nYou were attacked by humans! They rob you of 15 minerals.\0"
brothelT:
    .ascii "\nYou visit the brothel, you now have \0"
intelligence:
    .ascii " intelligence\n\0"
discover:
    .ascii "\nYou discover a camp made by Earthlings, you destory it and gain \0"
invadeT:
    .ascii "You invade Earth and plunder \0"
minerals:
    .ascii " minerals\n\0"
deadT:
    .ascii "Oh no!! You died during your invasion...\n\0"
dead2T:
    .ascii "\nYou ran out of minerals and died...\n\0"
notEnough:
    .ascii "Not Enough intelligence!\n\0"
nl:
    .ascii "\n\0"   
ending:
    .ascii "\nYou ended with $\0"
thanks:
    .ascii "\nAlien Digger 2 coming soon.\n\0"

# Not my own art, taken from asciiart.eu/space/aliens
art:
    .ascii "\n         __.,,------.._"
    .ascii "\n      ,'\"   _      _   \"`." 
    .ascii "\n     /.__, ._  -=- _\"`    Y"
    .ascii "\n    (.____.-.`      \"\"`   j"
    .ascii "\n     VvvvvvV`.Y,.    _.,-'       ,     ,     ,"
    .ascii "\n        Y    ||,   '\"\         ,/    ,/    ./"
    .ascii "\n        |   ,'  ,     `-..,'_,'/___,'/   ,'/   ,"
    .ascii "\n    ..  ,;,,',-'\"\,'  ,  .     '     ' \"\"' '--,/    .. .."
    .ascii "\n ,'. `.`---'     `, /  , Y -=-    ,'   ,   ,. .`-..||_|| .." 
    .ascii "\nff\\`. `._        /f ,'j j , ,' ,   , f ,  \=\ Y   || ||`||_.."
    .ascii "\nl` \` `.`.\"`-..,-' j  /./ /, , / , / /l \   \=\l   || `' || ||..." 
    .ascii "\n `  `   `-._ `-.,-/ ,' /`\"/-/-/-/-\"'''\"`.`.  `'.\--`'--..`'_`' || ,"
    .ascii "\n            \"`-_,',  ,'  f    ,   /      `._    ``._     ,  `-.`'//         ,"
    .ascii "\n          ,-\"'' _.,-'    l_,-'_,,'          \"`-._ . \"`. /|     `.'\ ,       |"
    .ascii "\n        ,',.,-'\"          \=) ,`-.         ,    `-'._`.V |       \ // .. . /j"
    .ascii "\n        |f\\               `._ )-.\"`.     /|         `.| |        `.`-||-\\/"
    .ascii "\n        l` \`                 \"`._   \"`--' j          j' j          `-`---'"
    .ascii "\n         `  `                     \"`,-  ,'/       ,-'\"  /"
    .ascii "\n                                 ,'\",__,-'       /,, ,-'"
    .ascii "\n                                 Vvv'            VVv'\n\0"


.text
.global _start

_start:
    mov  $3, %rcx
    call SetForeColor    # Sets color to yellow
    mov  $intro, %rcx
    call PrintCString
    mov  $7, %rcx
    call SetForeColor    # Returns color to white (by re-setting to white)
    mov  $6, %rcx
    call SetForeColor
    mov  $rules, %rcx
    call PrintCString    # End of intro + rules
    mov  $7, %rcx
    call SetForeColor
    mov  $300, %r9       # Money the player starts with
    mov  $0, %r14        # Start with 0 intelligence

# My table
# r8 = amount of weeks
# r9 = total gold so far
# r10 = amount of nests
# r11 = gold earned that week
# r12 = expenses/spent
# r13 = nest increment
# r14 = intelligence

begin:                   # Loops until set number of weeks go by
    mov  $0, %r11        # Reset gold earned that week to 0
    mov  $0, %r12        # Reset gold spent that week to 0
    mov  $0, %r13        # Reset nest count to 0
    
    cmp  $0, %r9
    jle  dead2
    
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
    mov  $2, %rcx
    call SetForeColor
    mov  %r10, %rcx      # how many nests
    call PrintInt
    mov  $7, %rcx
    call SetForeColor    
    mov  $prompt3, %rcx
    call PrintCString
    mov  $6, %rcx
    call SetForeColor
    mov  %r14, %rcx
    call PrintInt
    mov  $7, %rcx
    call SetForeColor
    mov  $prompt4, %rcx
    call PrintCString
    mov  $option, %rcx   # Asks user for option
    call PrintCString
    
options:
    call ScanInt
    mov  %rcx, %rax
    cmp  $1, %rcx
    je   buy
    cmp  $2, %rcx
    je   pan
    cmp  $3, %rcx
    je   brothel
    cmp  $4, %rcx
    je   invade
    jmp  options
        
pan:    
    mov  $panning, %rcx  
    call PrintCString
    mov  $3, %rcx
    call SetForeColor
    mov  $26, %rcx       # Gets random gold 0-25
    call Random
    imul %r14, %rcx
    call PrintInt
    add  %rcx, %r11      # adds to gold earned that week
    add  %rcx, %r9       # Adds gold collected that week to total gold
    mov  $7, %rcx
    call SetForeColor
    mov  $inGold, %rcx 
    call PrintCString    # Prints "of gold"
    cmp  $0, %r10
    jg   nest
   
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
    cmp  $3, %rax
    je   afterBrothel
    cmp  $4, %rax
    je   afterBrothel
    mov  $0, %r13           #NEW R13 NOW r13 checks for broken nest
cont:
    mov  $10, %rcx
    call Random
    add  $1, %r13
    cmp  $0, %rcx         # rcx has 0-9
    je   broken           # broken nests go here
    cmp  %r10, %r13 
    jle  cont
afterBrothel:
    mov  $5, %rcx         #20% chance of getting robbed
    call Random
    cmp  $0, %rcx
    je   robbed
afterRob:
    mov  $5, %rcx
    call Random
    cmp  $0, %rcx
    je   camp    
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

    cmp  $25, %r8         # Total amount of weeks there are (length of game)
    jl   begin
    jmp  end             
    			 # r10 is nests: if r10 > 0 print nest 1 yields...
                         # gold gained + in gold.
notEnoughL:
    mov  $notEnough, %rcx
    call PrintCString
    jmp  options
                         
camp:
    mov  $discover, %rcx
    call PrintCString
    mov  $1, %rcx
    call PrintInt
    add  $1, %r14
    mov  $intelligence, %rcx
    call PrintCString
    jmp  go

invade:
    cmp  $10, %r14
    jl   notEnoughL
    mov  $invadeT, %rcx
    call PrintCString
    mov  $700, %rcx
    call Random
    add  $400, %rcx
    call PrintInt
    add  %rcx, %r11
    add  %rcx, %r9
    mov  $minerals, %rcx
    call PrintCString
    mov  $10, %rcx
    call Random
    cmp  $2, %rcx
    jle  dead
    jmp  go    
                         
brothel:
    mov  $2, %rcx
    call Random
    add  $1, %rcx
    add  %rcx, %r14
    mov  $brothelT, %rcx
    call PrintCString
    mov  $6, %rcx
    call SetForeColor
    mov  %r14, %rcx
    call PrintInt
    mov  %rcx, %r14
    mov  $7, %rcx
    call SetForeColor
    mov  $intelligence, %rcx
    call PrintCString
    jmp  eat
                         
robbed:
    mov  $robbedT, %rcx
    call PrintCString
    sub  $15, %r9
    add  $15, %r12
    jmp  afterRob
                         
buy:
    cmp $100, %r9
    jl  pan
    add $1, %r10
    sub $100, %r9
    add $100, %r12
    jmp pan

nest:
    add  $1, %r13
    mov  $nestT, %rcx
    call PrintCString
    mov  %r13, %rcx
    call PrintInt
    mov  $nestY, %rcx    # yields 
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
    jl   nest    
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

dead2:
    mov  $1, %rcx
    call SetForeColor
    mov  $dead2T, %rcx
    call PrintCString
    jmp  end

dead:
    mov  $1, %rcx
    call SetForeColor
    mov  $deadT, %rcx
    call PrintCString

end:
    mov  $ending, %rcx
    call PrintCString
    mov  %r9, %rcx
    call PrintInt
    mov  $nl, %rcx
    call PrintCString
    mov  $art, %rcx
    call PrintCString
    mov  $thanks, %rcx
    call PrintCString
    mov  $7, %rcx
    call SetForeColor
    call EndProgram


