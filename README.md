

# 403bypasser

# IMPORTANT NOTE:
## This project will be deprecated and a new, more powerful and flexible tool will take place here. The new project is still under development (being written in Python 3) and will be published soon. Thanks for your patience...

## Türkçe
**403bypasser**, erişimine herhangi bir sebeple izin verilmeyen ve HTTP 403 durum kodunu döndüren sayfalara erişmek için çeşitli bypass tekniklerini otomatize eden bir araçtır. URL ve erişilmek istenen dizin parametreleri tek olarak ya da liste olarak verilebilir. Bu araç geliştirilmeye devam edecektir, katkılara açıktır. 

## English 

**403bypasser** is a tool that automatize the techniques to bypass access control of the pages which return HTTP 403 status code that means accessing the page or resource you were trying to reach is absolutely forbidden for some reason. This tool takes two parameters(single or list): a URL and a directory. **403bypasser** will continue to be improved and it is open to contributions.

**Arguments:**
-u <single_url>
-U <path_of_URL_list>
-d <single_directory>
-D <path_of_directory_list>

## Kullanım / Usage

1. `./bypass_403.sh -u <single_URL> -d <single_dir>`
2. `./bypass_403.sh -U <path_of_URL_list> -D <path_of_dir_list>`
3. `./bypass_403.sh -u <single_URL> -D <path_of_dir_list>`
4. `./bypass_403.sh -U <path_of_URL_list> -d <single_dir>`

## Örnekler / Examples

* `./bypass_403.sh -u https://example.com -d example`
* `./bypass_403.sh -U some/path/urls.txt -D some/path/dirs.txt`

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
