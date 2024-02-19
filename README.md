# Football Data Engineering

This repository hosts the Football Data Engineering project, a Python-based initiative that automates the extraction of stadium capacity data from Wikipedia, employs Apache Airflow for data orchestration, cleanses the extracted data, and finally pushes it to Azure Data Lake for further processing and analysis with Azure Synapse and Tableau.

## Table of Contents

- [System Architecture](#system-architecture)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Running the Code With Docker](#running-the-code-with-docker)
- [How It Works](#how-it-works)

### System Architecture

The project's architecture is designed to streamline the data engineering process from data extraction to storage. Please refer to `Architecture.png` in the repository for a visual overview.

![Architecture.png](assets%2FArchitecture.png)
### Requirements

To run this project, you will need:

- Python 3.9 or later
- Docker
- PostgreSQL
- Apache Airflow 2.6 or later

### Getting Started

1. **Clone the repository** to your local machine:

    git clone https://github.com/Rafavermar/FootballRVMDataEngineering.git



2. **Install Python dependencies** needed for the project:

    pip install -r requirements.txt



### Running the Code With Docker

  To facilitate easy setup and scalability, the project is containerized with Docker. 

  - **Start your services on Docker** by running:

    docker compose up -d


- **Trigger the DAG** on the Airflow UI to begin the data processing workflow.

### How It Works

The project's workflow is outlined as follows:

1. **Fetches data** from Wikipedia using Beautiful Soup for web scraping.
2. **Cleans the data** to ensure quality and consistency.
3. **Transforms the data** for analytical readiness.
4. **Pushes the data** to Azure Data Lake, leveraging the ABFS protocol for efficient data storage and access.

By following these steps, you will be able to successfully execute the Football Data Engineering project, leveraging powerful tools such as Python, Docker, Apache Airflow, and Azure to manage and analyze sports data efficiently.

### Visualization in Tableau
![dashboard_static.png](assets%2Fdashboard_static.png)

[Dashboard in Tableau Public](https://public.tableau.com/app/profile/rafael.vera.maranon/viz/shared/KJFNK5SK7)


Acknowledgments

I extend my gratitude to Yusuf for his invaluable guidance and to the open-source community for the tools and libraries that made this project possible. This experience has reinforced my belief in the power of collaboration and continuous learning in the field of data engineering.

Yusuf's youtube channel
