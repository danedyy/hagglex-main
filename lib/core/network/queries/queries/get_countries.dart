const String getCountries = '''
  query {
   getActiveCountries{
      _id
      name
      flag
      callingCode
      currencyCode
   }
}
''';
