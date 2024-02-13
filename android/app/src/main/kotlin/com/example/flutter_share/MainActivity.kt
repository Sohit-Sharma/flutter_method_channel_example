package com.example.flutter_share

import android.content.pm.PackageManager
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    private val CHANNEL = "MainChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method.equals("instagram")) {
                result.success("success")
                checkAppInstalled(call.arguments.toString());
            } else if (call.method.equals("twitter")) {
                result.success("success")
                checkAppInstalled(call.arguments.toString());
            } else if (call.method.equals("thread")) {
                result.success("success")
                checkAppInstalled(call.arguments.toString());
            } else {
                result.notImplemented()
            }
        }
    }

    private fun checkAppInstalled(arguments: String) {
        val check=appInstalledOrNot(arguments)
        if(check){
            val launchIntent = packageManager.getLaunchIntentForPackage(arguments)
            launchIntent?.let { startActivity(it) }
        }else{
            Toast.makeText(applicationContext,"App not installed",Toast.LENGTH_SHORT).show();
            Log.e("Error", "App not installed");
        }
    }

    private fun appInstalledOrNot(uri: String): Boolean {
        val pm = packageManager
        try {
            pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES)
            return true
        } catch (e: PackageManager.NameNotFoundException) {
        }
        return false
    }

}
