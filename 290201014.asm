##############################################################
#Array
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Size of array
#   4 Bytes - Size of elements
##############################################################

##############################################################
#Linked List
##############################################################
#   4 Bytes - Address of the First Node
#   4 Bytes - Size of linked list
##############################################################

##############################################################
#Linked List Node
##############################################################
#   4 Bytes - Address of the Data
#   4 Bytes - Address of the Next Node
##############################################################

##############################################################
#Recipe
##############################################################
#   4 Bytes - Name (address of the name)
#	4 Bytes - Ingredients (address of the ingredients array)
#   4 Bytes - Cooking Time
#	4 Bytes - Difficulty
#	4 Bytes - Rating
##############################################################


.data
space: .asciiz " "
newLine: .asciiz "\n"
tab: .asciiz "\t"
lines: .asciiz "------------------------------------------------------------------\n"

listStr: .asciiz "List: \n"
recipeName: .asciiz "Recipe name: "
ingredients: .asciiz "Ingredients: "
cookingTime: .asciiz "Cooking time: "
difficulty: .asciiz "Difficulty: "
rating: .asciiz "Rating: "
listSize: .asciiz "List Size: "
emptyListWarning: .asciiz "List is empty!\n"
indexBoundWarning: .asciiz "Index out of bounds!\n"
recipeNotMatch: .asciiz "Recipe not matched!\n"
recipeMatch: .asciiz "Recipe matched!\n"
recipeAdded: .asciiz "Recipe added.\n"
recipeRemoved: .asciiz "Recipe removed.\n"
noRecipeWarning: .asciiz "No recipe to print!\n"

addressOfRecipeList: .word 0 #the address of the array of recipe list stored here!


# Recipe 1: Pancakes
r1: .asciiz "Pancakes"
r1i1: .asciiz "Flour"
r1i2: .asciiz "Milk"
r1i3: .asciiz "Eggs"
r1i4: .asciiz "Sugar"
r1i5: .asciiz "Baking powder"
r1c: .word 15							# Cooking time in minutes
r1d: .word 2							# Difficulty (scale 1-5)
r1r: .word 4							# Rating (scale 1-5)

# Recipe 2: Spaghetti Bolognese
r2: .asciiz "Spaghetti Bolognese"
r2i1: .asciiz "Spaghetti"
r2i2: .asciiz "Ground beef"
r2i3: .asciiz "Tomato sauce"
r2i4: .asciiz "Garlic"
r2i5: .asciiz "Onion"
r2c: .word 30
r2d: .word 3
r2r: .word 5

# Recipe 3: Chicken Stir-Fry
r3: .asciiz "Chicken Stir-Fry"
r3i1: .asciiz "Chicken breast"
r3i2: .asciiz "Soy sauce"
r3i3: .asciiz "Bell peppers"
r3i4: .asciiz "Broccoli"
r3i5: .asciiz "Garlic"
r3c: .word 20
r3d: .word 3
r3r: .word 4

# Recipe 4: Caesar Salad
r4: .asciiz "Caesar Salad"
r4i1: .asciiz "Romaine lettuce"
r4i2: .asciiz "Caesar dressing"
r4i3: .asciiz "Parmesan cheese"
r4i4: .asciiz "Croutons"
r4i5: .asciiz "Chicken breast (optional)"
r4c: .word 10
r4d: .word 1
r4r: .word 4

# Recipe 5: Chocolate Chip Cookies
r5: .asciiz "Chocolate Chip Cookies"
r5i1: .asciiz "Butter"
r5i2: .asciiz "Sugar"
r5i3: .asciiz "Flour"
r5i4: .asciiz "Eggs"
r5i5: .asciiz "Chocolate chips"
r5c: .word 25
r5d: .word 2
r5r: .word 5


search1: .asciiz "Caesar Salad"
search2: .asciiz "Shepherd's Pie"

.text 
main:
	# Initialize the Recipe List
    	jal createLinkedList                # Create the linked list
    	sw $v0, addressOfRecipeList         # addressOfRecipeList = linkedlist address
