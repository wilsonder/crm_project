package com.example.crm_app.network

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded

interface ApiService {
    @GET("webservice.php")
    fun getChallenge(
        @Query("operation") operation: String,
        @Query("username") username: String
    ): Call<ChallengeResponse>

    @FormUrlEncoded
    @POST("webservice.php")
    fun login(
        @Field("operation") operation: String,
        @Field("username") username: String,
        @Field("accessKey") accessKey: String
    ): Call<LoginResponse>

    @GET("webservice.php")
    fun getContacts(
        @Query("operation") operation: String,
        @Query("sessionName") sessionName: String,
        @Query("query") query: String
    ): Call<ContactResponse>
}
