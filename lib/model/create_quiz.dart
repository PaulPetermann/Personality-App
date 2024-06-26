import 'dart:convert';

class Allquiz{
  final quizzes = jsonDecode('''
  {
      "quizzes":[
          {
              "name": "Introvert versus extrovert",
              "questions":[
                  {
                      "title": "I enjoy social gatherings.",
                      "choices":[
                          {
                              "answer": "Yes",
                              "points": 5
                          },
                          {
                              "answer": "No",
                              "points":10
                          }
                      ]
                  },
                  {
                      "title": "I prefer detailed planning over spontaneity.",
                      "choices":[
                          {
                              "answer": "Yes",
                              "points": 5
                          },
                          {
                              "answer": "No",
                              "points":10
                          }
                      ]
                  },
                  {
                      "title": "I often think about the meaning of life.",
                      "choices":[
                          {
                              "answer": "1",
                              "points": 5
                          },
                          {
                              "answer": "2",
                              "points": 7
                          },
                          {
                              "answer": "3",
                              "points": 8
                          },
                          {
                              "answer": "4",
                              "points":10
                          }
                      ]
                  },
                  {
                      "title": "How Important is the Family to you!",
                      "choices":[
                          {
                              "answer": "Yes",
                              "points": 5
                          },
                          {
                              "answer": "No",
                              "points":10
                          }
                      ]
                  }
              ],
              "results":[
                  {
                      "maxpoints": 5,
                      "text": "you are an introvert"
                  },
                  {
                      "maxpoints": 10,
                      "text": "you are an ambivert"
                  },
                  {
                      "maxpoints": 15,
                      "text": "you are an extrovert"
                  }
              ]
          }
      ]
  }
  ''');
}