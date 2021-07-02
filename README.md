[![forthebadge made-with-python](http://ForTheBadge.com/images/badges/made-with-python.svg)](https://www.python.org/)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

# 403bypasser

# IMPORTANT NOTE:
## New README is coming...

## Türkçe
**403bypasser**, erişim kısıtlaması bulunan sayfalardaki kısıtlamaları ve kontrolleri atlatmak amacıyla kullanılan teknikleri otomatize etmek için yazılmıştır. Bu araç geliştirilmeye devam edecektir, katkılara açıktır. 

## English 

**403bypasser** has been written to automate the techniques used to circumvent restrictions and access controls on restricted pages. **403bypasser** will continue to be improved and it is open to contributions.

## Usage

**Arguments:**<br>
1.1 -u <single_url>&emsp;&emsp;&emsp;ex: /admin, admin, /admin/, admin/&emsp;403bypasser handles all these usages in the same way, it does not matter which one you prefer!<br>
-U <path_of_URL_list>
-d <single_directory>
-D <path_of_directory_list>

| Argument | Description | Example | Note |
| -------- | ----------- | ------- | ---- |
| -u | single URL to scan | http://example.com or http://example.com/ | All these example usages are handled in the same way |

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
