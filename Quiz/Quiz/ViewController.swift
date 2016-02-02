//
//  ViewController.swift
//  Quiz
//
//  Created by David Stancu on 2/2/16.
//  Copyright © 2016 David Stancu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
    }
    
    let questions: [String] = [
        "From what is cognac made?",
        "What is 7+7",
        "What is the capital of Vermont?",
        "How many people does it take to set up a Hadoop cluster with a Jenkins job?"
    ]
    
    let answers: [String] = [
        "Grapes",
        "14",
        "Montpelier",
        "Too many"
    ]
    
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        ++currentQuestionIndex;
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0;
        }
        
        let question: String = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }

}

