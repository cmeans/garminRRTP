// It is common for developers to wrap a makeWebRequest() call in a function
// as displayed below. The function defines the variables for each of the
// necessary arguments in a Communications.makeWebRequest() call, then passes
// these variables as the arguments. This allows for a clean layout of your web
// request and expandability.
import Toybox.Background;
import Toybox.System;
import Toybox.Communications;

(:background)
class RRTPServiceDelegate extends System.ServiceDelegate {

    const URL = "https://hourlypricing.comed.com/api?type=currenthouraverage";                         // set the url

    function initialize() {
        // System.println("Enter RRTPServiceDelegate.initialize()");
        ServiceDelegate.initialize();
    }

    function onReceive(responseCode as Number, data as Dictionary?) as Void {
        // System.println("Enter RRTPServiceDelegate.onReceive()");
        if (responseCode == 200) {
            showError = false;
            Background.exit(data);
            return;
        }

        showError = true;
        errorMessage = "Bad Response: " + responseCode;
    }

    function onTemporalEvent() {
        startGetRRTPRate();
    }

    function startGetRRTPRate() {
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :headers => {},
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        Communications.makeWebRequest(
            URL,
            null,
            options,
            method(:onReceive));
    }
}
