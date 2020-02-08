import sys
from collections import OrderedDict

filename = sys.argv[1]

def checkIdentifier(data):
    if len(data) == 0:
        return False
    if data.isdigit():
        return False       
    index = 0
    while index < len(data):
        if data[index].isalpha() == False and data[index] != '_' and data[index].isdigit() == False:
            return False
        index += 1
    return True

def checkString(data):
    end = 1
    if data[0] == '"':
        while end < len(data):
            if (line[end] == '"') and (line[end - 1] != "\\"):
                return True       
            end += 1
    return False

def checkInteger(data):
    for c in data:
        if c.isdigit() == False:
            return False
    return True

def checkFloat(data):
    if len(data) == 1:
        return False
    for c in data:
        if c.isdigit() == False:
            if c != '.':
                return False
    if data.count('.') != 1:
        return False
    return True

def checkOperator(data):
    opsArray = ['&', '=', '!', ':', ',', '.', '>', '<', '[', ']', '(', ')', '+', '-', '/', '*', ';']
    if len(data) == 1:
        for op in opsArray:
            if op == data:
                return True
    return False

def removeSlashes(data):
    start = 1
    answer = data
    while start < len(answer):
        if answer[start] == '"' and answer[start - 1] == "\\":
            answer = answer[0: start - 1] + answer[start:]
        start += 1
    if len(answer) > 1:
        answer = answer[1: len(answer) - 1]
    return answer

