require(pryr)

## Create S3 Method and Object: 
## This data set is a list of ships from the White Star line (of Titanic fame) 
## from 1910 - 1919. The S3 ship class in order to create S3 ship 
## objects from the White Star Line.

# define a generic function. Will dispatch (execute) a method (class specific 
# function) based on the object class
# this generic function will create a ship object with validity checking
#generic_fn <- function(x, ...){
#  UseMethod("generic_fn")
#}

ship <- function(shipName, shippingLine, yearBuilt, begin, end, fate, ... ){
  
  ## perform validity checks
  
  # Validity check for name: must be char 
  if(!is.character(shipName)){
    stop("Error: 'name' must be a string.")
  }
  
  # Validity check for shippingLine: char 
  if(!is.character(shippingLine)){
    stop("Error: 'shippingLine' must be a string.")
  }
  
  # Validity check for yearBuilt: must be numeric and >0
  if(!is.numeric(yearBuilt) || yearBuilt <= 0){
    stop("Error: 'yearBuilt' must be a positive number representing a year.")
  }
  
  # Validity check for begin date: must be numeric and >0
  if(!is.numeric(begin) || begin <= 0){
    stop("Error: 'begin' must be a positive number representng a year.")
  }
  
  # Validity check for end date: must be numeric and >0
  if(!is.numeric(end) || begin <= 0){
    stop("Error: 'end' must be a positive number representng a year.")
  }
  
  # Validity check for fate: must be char 
  if(!is.character(fate)){
    stop("Error: 'fate' must be a string.")
  }
  
 
   # characteristics of a the White Star Ship
  ship = list(shipName = shipName, shippingLine = shippingLine, 
                   yearBuilt = yearBuilt, begin = begin, end = end, fate = fate)
 

  # Set the class of an object by using class(object) <- "classname"
  class(ship) = "ship"
  return(ship)
}



# create a custom print method to display ship info
# pass x (the object) into the method. not necessary to specify the name of the 
# object, just a placeholder
print.ship <- function(x, ... ){
  cat("Name: ", x$shipName, "\n")
  cat("Shipping Line: ", x$shippingLine, "\n")
  cat("Year Built: ", x$yearBuilt, "\n")
  cat("Beginning of Service: ", x$begin, "\n")
  cat("End of Service: ", x$end, "\n")
  cat("Fate: ", x$fate, "\n")
  
}

# create a individual ship objects from the White Star Line
ws1 <- ship("Titanic", "White Star", 1912, 1912, 1912, "Sunk")
ws1

# read in 1910 - 1919 White Star ship list
WSships <- read.csv("WhiteStar1910.csv", header = T, stringsAsFactors = FALSE)

# create a list of ships
ship_list <- list()
# extract data from data frame with a loop and place in object
for(i in 1:nrow(WSships)){ # for each row in 1 thru end of df 
  # extract data for each passenger
  shipName <- WSships$shipName[i]
  yearBuilt <- WSships$yearBuilt[i]
  begin <- WSships$begin[i]
  end <- WSships$end[i]
  fate <- WSships$fate[i]
  
  # create a ship object using the constructor
  ws_obj <- ship(shipName, shippingLine = "White Star", yearBuilt, begin, end,
                fate)
  
  # store the ship object in a list
  ship_list[[i]] <- ws_obj
}

# print a ship object
ship_list
print(ship_list[[7]])

# Add a ship object with incorrect date
new_ship <- ship("Titanic II", "White Star", "unknown", "unknown", "unknown", "Not Yet Built")

# check class type
otype(ws1) # Titanic test object
class(ws1) # Titanic test object

otype(ship_list) # base type "list" of all White Star ships
otype(ship_list[[1]])  # individual elements in list are type S3 objects

# Call a single variable inside the object
ws1$shipName. # Titanic test object
ship_list[[1]]$shipName # all White Star ships

## Create an S4 Method and Object
## This data set is a list of several famous passengers from the sinking of the 
## Titanic and basic about them (age, passenger class, survival status etc)
## The method serves as a constructor to create an S4 class. It's responsible
## creating and initializing S4 passenger objects

Passenger <- setClass("Passenger", slots = c(name = "character", 
                                             sex = "character",
                                             age = "numeric", 
                                             pClass = "numeric",
                                             survivalStatus = "character"),
                     # no prototype means user must enter all values
                     # check validity
                      validity = function(object){
                        if(object@age < 0){
                          return("Age must greater than or equal to 0 years")
                        } 
                        if(object@pClass < 0 || object@pClass > 3){
                          return("Passenger class must be equal to 1, 2 or 3")
                        } else(return(TRUE))
                      }
                      
                      )
# Create passenger objects
unsinkable <- Passenger(name = "Molly Brown", sex = "F", age = 39, pClass = 1, survivalStatus = "Survived")

richest <- Passenger(name = "John Jacob Astor", sex = "M", age = 47, pClass = 1,
                     survivalStatus = "Died")
# must use named arguments when creating arguments in S4 not positional
youngest <- Passenger("Milvina Dean", "F", "0", 3, "Survived")
# age must be numeric
youngest <- Passenger(name = "Milvina Dean", sex = "F", age = "0", pClass = 3, 
                      survivalStatus = "Survived")
youngest <- Passenger(name = "Milvina Dean", sex = "F", age = 0, pClass = 3, 
                      survivalStatus = "Survived")


# Define custom print method for Titanic Passengers
print.Passenger <- function(x, ... ){
  cat("Name: ", x@name, "\n")
  cat("Sex: ", x@sex, "\n")
  cat("Age in 1912: ", x@age, "\n")
  cat("Passenger Class: ", x@pClass, "\n")
  cat("Survival Status: ", x@survivalStatus, "\n")
  
}

print(unsinkable)
print(richest)
print(youngest)

# Check object type and class
class(unsinkable)
otype(unsinkable)
isS4(unsinkable)
