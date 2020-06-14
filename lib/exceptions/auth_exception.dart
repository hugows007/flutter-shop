class AuthException implements Exception{
  static const Map<String, String> errors ={
    "EMAIL_EXISTS" : "E-mail existe",
    "OPERATION_NOT_ALLOWED" : "Operação não permitida",
    "TOO_MANY_ATTEMPTS_TRY_LATER" : "Tente mais tarde",
    "EMAIL_NOT_FOUND" : "E-mail não encontrado",
    "INVALID_PASSWORD" : "Senha invalida",
    "USER_DISABLED" : "Usuario desativado",
    "INVALID_EMAIL" : "E-mail inválido",
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    if(errors.containsKey(key)){
      return errors[key];
    }else{
      return "Ocorre um erro na autenticação";
    }
  }

}