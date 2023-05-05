# Auto JDownloader

This repository contains a set of scripts to automate the process of scraping forum thread URLs and downloading files from k2s.cc using JDownloader.

## Features

1. Scrape forum thread URLs based on user input.
2. Filter and extract k2s.cc links from the forum threads.
3. Generate JDownloader crawljob files for each k2s.cc link.

## Prerequisites

- Lynx: A text-based web browser used for URL scraping.
- cURL: A command-line tool for transferring data with URLs.

Install Lynx and cURL using package managers for your respective operating system.

## Scripts

1. `url_scraper`: A script to scrape forum thread URLs and k2s.cc links.
2. `automate_workflow.sh`: A script that calls `url_scraper` and generates JDownloader crawljob files.

## Usage

1. Clone the repository:
git clone https://github.com/4ndr0666/autojdownload.git
cd autojdownload

2. Make sure the scripts are executable:
chmod +x url_scraper automate_workflow.sh

3. Run the `automate_workflow.sh` script:
./automate_workflow.sh

4. Follow the prompts to input the forum thread's parent URL.

5. The script will generate crawljob files in the `jdownloader-watch` directory.

6. Import the generated crawljob files into JDownloader to start downloading the files.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
