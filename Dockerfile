FROM apache/airflow:2.3.3

LABEL maintainer="devops@yoast.com"

# Switch to root to install packages
USER root

# Install Needed Packages & Cleanup after
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    && apt-get clean autoclean  \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Switch to Airflow user
USER airflow

# Create and set workdir
RUN mkdir -p /opt/airflow/singer
WORKDIR /opt/airflow/singer

# Create virtual environments to isolate dependancies
RUN python3 -m venv \
    singer-activecampaign \
    singer-adyen \
    singer-basecone \
    singer-bq \
    singer-builtwith \
    singer-coosto \
    singer-fixer \
    singer-paypal \
    singer-postmark \
    singer-shopify-shops \
    singer-tap-openexchange \
    singer-tap-shopify-partners \
    singer-twinfield \
    singer-wordpress-plugin-stats \
    singer-wordpress-reviews \
    singer-wordpress-stats \
    singer-wordpress-support-forums

# Install Taps into Virtual Environments
RUN /opt/airflow/singer/singer-activecampaign/bin/pip install --no-user             git+https://github.com/Yoast/tap-activecampaign \
&& /opt/airflow/singer/singer-adyen/bin/pip install --no-user                       git+https://github.com/Yoast/singer-tap-adyen \
&& /opt/airflow/singer/singer-basecone/bin/pip install --no-user                    git+https://github.com/Yoast/singer-tap-basecone \
&& /opt/airflow/singer/singer-bq/bin/pip install --no-user                          git+https://github.com/Yoast/target-bigquery \
&& /opt/airflow/singer/singer-builtwith/bin/pip install --no-user                   git+https://github.com/Yoast/singer-tap-builtwith \
&& /opt/airflow/singer/singer-coosto/bin/pip install --no-user                      git+https://github.com/Yoast/singer-tap-coosto \
&& /opt/airflow/singer/singer-fixer/bin/pip install --no-user                       git+https://github.com/Yoast/tap-fixerio \
&& /opt/airflow/singer/singer-postmark/bin/pip install --no-user                    git+https://github.com/Yoast/singer-tap-postmark \
&& /opt/airflow/singer/singer-shopify-shops/bin/pip install --no-user               git+https://github.com/Yoast/singer-tap-shopify-shops \
&& /opt/airflow/singer/singer-tap-openexchange/bin/pip install --no-user            git+https://github.com/Yoast/singer-tap-open-exchange-rate \
&& /opt/airflow/singer/singer-tap-shopify-partners/bin/pip install --no-user        git+https://github.com/Yoast/singer-tap-shopify-partners \
&& /opt/airflow/singer/singer-twinfield/bin/pip install --no-user                   git+https://github.com/Yoast/singer-tap-twinfield \
&& /opt/airflow/singer/singer-wordpress-plugin-stats/bin/pip install --no-user      git+https://github.com/Yoast/singer-tap-wordpress-plugin-stats \
&& /opt/airflow/singer/singer-wordpress-reviews/bin/pip install --no-user           git+https://github.com/Yoast/singer-tap-wordpress-reviews \
&& /opt/airflow/singer/singer-wordpress-stats/bin/pip install --no-user             git+https://github.com/Yoast/singer-tap-wordpress-stats \
&& /opt/airflow/singer/singer-wordpress-support-forums/bin/pip install --no-user    git+https://github.com/Yoast/singer-tap-wordpress-support-forums
