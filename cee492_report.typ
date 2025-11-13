#import "@preview/charged-ieee:0.1.4": ieee
#import "report_format.typ": *

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
#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()
#linebreak()

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
  - `Vict Descent (Text)`: Descent of the victim.
    - `LAT (Number)`: Latitude coordinate of the incident.
    - `LON (Number)`: Longitude coordinate of the incident.

    This dataset provides both spatial (latitude/longitude, area, district) and socio-demographic (victim age, sex, descent) attributes, along with temporal information (date and time of crime occurrence), enabling spatial, temporal, and predictive risk modeling for transportation safety interventions.


= Exploratory Data Analysis (EDA) 
 == *Crime Type Distribution*
The #ref(<fig-crime-hist>) ranks the most common crimes reported across Los Angeles between 2020 and the present.

Vehicle-related crimes (particularly Vehicle Stolen, Burglary from Vehicle, and Theft from Motor Vehicle) dominate the dataset, together accounting for nearly half of all recorded incidents. These are followed by Battery – Simple Assault and Identity Theft, highlighting both property security and personal safety as key urban vulnerabilities. 

To identify which areas experience the highest concentration of specific crimes, we generated a heatmap showing the top ten most frequent crime types across all police districts. Each cell represents the number of incidents for a given crime type within an area.

The heatmap reveals that crime intensity is not evenly distributed across the city. Property-related crimes such as Theft, Burglary from Vehicle, and Motor Vehicle Theft dominate the overall dataset but are heavily concentrated in a few areas—particularly Central, 77th Street, and Newton divisions. Conversely, violent offenses like Assault with a Deadly Weapon and Robbery cluster around Southeast and Southwest areas, indicating localized vulnerability.

The color gradients in the heatmap highlight that these high-frequency zones consistently report a wider mix of offenses than low-crime areas, suggesting persistent multi-type crime exposure. This uneven distribution underscores the importance of strategic resource allocation, as new or expanded police stations in these hotspots could improve response times and deter repeated offenses.
These findings, combined with temporal and demographic analyses in later sections, provide quantitative evidence for prioritizing areas that face both high crime density and crime diversity, strengthening the case for targeted infrastructure and patrol expansion.


  #figure(
    image("figures/top_hist.JPG"),
    caption: [Top 10 Crime Types in Los Angeles (2020–2024).],
  ) <fig-crime-hist>
  
   #figure(
    image("figures/topcrime.JPG"),
    caption: [Top 10 Crime Types in Los Angeles vs. Areas],
  ) <fig-crime-type>
  
   

== *Temporal Analysis*

==== (i) Temporal Patterns of Different Crime Categories

The temporal profile of generalized crime categories reveals that **motor vehicle and bicycle theft** consistently rank as the most frequent crime types, averaging **30,000–32,000** cases per year. These are followed by **simple assault**, **personal or retail theft**, and **vandalism**, which collectively account for a substantial share of the total crime volume.  
**Aggravated assault** and **theft from vehicle** form the next major tier, reflecting a stable yet diversified pattern of property and personal crimes. While total incident counts remained relatively stable from **2020–2023**, a modest uptick was observed in 2022–2023, coinciding with post-pandemic normalization of urban activity. A slight decline in 2024 may partially reflect data latency or reporting lag rather than an actual reduction in crime rates.

#figure(
  image("figures/Temporal_Trend_of_Top_Crime.png", width: 100%),
  caption: [Top ten generalized crime categories by year (2020–2024).],
)

==== (ii) Incident Frequency Heatmap

Incident frequency exhibits a strong diurnal and weekly rhythm, consistent with human activity cycles in an urban environment. As shown in the hourly heatmap, the lowest activity occurs during the early morning hours (**03:00–06:00**), followed by a sharp increase after **08:00** that persists throughout the day.  
Evening hours remain active, peaking around typical commuting and social periods, and the highest overall frequencies are observed on **Fridays and weekends**. This pattern aligns with nightlife, leisure, and mobility trends, highlighting the influence of temporal human behavior on incident dynamics.

#figure(
  image("figures/Hourly_incident_frequency.png", width: 100%),
  caption: [Hourly heatmap showing diurnal and weekly variations in incident frequency.],
)

