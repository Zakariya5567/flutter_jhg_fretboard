import 'package:reg_page/reg_page.dart';

mixin BaseController {
  Future<void> handleError(error) async {
    // hideLoading();
    if (error is BadRequestException) {
      showErrorToast(error.message);
    } else if (error is FetchDataException) {
      showErrorToast(error.message);
    } else if (error is ApiNotRespondingException) {
      showErrorToast('Oops! It tooks too long to respond');
    } else if (error is UnAutthorizedException) {
      showErrorToast(error.message == '' ? 'UnAuthorised' : '');
      debugLog(error.toString());
    } else {
      showErrorToast('Something went wrong $error');
    }
  }
}
