import requests
import sys
import argparse
import validators
import os
import tldextract
from colorama import init, Fore, Style
from pyfiglet import Figlet
from time import sleep

# INITIALISE COLORAMA
init()

# DISPLAY BANNER -- START
custom_fig = Figlet(font="slant")
print(
    Fore.BLUE + Style.BRIGHT + custom_fig.renderText("-------------") + Style.RESET_ALL
)
print(Fore.BLUE + Style.BRIGHT + custom_fig.renderText("403bypasser") + Style.RESET_ALL)
print(
    Fore.GREEN
    + Style.BRIGHT
    + "____________________ Yunus Emre SERT ____________________\n"
)
print(
    Fore.LIGHTMAGENTA_EX
    + Style.BRIGHT
    + "-----> Twitter   : https://twitter.com/yunem_se\n"
)
print(Fore.MAGENTA + Style.BRIGHT + "-----> GitHub    : https://github.com/yunemse48\n")
print(
    Fore.MAGENTA
    + Style.BRIGHT
    + "-----> LinkedIn  : https://www.linkedin.com/in/yunus-emre-sert-9102a9135/\n"
)
print(
    Fore.BLUE + Style.BRIGHT + custom_fig.renderText("-------------") + Style.RESET_ALL
)
# DISPLAY BANNER -- END

# HANDLE ARGUMENTS -- START
parser = argparse.ArgumentParser()
parser.add_argument(
    "-u", "--url", type=str, help="single URL to scan, ex: http://example.com"
)
parser.add_argument(
    "-U", "--urllist", type=str, help="path to list of URLs, ex: urllist.txt"
)
parser.add_argument(
    "-d",
    "--dir",
    type=str,
    help="Single directory to scan, ex: /admin",
    nargs="?",
    const="/",
)
parser.add_argument(
    "-D", "--dirlist", type=str, help="path to list of directories, ex: dirlist.txt"
)

args = parser.parse_args()
# HANDLE ARGUMENTS -- END


class Arguments:
    def __init__(self, url, urllist, dir, dirlist):
        self.url = url
        self.urllist = urllist
        self.dir = dir
        self.dirlist = dirlist
        self.urls = []
        self.dirs = []

        self.checkURL()
        self.checkDir()

    def return_urls(self):
        return self.urls

    def return_dirs(self):
        return self.dirs

    def checkURL(self):
        if self.url:
            if not validators.url(self.url):
                print(
                    "You must specify a valid URL for -u (--url) argument! Exitting...\n"
                )
                # Muteavery: Syntax fix + adding exit code
                sys.exit(1)

            if self.url.endswith("/"):
                self.url = self.url.rstrip("/")

            self.urls.append(self.url)
        elif self.urllist:
            if not os.path.exists(self.urllist):
                print("The specified path to URL list does not exist! Exitting...\n")
                # muteavery: adding exit code
                sys.exit(1)

            with open(self.urllist, "r") as file:
                temp = file.readlines()

            for x in temp:
                self.urls.append(x.strip())
        else:
            print("Please provide a single URL or a list either! (-u or -U)\n")
            # muteavery: adding exit code
            sys.exit(1)

    def checkDir(self):
        if self.dir:
            if not self.dir.startswith("/"):
                self.dir = "/" + self.dir

            if self.dir.endswith("/") and self.dir != "/":
                self.dir = self.dir.rstrip("/")
            self.dirs.append(self.dir)
        elif self.dirlist:
            if not os.path.exists(self.dirlist):
                print(
                    "The specified path to directory list does not exist! Exitting...\n"
                )
                # muteavery: adding exit code
                sys.exit(1)

            with open(self.dirlist, "r") as file:
                temp = file.readlines()

            for x in temp:
                self.dirs.append(x.strip())
        else:
            self.dir = "/"


class PathRepository:
    def __init__(self, path):
        self.path = path
        self.newPaths = []
        self.newHeaders = []
        self.rewriteHeaders = []

        self.createNewPaths()
        self.createNewHeaders()

    def createNewPaths(self):
        self.newPaths.append(self.path)

        pairs = [["/", "//"], ["/.", "/./"]]

        leadings = ["/%2e"]

        trailings = [
            "/",
            "..;/",
            "/..;/",
            "%20",
            "%09",
            "%00",
            ".json",
            ".css",
            ".html",
            "?",
            "??",
            "???",
            "?testparam",
            "#",
            "#test",
            "/.",
        ]

        for pair in pairs:
            self.newPaths.append(pair[0] + self.path + pair[1])

        for leading in leadings:
            self.newPaths.append(leading + self.path)

        for trailing in trailings:
            self.newPaths.append(self.path + trailing)

    def createNewHeaders(self):
        headers_overwrite = ["X-Original-URL", "X-Rewrite-URL"]

        headers = [
            "X-Custom-IP-Authorization",
            "X-Forwarded-For",
            "X-Forward-For",
            "X-Remote-IP",
            "X-Originating-IP",
            "X-Remote-Addr",
            "X-Client-IP",
            "X-Real-IP",
        ]

        values = [
            "localhost",
            "localhost:80",
            "localhost:443",
            "127.0.0.1",
            "127.0.0.1:80",
            "127.0.0.1:443",
            "2130706433",
            "0x7F000001",
            "0177.0000.0000.0001",
            "0",
            "127.1",
            "10.0.0.0",
            "10.0.0.1",
            "172.16.0.0",
            "172.16.0.1",
            "192.168.1.0",
            "192.168.1.1",
        ]

        for header in headers:
            for value in values:
                self.newHeaders.append({header: value})

        for element in headers_overwrite:
            self.rewriteHeaders.append({element: self.path})


