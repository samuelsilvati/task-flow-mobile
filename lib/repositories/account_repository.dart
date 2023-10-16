import 'package:task_flow/models/account_model.dart';
import 'package:task_flow/repositories/store.dart';
import 'package:task_flow/repositories/tasks/dio.dart';

class AccountRepository {
  final _customDio = CustomDio();

  AccountRepository();

  Future<AccountModel> getAccount() async {
    final String userId = await Store.getString('sub');
    try {
      var url = '/user/$userId';
      var result = await _customDio.dio.get(url);
      return AccountModel.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(AccountModel user) async {
    try {
      await _customDio.dio.put('/edit-user', data: user.toJsonApi());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete() async {
    try {
      await _customDio.dio.delete("/delete");
    } catch (e) {
      rethrow;
    }
  }
}