#---------------------------------------------------------------
	# CREATE ARRAY: Pancake ingredients array
    	li $a0, 5               # Max number of elements (5 ingredients)
    	li $a1, 4               # Size of each element (4 bytes for addresses)
    	jal createArray         # Call createArray to create the ingredients array
    	move $s0, $v0           # s0 = array address for pancake ingredients
#---------------------------------------------------------------
     	# PUT ELEMENT TO ARRAY: Pancake ingredients
     	move $a0, $s0           # a0 = array address for pancake ingredients
    	# Add Flour (index 0)
    	la $a1, r1i1            # a1 = address of "Flour"
    	li $a2, 0               # a2 = Index 0
    	jal putElementToArray   # Add the ingredient

    	# Add Milk (index 1)
    	la $a1, r1i2            # a1 = address of "Milk"
    	li $a2, 1               # a2 = Index 1
    	jal putElementToArray   # Add the ingredient

    	# Add Eggs (index 2)
    	la $a1, r1i3            # a1 = address of "Eggs"
    	li $a2, 2               # a2 = Index 2
    	jal putElementToArray   # Add the ingredient

    	# Add Sugar (index 3)
    	la $a1, r1i4            # a1 = address of "Sugar"
    	li $a2, 3               # a2 = Index 3
    	jal putElementToArray   # Add the ingredient

    	# Add Baking Powder (index 4)
    	la $a1, r1i5            # a1 =  address of "Baking powder"
    	li $a2, 4               # a2 = Index 4
    	jal putElementToArray   # Add the ingredient
#---------------------------------------------------------------
	# CREATE RECIPE: Pancake Recipe
    	la $a0, r1                  # a0 = Recipe name ("Pancakes")  
    	move $a1, $s0               # a1 = s0 (Address of the pancake ingredients)
    	lw $a2, r1c                 # a2 = Cooking time (15 minutes)
    	lw $a3, r1d                 # a3 = Difficulty (2)
    	addi $sp, $sp, -4  	
  	lw $t1, r1r        	    # t1 = rating
    	sw $t1, 0($sp)              
    	
    	jal createRecipe            # Create the recipe
    	move $s0, $v0               # s1 = pancake recipe address
    	
    	addi $sp, $sp, 4    
#---------------------------------------------------------------
	# ENQUEUE: Pancake Recipe
    	lw $a0, addressOfRecipeList # a0 = linked list address
    	move $a1, $s0               # a1 = Recipe address
    	jal enqueue                 # Add the recipe to the linked list
#---------------------------------------------------------------    	
    	# CREATE ARRAY:Spaghetti Bolognese Recipe Ingredients
    	li $a0, 5
    	li $a1, 4
    	jal createArray
    	move $s0, $v0	#s0 = Spaghetti Bolognese Ingredient Array
#---------------------------------------------------------------    	
	# PUT ELEMENTS TO ARRAY: Spaghetti Bolognese Ingredients
	move $a0, $s0           # a0 = Address of Spaghetti Bolognese Ingredient Array
    	la $a1, r2i1		# a1 =
    	li $a2, 0		# a2 = Index 0
    	jal putElementToArray

    	la $a1, r2i2
    	li $a2, 1		# a2 = Index 1
    	jal putElementToArray

    	la $a1, r2i3
    	li $a2, 2		# a2 = Index 2
    	jal putElementToArray

    	la $a1, r2i4
    	li $a2, 3		# a2 = Index 3
    	jal putElementToArray

    	la $a1, r2i5
    	li $a2, 4		# a2 = Index 4
    	jal putElementToArray
#---------------------------------------------------------------    	
    	# CREATE RECIPE: Spaghetti Bolognese Recipe
    	la $a0, r2		# a0 = Recipe Name("Spaghetti Bolognese")    	
    	move $a1, $s0		# a1 = Spaghetti Bolognese Ingredient Array
    	lw $a2, r2c		# a2 = Cooking time
    	lw $a3, r2d		# a3 = Difficulty
    	
    	addi $sp, $sp, -4
    	lw $t1, r2r
    	sw $t1, 0($sp)
    	
    	jal createRecipe
    	move $s1, $v0		#s1 = Spaghetti Bolognese recipe address
    	
    	addi $sp, $sp, 4
