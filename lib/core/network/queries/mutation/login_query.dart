const String loginQuery = r'''
  mutation login($input: LoginInput!) {
  login(data: $input) {
    user{email, phonenumber,emailVerified,phoneNumberDetails{phoneNumber,callingCode,flag}}
    token
  }
}
''';
