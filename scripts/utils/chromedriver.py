from scrapy.http import TextResponse
import subprocess
import re
import requests

headers = {
    'authority': 'chromedriver.storage.googleapis.com',
    'sec-ch-ua': '" Not;A Brand";v="99", "Google Chrome";v="91", "Chromium";v="91"',
    'sec-ch-ua-mobile': '?0',
    'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36',
    'accept': '*/*',
    'x-client-data': 'CIe2yQEIo7bJAQipncoBCI+5ygEIjYjLAQjxl8sBCKCgywEI3fLLAQjq8ssBCO/yywEIzfbLAQiz+MsBCKf5ywEI8PnLAQiv+ssBCO/6ywEYjp7LARi68ssBGI/1ywE=',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'sec-fetch-dest': 'empty',
    'referer': 'https://chromedriver.storage.googleapis.com/index.html',
    'accept-language': 'en-US,en;q=0.9',
}

params = (
    ('delimiter', '/'),
    ('prefix', ''),
)


def get_chrome_version():
    google_process = subprocess.Popen("google-chrome --version", shell=True, stdout=subprocess.PIPE)
    google_process_return = google_process.stdout.read()
    return google_process_return.decode('utf-8')


def parse_version(chrome_version: str):
    return chrome_version.split()[2]


def get_chromedriver_version(chrome_version: str):
    url = 'https://chromedriver.storage.googleapis.com/'
    response = requests.get(url, headers=headers, params=params)
    response = TextResponse(body=response.content, url=url)

    for item in response.css('Prefix').extract():
        if chrome_version[0:7] in item:
            return re.compile(r'(\d.*\d)').search(item)


def download_chromedriver(chromedriver_version: str):
    headers = {
        'sec-ch-ua': '" Not;A Brand";v="99", "Google Chrome";v="91", "Chromium";v="91"',
        'sec-ch-ua-mobile': '?0',
        'Upgrade-Insecure-Requests': '1',
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36',
        'Referer': f'https://chromedriver.storage.googleapis.com/index.html?path={chromedriver_version}/',
    }

    url = f'https://chromedriver.storage.googleapis.com/{chromedriver_version}/chromedriver_linux64.zip'

    with requests.get(url, headers, stream=True) as r:
        r.raise_for_status()
        with open('chromedriver.zip', 'wb') as f:
            for chunk in r.iter_content(chunk_size=1024):
                if chunk:
                    f.write(chunk)

    g = subprocess.Popen("rm chromedriver; unzip chromedriver.zip", shell=True, stdout=subprocess.PIPE)
    return g.stdout.read()


def main():
    g = get_chrome_version()
    b = parse_version(g)
    version = get_chromedriver_version(b)
    download_chromedriver(version.group())
    print(f'👌 Chromedriver updated: {version.group()}')


if __name__ == '__main__':
    main()