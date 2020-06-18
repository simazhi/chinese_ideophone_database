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
#library(readxl)
library(DT)
library(shinythemes)

# Here is the data and stuff

#library(devtools)
#install_github("simazhi/chinese_ideophone_database/CHIDEOR")

library(CHIDEOD) 
#make sure this is the latest version of this package
data("chideod")

#ideodata <- read_xlsx("www/data.xlsx") %>%
ideodata <- chideod



## SERVER

server <- 
    function(input, output) {
        checkGroup <- reactive(c(input$checkGroupDatavars,
                                 input$checkGroupOrthography,
                                 input$checkGroupPhonology,
                                 input$checkGroupMeaning,
                                 input$checkGroupMotivation,
                                 input$checkGroupFormation,
                                 input$checkGroupFrequencies,
                                 input$checkGroupOther))
        #input$checkGroup <- c(input$checkGroupForm,input$checkGroupMeaning)

        # Filter data based on selections
        output$table <- DT::renderDataTable(
            DT::datatable({
                data <- ideodata
                data <- data[, checkGroup(), drop = FALSE]
                data <- distinct(data)
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
                                      checkboxGroupInput("checkGroupDatavars", 
                                                         label = h2("Data variables"), 
                                                         choices = c("Language stage" = "language_stage",
                                                                     "Data source" = "data_source"),
                                                         selected = c("language_stage", "data_source")
                                      ),
                                      #end of checkboxes
                                      br(),
                                      h2("Descriptive variables"),
                                      #checkboxes two
                                      checkboxGroupInput("checkGroupOrthography", 
                                                         label = h3("Orthography"), 
                                                         choices = c("Traditional Chinese" = "traditional",
                                                                     "Simplified Chinese" = "simplified",
                                                                     "Traditional character 1" = "traditional1",
                                                                     "Traditional character 2" = "traditional2",
                                                                     "Traditional character 3" = "traditional3",
                                                                     "Traditional character 4" = "traditional4",
                                                                     "Simplified character 1" = "simplified1",
                                                                     "Simplified character 2" = "simplified2",
                                                                     "Simplified character 3" = "simplified3",
                                                                     "Simplified character 4" = "simplified4",
                                                                     "Semantic radical 1" = "character1_semantic_radical",
                                                                     "Semantic radical 2" = "character2_semantic_radical",
                                                                     "Semantic radical 3" = "character3_semantic_radical",
                                                                     "Semantic radical 4" = "character4_semantic_radical",
                                                                     "Sound component 1" = "character1_phonetic_component",
                                                                     "Sound component 2" = "character2_phonetic_component",
                                                                     "Sound component 3" = "character3_phonetic_component",
                                                                     "Sound component 4" = "character4_phonetic_component",
                                                                     "Orthographic variants" = "orthograpic_variants"),                                                   
                                                         selected = "traditional"
                                      ),
                                      #end of checkboxes
                                      br(),                                    
                                      #checkboxes
                                      checkboxGroupInput("checkGroupPhonology", 
                                                         label = h3("Phonology"), 
                                                         choices = c("Pinyin without tones" = "pinyin_without_tone", 
                                                                     "Pinyin with tones" = "pinyin_tone",
                                                                     "Pinyin with numbers" = "pinyin_tonenumber",
                                                                     "IPA with toneletters"= "ipa_toneletter",
                                                                     "IPA with tonenumbers" = "ipa_tonenumber",
                                                                     "Middle Chinese Baxter" = "middle_chinese_baxter", 
                                                                     "Middle Chinese IPA" = "middle_chinese_ipa",
                                                                     "Old Chinese IPA" = "old_chinese_ipa"),
                                                         selected = "pinyin_tone"
                                      ),
                                      #end of checkboxes
                                      br(),
                                      # checkboxes five
                                      checkboxGroupInput("checkGroupMeaning", 
                                                         label = h3("Definitions"), 
                                                         choices = c("Definitions" = "definitions")
                                      ),
                                      #end of checkboxes
                                      br(),
                                      # checkboxes three
                                      checkboxGroupInput("checkGroupFormation", 
                                                         label = h2("Analytical variables"), 
                                                         choices = c("Morphological template" = "morphological_template",
                                                                     "Radical support" = "radical_support",
                                                                     "Interjection" = "interjection",
                                                                     "Sensory imagery" = "sensory_imagery")
                                      ),
                                      #end of checkboxes
                                      br(),
                                      # checkboxes six
                                      checkboxGroupInput("checkGroupFrequencies", 
                                                         label = h3("Frequency measures"), 
                                                         choices = c("Character 1 freq" = "character1_freq",
                                                                     "Character 2 freq" = "character2_freq",
                                                                     "Character 3 freq" = "character3_freq",
                                                                     "Character 4 freq" = "character4_freq",
                                                                     "Character 1 family size" = "character1_family_size",
                                                                     "Character 2 family size" = "character2_family_size",
                                                                     "Character 3 family size" = "character3_family_size",
                                                                     "Character 4 family size" = "character4_family_size",
                                                                     "Character 1 radical freq" = "character1_semantic_radical_freq",
                                                                     "Character 2 radical freq" = "character2_semantic_radical_freq",
                                                                     "Character 3 radical freq" = "character3_semantic_radical_freq",
                                                                     "Character 4 radical freq" = "character4_semantic_radical_freq",
                                                                     "Character 1 radical family size" = "character1_semantic_family_size",
                                                                     "Character 2 radical family size" = "character2_semantic_family_size",
                                                                     "Character 3 radical family size" = "character3_semantic_family_size",
                                                                     "Character 4 radical family size" = "character4_semantic_family_size",
                                                                     "Character 1 phonetic freq" = "character1_phonetic_component_freq",
                                                                     "Character 2 phonetic freq" = "character2_phonetic_component_freq",
                                                                     "Character 3 phonetic freq" = "character3_phonetic_component_freq",
                                                                     "Character 4 phonetic freq" = "character4_phonetic_component_freq",
                                                                     "Character 1 phonetic family size" = "character1_phonetic_family_size",
                                                                     "Character 2 phonetic family size" = "character2_phonetic_family_size",
                                                                     "Character 3 phonetic family size" = "character3_phonetic_family_size",
                                                                     "Character 4 phonetic family size" = "character4_phonetic_family_size")
                                      ),
                                      #end of checkboxes
                                      br(),
                                      # checkboxes seven
                                      checkboxGroupInput("checkGroupOther", 
                                                         label = h3("Other variables"), 
                                                         choices = c("Notes" = "note")
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
                    strong("March 2020, CHIDEOD (0.9.3)"),
                    a(href="https://osf.io/kpwgf/", "(link to repository)"),
                    br(),
                    print("Please cite as: "),
                    strong("Van Hoey, Thomas & Arthur Lewis Thompson. 2019. Chinese ideophone database. osf.io/kpwgf")
                    
           ),
           tabPanel("About",
                    h2("About CHIDEOD"),
                    h4("— The Chinese Ideophone Database"),
                    p("The Chinese Ideophone Database (CHIDEOD) is an open-source dataset, which currently collects 4948 unique onomatopoeia and ideophones (mimetics) of Mandarin, as well as Middle Chinese and Old Chinese. These are analyzed according to a wide range of variables pertaining to the type of data, description, analysis and frequency."),
                    br(),
                    print("© Thomas Van Hoey 司馬智"),
                    a(href="https://www.thomasvanhoey.com", "(website)"),
                    print("and Arthur Lewis Thompson"),
                    br(),
                    br(),
                    print("Last updated:"),
                    strong("June 2020"),
                    a(href="https://osf.io/kpwgf/", "(link to repository)"),
                    br(),
                    br(),
                    print("Link to the explanatory paper (to be added)."),
                    br(),
                    br(),
                    h2("Please cite as: "),
                    strong("Van Hoey, Thomas & Arthur Lewis Thompson. 2019. Chinese ideophone database (CHIDEOD). doi: 10.17605/OSF.IO/KPWGF"),
                    br(),
                    h2("Licence"),
                    print("The database is licenced under "),
                    a(href="https://creativecommons.org/licenses/by-nc-sa/4.0/", "the CC BY-NC-SA 4.0 licence"),
                    print(". This means that you can share and adapt, but that you cannot use it for any commerical purposes, and that you need to attribute correctly."),
                    br(),
                    h2("Disclaimer"),
                    print("This database has been constructed with academic purposes in mind, especially in the domain of ideophone studies. We recommend using this app as an exploratory tool but consulting the datasets on the OSF page for substantial research. Please also have a look at the paper that details the structure and which contains the references from which we draw a number of data from that were transformatively combined into this one repository. These data were collected with fair use in mind and we do recommend consulting those sources (and citing them) if you publish your research. CHIDEOD is a tool that can help you on your way."),
                    br(),
                    print("There may be a number of small typos or mistakes in the database. If you find any, please do not hesitate to contact us so that we can improve a better repository for the study of Chinese ideophones.")
                    
                    ),
           tabPanel("Data variables and abbreviations",
                    includeMarkdown("https://raw.githubusercontent.com/simazhi/chinese_ideophone_database/master/variables_and_data/abbreviations_references.md"))
           )


# fluidPage(theme = shinytheme("flatly"),
#     titlePanel("The Chinese Ideophones Database (CHIDEOD)"),
    

    
#) #end tabpage





# Run the application 
shinyApp(ui = ui, server = server)