#---------------------------------------------------------------    	
    	# ENQUEUE: Spaghetti Bolognese recipe
    	lw $a0, addressOfRecipeList
    	move $a1, $s1		# a1 = Spaghetti Bolognese recipe address
    	jal enqueue
#---------------------------------------------------------------    	
	# PRINT QUEUE SIZE: 
	la $a0, listSize
	li $v0, 4
	syscall
	
    	lw $a0, addressOfRecipeList           # a0 = linkedlist address
    	lw $t0, 4($a0)                        # Load the size from the linked list (offset 4)
    	li $v0, 1                             # Print integer syscall
    	move $a0, $t0                         # Move size to $a0 for printing
    	syscall
#---------------------------------------------------------------    	
    	# NEWLINE
    	la $a0, newLine
    	li $v0, 4
    	syscall
#---------------------------------------------------------------    	
    	# PRINT RECIPES: Print Current Recipes in the List
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe 1 address
    	la $a1, printRecipe            # a1 = address of printRecipe
    	li $a2, 0                      # a2 = extra arguments (none here)

    	jal traverseLinkedList
#---------------------------------------------------------------    	
    	# DEQUEUE: Pancake
    	lw $a0, addressOfRecipeList
    	jal dequeue
#---------------------------------------------------------------    	
  	# PRINT RECIPES: Print Removed Recipes in the List
	move $a0, $v0				# a0 = address of the removed recipe struct
	lw $a0, 0($a0)
	jal printRecipe
#---------------------------------------------------------------    	
	# PRINT QUEUE SIZE: 
	la $a0, listSize
	li $v0, 4
	syscall
	
    	lw $a0, addressOfRecipeList           # a0 = linkedlist address
    	lw $t0, 4($a0)                        # Load the size from the linked list (offset 4)
    	li $v0, 1                             # Print integer syscall
    	move $a0, $t0                         # Move size to $a0 for printing
    	syscall
#---------------------------------------------------------------    	
    	# NEWLINE
    	la $a0, newLine
    	li $v0, 4
    	syscall
#---------------------------------------------------------------    	
    	# PRINT RECIPES: Print Current Recipes in the List
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe 1 address
    	la $a1, printRecipe            # a1 = address of printRecipe
    	li $a2, 0                      # a2 = extra arguments (none here)

    	jal traverseLinkedList
#---------------------------------------------------------------    	
    	# DEQUEUE : Spaghetti Bolognese
    	lw $a0, addressOfRecipeList
    	jal dequeue
#---------------------------------------------------------------    	
    	# PRINT RECIPE: Print removed recipe
    	move $a0, $v0				# a0 = address of the removed recipe struct
	lw $a0, 0($a0)
	jal printRecipe
#---------------------------------------------------------------	
    	# DEQUEUE: EMPTY LIST
    	lw $a0, addressOfRecipeList
    	jal dequeue
#---------------------------------------------------------------
    	# PRINT QUEUE SIZE:
    	la $a0, listSize
	li $v0, 4
	syscall
    	lw $a0, addressOfRecipeList           # a0 = linkedlist address
    	lw $t0, 4($a0)                        # Load the size from the linked list (offset 4)
    	li $v0, 1                             # Print integer syscall
    	move $a0, $t0                         # Move size to $a0 for printing
    	syscall
#---------------------------------------------------------------    	
    	# NEWLINE
    	la $a0, newLine
    	li $v0, 4
    	syscall
#---------------------------------------------------------------    	
    	# PRINT RECIPES: Remaining Recipes
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe 1 address
    	la $a1, printRecipe            # a1 = address of printRecipe
    	li $a2, 0                      # a2 = extra arguments (none here)

    	jal traverseLinkedList
#---------------------------------------------------------------    	
    	# CREATE ARRAY: Chicken Stir-Fry Ingredient Array
    	li $a0, 5               # Max number of elements (5 ingredients)
    	li $a1, 4               # Size of each element (4 bytes for addresses)
    	jal createArray         # Call createArray to create the ingredients array
    	move $s0, $v0           # s0 = array address for Chicken Stir-Fry ingredients
