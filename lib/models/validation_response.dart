class ValidationResponse {
  final bool success;
  final int statusCode;
  final String mensage;

  ValidationResponse(this.success, this.mensage, this.statusCode);
}
