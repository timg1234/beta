#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import time
import datetime
import glob
import MySQLdb
from time import strftime, sleep
import RPi.GPIO as GPIO
from datetime import datetime
# sleep for a half second to avoid "modprobe: not found" error
#time.sleep(0.5)
from datetime import datetime
import time
from time import strftime, sleep
import RPi.GPIO as GPIO

# set up text message capability
from twilio.rest import Client
TWILIO_ACCOUNT_SID='AC7079b1a0e061636592f4779a071cee93'
TWILIO_AUTH_TOKEN='0bc99309d2c1b550d58b78dfaa7550b7'

os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')
temp_sensor = '/sys/bus/w1/devices/28-0114548db3ff/w1_slave'

db = MySQLdb.connect(host="localhost",user="freddy",passwd="T0p0fthem0rning", db="4_database")
cur = db.cursor()

# define the degree symbol
deg = u"\u00b0"

# Configure GPIO library
GPIO.setmode(GPIO.BOARD)

# Disable warnings
GPIO.setwarnings(False)

#GPIO Mode (BOARD / BCM)
GPIO.setmode(GPIO.BOARD)

#set GPIO Pins
GPIO_TRIGGER = 3
GPIO_ECHO = 5

#set GPIO direction (IN / OUT)
GPIO.setup(GPIO_TRIGGER, GPIO.OUT)
GPIO.setup(GPIO_ECHO, GPIO.IN)

#set up leak detection
pin = 18
GPIO.setup(pin, GPIO.IN, GPIO.PUD_UP)

def distance():
    # set Trigger to HIGH
    GPIO.output(GPIO_TRIGGER, True)

    # set Trigger after 0.01ms to LOW
    time.sleep(0.00001)
    GPIO.output(GPIO_TRIGGER, False)

    StartTime = time.time()
    StopTime = time.time()

    # save StartTime
    while GPIO.input(GPIO_ECHO) == 0:
        StartTime = time.time()

    # save time of arrival
    while GPIO.input(GPIO_ECHO) == 1:
        StopTime = time.time()

    # time difference between start and arrival
    TimeElapsed = StopTime - StartTime
    # multiply with the sonic speed (34300 cm/s)
    # and divide by 2, because there and back
    distance = (TimeElapsed * 34300) / 2
    
    return distance
    
    while GPIO.input(GPIO_ECHO) != GPIO.HIGH:
        signaloff = time.time()

    # wait for "ECHO" pin becomes LOW
    signalon = signaloff
    while time.time() < signaloff + 0.1: # timeout in 0.1 seconds
        if GPIO.input(GPIO_ECHO) == GPIO.LOW:
            signalon = time.time()
            break

    # cleanup GPIO state
    GPIO.cleanup()

    if distance <= 500:
        return round(distance,1)
    else:
        return None

while True:
    datetimeWrite = (time.strftime("%Y-%m-%d ") + time.strftime("%H:%M:%S"))
    dist1 = distance()  
    dist1in = dist1 / 2.54
    sql = ("""INSERT INTO dataLog (datetime, dist1) VALUES (%s,%s)""", (datetimeWrite, dist1))
    
    try:
        # Execute the SQL command
        cur.execute(*sql)
        # Commit your changes in the database
        db.commit()
#        db.close() 
        print("On {}, dist1 was {} cm, {} in.".format(datetimeWrite, round(dist1,1), round(dist1in,1)))

    except:
        # Rollback in case there is any error
        db.rollback()
        print("Failed writing to database")

    sleep(10)


