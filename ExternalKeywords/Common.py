from robot.api.deco import keyword
import os
import sys
import time
import re
import unicodedata
from datetime import datetime
from robot.libraries.BuiltIn import BuiltIn

def convert_date_format(str_date):
    browser = BuiltIn().get_variable_value("${BROWSER}")
    if browser == 'firefox':
        return datetime.strptime(str_date, '%d%m%Y').strftime('%Y-%m-%d')
    if browser == 'chrome':
        return str_date

def clean_string_filename(str):
    clean1 = re.sub(r'[\\/*?:"<>| ]',"",str)
    clean2 = ''.join((c for c in unicodedata.normalize('NFD', clean1) if unicodedata.category(c) != 'Mn'))
    return clean2


@keyword('This is keyword with custom name')
def xxx():
    pass
