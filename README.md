# RecipeQueue-MIPS
Queue of Recipes using MIPS assembly language

This project uses a variety of data structures to manage recipes and their components efficiently. Below are the details of each structure used in the implementation:

## Array
An array is used to store ingredients for recipes. The structure contains the following fields:

* 4 Bytes: Address of the data.
* 4 Bytes: Array size (maximum number of elements).
* 4 Bytes: Element size.

## Linked List
The queue is implemented as a linked list. The structure contains the following fields:

* 4 Bytes: Address of the first node.
* 4 Bytes: Size (number of nodes in the list).

## Linked List Node
Each node in the linked list represents a single recipe. The structure contains the following fields:

* 4 Bytes: Address of the recipe data.
* 4 Bytes: Address of the next node.

## Recipe
A recipe consists of metadata and ingredients, stored in the following fields:

* 4 Bytes: Address of the recipe name (string).
* 4 Bytes: Address of the ingredients array.
* 4 Bytes: Cooking time (integer).
* 4 Bytes: Difficulty (integer).
* 4 Bytes: Rating (integer).