#---------------------------------------------------------------    	
    	# PUT ELEMENT TO ARRAY: Chicken Stir-Fry Ingredients
    	move $a0, $s0           # a0 = Address of Chicken Stir-Fry Ingredient Array
    	la $a1, r3i1		# a1 =
    	li $a2, 0		# a2 = Index 0
    	jal putElementToArray

    	la $a1, r3i2
    	li $a2, 1		# a2 = Index 1
    	jal putElementToArray

    	la $a1, r3i3
    	li $a2, 2		# a2 = Index 2
    	jal putElementToArray

    	la $a1, r3i4
    	li $a2, 3		# a2 = Index 3
    	jal putElementToArray

    	la $a1, r3i5
    	li $a2, 4		# a2 = Index 4
    	jal putElementToArray
#---------------------------------------------------------------    	
    	# CREATE RECIPE : Chicken Stir-Fry recipe
    	la $a0, r3		# a0 = Recipe Name("Chicken Stir-Fry")    	
    	move $a1, $s0		# a1 = Chicken Stir-Fry Ingredient Array
    	lw $a2, r2c		# a2 = Cooking time
    	lw $a3, r2d		# a3 = Difficulty
    	
    	addi $sp, $sp, -4
    	lw $t1, r2r
    	sw $t1, 0($sp)
    	
    	jal createRecipe
    	move $s2, $v0		#s2 = Chicken Stir-Fry recipe address
    	
    	addi $sp, $sp, 4
#---------------------------------------------------------------    	
    	# ENQUEUE: add Chicken stir-fry recipe
    	lw $a0, addressOfRecipeList
    	move $a1, $s2		# a1 = Chicken Stir-Fry recipe address
    	jal enqueue
#---------------------------------------------------------------    	
    	# PRINT RECIPE: Current Recipe List
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe 1 address
    	la $a1, printRecipe            # a1 = address of printRecipe
    	li $a2, 0                      # a2 = extra arguments (none here)

    	jal traverseLinkedList
#---------------------------------------------------------------    	
    	# CREATE ARRAY: Caesar Salad Ingredient Array
    	li $a0, 4               # Max number of elements (4 ingredients)
    	li $a1, 4               # Size of each element (4 bytes for addresses)
    	jal createArray         # Call createArray to create the ingredients array
    	move $s0, $v0           # s0 = array address for Caesar Salad ingredients
#---------------------------------------------------------------    	
    	# PUT ELEMENT TO ARRAY: Caesar Salad Ingredients
    	move $a0, $s0           # a0 = Address of Caesar Salad Ingredient Array
    	la $a1, r4i1		# a1 =
    	li $a2, 0		# a2 = Index 0
    	jal putElementToArray

    	la $a1, r4i2
    	li $a2, 1		# a2 = Index 1
    	jal putElementToArray

    	la $a1, r4i3
    	li $a2, 2		# a2 = Index 2
    	jal putElementToArray

    	la $a1, r4i4
    	li $a2, 3		# a2 = Index 3
    	jal putElementToArray

    	la $a1, r4i5
    	li $a2, 4		# a2 = Index 4
    	jal putElementToArray
#---------------------------------------------------------------    	
    	# CREATE RECIPE : Caesar Salad recipe
    	la $a0, r4		# a0 = Recipe Name("Caesar Salad")    	
    	move $a1, $s0		# a1 = Caesar Salad Ingredient Array
    	lw $a2, r2c		# a2 = Cooking time
    	lw $a3, r2d		# a3 = Difficulty
    	
    	addi $sp, $sp, -4
    	lw $t1, r2r
    	sw $t1, 0($sp)
    	
    	jal createRecipe
    	move $s3, $v0		#s3 = Caesar Salad recipe address
    	
    	addi $sp, $sp, 4
#---------------------------------------------------------------    	
    	# ENQUEUE: add Caesar Salad recipe
    	lw $a0, addressOfRecipeList
    	move $a1, $s3		# a1 = Caesar Salad recipe address
    	jal enqueue
