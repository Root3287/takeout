#!/usr/bin/env python3
# parallel --progress ./takeout.py -w {1} -t {2} -g {3} -c {4} -o {5} --batch ::: $(seq 0 5 100) ::: $(seq 0 5 300) ::: $(seq 0 5 1000) ::: $(seq 0.25 0.25 4) ::: $(seq 0 1 0.25) >> takeout.csv

import argparse
import sys
parser = argparse.ArgumentParser(
        prog = 'takeout',
        description = 'A simple algorithm to determine if you sould takeout or cook'
)

parser.add_argument('-w', '--wage', type=float, required=True)
parser.add_argument('-t', '--takeout-price', type=float, required=True)
parser.add_argument('-g', '--grocery-price', type=float, required=True)
parser.add_argument('-c', '--cooking-time', type=float, required=True)
parser.add_argument('-o', '--order-time', type=float, required=True)
parser.add_argument('--batch', action=argparse.BooleanOptionalAction)

args = parser.parse_args()

# print(args)

# sys.exit(0)

working = True if args.wage > 0 else False # input("Are you working (Y/n) ").lower().strip() == 'y'
takeout_price = args.takeout_price # args.float(input("What is the price of takeout? "))
grocery_price = args.grocery_price # float(input("What is the price of groceries? "))
time_to_cook = args.cooking_time # float(input("What is the time to cook? "))
time_to_order = args.order_time # float(input("What is the time to order? "))
wage = args.wage # float(input("What is your hourly wage?"))

if working == True and ((takeout_price - grocery_price) < ((time_to_cook - time_to_order) * wage)):
    if args.batch == True:
        print(f"{args.wage},{args.takeout_price},{args.grocery_price},{args.cooking_time},{args.order_time},Takeout")
    else:
        print("Takeout")
else:
    if args.batch == True:
        print(f"{args.wage},{args.takeout_price},{args.grocery_price},{args.cooking_time},{args.order_time},Cook")
    else:
        print("Cook yourself")

