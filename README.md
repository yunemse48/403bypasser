[![forthebadge made-with-python](http://ForTheBadge.com/images/badges/made-with-python.svg)](https://www.python.org/)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
[![GitHub release](https://img.shields.io/github/release/Naereen/StrapDown.js.svg)](https://github.com/yunemse48/403bypasser/releases)
[![GitHub tag](https://img.shields.io/github/tag/Naereen/StrapDown.js.svg)](https://github.com/yunemse48/403bypasser/tags)

# 403bypasser

# IMPORTANT NOTE:
## New README is coming...

## Türkçe
**403bypasser**, erişimine herhangi bir sebeple izin verilmeyen ve HTTP 403 durum kodunu döndüren sayfalara erişmek için çeşitli bypass tekniklerini otomatize eden bir araçtır. URL ve erişilmek istenen dizin parametreleri tek olarak ya da liste olarak verilebilir. Bu araç geliştirilmeye devam edecektir, katkılara açıktır. 

## English 

**403bypasser** is a tool that automatize the techniques to bypass access control of the pages which return HTTP 403 status code that means accessing the page or resource you were trying to reach is absolutely forbidden for some reason. This tool takes two parameters(single or list): a URL and a directory. **403bypasser** will continue to be improved and it is open to contributions.

**Arguments:**
-u <single_url>
-U <path_of_URL_list>
-d <single_directory>
-D <path_of_directory_list>



## Which Cases Does This Tool Check?
 1. Testing `https://url.com/path`
 2. Testing `https://url.com/%2e/path`
 3. Testing `https://url.com/path/.`
 4. Testing `https://url.com//path//`
 5. Testing `https://url.com/./path/./`
 6. Testing `https://url.com/path/`
 7. Testing `https://url.com/path..;/`
 8. Testing `https://url.com/path` with header poisoning `X-Custom-IP-Authorization: 127.0.0.1`
 9. Testing `https://url.com/anything` with header poisoning `X-Original-URL: /directory`
10. Testing `https://url.com` with header poisoning `X-Rewrite-URL: /directory`

**Added Features in v1.1**: It's now possible to pass files (lists) to 403bypasser as input via arguments. Furthermore, two more test cases added: 
poisoning with 1)`X-Original-URL` and 2)`X-Rewrite-URL` headers. 
