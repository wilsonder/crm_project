package com.example.crm_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import com.example.crm_app.network.RequestHandler


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.crm_app"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

       
            when (call.method) {
                "getChallenge" -> {
                    val username = call.argument<String>("username")
                    if (username != null) {
                        RequestHandler.getChallenge(username) { token ->
                            if (token != null) {
                                result.success(token)
                            } else {
                                result.error("UNAVAILABLE", "Token not available.", null)
                            }
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Username required", null)
                    }
                }
                "login" -> {
                    val username = call.argument<String>("username")
                    val accessKey = call.argument<String>("accessKey")
                    if (username != null && accessKey != null) {
                        RequestHandler.login(username, accessKey) { sessionName ->
                            if (sessionName != null) {
                                result.success(sessionName)
                            } else {
                                result.error("UNAVAILABLE", "Session name not available.", null)
                            }
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Username and AccessKey required", null)
                    }
                }

                "getContacts" -> {
                val sessionName = call.argument<String>("sessionName")
                if (sessionName != null) {
                    RequestHandler.getContacts(sessionName) { contacts ->
                        if (contacts != null) {
                            result.success(contacts.map { contact ->
                                mapOf(
                                    "contact_no" to contact.contact_no,
                                    "firstname" to contact.firstname,
                                    "lastname" to contact.lastname,
                                    "email" to contact.email
                                )
                            })
                        } else {
                            result.error("UNAVAILABLE", "Contacts not available", null)
                        }
                    }
                } else {
                    result.error("INVALID_ARGUMENT", "Session name required", null)
                }
            }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