==== (iii) Reporting Delay Distribution 

The analysis of reporting delay is defined as the difference between the date reported and the date of occurrence (Date Rptd − DATE OCC) — reveals a pronounced right-skewed distribution. Most incidents are reported either on the same day or within a few days of occurrence, with a mean delay of **2.96 days** and a median delay of **1 day**. Approximately **90%** of all incidents are reported within **five days**, indicating generally prompt reporting behavior across most crime categories.  
The long upper tail in the delay distribution likely reflects crimes with delayed discovery or complex administrative workflows, such as fraud, forgery, or identity-theft–related offenses. This temporal asymmetry underscores the importance of considering both immediate and delayed reporting in operational planning and predictive modeling.

#figure(
  image("figures/Delay_distribution.png", width: 100%),
  caption: [Distribution of reporting delays (All recorded incidents, 2020–2024).],
)

#linebreak()

==== (iv) Spatial Distribution and Temporal Stability

Spatially, incident clusters remain highly consistent across the five-year period, concentrating in **Downtown**, **Hollywood**, **Westlake**, and **South Los Angeles**. These areas exhibit persistent activity regardless of month or year, suggesting enduring socioeconomic and infrastructural factors driving higher incident density.  
The six representative panels display the months of peak activity for each year between 2020 and 2024. The scatter of points lies almost entirely within the official **Los Angeles city boundary**, confirming the spatial integrity and proper geocoding of the dataset. Such spatial persistence provides a reliable foundation for hotspot-based predictive modeling and targeted resource deployment.

#figure(
  image("figures/Incident_peaks_with_boundary.png", width: 100%),
  caption: [Annual Peak Months of Incident Distributions (2020–2024)],
)










== *Spatial Analysis*

Another important aspect of our exploratory data analysis is the spatial distribution of crimes across Los Angeles. By mapping the latitude–longitude of each incident, we visualize hotspots and identify areas with high crime density.

We work with three spatial datasets: the set of crime points $C = \{C_i\}_{i=1}^{N_c}$, the set of street-lamp points $L = \{L_l\}_{l=1}^{N_l}$, and the city-boundary polygon $B$. We ensure longitudes and latitudes are numeric, finite, and within plausible ranges so that subsequent geometry remains meaningful. The street-light dataset is sourced from the City of Los Angeles GeoHub @la_geohub_streetlights.


#figure(
  image("/figures/Spatial_figures/top500crimefreq.png", width: 100%),
  caption: [Top 500 crime count in each designated LAPD district.],
)<fig:la-top500>

Figure @fig:la-top500 ranks Los Angeles (city) LAPD reporting districts by
total reported incidents (2020–present). The x-axis lists districts in
descending order (leftmost = highest), and the y-axis shows incident counts.
The distribution is heavy-tailed: a few districts concentrate many incidents,
followed by a long tail of moderate activity.

#figure(
  image("/figures/Spatial_figures/top500crimefreq_ranked.png", width: 100%),
  caption: [LA top-500 crime counts (ranked).],
)<fig:la-top500-ranked>

Figure @fig:la-top500-ranked shows the top 500 LAPD reporting districts
sorted by total incidents, with the x-axis as rank (left = highest).
The y-axis is the incident count. The curve is heavy-tailed: a few
districts account for many incidents, followed by a long taper of
moderate counts across the remaining ranked districts.

#figure(
  image("/figures/Spatial_figures/La_Slights.png", width: 100%),
  caption: [LA street lights within the city boundary (n=221,897).]
)<fig:lights>

This map @fig:lights plots the reported street-light point locations for Los Angeles in geographic
coordinates (longitude/latitude). The high point density makes many neighborhoods appear
as solid filled regions, revealing broad coverage across the city and sparser coverage
near edges and open spaces. Axes are in degrees to match the source data.

=== Finding relationship between crime locations and street lights

We project all coordinates into a single metric CRS so distances are measured in meters:

$((x_i, y_i) = Φ(λ_i, φ_i), space (u_l, v_l) = Φ(λ'_l, φ'_l))$