#---------------------------------------------------------------    	
    	# PRINT QUEUE SIZE: 
    	la $a0, listSize
	li $v0, 4
	syscall
    	lw $a0, addressOfRecipeList           # a0 = linkedlist address
    	lw $t0, 4($a0)                        # Load the size from the linked list (offset 4)
    	li $v0, 1                             # Print integer syscall
    	move $a0, $t0                         # a0 = size of linkedlist
    	syscall
#---------------------------------------------------------------    	
    	# NEWLINE
    	la $a0, newLine
    	li $v0, 4
    	syscall
#---------------------------------------------------------------    	
    	# PRINT RECIPES: Print current recipes
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe 1 address
    	la $a1, printRecipe            # a1 = address of printRecipe
    	li $a2, 0                      # a2 = extra arguments (none here)

    	jal traverseLinkedList
#---------------------------------------------------------------    	
    	# CREATE ARRAY: Chocolate Chip Cookies Ingredient Array
    	li $a0, 5               # Max number of elements (5 ingredients)
    	li $a1, 4               # Size of each element (4 bytes for addresses)
    	jal createArray         # Call createArray to create the ingredients array
    	move $s0, $v0           # s0 = array address for Chocolate Chip Cookies ingredients
#---------------------------------------------------------------    	
    	# PUT ELEMENT TO ARRAY: Chocolate Chip Cookies Ingredients
    	move $a0, $s0           # a0 = Address of Chocolate Chip Cookies Ingredient Array
    	la $a1, r5i1		# a1 =
    	li $a2, 0		# a2 = Index 0
    	jal putElementToArray

    	la $a1, r5i2
    	li $a2, 1		# a2 = Index 1
    	jal putElementToArray

    	la $a1, r5i3
    	li $a2, 2		# a2 = Index 2
    	jal putElementToArray

    	la $a1, r5i4
    	li $a2, 3		# a2 = Index 3
    	jal putElementToArray

    	la $a1, r5i5
    	li $a2, 4		# a2 = Index 4
    	jal putElementToArray
#---------------------------------------------------------------    	
    	# CREATE RECIPE : Chocolate Chip Cookies recipe
    	la $a0, r5		# a0 = Recipe Name("Chocolate Chip Cookies")    	
    	move $a1, $s0		# a1 = Chocolate Chip Cookies Ingredient Array
    	lw $a2, r2c		# a2 = Cooking time
    	lw $a3, r2d		# a3 = Difficulty
    	
    	addi $sp, $sp, -4
    	lw $t1, r2r
    	sw $t1, 0($sp)
    	
    	jal createRecipe
    	move $s4, $v0		#s4 = Chocolate Chip Cookies
    	
    	addi $sp, $sp, 4
#---------------------------------------------------------------    	
    	# ENQUEUE: add Chocolate Chip Cookies recipe
    	lw $a0, addressOfRecipeList
    	move $a1, $s4		# a1 = Chocolate Chip Cookies recipe address
    	jal enqueue
#---------------------------------------------------------------    	
    	# PRINT QUEUE SIZE: 
    	la $a0, listSize
	li $v0, 4
	syscall
    	lw $a0, addressOfRecipeList           # a0 = linkedlist address
    	lw $t0, 4($a0)                        # Load the size from the linked list (offset 4)
    	li $v0, 1                             # Print integer syscall
    	move $a0, $t0                         # a0 = size of linkedlist
    	syscall
#---------------------------------------------------------------   	
    	# NEWLINE
    	la $a0, newLine
    	li $v0, 4
    	syscall
#---------------------------------------------------------------  	
    	#PRINT RECIPES: current recipes
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe struct address
    	la $a1, printRecipe            # a1 = address of printRecipe
    	li $a2, 0                      # a2 = extra arguments (none here)

    	jal traverseLinkedList
#---------------------------------------------------------------  	
    	#SEARCH BY NAME
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe struct address
    	la $a1, findRecipe            # a1 = address of findRecipe
    	la $a2, search1			# a2 = search 1 address
    	jal traverseLinkedList
    	
    	lw $a0, addressOfRecipeList    # a0 = linked list address
    	lw $a0, 0($a0)                 # a0 = recipe struct address
    	la $a1, findRecipe            # a1 = address of findRecipe
    	la $a2, search2			# a2 = search 2 address
    	jal traverseLinkedList
