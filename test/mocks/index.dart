import 'package:bytebanksqlite/api/apis/TransactionApi.dart';
import 'package:bytebanksqlite/dao/ContactDAO.dart';
import 'package:mockito/mockito.dart';

class MockContactDAO extends Mock implements ContactDAO {}

class MockTransactionApi extends Mock implements TransactionApi {}