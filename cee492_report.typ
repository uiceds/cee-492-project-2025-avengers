#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [Infrastructure Planning under a Analysis of Crime Data in Los Angeles],
  abstract: [
  Integrating personal safety into transportation and pedestrian planning requires the systematic use of crime data. For example, information on crime location, time, and type can be analyzed to identify unsafe streets, intersections, and transit hubs, thereby uncovering vulnerable areas in the urban network. Such insights enable engineers to propose design interventions such as reducing dead-end streets, improving pedestrian connectivity, and strategically relocating public transit drop-off points to enhance safety and accessibility.

Therefore, as part of this study, raw crime record data will be transformed into actionable hotspot maps and predictive risk models that optimize the allocation of traffic police and patrol routes, ensuring coverage in the areas of highest need. Using advanced machine learning techniques, the study will predict crime types based on factors such as location, time of day, victim profile, and premises description. These results will provide Civil Engineers and Urban Planners with evidence-based tools to prioritize infrastructure improvements and safety-related investments. Moreover, the study will identify specific locations that are likely to evolve into future crime hotspots, supporting proactive deployment of patrols, surveillance systems, and security vehicles.

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
  index-terms: ("Optional", "Keywords", "Here"),
  bibliography: bibliography("refs.bib"),
)

= First Section

To add citations to the report, go to https://scholar.google.com, search for a paper, click on the quotation mark icon below the search result, and copy the BibTeX entry. Then paste it into the `refs.bib` file. You can cite papers using the `@` symbol followed by the citation key, e.g., @lowry1951protein.

Other options to get BibTeX entries for your references include https://www.bibtex.com/converters/ and asking ChatGPT to generate the a BibTeX entry for you. (If you use ChatGPT, make sure to verify the generated BibTeX entry for correctness.)


I am trying to commit lets see 

More information about citations can be found in the Typst documentation: https://typst.app/docs/reference/model/cite.

== First Subsection
Dataset description:
The dataset we will be analyzing is the "Crime Data from 2020 to Present" dataset in Los Angeles city, which is publicly available on DATA.GOV (link: https://catalog.data.gov/dataset/crime-data-from-2020-to-present). The dataset in a CSV file contains more than 1 million rows. For our project, we will reduce it to 100,000 rows due to laptop memory limitations. 
There are 28 columns in the dataset, and we will be using the following 12 columns for our analysis:
- `DR_NO`: Division of Records Number: Official file number made up of a 2 digit year, area ID, and 5 digits. The data type is Text.
- `Date Rptd`: Date the incident was reported. The data type is Floating and Timestamp.
- `DATE OCC`: Date the incident occurred. The data type is Floating and Timestamp.  
- `TIME OCC`: Time the incident occurred. The data type is Text.
- `AREA`: Area where the incident occurred. The data type is Text.
- `AREA NAME`: ID of the area where the incident occurred. The data type is Text.
- `Rpt Dist No`: A four-digit code that represents a sub-area within a Geographic Area.  The data type is Text.
- `Vict Age`: Age of the victim. The data type is Text.
- `Vict Sex`: Sex of the victim. The data type is Text.
- `Vict Descent`: Descent of the victim. The data type is Text.
- `LAT`: Latitude coordinate of the incident. The data type is Number.
- `LON`: Longitude coordinate of the incident. The data type is Number.




To add figures to your report, save the image file in the `figures` folder and use the `#figure` command as shown below to include it in your document. You can specify the width of the image and add a caption. Then you can reference the figure like this: @proofread.

#figure(
  image("figures/proof-read.png", width: 80%),
  caption: [A humble request. (Copyright: University of the Fraser Valley.)], 
) <proofread>

=== First Subsubsection

You can make sub, sub-sub, and sub-sub-sub sections by adding `=` signs in front of the section title. There needs to be a space between the last `=` sign and the title text.

= Second Section

You can add tables using the `#table` command. Here is an example table:

#figure(
  caption: [Example Table],
  table(
    columns: (auto, auto, auto),
    table.header([*Column 1*], [*Column 2*], [*Column 3*]),
    "Row 1", "Data 1", [Data 2],
    image("figures/proof-read.png", width: 40%), "Data 3", "Data 4",
  ),
) <table-example>

You can reference the table like this: @table-example.

== Various Text Formatting Options

You can make text _italic_ by surrounding it with `_` symbols, *bold* by surrounding it with `*` symbols, and _*bold italic*_ by combining both. You can also use `#code` to format inline code snippets.

You can create bullet point lists using `-` or `*` symbols:
- Bullet point 1
- Bullet point 2
  - Sub bullet point 1
  - Sub bullet point 2

jhjgh
You can create numbered lists using numbers followed by a period:
1. First item
2. Second item
  1. Sub item 1
  2. Sub item 2



== Equations

You can create equations using `$` symbols. For example, you can make an inline equation like this $E=m c^2$ or a displayed equation like this:

$ x < y => x gt.eq.not y $ <eq1>

You can reference the equation like this: Eq. @eq1.
