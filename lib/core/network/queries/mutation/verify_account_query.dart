const String verifyAccountQuery = r'''
  mutation verifyUser($input: VerifyUserInput!) {
  verifyUser(data: $input) {
    user{email, phonenumber,emailVerified}
    token
  }
}
''';
