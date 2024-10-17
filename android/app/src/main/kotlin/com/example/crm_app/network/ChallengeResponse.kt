package com.example.crm_app.network

data class ChallengeResponse(
    val success: Boolean,
    val result: Result
)

data class Result(
    val token: String
)
