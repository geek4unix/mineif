# mineif

A script to control if and when you start or stop your miner ( think solar power! )

> This is a proof of concept to provide a framework that can monitor a solar system and make a logical decision on if mining is appropriate.

E.g. between certain hours, above a certain battery SOC 100% or a battery voltage value , or a combination or custom sensor you could add.

See mineif.sh script.

The readings are taken from my Studer XTM device via API, see: [My other project](https://github.com/geek4unix/py-studer-api-examples)


```
neil@NMBP % while (true); do ./mineif.sh; sleep 60; done
Battery SOC: 88
SOC Limit: 90
Battery Volts: 49
Current Hour: 23
Start Hour: 0
End Hour: 23
DayTime Sensor: 45
Mining Allowed: false

Battery SOC: 88
SOC Limit: 90
Battery Volts: 49
Current Hour: 23
Start Hour: 0
End Hour: 23
DayTime Sensor: 45
Mining Allowed: false
```
