const String resentCodeQuery = r'''
  query resendVerificationCode($input: EmailInput!) {
  resendVerificationCode(data: $input)
}
''';
