//
//  BotResponse.swift
//  PillPal-2.0
//
//  Created by 47GOParticipant on 7/16/25.
//

import Foundation

func getBotResponse(message: String) -> String {
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("how are you") {
        return "I'm doing great, thanks for asking!"
    }
    else if tempMessage.contains("hi") || tempMessage.contains("hello") {
        return "Hello! How can I help?"
    }
    else if tempMessage.contains("goodbye") {
        return "Goodbye!"
    }
    else if tempMessage.contains("pain") || tempMessage.contains("inflammation") || tempMessage.contains("fever") || tempMessage.contains("headache") {
        return "I recommend taking Ibuprofen."
    }
    else if tempMessage.contains("acid reflux"){
        return "I recommend taking Omeprazole."
    }
    else if tempMessage.contains("sneezing") ||  tempMessage.contains("itching") || tempMessage.contains("watery eyes") || tempMessage.contains("eyes watery") || tempMessage.contains("runny nose"){
        return "I recommend taking Cetirizine(Zyrtec)."
    }
    else if tempMessage.contains("diaherra") || tempMessage.contains("nausea") {
        return "I recommend taking Pepto bismol(bismath subsacylate)."
    }
    else if tempMessage.contains("heartburn") || tempMessage.contains("indigestion") {
        return "I recommend taking Omeprazole or Pepto bismol(bismath subsacylate)."
    }
    else if (tempMessage.contains("dispose") || tempMessage.contains("throw")) && tempMessage.contains("ibuprofen"){
        return "The best way to despose is to drop off them at a drug take-back location or mail them using a prepaid drug mail-back envelope."
    }
    else if tempMessage.contains("store") || tempMessage.contains("Cetirizine") {
        return "Store the medicine in a closed container at room temperature, away from heat, moisture, and direct light."
    }
    else {
        return "I recommend talking to a healthcare professional. They can provide personalized advice and guidance based on your individual symptoms and medical history."
    }
}
