library(shiny)
library(shinythemes)
library(plotly)

# local authority drop-down menu values
local_authorities =sort(c("Sefton", "Wigan", "Rotherham", "Westminster", "Stoke-on-Trent", "South Gloucestershire", "Tameside", "Peterborough", "Lewisham", "Richmond upon Thames", "Medway", "Oldham", "Slough", "East Riding of Yorkshire", "Barnet", "Sandwell", "Camden", "Derby", "Windsor and Maidenhead", "Sunderland", "Portsmouth", "Herefordshire, County of", "Kirklees", "Cheshire West and Chester", "Wiltshire", "Walsall", "Blackpool", "Hammersmith and Fulham", "Hartlepool", "Bournemouth, Christchurch and Poole", "Darlington", "Hillingdon", "Blackburn with Darwen", "Wolverhampton", "Bedford", "Shropshire", "Leeds", "Havering", "Stockton-on-Tees", "Dorset", "Hackney", "York", "Bromley", "Cheshire East", "Solihull", "Barking and Dagenham", "Kingston upon Hull, City of", "Nottingham", "Southampton", "Newcastle upon Tyne", "Birmingham", "Wokingham", "Thurrock", "Redbridge", "Lambeth", "Swindon", "Trafford", "Bolton", "Reading", "Rochdale", "Knowsley", "Wirral", "North Somerset", "Telford and Wrekin", "Wandsworth", "Sheffield", "Stockport", "Southwark", "Manchester", "Kensington and Chelsea", "Luton", "Bracknell Forest", "Merton", "Bath and North East Somerset", "Tower Hamlets", "Plymouth", "Doncaster", "St. Helens", "Middlesbrough", "Enfield", "Haringey", "Halton", "Gateshead", "Calderdale", "Northumberland", "Hounslow", "Dudley", "Brighton and Hove", "County Durham", "South Tyneside", "Croydon", "North East Lincolnshire", "Leicester", "Bexley", "Ealing", "North Tyneside", "Isle of Wight", "Milton Keynes", "Coventry", "Brent", "Rutland", "North Lincolnshire", "Warrington", "Harrow", "Greenwich", "Redcar and Cleveland", "Islington", "Central Bedfordshire", "Bradford", "Wakefield", "Cornwall and Isles of Scilly", "Torbay", "Waltham Forest", "Bristol, City of", "Liverpool", "Barnsley", "Bury", "Sutton", "Salford", "Newham", "West Berkshire", "Southend-on-Sea", "Kingston upon Thames"))


shinyUI(fluidPage(theme = shinytheme("lumen"),
                  titlePanel("UK Local COVID-19 Tracker"),
                  sidebarLayout(
                      sidebarPanel(
                          #Select Local Authority
                          selectInput(inputId = "area", label = strong("Local Authority"),
                                      choices = local_authorities,
                                      selected = "Richmond upon Thames"
                          ),
                          
                          # Select date range to be plotted
                          dateRangeInput("date", strong("Date Range"), 
                                         start = "2020-03-01", end = "2020-08-20",
                                         min = "2020-03-01", max = "2020-08-20"
                            ),
#                                        start = "2020-03-01", end = "2020-08-20",
#                                        min = "2020-03-01", max = "2020-08-20"),
                      ),
                      
                      # Output: Description, lineplot, and reference
                      mainPanel(
                          tabsetPanel(
                              tabPanel("Plot", plotlyOutput(outputId = "lineplot", height = "300px")),
                              tabPanel("Documentation", 
                                       h3("About"),
                                       p("This app allows you to visualise daily COVID-19 cases per selected UK local authority."),
                                       h3("How to Use The App"),
                                       p("Select a local authority in the Local Authority drop-down menu. If you hover cursor over blue bars in the plot, you will be able to see daily new cases in on the selected day. Hovering the cursor over the over red line will show you 7 day rolling average.\nYou can restrict the date range using the Date Range selector on the left."),
                                       h3("Data Source:"),
                                       p("Guidotti, E., Ardia, D., (2020), \"COVID-19 Data Hub\", Journal of Open Source Software 5(51):2376, doi: 10.21105/joss.02376."),
          tags$a(href = "https://covid19datahub.io", "COVID19 Data Hub", target = "_blank")
                              )
                          )
                      )
                  )
            )
)