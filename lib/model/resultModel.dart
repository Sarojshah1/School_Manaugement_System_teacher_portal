class Result {
  final String studentId;
  final String subjectId;
  final int term;
  final int marks;

  Result({required this.studentId, required this.subjectId, required this.term, required this.marks});


  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'subjectId': subjectId,
      'term': term,
      'marks': marks,
    };
  }
  @override
  String toString() {
    return '{ studentId: $studentId, subjectId: $subjectId, term: $term, marks: $marks }';
  }
}
