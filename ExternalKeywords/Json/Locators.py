import json
import requests
import jsonpath_ng

#dictionary
#odics = '{"K1": "val1", "K2": "val2"}'

#json_result = json.loads(odics)
#print(json_result)

##
api_url = "https://reqres.in/api/user?page=2"

# make request
resp = requests.get(api_url)
print(resp.text)

# Validate status code
assert resp.status_code == 200

# Parse response into Json format
json_response = json.loads(resp.text)
print(json_response)

# fetching response path (il faut installer jsonpath via le pip : pip install jsonpath)
x = jsonpath.jsonpath(json_response, 'total')
print(x[0])
y = jsonpath.jsonpath(json_response, 'data[0].first_name')
print(y[0])

for val in json_response['data']:
    print(val['first_name'])

##

def read_locator_from_json(locatorname):
    response = json.loads("..JsonFiles/Elements.json")
    value = jsonpath(response, locatorname)
    return value