//
//  Conjugation.swift
//  GoFrench
//
//  Created by Sandeep Singh on 2023-11-24.
//

class Conjugation {
    let type: String
    let tense: String
    let conjugatedForm: String
    let subject: String

    init(type: String, tense: String, conjugatedForm: String, subject: String) {
        self.type = type
        self.tense = tense
        self.conjugatedForm = conjugatedForm
        self.subject = subject
    }
}
