const String registerQuery = '''
  mutation register(\$input: CreateUserInput!) {
  register(data: \$input) {
    user{email, phonenumber,phonenumber,referralCode,phoneNumberDetails{phoneNumber,callingCode,flag}}
    token
  }
}
''';