*where:*
- $(λ_i,φ_i)$ and $(λ'_l,φ'_l)$ are geographic (lon/lat, degrees) for crime $C_i$ and lamp $L_l$,
- Φ denotes the projection to a local metric CRS,
- $(x_i,y_i)$ and $(u_l,v_l)$ are projected (planar) coordinates in meters.

A local projected CRS is used because Euclidean lengths in degrees are not physically meaningful, and a single metric CRS avoids unit mismatches.

We restrict the analysis to the jurisdiction by clipping points to the city polygon $B$, keeping only crimes and lamps whose projected coordinates fall inside $B$. This removes out-of-area points and reduces boundary artifacts that would otherwise inflate nearest-distance values.

We define planar Euclidean distance between a crime and a lamp:
$ 
d(C_i, L_l) = sqrt((x_i - u_l)^2 + (y_i - v_l)^2)
$

For each crime, we keep its nearest-lamp distance:
$d_i = \min_{1 \le l \le N_l} d(C_i, L_l), \qquad i=1,...,n,$
where $n$ is the number of crimes inside $B$. This yields a single, interpretable proximity value per incident. A spatial index keeps these queries fast.

From $\{d_i\}_{i=1}^n$ we build the empirical cumulative distribution function (ECDF):
$F(r) = frac(1,n) sum_(i=1)^n bold(1){d_i <= r}, quad r >= 0,$
so the coverage at an operational radius $R$ is simply:
$"Coverage"(R) = F(R).$

We report robust summaries of proximity (median) and tail behavior (p90, p99) along with the maximum distance. Quantiles are preferred over the mean because the distribution is typically right-skewed and outlier-sensitive.

To guard against faulty records, we flag implausible distances above a conservative cap and, if needed, compute robust z-scores using the median and MAD to identify unusual $d_i$ values.

Finally, to see how coverage accumulates with distance, we partition $r$ into analyst-chosen bands (e.g., $0$–$50$–$100$–$250$ m, …) and tabulate the share of crimes whose nearest-lamp distance falls into each band. This “coverage by band” view highlights where most gains occur (very small radii) and where diminishing returns set in as the radius grows.

// Figure with short caption
// #figure(
//   image("/figures/Spatial_figures/Crime_nearest.svg", width: 100%),
//   caption: [Crime → nearest light distance (≤ p99), LA. ],
// )<fig:crime-nearest>

// Separate explanation paragraph (Typst)
// Figure @fig:crime-nearest shows a histogram of distances (meters) from each
// crime point to its nearest street light, limited to the 99th percentile to
// avoid outliers. Most crimes fall very close to a light (left-heavy bar mass),
// and the frequency declines rapidly with distance. The vertical orange line
// marks the chosen radius R used later as a working cutoff for proximity.

@tab:la-dist-summary-typed summarizes the distance from each reported
crime in Los Angeles to its nearest street light. It shows total valid
records, distribution percentiles (p25–p99), the maximum, and how many / what
share fall within the working radius *R = 100 m*. Most crimes are close to a
light, with a long right tail driven by a small set of far-out points. More such comparison will be carried out based upon availability of the data. 




== *Demographic Anlysis*
Besides analyzing crime types and its patterns over time and space, exmining the demographic characteristics of crime victims might provide some useful sights.
We analyzed age, sex, and descent compositions of victims. Overall, the victim population is 40.19% male, 35.68% female, and 24.13% unknown or missing. The age distribution of victims is shown in #ref(<fig-age>). It shows that the age group of 30-34 has the highest number of victims, followed by the age group of 25-29. The descent distribution of victims is shown in #ref(<fig-descent>). It shows that the major victim descent groups are Hispanic/Latin/Mexican, White, and Black, with the percentages of 34.45%, 23.41%, and 15.79%, respectively.

 #figure(
  image("figures/victim_age_hist.png"),
  caption: [Age Distribution of Crime Victims]
) <fig-age>

#figure(
  image("figures/victim_descent_hist.png"),
  caption: [Descent Distribution of Crime Victims]
) <fig-descent>

To see the correlation between age and descent, we created a heatmap shown in #ref(<fig-age-descent>). The pattern of age among all descent groups is similar, with the age group of 25-34 having the highest number of victims across all descent groups.

  #figure(
    image("figures/age_descent_heatmap.png"),
    caption: [Heatmap of Victim Age vs. Descent]
  ) <fig-age-descent>

  == *Summary Statistics of Dataset*

