package com.example.crm_app.network

data class Contact(
    val contact_no: String,
    val firstname: String,
    val lastname: String,
    val email: String
)

// Clase para manejar la respuesta de contactos
data class ContactResponse(
    val success: Boolean,
    val result: List<Contact>
)
