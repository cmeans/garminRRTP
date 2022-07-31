import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class RRTPView extends WatchUi.View {

    function initialize() {
        View.initialize();

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
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("Enter onShow()");
        // price = Background.getBackgroundData();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        System.println("Enter onUpdate()");

        var priceString = Lang.format("$1$ ¢/kWh", [bgData]);
        System.println(priceString);
        var rate = View.findDrawableById("id_rate");
        rate.setText(priceString);

        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