#figure(
  table(
   columns: (auto, auto),
    table.header([*Metric*], [*Value*]),

    "Total records (2020–2024)", "≈ 1,004,991 incidents",
    "Average monthly incidents", "≈ 20,000–23,000",
    "Distinct crime types", "≈ 140",
   "Generalized crime types", "37 aggregated categories",
    "Earliest date of Dataset", "2020-01-01",
    "Latest date of Dataset", "2024-03-31",
    "Mean Hotspot for Crime 
    (lat / lon)", "34.05 / −118.32
    (≈ Downtown LA)",
    "Mean reporting delay after 
    incident", "2.96 days (mean), 
    1 day (median)",
    "Victim Sex Composition", "40.19% male, 35.68% female",
    "Largest Victim Age Group", "30–34 years",
    "Top Victim Descent", "Hispanic/Latin/Mexican"
  ), caption: [Overview of key statistics of Crime Data from 2020 to 2024],
)<tab:dataset-summary-typed>

#figure(
  table(
    columns: 2,  // Two columns
    align: (left, right),
    inset: 6pt,
    stroke: 0.5pt + gray,
    
    [*Metric*], [*Value*],
    [N (valid)], [1,004,996],
    [min (m)], [0.0852],
    [mean (m)], [25,702.8],
    [std (m)], [5.43e3],
    [p25 (m)], [10.8821],
    [median (m)], [14.2868],
    [p75 (m)], [20.8421],
    [p90 (m)], [81.4454],
    [p95 (m)], [152.942],
    [p99 (m)], [342.602],
    [max (m)], [1.15167e7],
    [≤R (count)], [922,403],
    [≤R (%)], [91.7822],
  ),
  caption: [LA distance-to-light summary.],
) <tab:la-dist-summary-typed>

  = Predictive Modeling

  The plan for the modeling will be:
  1. Dig into correlations between all features and introduce some new variables if necessary.
  2. Come up with a suitable formulation (i.e. decide the structure of the model equation to calculate the number of crimes.)
  3. Apply the machine learning scheme we learned in class to train the model and validate it.
== *Crime Type Prediction with Decision Tree Method*
=== Crime Type Prediction with Demographic Features
We first examined the relationship between demographic features of victims and the crime types happened on them. The characteristics of victims includes age, gender, and descent. After extracted necessary data from the original dataset, we set victim age, victim gender, and victim descent as features, and crime type as labels to train a decision tree classifier model. After organizing and encode data, the gender feature includes male and female; the age feature includes 9 age groups; the descent feature keeps the original categories; and the crime type includes top 20 types. 80% of the data was used for training and the remaining 20% was used for testing. After apply the standard decision tree classifier from DecisionTree.jl package, the accuracy of the model on the test data is 16.14%, which indicates low correlation between demographic features and crime types. Besides, only two features were used as features in the model in pairs (i.e. age and gender; age and descent; gender and descent), the accuracy of the model are 12.48%, 15.06%, and 13.45%, respectively. The results shows that either the decision tree method is not suitable for predicting crime types, or the demographic features of victims are not strongly related to the crime types happened on them.

\
\

== *Temporal–Spatial Crime Hotspot Prediction Model*

Motivated by urban safety and resource allocation in Los Angeles, we focused on the following predictive question: \
\


_Can we predict which spatial crime hotspot an incident will occur in using time of occurrence (hour of day, day of week, and month)?_\
\


This question is very important from a civil and environmental engineering perspective because police, EMS, and traffic management agencies often require time-of-day deployment strategies without knowing the exact location of future incidents. If reliable temporal–spatial patterns exist, agencies could proactively position resources within a select number of hotspot regions during specific time windows. \
\
==== i.  *Spatial Clustering of Crime Locations (Unsupervised)*

To forecast crime hotspots in Los Angeles, we developed a predictive modeling framework that integrates unsupervised spatial clustering with supervised softmax classification. The objective is to predict which hotspot (cluster) is most likely to experience crime under specific temporal and categorical conditions such as month, day of week, hour, crime category, and LAPD geographic area.

