FROM apache/airflow:2.3.3

LABEL maintainer="devops@yoast.com"

# Switch to root to install packages
USER root

# Install Needed Packages & Cleanup after
RUN apt-get update && apt-get install -y \
    jq \
    git \
    gcc \
    && apt-get clean autoclean  \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Switch to Airflow user
USER airflow

# Create and set workdirs
RUN mkdir -p /opt/airflow/singer \
&& mkdir -p /opt/airflow/singer/config \
&& mkdir -p /opt/airflow/singer/state

WORKDIR /opt/airflow/singer

COPY ./scripts/init.sh /opt/airflow/singer/

# Run the init script to create virtual environments & install the taps/targets
RUN ./init.sh
