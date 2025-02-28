package com.example.seek_challenge

import android.content.Intent
import android.os.Build
import android.provider.Settings
import androidx.biometric.BiometricManager
import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.BiometricHostApi

class BiometricHandler(private val activity: FlutterFragmentActivity, private val channel: MethodChannel) : BiometricHostApi {

    private val methodBiometric = "method_biometric"

    override fun isBiometricAvailable(): Boolean {
        val biometricManager = BiometricManager.from(activity)
        val authenticators = if(Build.VERSION.SDK_INT >= 30) {
            BIOMETRIC_STRONG or DEVICE_CREDENTIAL
        } else BIOMETRIC_STRONG
        return biometricManager.canAuthenticate(authenticators) == BiometricManager.BIOMETRIC_SUCCESS
    }

    override fun showBiometricPrompt(
        title: String,
        description: String,
    ) {

        val manager = BiometricManager.from(activity)
        val authenticators = if(Build.VERSION.SDK_INT >= 30) {
            BIOMETRIC_STRONG or DEVICE_CREDENTIAL
        } else BIOMETRIC_STRONG

        val promptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle(title)
            .setDescription(description)
            .setAllowedAuthenticators(authenticators)
            .setConfirmationRequired(false)

        if (Build.VERSION.SDK_INT < 30) {
            promptInfo.setNegativeButtonText("Cancel")
        }

        when(manager.canAuthenticate(authenticators)) {
            BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE -> {
                channel.invokeMethod(methodBiometric, BiometricResult(false, "BIOMETRIC_ERROR_HW_UNAVAILABLE").toMap())
                return
            }
            BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> {
                channel.invokeMethod(methodBiometric, BiometricResult(false, "BIOMETRIC_ERROR_NO_HARDWARE").toMap())
                return
            }
            BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> {
                channel.invokeMethod(methodBiometric, BiometricResult(false, "Biometric not configured").toMap())
                if(Build.VERSION.SDK_INT >= 30) {
                    val enrollIntent = Intent(Settings.ACTION_BIOMETRIC_ENROLL).apply {
                        putExtra(
                            Settings.EXTRA_BIOMETRIC_AUTHENTICATORS_ALLOWED,
                            BIOMETRIC_STRONG or DEVICE_CREDENTIAL
                        )
                    }
                    activity.startActivity(enrollIntent)
                }
                return
            }
            else -> Unit
        }

        val prompt = BiometricPrompt(
            activity,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    super.onAuthenticationError(errorCode, errString)
                    channel.invokeMethod(methodBiometric, BiometricResult(false, errString.toString()).toMap())
                }

                override fun onAuthenticationSucceeded(authResult: BiometricPrompt.AuthenticationResult) {
                    super.onAuthenticationSucceeded(authResult)
                    channel.invokeMethod(methodBiometric, BiometricResult(true, null).toMap())
                }

                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    channel.invokeMethod(methodBiometric, BiometricResult(false, "Authentication Failed").toMap())
                }
            }
        )

        prompt.authenticate(promptInfo.build())
    }

    data class BiometricResult(
        val success: Boolean,
        val error: String?
    ) {
        fun toMap(): Map<String, Any?> {
            return mapOf(
                "success" to success,
                "error" to error
            )
        }
    }

}
