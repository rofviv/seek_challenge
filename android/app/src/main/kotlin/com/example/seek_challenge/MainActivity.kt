package com.example.seek_challenge

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.BiometricHostApi
import java.util.Timer
import kotlin.concurrent.timer

class MainActivity: FlutterFragmentActivity() {

    private val CHANNEL = "io.flutter.dev/seek"
    private lateinit var channel: MethodChannel
    private var timer: Timer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        val biometricHostApi = BiometricHandler(this, channel)
        BiometricHostApi.setUp(flutterEngine.dartExecutor.binaryMessenger, biometricHostApi)


        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    result.success("BATTERY EC")
                }
//                "startPeriodicMessages" -> {
//                    startPeriodicMessages()
//                    result.success(null)
//                }
//                "stopPeriodicMessages" -> {
//                    stopPeriodicMessages()
//                    result.success(null)
//                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        // Iniciar los mensajes periódicos automáticamente
//        startPeriodicMessages()
    }

    private fun startPeriodicMessages() {
        timer?.cancel()
        timer = timer(period = 5000) {
            runOnUiThread {
                channel.invokeMethod("periodicMessage", "Mensaje desde Kotlin: ${System.currentTimeMillis()}")
            }
        }
    }

    private fun stopPeriodicMessages() {
        timer?.cancel()
        timer = null
    }

    override fun onDestroy() {
        stopPeriodicMessages()
        super.onDestroy()
    }
}