#---------------------------------------------------------------    	
mainTerminate:
	# End of the program
    	li $v0, 10                  # Exit the program
    	syscall

#---------------------------------------------------------------
createArray:
    # Inputs: $a0 = Max number of elements, $a1 = Size of elements
    # Outputs: $v0 = Address of the array structure

	move $t2, $a0
	
	li $v0, 9
	li $a0, 12
	syscall
	
	move $t0, $v0
	move $a0, $t2
	
	mul $a0, $a0, $a1
	li $v0, 9
	syscall
	
	move $t1, $v0
	move $a0, $t2
	
	sw $t1, 0($t0)
	sw $a1, 4($t0)
	sw $a0, 8($t0)
	
	move $v0, $t0
	
	jr $ra
#---------------------------------------------------------------
putElementToArray: #DONE
    # Inputs:
    #   $a0 = Address of the array structure
    #   $a1 = Address of the element to add
    #   $a2 = Index to add the element at
    	lw $t0, 0($a0)         # Address of data
    	lw $t1, 4($a0)         # Size of each element
    	lw $t2, 8($a0)         # Max number of elements

    	# Check if the index is valid
    	bge $a2, $t2, putElementError  # If index >= max size, go to error
    	bltz $a2, putElementError      # If index < 0, go to error

    	# Calculate the address of the element
    	mul $t3, $a2, $t1      # Offset = Index * Element Size
    	add $t4, $t0, $t3      # Element address = Data Address + Offset
    	sw $a1, 0($t4)         

    	jr $ra

putElementError:
    	# Print an error message and return
    	move $t1, $a0    	
    	la $a0, indexBoundWarning  
    	li $v0, 4                 
    	syscall                   
    	move $a0, $t1
    	jr $ra                    
#---------------------------------------------------------------    
createLinkedList: #DONE
    	# Inputs: None
    	# Outputs: $v0 = Address of the linked list structure

    	# Allocate memory for the linked list structure (Head + Size)
    	li $a0, 8               
    	li $v0, 9               
    	syscall                 
    	move $t0, $v0           
    	
    	# Initialize the linked list structure
    	li $t1, 0               # Initialize size to 0
    	sw $t1, 0($t0)          
    	sw $t1, 4($t0)          

    	move $v0, $t0           
    	jr $ra                  
#---------------------------------------------------------------   	
enqueue:
    # Inputs:
    #   $a0 - Address of the linked list structure (head + size)
    #   $a1 - Address of the data to add (new node's data)

	move $t0, $a0	# a0 = address of linkedlist
	
    	# Allocate memory for the new node (8 bytes for data + next pointer)
    	li $a0, 8               
    	li $v0, 9               
    	syscall                 

    	move $a0, $t0	# a0 = linkedlist address
    	    
    	move $t1, $v0           # Store the address of the new node in $t1

    	# Set up the new node
    	sw $a1, 0($t1)          
    
    	li $t2, 0               # 0 for the next pointer
    	sw $t2, 4($t1)          # the node's next field = 0

    	lw $t3, 0($a0)          
    	beqz $t3, enqueueEmpty  

enqueueLoop: 
	lw $t4, 4($t3)
	bne $t4, $zero, next
	j addNode
next:
	move $t3, $t4
	j enqueueLoop
	
enqueueEmpty:
	sw $t1, 0($a0)
	j incrementQueueSize 	#added to empty linkedlist
	
addNode:
	sw $t1, 4($t3) 	
	j incrementQueueSize	#added to not empty linkedlist
	
incrementQueueSize:
	lw $t5, 4($a0)
	addi $t5, $t5, 1
	sw $t5, 4($a0)
	j printRecipeAdded
	
printRecipeAdded:
	move $t6, $a0
	la $a0, recipeAdded
	li $v0, 4
	syscall
	move $a0, $t6
	jr $ra
