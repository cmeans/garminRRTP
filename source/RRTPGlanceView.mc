import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;

(:glance)
class RRTPGlanceView extends WatchUi.GlanceView {

    const UNIT = "¢/kWh";

    function initialize() {
        GlanceView.initialize();

        var bgTmp = Application.getApp().getProperty(OSDATA);
        if (bgTmp instanceof String) {
            bgTmp = null;
        }
        if (bgTmp != null) {
            System.println("Initializing background data from the object store...");
            bgData = bgTmp;
        }
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("Enter RRTPGlanceView.onShow()");
    }

    function onUpdate(dc as Dc) as Void {
        GlanceView.onUpdate(dc);

        renderDirect(dc);
    }

    function renderDirect(dc as Dc) {
	    var height = dc.getHeight();

    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	dc.clear();

    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        //
        // Render price/rate.
        //
        var priceFontHeight = Graphics.getFontHeight(Graphics.FONT_SYSTEM_MEDIUM);
        var priceY = height/4 - priceFontHeight/2;
        var price = getPrice();

        dc.drawText(
            0,
            priceY,
            Graphics.FONT_SYSTEM_MEDIUM,
            price,
            Graphics.TEXT_JUSTIFY_LEFT);

        var priceUnitX = 5 + dc.getTextWidthInPixels(price, Graphics.FONT_SYSTEM_MEDIUM);
        var priceUnitY = 4 + priceY + Graphics.getFontHeight(Graphics.FONT_SYSTEM_XTINY) / 2;

        dc.drawText(
            priceUnitX,
            priceUnitY,
            Graphics.FONT_SYSTEM_XTINY,
            UNIT,
            Graphics.TEXT_JUSTIFY_LEFT);

        // Render "as of" time.
        dc.drawText(
            0,
            height*0.75 - Graphics.getFontHeight(Graphics.FONT_SYSTEM_TINY)/2,
            Graphics.FONT_SYSTEM_TINY,
            getAsOf(),
            Graphics.TEXT_JUSTIFY_LEFT);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function getPrice() as String {
        return bgData[PRICE].format("%0.1f");
    }

    function getAsOf() as String {
        var seconds = bgData[MILLISUTC] / 1000;
        var moment = new Time.Moment(seconds);
        var time = Time.Gregorian.info(moment, Time.FORMAT_LONG);

        return Lang.format(
            "as of $1$:$2$$3$",
            [
                time.hour < 13 ? time.hour : time.hour % 12,
                time.min.format("%02d"),
                time.hour < 12 ? "a" : "p"
            ]
        );
    }
}
