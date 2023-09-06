extension NetworkErrorExtension on String {
  String get rawValue {
    switch (this) {
      case 'bad_request':
        return 'Something went wrong';
      case 'invalid_process':
        return 'Time out';
      case 'invalid_request':
        return 'Invalid Request';
      case 'please_wait':
        return 'Please Wait';
      case 'invalid_user':
        return 'This email address already exists';
      case 'Internal Server Error':
        return 'Server Error';
      case 'Unauthorized':
        return 'Unauthorized';
      case 'not_found':
        return 'Not found';

      default:
        return 'Bad Request';
    }
  }

  String get toMessage {
    return rawValue;
  }
}
