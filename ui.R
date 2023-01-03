library(shiny)

shinyUI(fluidPage(
  tabsetPanel(
    tabPanel(title = "About",
      column(width = 2),
      column(width = 8,
             fluidRow(
               column(width = 12,align = "center",
                      h3("Web Application to Summarize and Report OD Survey Data")
                )
             ),
             fluidRow(
               column(width = 12,
                      p(style="text-align: justify;font-size:18px;",
                        "The objective of this project to quickly convert OD survey data into a OD matrix and to create a brief PDF report of the data."),
                      p(style="text-align: justify;font-size:18px;",
                        "Arrange the OD Survey data as shwon below (please maintain 'origin' and 'destination' column names):"),
                      fluidRow(column(width = 12,tableOutput(outputId = "od_sample_df"), align = "center")),
                      p(style="text-align: justify;font-size:18px;",
                        "Zone Ids should be provided in a different sheet. Make sure that the column name in this sheet is 'zone_id'. Enter the other column names with a comma in between in the 'Parameters to be Summarized' widget. For example if you want to summarize two columns namely age and purpose, you can write this: age,purpose. Aggregated tables and plots will be generated for these columns in the pdf report."),
                      p(style="text-align: justify;font-size:18px;",
                        "An option to draw a plot between Distance and Time was provided. If you select that option then you need to have columns  with names 'distance' and 'time'(in hrs by default) in the survey data."),
                      p(style="text-align: justify;font-size:18px;",
                        "After filling all the input data, click on 'Create Report and OD Matrix'. A message will be displayed once the processing is done. After that you can donwload the OD matrix and PDF report in the given formats."),
                      markdown("For any queries or suggestions, you can reach out me on Linkedin [here](https://www.linkedin.com/in/pamidiashok/) or at ashokpamidi07@gmail.com.
                               You can find the scripts and sample data [here](https://github.com/ashokpamidi/).")
                      )
             )
             ),
      column(width = 2)
    ),
    tabPanel(title = "OD Summary",
      column(width = 2),
      column(width = 8,
             h3("Summarizing OD Survey Data"),
             fluidRow(
               column(width = 3,
                      fileInput(inputId = "input_file", label = "Upload Excel File", width = "100%")),
               column(width = 3,
                      textInput(inputId = "od_sheetname", label = "Sheet with OD data", width = "100%")),
               column(width = 3,
                      textInput(inputId = "zones_sheetname", label = "Sheet with zone ids", width = "100%")),
               column(width = 3,
                      br(),
                      checkboxInput(inputId = "dvt_plot", label = "Draw Distance vs Time"))
             ),
             
             fluidRow(
               column(width = 2,
                      h4("Author Name")),
               column(width = 4,
                      textInput(inputId = "author_name", label = NULL, width = "100%")),
               column(width = 2,
                      h4("Report Title")),
               column(width = 4,
                      textInput(inputId = "report_title", label = NULL, width = "100%"))
             ),
             
             fluidRow(
               column(width = 4,
                      h4("Parameters to be summarised:")),
               column(width = 8,
                      textInput(inputId = "para_string", label = NULL, placeholder = "Type column names with a comma in between", 
                                width = "100%"))
             ),
             
             fluidRow(
               column(width = 12, align = "center",
                      actionButton(inputId = "create_od_report", label = strong("Create Report and OD matrix"),
                                   style = "color: #fff; background-color: green; border-color: #2e6da4"))
             ),
             br(),
             
             fluidRow(
               column(width = 12, align = "center",
                      uiOutput(outputId = "msg"))
             ),
             
             fluidRow(
               column(width = 2,
                      selectInput(inputId = "od_file_type", label = NULL,
                                  choices = list("xlsx", "csv"),selected = "xlsx", width = "100%")),
               column(width = 4,
                      downloadButton(outputId = "od_matrix", label = strong("Download OD Matrix"),
                                     style = "width:100%; color: #fff; background-color: #337ab7; border-color: #2e6da4")),
               column(width = 2,
                      selectInput(inputId = "report_file_type", label = NULL,
                                  choices = c("pdf", "html"), selected = "pdf", width = "100%")),
               column(width = 4,
                      downloadButton(outputId = "report", label = strong("Download Summary Report"),
                                     style = "width:100%; color: #fff; background-color: #337ab7; border-color: #2e6da4"))
             )
          ),
      column(width = 2)
  )
)))