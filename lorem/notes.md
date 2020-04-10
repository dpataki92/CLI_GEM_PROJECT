What is a recipe?
    -it has a name
    -it has ingredients
    -it has directions
    -it has a category


Goals 

-it scrapes through the allrecipes website's appropriate page
-it can provide a list of vegan, vegetarian and mediterranean recipes or all the recipes
-the user can choose from the list and then it will show him the recipe and other data, random order or sorted alphabetically
-the user can ask for a random recipe from the chosen list
-the user can ask for a random daily menu from the chosen list
-the user can ask for a random weekly menu from the chosen list
-the user can save the recipe he wants
-the user can ask for all the favorite recipes he saved

Recipe class
 -Based on the user choice, it selects the chosen list (or all lists)
 -it lists the names of the dishes in a numbered but random order, the user can sort the list alphabetically
 -it creates an object from all the listed dishes based on the url and stores it in an array
 -if the user selects a dish based on the number, it returns the data from the created object
 -if the user exits - it clears the array and gets back to part when the user can choose from the lists
 -if the user wants to go back, it goes back to the list
 -if the user wants to save the recipe, it saves the object in the User class' class variabe, favorites, if it is not there already
 -if the user wants to the see the favorites, it clears the list array and returns a list of the names of the favorites in a numbered order, the user can sort it alphabetically
 -the user can select the recipe and it shows the details
 -if the user wants it returns a random recipe from the list
 -if the user wants it return a random daily menu from the list
 -it returns a random weekly menu from the list