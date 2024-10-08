import openpyxl

wk = openpyxl.Workbook()
print(wk.active.title)
sh = wk.active

#change sheetName
sh.title="DataTesting"
print(sh.title)

# read on a cell
sh['A4'].value = "www.thetesting.com"

# create a new sheet called TestingW
wk.create_sheet(title='TestingW')

# entrer data in the second sheet TestingW
sh1 = wk['TestingW']
sh1['A2'] = "334455"

# remove a sheet
wk.remove(wk['DataTesting'])

# save all sheets (wk)
wk.save("./writedSheet.xlsx")