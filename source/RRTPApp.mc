import Toybox.Application;
import Toybox.Background;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

const OSDATA = "rrptdata";

const PRICE     = 0;
const MILLISUTC = 1;

var bgDataOld = { "price" => "Unknown", "millisUTC" => "1659137400000" };
var bgData = { PRICE => 0.0, MILLISUTC => 0 };

// Tracks if the last response from ComEd was bad.
var badResponse as Boolean = false;
var hasBackground as Boolean = false;

var showError as Boolean = false;
var errorMessage as String = "";

(:background :glance)
class RRTPApp extends Application.AppBase {

    const UPDATE_FREQUENCY_SECONDS as Long = 5 * 60;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        startBackground();

        return [ new RRTPView() ] as Array<Views or InputDelegates>;
    }

    function getServiceDelegate() {
        return [new RRTPServiceDelegate()];
    }

    function onBackgroundData(data) {
        bgData = marshallBgData(data);
        System.println(bgData);

        Application.getApp().setProperty(OSDATA, bgData);
        WatchUi.requestUpdate();
    }

    function getGlanceView() as Lang.Array<WatchUi.GlanceView> or Null {
        startBackground();

        return [new RRTPGlanceView()];
    }

    function startBackground() {
        if (hasBackground) {
            return;
        }

        if (Toybox.System has :ServiceDelegate) {
            hasBackground = true;

            var duration = new Time.Duration(UPDATE_FREQUENCY_SECONDS);
            Background.registerForTemporalEvent(duration);
        }
        else {
            showError = true;
            errorMessage = "Background service not available on this device";
        }
    }

    function marshallBgData(data as Dictionary) as Dictionary {
        return
            {
                PRICE     => data[0]["price"].toFloat(),
                MILLISUTC => data[0]["millisUTC"].toLong()
            };
    }
}

function getApp() as RRTPApp {
    return Application.getApp() as RRTPApp;
}