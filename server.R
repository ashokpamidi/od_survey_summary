library(shiny)
library(readxl)
library(shinyjs)

shinyServer(function(input, output, session) {
  global_var <- reactiveValues(od_mat = NULL)
  
  observeEvent(input$create_od_report, {
    
    disable("report")
    p <- input$input_file
    
    df <- read_xlsx(p$datapath, sheet = input$od_sheetname)
    zones_df <- read_xlsx(p$datapath, sheet = input$zones_sheetname)
    zone_codes <- zones_df %>% 
      pull(zone_id) %>% 
      as.character()
    
    global_var$od_mat <- od_to_mat(df = df, zone_codes = zone_codes)
    
    l <- as.list(strsplit(input$para_string, ","))[[1]]
    
    rmarkdown::render(
      input = "markdown_template.Rmd",
      output_format = paste0(input$report_file_type,"_document"),
      params = list(
        name = input$author_name,
        report_title = input$report_title,
        survey_data = df,
        para_list = l,
        draw_dt_plot = input$dvt_plot
      )
    )
    
    enable("report")
    
    output$msg <- renderUI(
      h3("OD matrix and Summary report are generated.")
    )
  })
  
  
  #downloading od summary report ----
  output$report <- downloadHandler(
    
    filename = function() {
      paste("report", input$report_file_type, sep = ".")
    },
    
    content = function(file) {
      generated_file_name <- paste("markdown_template", input$report_file_type, 
                                   sep = ".")
      file.copy(generated_file_name, file)
    }
  )
  
  #downloading od mat ----
  output$od_matrix <- downloadHandler(
    filename = function() {
      paste("od_matrix", input$od_file_type, sep = ".")
    },
    
    content = function(file) {
      d <- as_tibble(global_var$od_mat)
      d <- data.frame("od" = names(d), d)
      if(input$od_file_type == "xlsx"){
        write_xlsx(d, file)
      } else{
        write_csv(d, file)
      }
      
    }
  )
  
  #displaying sample data ----
  output$od_sample_df <- renderTable({
    data.frame(
      "sample_id" = c(1,2),
      "origin" = c("c","a"),
      "destination" = c("a","b"),
      "age" = c("<20","31-40"),
      "purpose" = c("Business", "Leisure")
    )
  }, digits = 0)
  
  
})