# 19Internals of ggplot2
# Chapter 23

# Example 1
p <- ggplot(mpg, aes(displ, hwy, color = drv)) + 
  geom_point(position = "jitter") +
  geom_smooth(method = "lm", formula = y ~ x) + 
  facet_wrap(vars(year)) + 
  ggtitle("A plot for expository purposes")

# Example 2
ggprint <- function(x) {
  data <- ggplot_build(x)
  gtable <- ggplot_gtable(data)
  grid::grid.newpage()
  grid::grid.draw(gtable)
  return(invisible(x))
}

# Example 3
p_built <- ggplot_build(p)
p_gtable <- ggplot_gtable(p_built)

class(p_gtable)
#> [1] "gtable" "gTree"  "grob"   "gDesc"

# Example 4
NewObject <- ggproto(
  `_class` = NULL, 
  `_inherits` = NULL
)

# Example 5
NewObject <- ggproto(NULL, NULL)

# Example 6
NewClass <- ggproto("NewClass", NULL)

# Example 7
Person <- ggproto("Person", NULL,
  
  # fields                  
  given_name = NA,
  family_name = NA,
  birth_date = NA,
  
  # methods
  full_name = function(self, family_last = TRUE) {
    if(family_last == TRUE) {
      return(paste(self$given_name, self$family_name))
    }
    return(paste(self$family_name, self$given_name))
  },
  age = function(self) {
    days_old <- Sys.Date() - self$birth_date
    floor(as.integer(days_old) / 365.25)
  },
  description = function(self) {
    paste(self$full_name(), "is", self$age(), "years old")
  }
)

# Example 8
Person$full_name
#> <ggproto method>
#>   <Wrapper function>
#>     function (...) 
#> full_name(..., self = self)
#> 
#>   <Inner function (f)>
#>     function (self, family_last = TRUE) 
#> {
#>     if (family_last == TRUE) {
#>         return(paste(self$given_name, self$family_name))
#>     }
#>     return(paste(self$family_name, self$given_name))
#> }

# Example 9
Thomas <- ggproto(NULL, Person,
  given_name = "Thomas Lin",
  family_name = "Pedersen",
  birth_date = as.Date("1985/10/12")
)

Danielle <- ggproto(NULL, Person,
  given_name = "Danielle Jasmine",
  family_name = "Navarro",
  birth_date = as.Date("1977/09/12")
)

# Example 10
# define the subclass
NewSubClass <- ggproto("NewSubClass", Person)

# verify that this works
NewSubClass
#> <ggproto object: Class NewSubClass, Person, gg>
#>     age: function
#>     birth_date: NA
#>     description: function
#>     family_name: NA
#>     full_name: function
#>     given_name: NA
#>     super:  <ggproto object: Class Person, gg>

# Example 11
Royalty <- ggproto("Royalty", Person,
  rank = NA,
  territory = NA,
  full_name = function(self) {
    paste(self$rank, self$given_name, "of", self$territory)
  }
)

# Example 12
Victoria <- ggproto(NULL, Royalty,
  given_name = "Victoria",
  family_name = "Hanover",
  rank = "Queen",
  territory = "the United Kingdom",
  birth_date = as.Date("1819/05/24")
)

# Example 13
Police <- ggproto("Police", Person,
  rank = NA, 
  description = function(self) {
    paste(
      self$rank,
      ggproto_parent(Person, self)$description()
    )
  }
)

# Example 14
John <- ggproto(NULL, Police,
  given_name = "John",
  family_name = "McClane",
  rank = "Detective",
  birth_date = as.Date("1955/03/19")
)

John$full_name() 
#> [1] "John McClane"

John$description()
#> [1] "Detective John McClane is 70 years old"

# Example 15
GeomErrorbar <- ggproto(
    # ...
    setup_params = function(data, params) {
      GeomLinerange$setup_params(data, params)
    }
    # ...
  )

