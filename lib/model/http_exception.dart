
class HttpExpection implements Exception {
  final String message;
  HttpExpection(this.message);

  @override
  String toString() {
    return message;
    // return super.toString();
  }
}
