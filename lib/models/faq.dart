import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class FAQ {
  final String question;
  final String answer;
  final String faqId;
  FAQ({
    required this.question,
    required this.answer,
    required this.faqId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
      'faqid': faqId,
    };
  }

  factory FAQ.fromMap(Map<String, dynamic> map) {
    return FAQ(
      question: map['question'] as String,
      answer: map['answer'] as String,
      faqId: map['faqid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FAQ.fromJson(String source) =>
      FAQ.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FAQ(question: $question, answer: $answer, faqId: $faqId)';
}
