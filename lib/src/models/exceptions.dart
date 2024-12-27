enum MemosExceptionsTypes {
  emptyRecordsException,
  listBucketContentException,
  uploadingException,
  authenticationException,
  mediaException,
}



class CustomMemosException implements Exception {
  final String message;
  final MemosExceptionsTypes type;
  final String? subMessage;
  CustomMemosException(
      {required this.message, required this.type, this.subMessage});

  factory CustomMemosException.emptyRecordsException() {
    return CustomMemosException(
      message: 'Ups! there are no ideas recorded yet.',
      type: MemosExceptionsTypes.emptyRecordsException,
    );
  }

  factory CustomMemosException.listBucketContentException() {
    return CustomMemosException(
      message: 'Ups! Something wrong happened when trying to get your ideas.',
      subMessage: 'Please try again later',
      type: MemosExceptionsTypes.listBucketContentException,
    );
  }

  factory CustomMemosException.uploadingException() {
    return CustomMemosException(
      message:
          'Ups! Something wrong happened when trying to upload your ideas.',
      subMessage: 'Please try again later',
      type: MemosExceptionsTypes.uploadingException,
    );
  }

  factory CustomMemosException.authenticationException() {
    return CustomMemosException(
      message: 'Ups! Something when wrong',
      subMessage: 'Please try again later',
      type: MemosExceptionsTypes.authenticationException,
    );
  }

  factory CustomMemosException.mediaException() {
    return CustomMemosException(
      message: 'Ups! Something when wrong when trying to play your idea',
      subMessage: 'Please try again later',
      type: MemosExceptionsTypes.mediaException,
    );
  }
}