class Query:
    def __init__(self, url, dir, dirObject):
        self.url = url
        self.dir = dir  # call pathrepo by this
        self.dirObject = dirObject
        self.domain = tldextract.extract(self.url).domain

    # MuteAvery: added switch case, to improve readabilty and to make it easier to append new status codes
    def checkStatusCode(self, status_code):
        status_colours = {
            200: Fore.GREEN + Style.BRIGHT,
            201: Fore.GREEN + Style.BRIGHT,
            301: Fore.BLUE + Style.BRIGHT,
            302: Fore.BLUE + Style.BRIGHT,
            403: Fore.BLUE + Style.BRIGHT,
            500: Fore.RED + Style.BRIGHT,
        }

        return status_colours.get(status_code, Fore.WHITE + Style.BRIGHT)

    def writeToFile(self, array):
        print("Writing to file!")
        with open(self.domain + ".txt", "a") as file:
            for line in array:
                file.write(line + "\n")

    def manipulateRequest(self):
        print(
            (" Target URL: " + self.url + "\tTarget Path: " + self.dir + " ").center(
                121, "="
            )
        )
        results = []
        sleep(0.5)  # rate limiting
        p = requests.post(self.url + self.dir, timeout=10)

        colour = self.checkStatusCode(p.status_code)
        reset = Style.RESET_ALL

        line_width = 100
        target_address = "POST --> " + self.url + self.dir
        info = f"STATUS: {colour}{p.status_code}{reset}\tSIZE: {len(p.content)}"
        info_pure = f"STATUS: {p.status_code}\tSIZE: {len(p.content)}"
        remaining = line_width - len(target_address)

        print("\n" + target_address + " " * remaining + info)

        results.append(target_address + " " * remaining + info_pure)

        self.writeToFile(results)

        self.manipulatePath()

    def manipulatePath(self):
        results = []
        reset = Style.RESET_ALL
        line_width = 100

        for path in self.dirObject.newPaths:
            # Muteavery: added timeout to request
            sleep()
            r = requests.get(self.url + path, timeout=10)

            colour = self.checkStatusCode(r.status_code)

            target_address = "GET --> " + self.url + path
            info = f"STATUS: {colour}{r.status_code}{reset}\tSIZE: {len(r.content)}"
            info_pure = f"STATUS: {r.status_code}\tSIZE: {len(r.content)}"
            remaining = line_width - len(target_address)

            print(target_address + " " * remaining + info)

            results.append(target_address + " " * remaining + info_pure)

        self.writeToFile(results)
        self.manipulateHeaders()

    def manipulateHeaders(self):
        results = []
        line_width = 100

        for header in self.dirObject.newHeaders:
            # Muteavery: added timeout to request
            sleep(0.5)
            r = requests.get(
                self.url + self.dir,
                headers=header,
                timeout=10,
            )

            colour = self.checkStatusCode(r.status_code)
            reset = Style.RESET_ALL

            target_address = "GET --> " + self.url + self.dir
            info = f"STATUS: {colour}{r.status_code}{reset}\tSIZE: {len(r.content)}"
            info_pure = f"STATUS: {r.status_code}\tSIZE: {len(r.content)}"
            remaining = line_width - len(target_address)

            print("\n" + target_address + " " * remaining + info)
            print(f"Header= {header}")

            results.append(
                "\n"
                + target_address
                + " " * remaining
                + info_pure
                + f"\nHeader= {header}"
            )
        self.writeToFile(results)

        results_2 = []
        for header in self.dirObject.rewriteHeaders:
            # Muteavery: added timeout to request
            sleep(0.5)
            r = requests.get(self.url, headers=header, timeout=10)

            colour = self.checkStatusCode(r.status_code)
            reset = Style.RESET_ALL

            target_address = "GET --> " + self.url
            info = f"STATUS: {colour}{r.status_code}{reset}\tSIZE: {len(r.content)}"
            info_pure = f"STATUS: {r.status_code}\tSIZE: {len(r.content)}"
            remaining = line_width - len(target_address)

            print("\n" + target_address + " " * remaining + info)
            print(f"Header= {header}")

            results_2.append(
                "\n"
                + target_address
                + " " * remaining
                + info_pure
                + f"\nHeader= {header}"
            )

        self.writeToFile(results_2)


class Program:
    def __init__(self, urllist, dirlist):
        self.urllist = urllist
        self.dirlist = dirlist

    # muteavery: FIX for issue KeyError
    # initialise locals()[domain_name] = Query(u, d, locals()[dir_objname])
    # ~~~~~~~~^^^^^^^^^^^^^ KeyError: 'secret'
    def initialise(self):
        path_objects = {}
        query_objects = {}

        for url in self.urllist:
            for dir in self.dirlist:
                if dir != "/":
                    dir_objname = dir.lstrip("/")
                else:
                    dir_objname = "_rootPath"

                path_objects[dir_objname] = PathRepository(dir)

                domain_name = tldextract.extract(url).domain

                query_objects[domain_name] = Query(url, dir, path_objects[dir_objname])

                query_objects[domain_name].manipulateRequest()


# added try/except block to handle manual exiting
try:
    argument = Arguments(args.url, args.urllist, args.dir, args.dirlist)
    program = Program(argument.return_urls(), argument.return_dirs())
    program.initialise()

except KeyboardInterrupt:
    print("\n\n[!] Interrupted by user (Ctrl+C)")
    sys.exit(1)
