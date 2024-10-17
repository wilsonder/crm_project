package com.example.crm_app.network

import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.math.BigInteger
import java.security.MessageDigest

object RequestHandler {

    private const val ACCESS_KEY = "6StH3Drqc9mdmOp2"

    fun getChallenge(username: String, callback: (String?) -> Unit) {
        RetrofitClient.apiService.getChallenge("getchallenge", username)
            .enqueue(object : Callback<ChallengeResponse> {
                override fun onResponse(
                    call: Call<ChallengeResponse>,
                    response: Response<ChallengeResponse>
                ) {
                    if (response.isSuccessful) {
                        val token = response.body()?.result?.token
                        callback(token)
                    } else {
                        callback(null)
                    }
                }

                override fun onFailure(call: Call<ChallengeResponse>, t: Throwable) {
                    callback(null)
                }
            })
    }

    fun login(username: String, token: String, callback: (String?) -> Unit) {
        // Generar accessKey usando MD5
        val accessKey = md5(token + ACCESS_KEY)

        RetrofitClient.apiService.login("login", username, accessKey)
            .enqueue(object : Callback<LoginResponse> {
                override fun onResponse(
                    call: Call<LoginResponse>,
                    response: Response<LoginResponse>
                ) {
                    if (response.isSuccessful) {
                        val sessionName = response.body()?.result?.sessionName
                        println("Login exitoso: Session Name = $sessionName")
                        callback(sessionName)
                    } else {
                        println("Login fallido: Error code = ${response.code()}")
                        callback(null)
                    }
                }

                override fun onFailure(call: Call<LoginResponse>, t: Throwable) {
                    callback(null)
                }
            })
    }

    // Función para generar MD5
    private fun md5(input: String): String {
        val md = MessageDigest.getInstance("MD5")
        return BigInteger(1, md.digest(input.toByteArray())).toString(16).padStart(32, '0')
    }

    // Función para obtener la lista de contactos
    fun getContacts(sessionName: String, callback: (List<Contact>?) -> Unit) {
        RetrofitClient.apiService.getContacts("query", sessionName, "select * from Contacts;")
            .enqueue(object : Callback<ContactResponse> {
                override fun onResponse(
                    call: Call<ContactResponse>,
                    response: Response<ContactResponse>
                ) {
                    if (response.isSuccessful) {
                        val contacts = response.body()?.result
                        println("Contacts retrieved successfully.")
                        callback(contacts)
                    } else {
                        println("Failed to retrieve contacts: Error code = ${response.code()}")
                        callback(null)
                    }
                }

                override fun onFailure(call: Call<ContactResponse>, t: Throwable) {
                    println("Failed to retrieve contacts: ${t.message}")
                    callback(null)
                }
            })
    }

}