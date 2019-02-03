import requests
import numpy as np
import pandas as pd
import csv
import sys


def getData(csvfile, personID):
    with open(csvfile) as csv_file:
        data = ['a','b']
        csv_reader = csv.reader(csv_file, delimiter=',') 
        for row in csv_reader:
            if row[0] == personID:
                data[0] = row[1]
                data[1] = row[2]
                return data
        return ["ERROR: userID not found", 0]


def request(personID, amount):
    info = getData('data.csv', personID)
    if info[0] == "ERROR: userID not found" :
        return info[0]

    response = requests.post('https://wild-chicken.appspot.com/v1/request-money', json={
        "amount": amount,
        "contactName": info[0],
        "email": info[1],
    })

    return(response.json())


print(request(sys.argv[1], sys.argv[2]))


