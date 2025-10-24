#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [#set text(size: 16pt)  // smaller than default ~18pt
    Predictive Risk Modeling for Safety Interventions in Transportation Networks Using Spatial Crime History
  ],
  abstract: 
  [ Integrating personal safety into transportation and pedestrian planning requires systematic use of crime data. Information on crime location, time, and type can be analyzed to identify unsafe streets, intersections, and transit hubs, uncovering vulnerable areas in the urban network. Such insights enable engineers to propose design interventions such as reducing dead-end streets, improving pedestrian connectivity, and strategically relocating public transit drop-off points to enhance safety.

In this study, raw crime record data will be transformed into actionable hotspot maps and predictive risk models to optimize the allocation of traffic police and patrol routes, ensuring coverage in the areas of highest need. Using advanced machine learning techniques, the study predicts crime types based on factors such as location, time of day, victim profile, and premises description. These results provide Civil Engineers and Urban Planners with evidence-based tools to prioritize infrastructure improvements and safety investments, while also identifying specific locations likely to evolve into future hotspots for proactive deployment of patrols, surveillance, and safety infrastructure.

Together, these predictive and spatial approaches are expected to enhance response efficiency and guide long-term city planning initiatives—from upgrading street lighting and redesigning public spaces to improving transit accessibility and targeting community resources—thereby strengthening the overall resilience and safety of urban infrastructure.

  ],
  authors: (
    (
      name: "Nazmus Sakib Pallab",
      department: [Civil & Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "npallab2@illinois.edu",
    ),
    (
      name: "Jiarui Yu",
      department: [Civil & Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "jiaruiy9@illinois.edu",
    ),
    (
      name: "Favour Jack",
      department: [Civil & Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "frjack2@illinois.edu", 
    ),
    (
      name: "Muhammad Fahad Ali",
      department: [Civil & Environmental Engineering],
      organization: [University of Illinois Urbana-Champaign],
      location: [Urbana, IL, USA],
      email: "mali19@illinois.edu",
    ),
  ),
  index-terms: ("Transportation safety","Crime data analysis","Predictive risk modeling", "Hotspot mapping","Machine learning","Urban infrastructure planning", "Pedestrian safety"),
  bibliography: bibliography("refs.bib"),
)

= Description of Dataset
    The dataset used for this project is the #strong[#emph[ “Crime Data from 2020 to Present”]] dataset for the City of Los Angeles, which is publicly available on DATA.GOV @lapd_crime2020. It is maintained and released by the Los Angeles Police Department (LAPD) as part of the city’s open-data initiative, based on official crime reports filed by law enforcement officers.

    The dataset is provided in CSV format and contains over 1 million rows of crime incidents. The full dataset consists of 28 columns, while our project will focus on the following 12 key attributes:

    - `DR_NO (Text)`: Division of Records Number: Official file number made up of a 2 digit year, area ID, and 5 digits.
    - `Date Rptd (Floating and Timestamp)`: Date the incident was reported.
    - `DATE OCC (Floating and Timestamp)`: Date the incident occurred.  
    - `TIME OCC (Text)`: Time the incident occurred.
    - `AREA (Text)`: Area where the incident occurred.
    - `AREA NAME (Text)`: ID of the area where the incident occurred.
    - `Rpt Dist No (Text)`: A four-digit code that represents a sub-area within a Geographic Area.
    - `Vict Age (Text)`: Age of the victim.
    - `Vict Sex (Text)`: Sex of the victim.
    - `Vict Descent (Text)`: Descent odf the victim.
    - `LAT (Number)`: Latitude coordinate of the incident.
    - `LON (Number)`: Longitude coordinate of the incident.

    This dataset provides both spatial (latitude/longitude, area, district) and socio-demographic (victim age, sex, descent) attributes, along with temporal information (date and time of crime occurrence), enabling spatial, temporal, and predictive risk modeling for transportation safety interventions.

    = Exploratory Data Analysis (EDA) 
   a. Crime Type Distribution
   #image("figures/N_of_Crime_vs_Type.png")
    Group and rank by "Crm Cd Desc".
    Plot 1: bar chart of top 10 crime types.
    Insight: most frequent vs. least frequent   crimes. (Favour Jack)

    Check if image loads properly.

   b. Temporal Patterns



   c. Spatial Patterns


   d. Victim and Incident Attributes





   4. Correlations and Relationships





   5. Implications for Police Station Planning

    Summarize the evidence:

    Which areas have high and persistent crime density?

    Which times need more coverage (e.g., night hours)?

    Support with map + table of “Top 5 areas by crime density and trend”.


   

    = Predicitive Modeling 
  

= Exploratory Data Analysis
=== Temporal Reporting Pattern

The distribution of reporting delays (Date Rptd − DATE OCC) is strongly right-skewed. Most incidents are reported on or shortly after the occurrence date:
- *Mean delay*: **2.96 days**
- *Median delay*: **1 day**
- ~90% of reports occur within **five days** of the incident

This pattern suggests generally prompt reporting with a long tail of delayed reports, which may reflect discovery lag (e.g., fraud/identity crimes) or administrative delays.

#figure(
  image("figures/Delay_distribution.png", width: 100%),
  caption: [Delay distribution of reported incidents (2020–2024).],
)

=== Hourly–Weekly Temporal Pattern

Incident frequency follows a pronounced diurnal cycle. Activity is lowest between **03:00–06:00**, rises rapidly after 08:00, and remains elevated through the late afternoon and evening. Fridays and weekends show the highest intensities, consistent with nightlife and leisure travel.

#figure(
  image("figures/Hourly_incident_frequency.png", width: 100%),
  caption: [Hourly heatmap of incident frequency by day of week.],
)

