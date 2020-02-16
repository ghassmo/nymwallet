package com.example.nymfinal;

import android.os.Bundle;
import android.util.Log;

import java.io.File;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import nymmobile.Nymmobile;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        String homeDirectory = getApplicationContext().getFilesDir().getAbsolutePath();
        new RunServerTask(homeDirectory).execute();

    }

    static class RunServerTask extends android.os.AsyncTask {

        private final String homeDirectory;

        public RunServerTask(String homeDirectory) {
            this.homeDirectory = homeDirectory;
        }

        @Override
        protected Object doInBackground(Object[] objects) {

            File userDirectory = new File(homeDirectory, "user");
            String providerID = "54U6krAr-j9nQXFlsHk3io04_p0tctuqH71t7w_usgI=";
            String userid = "user";
            if (!userDirectory.exists()) {
                userDirectory.mkdirs();
                nymmobile.Nymmobile.generateKeyPair(userid, userDirectory.getAbsolutePath(), providerID);
            }

            nymmobile.Nymmobile.startWebsocket(userid, userDirectory.getAbsolutePath());

            return null;
        }
    }
}
