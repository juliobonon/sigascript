def capitalizeString(string):
    strList = string.split()
    newstr = ''

    for val in strList:
        newstr += val.capitalize()+ ' '
        
    if '-' in newstr:
        newstrplus = newstr.replace('-', '')    

    return newstrplus