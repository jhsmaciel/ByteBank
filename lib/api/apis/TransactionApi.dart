import 'dart:async';
import 'dart:convert';
import 'package:bytebanksqlite/api/HttpException.dart';
import 'package:bytebanksqlite/api/WebClient.dart';
import 'package:bytebanksqlite/model/Transaction.dart';

class TransactionApi {
  Future<List<Transaction>> findAll() async {
    final transactions = await httpClientWithInterceptor.get(basePath);
    final List<dynamic> listDecoded = jsonDecode(transactions.body);
    return listDecoded
        .map((transact) => Transaction.fromJson(transact))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    try {
      final response = await httpClientWithInterceptor.post(
        basePath,
        body: jsonEncode(transaction.toJson()),
        headers: {'password': password},
      );
      return Transaction.fromJson(jsonDecode(response.body));
    } on TimeoutException catch (e) {
      throw Exception('Timeout server response');
    } on HttpException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw Exception('Unknown error');
    }
  }
}