#---------------------------------------------------------------		
dequeue:
    	# Inputs:
    	#   $a0 - Address of the linked list structure (head + size)
    	# Outputs:
    	#   $v0 - Removed head node address, 0 if empty

    	move $t0, $a0            # Store linked list address in $t0
    
    	lw $t1, 0($t0)       # Load the head pointer    

    	beqz $t1, dequeueEmpty	# Check if the list is empty (head is NULL)

    	move $v0, $t1            
    	
    	lw $t2, 4($t1)           
    	sw $t2, 0($t0)           

    	lw $t3, 4($t0)           
    	addi $t3, $t3, -1        
    	sw $t3, 4($t0)           

    	beqz $t2, dequeueEmptyList 

printRemoved:
        la $a0, recipeRemoved  
        li $v0, 4              
        syscall                
        move $v0, $t1
        jr $ra                 

dequeueEmpty:
    	li $v0, 0                  # Set $v0 to 0: no node to remove

    	la $a0, noRecipeWarning    
    	li $v0, 4                  
    	syscall                    
    	jr $ra                     

dequeueEmptyList:
    	li $t2, 0                  # Load 0 into $t2
    	sw $t2, 0($t0)             # Set the head pointer to 0
    	j printRemoved             
#---------------------------------------------------------------
traverseArray:
    # Inputs:
    #   $a0 - address of array structure
    #   $a1 - address of the function to be applied to each element
    #
    # The array structure format is:
    #   0($a0): Address of data
    #   4($a0): Size of each element (bytes)
    #   8($a0): Max number of elements


	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	
	move $t6, $a0 		#t5 = a0

    	lw $s5, 0($a0)         # t2 = data base address
    	lw $s6, 4($a0)         # t3 = size of each element (bytes)
    	lw $s7, 8($a0)         # t4 = max number of elements in the array

    	li $t5, 0              # t3 = index = 0
traverseArrayLoop:
    	bge $t5, $s7, endArrayLoop  # If i >= max number of elements, exit the loop

    	mul $t6, $t5, $s6      # offset = i * element_size
    	add $t6, $t6, $s5      # t6 = ingredient address = base_address + offset
    	lw $a0, 0($t6)         # $a0 = ingredient address


    	jalr $a1               

    	lw $ra, 0($sp)


    	addi $t5, $t5, 1       # i++
    	j traverseArrayLoop

endArrayLoop:
    	move $a0, $t6
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
    	jr $ra
#---------------------------------------------------------------
traverseLinkedList:
    	# Inputs:
    	#   $a0 - head node of linked list (address of the first node)
    	#   $a1 - function address (e.g., for printing or finding a recipe)
    	#   $a2 - extra argument (e.g., search term)
    	# Outputs:
    	#   None

    	# Allocate space on the stack for $a1, $a2, and $ra
    	addi $sp, $sp, -12        
    	sw $a1, 0($sp)            # Save $a1 (function address)
    	sw $a2, 4($sp)            # Save $a2 (extra argument)
    	sw $ra, 8($sp)            # Save $ra (return address)

    	move $t0, $a0             # t0 = head node address (first node)
    	
    	move $a0, $t0
    	beqz $a0, emptyList       

traverseLinkedListLoop:
        lw $a0, 0($t0)        # $a0 = recipe struct address from current node

    	lw $a1, 4($sp)            # $a1 = function address 
    	lw $a3, 0($sp)            # $a2 = extra argument 

    	jalr $a3                  # Jump to the function address in $a3
    	lw $ra, 8($sp)         #restore the ra after function call

        lw $t0, 4($t0)        # Load the address of the next node
        bnez $t0, traverseLinkedListLoop 

endLinkedListTraverse:
    	lw $ra, 8($sp)            
    	lw $a2, 4($sp)            
    	lw $a1, 0($sp)            
    	addi $sp, $sp, 12         

    	jr $ra                    

emptyList:
    	la $a0, emptyListWarning  
    	li $v0, 4                 
    	syscall                   
    	j endLinkedListTraverse            
#---------------------------------------------------------------
compareString: 
    # Inputs: $a0 - string 1 address, $a1 - string 2 address
    # Outputs: $v0 - 0 if matched, 1 if not matched
        lb $t2, 0($a0) 
        lb $t3, 0($a1) 

        bne $t2, $t3, notSame 
        beq $t2, $zero, same 

        addi $a0, $a0, 1 
        addi $a1, $a1, 1 
        j compareString    

