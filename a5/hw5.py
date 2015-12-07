import os
import zipfile
import smtplib
import getpass


def get_symbols():
    # c symbols
    c_symbols = []
    file = open("C:/Users/Tim/Desktop/csc344/a1/main.c")
    flags = ['int','char','char*','char**','FILE']
    ignore = ['{','}',";","'",","'"']
    idents = []

    for line in file:
        line = line.replace("("," ( ")
        for each in ignore:
            line = line.replace(each, " ")
            line = line.replace("char *", "char*")
            line = line.replace("char * ","char*")
        text_list = line.split()
        for i in range(len(text_list)):
            if i < len(text_list)-1:
                candidate = text_list[i + 1]
                if text_list[i] in flags and candidate not in idents:
                    idents.append(candidate)
                    c_symbols.append('[C,' + candidate + ']')


    # lisp symbols
    lisp_symbols = []
    file = open("C:/Users/Tim/Desktop/csc344/a2/hw2final.lsp")
    flags = ['setf', 'setq', 'defun']
    idents = []

    for line in file:
        line = line.replace("(","( ")
        text_list = line.split()
        for i in range(len(text_list)):
            if i < len(text_list)-1:
                candidate = text_list[i + 1]
                if text_list[i] in flags and candidate not in idents:
                    idents.append(candidate)
                    lisp_symbols.append('[Lisp,' + candidate + ']')


    #scala symbols
    scala_symbols = []
    file = open("C:/Users/Tim/Desktop/csc344/a3/src/main.scala")
    flags = ['val','var','class','def']
    ignore = ['{','}',";","'",",","'",'.',':']
    idents = []

    for line in file:
        line = line.replace("("," ( ")
        for each in ignore:
            line = line.replace(each, " ")
        text_list = line.split()
        for i in range(len(text_list)):
            if i < len(text_list)-1:
                candidate = text_list[i+1]
                if text_list[i] in flags and candidate not in idents:
                    idents.append(candidate)
                    scala_symbols.append('[Scala,' + candidate + ']')


    #prolog symbols
    prolog_symbols = []
    file = open("C:/Users/Tim/Desktop/csc344/a4/hw4final.pro")
    ignore = ['0,','1,',"2,","3,","4,","5,","6,","7,","8,","9,",'10,','11,','12,','nl','is','_,','']
    used = []
    idents = []

    for line in file:
        line = line.replace("(","( ")
        line = line.replace(",",", ")
        line = line.replace(":-", " ")
        line = line.replace(")","")
        line = line.replace("|"," ,")
        line = line.replace("]",", ")
        line = line.replace("[",", ")

        text_list = line.split()
        for i in range(len(text_list)):
            candidate = text_list[i]
            if not candidate.startswith("'") and not candidate.endswith("'") and candidate not in ignore:
                if candidate.endswith("(") and candidate not in used:
                    used.append(candidate)
                    idents.append(candidate.replace("(",""))
                if candidate.endswith(",") and candidate not in used and not candidate.startswith("'"):
                    used.append(candidate)
                    idents.append(candidate.replace(",",""))
    for each in idents:
        if each is '' or each.endswith("'") or each.startswith("~") or each is '_':
            pass
        else: prolog_symbols.append("Prolog, " + each + "] ")


    #python symbols
    python_symbols = []
    file = open("C:/Users/Tim/Desktop/csc344/a5/hw5.py")
    flags = ['def','class']
    idents = []
    for line in file:
        line = line.replace("(","( ")
        line = line.replace("."," ")
        text_list = line.split()
        for i in range(len(text_list)):
            current = text_list[i]
            if current in flags and text_list[i+1] not in idents:
                idents.append(text_list[i+1].replace("(",""))
            if current is '=' and text_list[i-1] not in idents:
                idents.append(text_list[i-1])
            if current.endswith("(") and current.replace("(","") not in idents:
                idents.append(current.replace("(",""))

    for each in idents:
        if each.endswith("'") or each.endswith('"') or each is '':
            pass
        else:
            python_symbols.append("[Python, " + each + "] ")


    #combine all symbols
    symbol_file = open("all_symbols.txt","w+")
    symbols = [c_symbols,lisp_symbols,scala_symbols,prolog_symbols,python_symbols]
    for symbollist in symbols:
        for token in symbollist:
            symbol_file.write(token)
        symbol_file.write('\n\n')
    symbol_file.close()
    print("all_symbols.txt file generated.")


def get_HTML():
    htmlfile = open("csc344.html","w+")
    htmlfile.write("<html>\n\n")
    htmlfile.write("<head>")
    htmlfile.write("<title> CSC 344 Assignments::Tim Dougherty </title>")
    htmlfile.write("</head>\n\n")
    htmlfile.write("<html><body bgcolor=f2f5a9''><center><br>")
    htmlfile.write("<font size='7'>")


def get_zip():
    zip = zipfile.ZipFile('all_assignments.zip', 'w')
    filepath = "C:/Users/Tim/Desktop/csc344"
    asn_files = ['main.c', 'hw2final.lsp', 'main.scala', 'hw4final.pro', 'hw5.py']
    os.path.abspath(os.path.join(filepath,os.pardir))
    for root, dirs, files in os.walk(os.path.pardir,topdown=False):
        for file in files:
            if file in asn_files:
                zip.write(os.path.join(root,file))
    print("zip made?")


def email():
    pass

def main():
    get_symbols()
    get_HTML()
    get_zip()
    email()


