# Code adapted from
# https://www.geeksforgeeks.org/python-program-to-recursively-scrape-all-the-urls-of-the-website/


from bs4 import BeautifulSoup
import requests
import csv

# lists
urls=["http://berglandlab.uvadcos.io/"]

f=open("splitlinks.csv","w")
csv_writer = csv.writer(f)

# function created
def scrape(site):

    # getting the request from url
    r = requests.get(site)

    # converting the text
    s = BeautifulSoup(r.text,"html.parser")

    for i in s.find_all("a"):
        href = site + i.attrs['href']
        href_split=href.split("/")[3:]
        href_split.insert(0,href)

        if not href.endswith("../"):
            csv_writer.writerow(href_split)
            urls.append(href)
            if href.endswith("/"):
                scrape(href)

    # for i in s.find_all("a"):
    #
    #     href = i.attrs['href']
    #
    #     if not href.startswith("http") and not href.endswith("../"):
    #         site = site+href
    #
    #         if site not in  urls:
    #             urls.append(site)
    #             print(site)
    #             # calling it self
    #             if site.endswith("/"):
    #                 scrape(site)

# main function
if __name__ =="__main__":

    # website to be scrape
    site="http://berglandlab.uvadcos.io/"

    # calling function
    scrape(site)