=== Spatial Distribution and Peak Months

Spatial clusters are stable across years and concentrate in Downtown, Hollywood, Westlake, and South LA. The six panels below show representative peak months for each year; the scatter lies almost entirely within the official city boundary, confirming geospatial integrity.

#figure(
  image("figures/Incident_peaks_with_boundary.png", width: 100%),
  caption: [Incident locations during peak months overlaid with the LA city boundary.],
)

=== Crime Category Distribution

Using the generalized crime buckets, **motor-vehicle/bike theft** consistently ranks first (≈30–32k per year), followed by **simple assault**, **personal/retail theft**, and **vandalism**. **Aggravated assault** and **theft from vehicle** comprise the next tier. The dominance of property crimes is stable from 2020–2024, with a modest post-pandemic rise and a slight dip in 2024 (which may partially reflect reporting lag).

#figure(
  image("figures/Temporal_Trend_of_Top_Crime.png", width: 100%),
  caption: [Top-10 crime buckets by year (2020–2024).],
)

=== Summary Statistics

#table(
  columns: 2,
  inset: 6pt,
  stroke: 0.5pt + luma(90%),
  align: horizon,
  [
    *Metric*      , *Value*;
    Total incidents (2020–2024), ~1,004,991;
    Avg monthly incidents       , ≈ 20k–23k;
    Distinct crime descriptions , ≈ 140;
    Generalized crime buckets   , 37;
    Mean reporting delay        , 2.96 days;
    Median reporting delay      , 1 day;
    Spatial coverage            , City of Los Angeles (LAT/LON);
  ],
)

== Characterization Summary

- High-fidelity **spatio-temporal** records (daily/hourly timestamps; point coordinates within city boundary).
- Broad **crime diversity** (≈140 descriptions collapsed to 37 buckets) with a clear **property-crime skew**.
- Stable **hotspots** over time → suitable for hotspot prediction and deployment planning.
- Predictable **daily/weekly seasonality** → supports patrol scheduling and risk-aware resource allocation.
Markdown version
markdown
Copy code
## Temporal Reporting Pattern

The distribution of reporting delays (Date Rptd − DATE OCC) is strongly right-skewed. Most incidents are reported on or shortly after the occurrence date:

- **Mean delay:** 2.96 days  
- **Median delay:** 1 day  
- ~90% of reports occur within **five days** of the incident

This suggests generally prompt reporting with a long tail of delayed reports (e.g., fraud/identity crimes).

![Delay distribution](figures/Delay_distribution.png)

---

## Hourly–Weekly Temporal Pattern

Incident frequency shows a clear diurnal cycle: lowest at **03:00–06:00**, rising after 08:00, and staying elevated through the late afternoon/evening. **Fridays** and **weekends** are the most active, consistent with nightlife and leisure travel.

![Hourly heatmap](figures/Hourly_incident_frequency.png)

---

## Spatial Distribution and Peak Months

Stable clusters appear in **Downtown**, **Hollywood**, **Westlake**, and **South LA** across years. The six panels show peak months per year; points lie within the official boundary, confirming geospatial integrity.

![Peak months with boundary](figures/Incident_peaks_with_boundary.png)

---

## Crime Category Distribution

Using generalized buckets, **motor-vehicle/bike theft** ranks #1 (≈30–32k/year), followed by **simple assault**, **personal/retail theft**, **vandalism**, **aggravated assault**, and **theft from vehicle**. Property crime dominates 2020–2024, with a modest post-pandemic rise and a small 2024 dip (possible reporting lag).

![Top 10 buckets](figures/Temporal_Trend_of_Top_Crime.png)

---

## Summary Statistics

| Metric                       | Value            |
|-----------------------------|------------------|
| Total incidents (2020–2024) | ~1,004,991       |
| Avg monthly incidents       | ≈ 20k–23k        |
| Distinct crime descriptions | ≈ 140            |
| Generalized crime buckets   | 37               |
| Mean reporting delay        | 2.96 days        |
| Median reporting delay      | 1 day            |
| Spatial coverage            | City of Los Angeles (LAT/LON) |

---

## Characterization Summary

- High-fidelity **spatio-temporal** data (daily/hourly timestamps; precise coordinates within boundary).  
- **Property-crime skew**; 140 detailed codes collapsed to 37 readable buckets.  
- Persistent **hotspots**, enabling hotspot prediction and strategic deployments.  
- Strong **daily/weekly seasonality**, useful for staffing and patrol scheduling.

== Crime Type Patterns

== Temporal Patterns of Crime 

== Spatial Distribution of Crime

== Demographic Patterns of Crime Victims
For the whole dataset, we first analyzed the demographic distribution of crime victims based on age, sex, and descent. The victims are consists of 40.19% male, 35.68% female, and with 24.13% unknown or missing data.





= Predictive Modeling