We applied k-means clustering to three years of historical crime data (2020–2022) using only geographic coordinates (latitude and longitude). After experimentation, we selected `K = 8` clusters, which produced meaningful and well-distributed hotspot regions across Los Angeles.

For crimes occurring in the test years (2023–2024), each incident was assigned to the nearest cluster centroid using Euclidean distance. This ensures generalization and avoids information leakage, since test points were never used to form the clusters.

This stage is fully unsupervised because the hotspot labels emerge solely from underlying spatial density patterns.\
\
==== ii. *Predicting Hotspot (Supervised)*

After generating cluster IDs, I treated them as labels for a supervised classifier. The following predictive features were used:

- hour of day  
- day of week  
- month  
- type of crime
- LAPD reporting area  

Numeric features were normalized, and categorical features were consistently encoded using training-set levels.  
A softmax neural network classifier was trained using cross-entropy loss and gradient descent, with accuracy and loss tracked across iterations.\
\
==== iii. *Evaluation and Performance*

The dataset was split chronologically:
- **Training:** 2020–2022  
- **Testing:** 2023–2024  

Model performance:
- **Training accuracy:** ~87%  
- **Test accuracy:** ~88%  
- **Cross-entropy loss:** steadily decreased and stabilized  
#figure(
  image("figures/Accurancy.png"),
  caption: [Training and testing accuracy over gradient steps.)]
) <fig-accurancy>
Compared to the baseline accuracy of 1/8 = 12.5% (random guessing), the classifier shows strong predictive capability. Learning curves indicate stable convergence with no signs of overfitting.

#figure(
  image("figures/Loss.png"),
  caption: [Cross-entropy loss during training]
) <fig-cross>

We also observed loss decreases sharply during the first ~300 gradient updates, indicating rapid learning of the major temporal–spatial decision boundaries from the training data. After this initial phase, the loss continues to decline more slowly and eventually stabilizes around 0.32, demonstrating smooth and monotonic convergence without instability or oscillation. This behavior confirms that the learning rate and optimization setup are well-chosen, and that the model successfully minimizes classification error as it adapts to the training patterns. The absence of sudden spikes further suggests that the model is not overfitting to rare or noisy samples.\
\
==== iv. *Hotspot Visualization*
To improve interpretability, I generated multiple geographic visualizations that overlay model predictions on the official Los Angeles boundary shapefile. These figures demonstrate how predicted hotspot regions shift depending on the temporal query.

#figure(
  image("figures/Pred_1.png"),
  caption: [Spatial distribution of predicted crime hotspots for a sample temporal query (Wednesday, November, 12:00 ±2h)]
) <fig-pred-1>

#figure(
  image("figures/Pred_2.png"),
  caption: [Spatial distribution of predicted crime hotspots for a sample temporal query (Friday, July, 20:00 ±1h)]
) <fig-pred-2>

For each user-defined query (e.g., “Fridays in July at 20:00 ± 1 hour” or “Wednesdays in November at 12:00 ± 2 hours”), the visualizations display:

- historical crime points within the specified temporal window (gray)  
- the LA city boundary outline  
- the model’s top predicted hotspot centroids (magenta points)  
- approximately 1-mile radius highlight zones around each centroid (magenta circles)  

The first visualization corresponds to **Friday in July around 20:00 (±1 hour)** and shows multiple active hotspots distributed across central and southern Los Angeles.

The second visualization corresponds to **Wednesday in November around 12:00 (±2 hours)** and reveals a different spatial pattern with fewer but more concentrated predicted hotspots.

Together, these visualizations illustrate how the model adapts hotspot predictions to specific time-of-day and seasonal contexts, providing interpretable, actionable spatial insights for operational decision-making.\
\

==== v. *Future Works*

Future improvements may include incorporating additional features such as weather, special events, socioeconomic indicators, or crime-type interactions. Alternative clustering approaches (e.g., DBSCAN, Gaussian Mixture Models) could capture more flexible hotspot shapes. In the supervised stage, deeper neural networks or ensemble models may further enhance accuracy. Deploying this framework as an interactive real-time tool would expand its usefulness for operational planning and situational awareness.
