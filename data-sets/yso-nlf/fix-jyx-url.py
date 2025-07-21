# Convert an old-style (pre 2025-07 or so) JYX PDF download URL read from
# stdin to a new URL by retrieving the original URL (which gives a HTML
# document) and extracting the new download URL from a HTML meta tag.

import sys
import requests
from bs4 import BeautifulSoup

def main():
    # Read URL from standard input
    url = input().strip()
    
    try:
        # Retrieve the content of the URL
        response = requests.get(url)
        response.raise_for_status()  # Raise an error for bad responses

        # Parse the HTML content
        soup = BeautifulSoup(response.text, 'html.parser')

        # Find the citation_pdf_url meta tag
        meta_tag = soup.find('meta', attrs={'name': 'citation_pdf_url'})
        
        if meta_tag and 'content' in meta_tag.attrs:
            pdf_url = meta_tag['content']
            # Decode HTML entities if necessary
            pdf_url = pdf_url.encode('utf-8').decode('unicode_escape')
            print(pdf_url)
        else:
            print("No citation_pdf_url meta tag found.")
    
    except requests.RequestException as e:
        print(f"Error retrieving the URL: {e}")

if __name__ == "__main__":
    main()
