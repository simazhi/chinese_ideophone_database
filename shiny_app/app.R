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
data("chideod")

#ideodata <- read_xlsx("www/data.xlsx") %>%
    ideodata <- chideod



## SERVER

server <- 
    function(input, output) {
        checkGroup <- reactive(c(input$checkGroupPhonology,
                                 input$checkGroupOrthography,
                                 input$checkGroupFormation,
                                 input$checkGroupMotivation,
                                 input$checkGroupMeaning,
                                 input$checkGroupFrequencies,
                                 input$checkGroupOther))
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


    
}



## UI

ui <-
navbarPage("CHIDEOD",
           fluid = TRUE,
           theme = shinytheme("flatly"),
           tabPanel("Table",
                    sidebarLayout(position = "left",
                                  #fluid = TRUE,
                                  sidebarPanel(
                                      width = 3,
                                      #checkboxes
                                      checkboxGroupInput("checkGroupPhonology", 
                                                         label = h3("Phonology"), 
                                                         choices = c("Pinyin without tones" = "pinyinnone", 
                                                                     "Pinyin with tones" = "pinyintone",
                                                                     "Pinyin with numbers" = "pinyinnum",
                                                                     "Middle Chinese" = "MC", 
                                                                     "Old Chinese" = "OC"),
                                                         selected = "pinyinnone"
                                      ),
                                      #end of checkboxes
                                      br(),
                                      #checkboxes two
                                      checkboxGroupInput("checkGroupOrthography", 
                                                         label = h3("Orthography"), 
                                                         choices = c("Traditional Chinese" = "traditional",
                                                                     "Simplified Chinese" = "simplified",
                                                                     "Traditional 1" = "T1",
                                                                     "Traditional 2" = "T2",
                                                                     "Traditional 3" = "T3",
                                                                     "Traditional 4" = "T4",
                                                                     "Simplified 1" = "S1",
                                                                     "Simplified 2" = "S2",
                                                                     "Simplified 3" = "S3",
                                                                     "Simplified 4" = "S4",
                                                                     "Semantic radical 1" = "S1.sem",
                                                                     "Semantic radical 2" = "S2.sem",
                                                                     "Semantic radical 3" = "S3.sem",
                                                                     "Semantic radical 4" = "S4.sem",
                                                                     "Sound radical 1" = "S1.phon",
                                                                     "Sound radical 2" = "S2.phon",
                                                                     "Sound radical 3" = "S3.phon",
                                                                     "Sound radical 4" = "S4.phon"),                                                   
                                                         selected = "traditional"
                                      ),
                                      #end of checkboxes
                                      br(), 
                                      # checkboxes three
                                      checkboxGroupInput("checkGroupFormation", 
                                                         label = h3("Formation"), 
                                                         choices = c("Base and Reduplicant" = "morphology")
                                      ),
                                      #end of checkboxes
                                      br(), 
                                      # checkboxes four
                                      checkboxGroupInput("checkGroupMotivation", 
                                                         label = h3("Motivation"), 
                                                         choices = c("Radical support" = "radsup")
                                      ),
                                      #end of checkboxes
                                      # checkboxes five
                                      checkboxGroupInput("checkGroupMeaning", 
                                                         label = h3("Meaning"), 
                                                         choices = c("Handian 漢典 (zdic)" = "zdic",
                                                                     "Kroll (2015)" = "Kroll",
                                                                     "Hanyu Da Cidian 漢語大詞典" = "HYDCD"),
                                                         selected = "Kroll"
                                      ),
                                      #end of checkboxes
                                      br(),
                                      # checkboxes six
                                      checkboxGroupInput("checkGroupFrequencies", 
                                                         label = h3("Frequencies"), 
                                                         choices = c("S1 character freq" = "S1.charfreq",
                                                                     "S2 character freq" = "S2.charfreq",
                                                                     "S3 character freq" = "S3.charfreq",
                                                                     "S4 character freq" = "S4.charfreq",
                                                                     "S1 family freq" = "S1.famfreq",
                                                                     "S2 family freq" = "S2.famfreq",
                                                                     "S3 family freq" = "S3.famfreq",
                                                                     "S4 family freq" = "S4.famfreq",
                                                                     "S1 semantic radical freq" = "S1.semfreq",
                                                                     "S2 semantic radical freq" = "S2.semfreq",
                                                                     "S3 semantic radical freq" = "S3.semfreq",
                                                                     "S4 semantic radical freq" = "S4.semfreq",
                                                                     "S1 semantic radical fam freq" = "S1.semfam",
                                                                     "S2 semantic radical fam freq" = "S1.semfam",
                                                                     "S3 semantic radical fam freq" = "S1.semfam",
                                                                     "S4 semantic radical fam freq" = "S1.semfam",
                                                                     "S1 sound freq" = "S1.phonfreq",
                                                                     "S2 sound freq" = "S2.phonfreq",
                                                                     "S3 sound freq" = "S3.phonfreq",
                                                                     "S4 sound freq" = "S4.phonfreq",
                                                                     "S1 sound fam freq" = "S1.phonfam",
                                                                     "S2 sound fam freq" = "S2.phonfam",
                                                                     "S3 sound fam freq" = "S3.phonfam",
                                                                     "S4 sound fam freq" = "S4.phonfam")
                                      ),
                                      #end of checkboxes
                                      br(),
                                      # checkboxes seven
                                      checkboxGroupInput("checkGroupOther", 
                                                         label = h3("Other variables"), 
                                                         choices = c("Variants" = "variant",
                                                                     "Data source" = "datasource")
                                      )
                                      #, #end of checkboxes
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
                    strong("July 2019"),
                    a(href="https://osf.io/kpwgf/", "(link to repository)"),
                    br(),
                    print("Please cite as: "),
                    strong("Van Hoey, Thomas & Arthur Lewis Thompson. 2019. Chinese ideophone database. osf.io/kpwgf")
                    
           ),
           tabPanel("About",
                    h2("About CHIDEOD"),
                    h4("— The Chinese Ideophone Database"),
                    p("This article introduces the Chinese Ideophone Database (CHIDEOD, accessible at https://osf.io/kpwgf/
                      an open-source dataset, which collects 3453 unique onomatopoeia and ideophones (mimetics) of Mandarin Chinese, 
                      as well as Middle Chinese and Old Chinese (based on Baxter & Sagart 2014). 
                      These are analyzed according to a wide range of phonological, orthographic, and semantic variables. 
                      Apart from an overview of these variables, preliminary findings are briefly discussed, 
                      such as motivation of the orthographic encoding of semantic and phonological forms, 
                      so-called radical support and phonological support. 
                      Lastly, some possible future applications are suggested, 
                      to show how CHIDEOD can integrate with existing databases and provide a typological example for ideophone studies in other languages."),
                    br(),
                    print("© Thomas Van Hoey 司馬智"),
                    a(href="https://www.thomasvanhoey.com", "(website)"),
                    print("and Arthur Lewis Thompson"),
                    br(),
                    print("Last updated:"),
                    strong("July 2019"),
                    a(href="https://osf.io/kpwgf/", "(link to repository)"),
                    br(),
                    print("Please cite as: "),
                    strong("Van Hoey, Thomas & Arthur Lewis Thompson. 2019. Chinese ideophone database. osf.io/kpwgf")
                    
                    )
           )


# fluidPage(theme = shinytheme("flatly"),
#     titlePanel("The Chinese Ideophones Database (CHIDEOD)"),
    

    
#) #end tabpage





# Run the application 
shinyApp(ui = ui, server = server)
