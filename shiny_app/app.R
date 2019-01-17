#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#global.R
library(shiny)
library(tidyverse)
library(readxl)
library(DT)
library(shinythemes)

# Here is the data and stuff

#library(devtools)
#install_github("simazhi/chinese_ideophone_database/CHIDEOR")

library(CHIDEOR) 
#make sure this is the latest version of this package
data("full_database")

#ideodata <- read_xlsx("www/data.xlsx") %>%
    ideodata <- full_database %>%
    filter(morph != "NOTIDEOPHONE") %>%
    select(pinyinnone,
           traditional,
           simplified,
           pinyintone,
           MC,
           OC,
           zdic,
           Kroll,
           morph,
           radsup,
           variant)



## SERVER
# Load the ggplot2 package which provides
# the 'mpg' dataset.

server <- 
    function(input, output) {
        checkGroup <- reactive(c(input$checkGroupForm,
                                 input$checkGroupMeaning,
                                 input$checkGroupFormation))
        #input$checkGroup <- c(input$checkGroupForm,input$checkGroupMeaning)
        # Filter data based on selections
        output$table <- DT::renderDataTable(
            DT::datatable({
                data <- ideodata
                data[, checkGroup(), drop = FALSE]
            },
            extensions = c('Buttons', 'ColReorder'), 
            options = list(dom = 'Bfrtip',
                           buttons = c('copy', 
                                       'csv', 
                                       'excel'#, 
                                       # 'pdf', 
                                       # 'print'
                                       ),
                           colReorder = TRUE)
            )
        )
        
        # # Reactive expression with the data, in this case iris
        # thedata <- reactive(output$table)
        # 
        # # output$dto <- renderDataTable({thedata()})
        # output$download <- downloadHandler(
        #     filename = function(){"chineseideophones_query.csv"}, 
        #     content = function(fname){
        #         write.csv(thedata, fname)
        #     }
        # )
    
}



## UI

ui <-
fluidPage(theme = shinytheme("flatly"),
    titlePanel("Chinese ideophones — a database"),
    
    sidebarLayout(position = "left",
                  fluid = TRUE,
                  sidebarPanel(
                      width = 3,
                       # h4("test"),
                       # br(),
                       #checkboxes
                       checkboxGroupInput("checkGroupForm", 
                                          label = h3("Phonology"), 
                                          choices = c("Pinyin without tones" = "pinyinnone", 
                                                      "Pinyin with tones" = "pinyintone",
                                                      "Traditional Chinese" = "traditional",
                                                      "Simplified Chinese" = "simplified",
                                                      "Middle Chinese" = "MC", 
                                                      "Old Chinese" = "OC"),
                                          selected = c("traditional", "pinyinnone")
                                          ),
                       #end of checkboxes
                       br(),
                       # checkboxes two
                       checkboxGroupInput("checkGroupMeaning", 
                                          label = h3("Meaning"), 
                                          choices = c("Handian 漢典 (zdic)" = "zdic",
                                                      "Kroll (2015)" = "Kroll"),
                                          selected = "Kroll"
                                          ),
                       #end of checkboxes
                       br(),
                       # checkboxes three
                       checkboxGroupInput("checkGroupFormation", 
                                          label = h3("Formation"), 
                                          choices = c("Base and Reduplicant" = "morph",
                                                      "Radical support" = "radsup",
                                                      "variants" = "variant")
                                          )#, #end of checkboxes
                      # downloadButton('download',"Download the data")
                ), # end of sidepanel

    mainPanel(width = 9,
              DT::dataTableOutput("table")
    ) #main panel
        ), #sidebar layout,
    hr(),
    print("© Thomas Van Hoey 司馬智"),
    a(href="https://www.thomasvanhoey.com", "(website)"),
    print("and Arthur Lewis Thompson"),
    br(),
    print("Last updated:"),
    strong("January 2019"),
    a(href="https://osf.io/kpwgf/", "(link to repository)"),
    br(),
    print("Please cite as: "),
    strong("Van Hoey, Thomas & Arthur Lewis Thompson. 2019. Chinese ideophone database. osf.io/kpwgf")
    
    
) #end fluidpage





# Run the application 
shinyApp(ui = ui, server = server)
