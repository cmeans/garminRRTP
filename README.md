# garminRRTP

[ComEd](https://www.comed.com) [RRTP](https://hourlypricing.comed.com/live-prices/) [currenthouraverage](https://hourlypricing.comed.com/api?type=currenthouraverage) price (¢/kWh) exposed as a Glance on compatible Garmin devices.

Makes background HTTP requests against the ComEd RRTP API every five minutes, and updates the UI with the current hour average, and when it was set.

## Resources
* [Garmin Connect IQ](https://developer.garmin.com/connect-iq/overview/)
* [Garmin Connect IQ Support](https://forums.garmin.com/developer/connect-iq/f/discussion)

## Requirements
* Designed and built using [Visual Studio Code v1.69.2](https://code.visualstudio.com/)
* Leveraging VSC Plugin: [Monkey C v1.0.5](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c)

## Installation
The "compiled" application, `garminRRTP.PRG`, can be "side-loaded" onto the target device in the `/garmin/APPS` folder.
