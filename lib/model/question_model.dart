import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel{
  final String question,answer,category,id, interestingFact;
  final List option;
  final String image;

  QuestionModel({
    required this.interestingFact,
    required this.id,
    required this.question,
    required this.answer,
    required this.image,
    required this.category,
    required this.option,
  });



  Map<String, dynamic> toJson(){
    return {
      "interestingFact": interestingFact,
      "question":question,
      "answer":answer,
      "image":image,
      "option":option,
      "category":category,
      "id":id
    };
  }

  factory QuestionModel.fromJson(DocumentSnapshot data){
    return QuestionModel(
      id: data['id'],
      question: data['question'],
      answer: data["answer"],
      image: data["image"],
      category: data["category"],
      option: data['option'],
      interestingFact: data['interestingFact'],
    );
  }

  QuestionModel copyWith({
    String? question1,
    String? answer1,
    String? image1,
    String? category1,
    String? iD,
    String? interestingFact1,
    List<String>? option1
}){
   return QuestionModel(
       id: iD??id,
       question:question1??question,
       answer: answer1??answer,
       image: image1??image,
       category: category1??category,
       option:option1??option,
       interestingFact: interestingFact1??interestingFact
   ) ;
}
}