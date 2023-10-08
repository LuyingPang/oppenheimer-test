from SeleniumLibrary import keywords
from datetime import datetime
from dateutil import relativedelta

def verify_natid(natid):
    if len(natid)>4:
        return '$'*(len(natid)-4)
    else:
        Exception("natid is not valid")

def calculate_hero_relief_amount(hero):
    variable = get_variable(hero['birthday'])
    gender_bonus = get_gender_bonus(hero['gender'])

    relief = ((float(hero['salary']) - float(hero['tax'])) * variable) + gender_bonus
    relief = '{:.2f}'.format(relief)
    relief = round(float(relief),0)
    if relief > 0 and relief < 50:
        relief = 50.00
    return '{:.2f}'.format(relief)

def get_variable(birthday):
    birthday = datetime.strptime(birthday, '%d%m%Y')
    years = relativedelta.relativedelta(datetime.now(),birthday).years

    if years <= 18: 
        return 1
    elif years <= 35:
        return 0.8
    elif years <= 50:
        return 0.5
    elif years <= 75:
        return 0.367
    else:
        return 0.05


def get_gender_bonus(sex):
    if sex == 'F':
        return 500
    elif sex == 'M':
        return 0 
    else:
        Exception("sex value is invalid")
    




