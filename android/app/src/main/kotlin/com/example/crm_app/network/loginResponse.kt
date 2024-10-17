package com.example.crm_app.network

data class LoginResponse(
    val success: Boolean,
    val result: LoginResult
)

data class LoginResult(
    val sessionName: String,
    val userId: String,
    val version: String,
    val vtigerVersion: String
)