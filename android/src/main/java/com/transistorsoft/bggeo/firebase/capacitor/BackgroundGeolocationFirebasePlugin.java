package com.transistorsoft.bggeo.firebase.capacitor;

import android.util.Log;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import com.transistorsoft.tsfirebaseproxy.TSFirebaseProxy;

import org.json.JSONException;

@CapacitorPlugin(name = "BackgroundGeolocationFirebase")
public class BackgroundGeolocationFirebasePlugin extends Plugin {
    public static final String TAG = "BackgroundGeolocationFirebasePlugin";
    private boolean isRegistered;

    @Override
    public void load() {
        Log.d(TAG, "load");
        isRegistered = false;
        super.load();
    }

    @PluginMethod
    public void configure(PluginCall call) {
        JSObject options = call.getObject("options");
        Context context = getContext().getApplicationContext();
        Log.d(TAG, " - configure: " + options);

        TSFirebaseProxy proxy = TSFirebaseProxy.getInstance(context);

        if (options.has(TSFirebaseProxy.FIELD_LOCATIONS_COLLECTION)) {
            proxy.setLocationsCollection(options.getString(TSFirebaseProxy.FIELD_LOCATIONS_COLLECTION));
        }
        if (options.has(TSFirebaseProxy.FIELD_GEOFENCES_COLLECTION)) {
            proxy.setGeofencesCollection(options.getString(TSFirebaseProxy.FIELD_GEOFENCES_COLLECTION));
        }
        if (options.has(TSFirebaseProxy.FIELD_UPDATE_SINGLE_DOCUMENT)) {
            proxy.setUpdateSingleDocument(options.getBoolean(TSFirebaseProxy.FIELD_UPDATE_SINGLE_DOCUMENT));
        }
        proxy.save(context);

        if (!isRegistered) {
            isRegistered = true;
            proxy.register(context);
        }

        JSObject result = new JSObject();
        call.resolve(result);
    }
}