with open(filename) as fp:
    line = fp.readline().strip()
    count = 1
    tokenArray = []
    lineArray = []
    while line:
        lineArray.append(line)
        if len(line) == 1:
            if checkIdentifier(line):
                tokenArray.append([line, 'Identifier', count])
            elif checkString(line):
                tokenArray.append([line, 'String', count])
            elif checkInteger(line):
                tokenArray.append([line, 'Integer', count])
            elif checkFloat(line):
                tokenArray.append([line, 'Float', count])
            elif checkOperator(line):
                tokenArray.append([line, 'Operator', count])
            else:
                tokenArray.append([hex(ord(line)), 'unknown character', count])
            line = ''
        if len(lineArray) > 1:
            if lineArray[-1] == lineArray[-2]:
                if not (checkIdentifier(line[0]) or checkString(line[0]) or checkInteger(line[0]) or checkFloat(line[0]) or checkOperator(line[0])):
                    tokenArray.append([hex(ord(line[0])), 'unknown character', count])
                    line = line[1:].strip()
        token = ''
        x = 1
        while x <= len(line):
            if x == 1:
                if checkIdentifier(line[0]):
                    if len(line[0]) > len(token):
                        token = line[0]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Identifier', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Identifier', count]
                            else:
                                tokenArray.append([token, 'Identifier', count])
                        else:
                            tokenArray.append([token, 'Identifier', count])
                elif checkString(line[0]):
                    if len(line[0]) > len(token):
                        token = line[0]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'String', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'String', count]
                            else:
                                tokenArray.append([token, 'String', count])
                        else:
                            tokenArray.append([token, 'String', count])
                elif checkInteger(line[0]):
                    if len(line[0]) > len(token):
                        token = line[0]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Integer', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Integer', count]
                            else:
                                tokenArray.append([token, 'Integer', count])
                        else:
                            tokenArray.append([token, 'Integer', count])
                elif checkFloat(line[0]):
                    if len(line[0]) > len(token):
                        token = line[0]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Float', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Float', count]
                            else:
                                tokenArray.append([token, 'Float', count])
                        else:
                            tokenArray.append([token, 'Float', count])
                elif checkOperator(line[0]):
                    if len(line[0]) > len(token) and line[1].isdigit() == False:
                        token = line[0]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Operator', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Operator', count]
                            else:
                                tokenArray.append([token, 'Operator', count])
                        else:
                            tokenArray.append([token, 'Operator', count])
            elif x == len(line):
                if checkIdentifier(line[0:]):
                    if len(line[0:]) > len(token):
                        token = line[0:]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Identifier', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Identifier', count]
                            else:
                                tokenArray.append([token, 'Identifier', count])
                        else:
                            tokenArray.append([token, 'Identifier', count])
                elif checkString(line[0:]):
                    if len(line[0:]) > len(token):
                        end = 1
                        if line[0] == '"':
                            while end < len(line[0:]):
                                if (line[end] == '"') and (line[end - 1] != "\\"):
                                    token = line[0: end + 1]
                                end += 1
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'String', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'String', count]
                            else:
                                tokenArray.append([token, 'String', count])
                        else:
                            tokenArray.append([token, 'String', count])
                elif checkInteger(line[0:]):
                    if len(line[0:]) > len(token):
                        token = line[0:]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Integer', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Integer', count]
                            else:
                                tokenArray.append([token, 'Integer', count])
                        else:
                            tokenArray.append([token, 'Integer', count])
                elif checkFloat(line[0:]):
                    if len(line[0:]) > len(token):
                        token = line[0:]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Float', count])
                            elif (token.find(tokenArray[-1][0]) != -1):
                                if tokenArray[-1][0] == '.':                           
                                    tokenArray.append([token, 'Float', count])
                                else:
                                    tokenArray[-1] = [token, 'Float', count]
                            else:
                                tokenArray.append([token, 'Float', count])
                        else:
                            tokenArray.append([token, 'Float', count])
                elif checkOperator(line[0:]):
                    if len(line[0:]) > len(token):
                        token = line[0:]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Operator'])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Operator', count]
                            else:
                                tokenArray.append([token, 'Operator', count])
                        else:
                            tokenArray.append([token, 'Operator', count])
            else:
                if (checkIdentifier(line[0: x])):
                    if len(line[0: x]) > len(token):
                        token = line[0: x]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Identifier', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Identifier', count]
                            else:
                                tokenArray.append([token, 'Identifier', count])
                        else:
                            tokenArray.append([token, 'Identifier', count])
                elif checkString(line[0: x]):
                    if len(line[0: x]) > len(token):
                        end = 1
                        if line[0] == '"':
                            while end < len(line[0: x]):
                                if (line[end] == '"') and (line[end - 1] != "\\"):
                                    token = line[0: end + 1]      
                                end += 1
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'String', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'String', count]
                            else:
                                tokenArray.append([token, 'String', count])
                        else:
                            tokenArray.append([token, 'String', count])
                elif checkInteger(line[0: x]):
                    if len(line[0: x]) > len(token):
                        token = line[0: x]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Integer', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Integer', count]
                            else:
                                tokenArray.append([token, 'Integer', count])
                        else:
                            tokenArray.append([token, 'Integer', count])
                elif checkFloat(line[0: x]):
                    if len(line[0: x]) > len(token):
                        token = line[0: x]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Float', count])
                            elif (token.find(tokenArray[-1][0]) != -1):
                                if tokenArray[-1][0] == '.':
                                    tokenArray.append([token, 'Float', count])
                                else:
                                    tokenArray[-1] = [token, 'Float', count]
                            else:
                                tokenArray.append([token, 'Float', count])
                        else:
                            tokenArray.append([token, 'Float', count])
                elif checkOperator(line[0: x]):
                    if len(line[0: x]) > len(token):
                        token = line[0: x]
                        if len(tokenArray) != 0:
                            if len(tokenArray[-1][0]) == len(token):
                                if tokenArray[-1][0] != token:
                                    tokenArray.append([token, 'Operator', count])
                            elif token.find(tokenArray[-1][0]) != -1:
                                tokenArray[-1] = [token, 'Operator', count]
                            else:
                                tokenArray.append([token, 'Operator', count])
                        else:
                            tokenArray.append([token, 'Operator', count])
            x += 1
        if token:
            line = line[len(token):].strip()
        if line == '':
            line = fp.readline().strip()
            count += 1
            lineArray = []
    for thing in tokenArray:
        if thing[1] == 'String':
            thing[0] = removeSlashes(thing[0])
        print(str(thing[2]) + ': ' + thing[1].lower() + ' ' + "'" + thing[0] + "'" + ' found')
            
    

        
    
        
