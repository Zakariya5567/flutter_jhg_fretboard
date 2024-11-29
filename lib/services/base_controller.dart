import 'package:reg_page/reg_page.dart' as l;
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
      l.debugLog(error.toString());
      // if (!(error.url.contains('Account'))) {
      //   await UserSession.deleteUser();
      //   Nav.off(const LoginScreen());
      // }
    } else {
      showErrorToast('Something went wrong $error');
    }
  }
}