notSame:
        li $v0, 1       # Set $v0 to 1 (strings are not same)
        jr $ra          

same:
        li $v0, 0       # Set $v0 to 0 (strings are same)
        jr $ra          
#-----------------------------------------------------------------
createRecipe: 
	# Create a recipe and store in the recipe struct.
	# Inputs: $a0 - recipe name, $a1 - address of ingredients array,
	#         $a2 - cooking time, $a3 - difficulty, 0($sp) - rating
	# Outputs: $v0 - recipe address
	
    	move $t0, $a0     # t0 = recipe name
    	move $t1, $a1     # t1 = ingredients array address
    	move $t2, $a2     # t2 = cooking time
    	move $t3, $a3     # t3 = difficulty

    	li $v0, 9          
    	li $a0, 20         
    	syscall

    	
    	move $t4, $v0      # t4 = allocated recipe struct address

    	sw $t0, 0($t4)      # recipe name
    	sw $t1, 4($t4)      # ingredients array address
    	sw $t2, 8($t4)      # cooking time
    	sw $t3, 12($t4)     # difficulty
    

    	lw $t5, 0($sp)      # rating from stack
    	sw $t5, 16($t4)     # store rating

    
    	move $v0, $t4       # return recipe address
    	jr $ra
#---------------------------------------------------------------
findRecipe:
    # Inputs:
    #   $a0 - recipe struct address
    #   $a1 - searched recipe name
    # Outputs:
    #   None (prints match or no match messages)

    	addi $sp, $sp, -4          
    	sw $ra, 0($sp)             

    	move $t9, $a0
    	lw $a0, 0($a0)             
    	jal compareString          

    
    	beq $v0, 0, matched        
    	j notMatched              

matched:
    	la $a0, recipeMatch        
    	li $v0, 4                  
    	syscall                    

    	move $a0, $t9              
    	jal printRecipe            
    	j endFind                 

notMatched:
    	la $a0, recipeNotMatch     
    	li $v0, 4                  
    	syscall                    

endFind:
    	lw $ra, 0($sp)             
    	addi $sp, $sp, 4           
    	jr $ra                     
#---------------------------------------------------------------
printRecipe:
    # Inputs: $a0 - address of recipe struct

    	addi $sp, $sp, -4   
    	sw $ra, 0($sp)      

    	move $t7, $a0    

    	la $a0, listStr           
    	li $v0, 4                 
    	syscall    

    	la $a0, lines             
    	li $v0, 4                 
    	syscall                                     
    	
 	move $a0, $t7
 	
    	la $a0, recipeName  
    	li $v0, 4
    	syscall

    	lw $a0, 0($t7)      
    	li $v0, 4
    	syscall

    	la $a0, newLine
    	li $v0, 4
    	syscall
    	
	la $a0, ingredients
	li $v0, 4
	syscall
    	
    	lw $a0, 4($t7)      		
    	la $a1, printIngredient		
    	jal traverseArray    

	la, $a0, newLine
	li $v0, 4
	syscall

	la $a0, cookingTime 	
	li $v0, 4
	syscall

	lw $a0, 8($t7)      
	li $v0, 1           
	syscall

	la, $a0, newLine
	li $v0, 4
	syscall

	la $a0, difficulty
	li $v0, 4
	syscall

	lw $a0, 12($t7) 
	li $v0, 1
	syscall

	la, $a0, newLine
	li $v0, 4
	syscall

	la $a0, rating
	li $v0, 4
	syscall

	lw $a0, 16($t7) 
	li $v0, 1
	syscall
	
	la, $a0, newLine
	li $v0, 4
	syscall

    	la $a0, lines             
    	li $v0, 4                 
    	syscall  
	lw $ra, 0($sp)
    	addi $sp, $sp, 4    

	jr $ra
#---------------------------------------------------------------
printIngredient:
	# Print ingredient.
	# Inputs: $a0 - address of ingredient
	move, $t8, $a0
	
	la $a0, newLine
	li $v0, 4
	syscall

	la $a0, tab
	li $v0, 4
	syscall

	move $a0, $t8
	li $v0, 4
	syscall

	jr $ra