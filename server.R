library(COVID19) # source data
library(dplyr) # data transformation
library(shiny) # web app
library(plotly) # interactive plots
library(zoo) # calculates rolling mean

# Load data
#gb<-covid19(country="GB", level=3)
gb<-readRDS(file="covid_gb_level3_latest")

# create daily new cases counts and rolling average numbers
gb$daily.confirmed<-c(gb$confirmed[1],diff(gb$confirmed))
gb <- gb %>%
    group_by(id) %>%
    mutate (rolling.avg = round(rollmean(daily.confirmed,7, align="left", fill="extend"),1)) %>%
    mutate (rolling.cumsum=rollapply(daily.confirmed, 7, sum, align="left", fill="extend")) %>%
    ungroup() %>%
    arrange(id, date)

shinyServer(function(input, output) {

    # Subset data based on user's selection
    selected_area <- reactive({
        req(input$date)
        validate(need(!is.na(input$date[1]) & !is.na(input$date[2]), "Error: Please provide both a start and an end date."))
        validate(need(input$date[1] < input$date[2], "Error: Start date should be earlier than end date."))
        gb %>%
            filter(
                administrative_area_level_3 == input$area,
#                date > as.POSIXct(input$date[1]) & date < as.POSIXct(input$date[2]
                date > as.Date(input$date[1]) & date < as.Date(input$date[2]
                                                                                     ))
    })
    
    
    output$lineplot <- renderPlotly({
        fig <- plot_ly(selected_area(), 
                       x= ~date, 
                       y= ~daily.confirmed, 
                       type='bar', width=2, 
                       name ='Daily Cases') %>%   
            add_lines(y= ~rolling.avg, 
                      x= ~date, 
                      line=list(color="red"), 
                      name='Rolling 7dy Avg') %>%
            layout( xaxis = list(title = "Date"), 
                    yaxis = list(title = "Daily New Cases")  )
    })
    
})
