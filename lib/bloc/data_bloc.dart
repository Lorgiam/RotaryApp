import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _dataController = BehaviorSubject<Map<String, dynamic>>();
  final dataObject = Map<String, dynamic>();
  static final DataBloc _singleton = new DataBloc._internal();

  factory DataBloc() {
    return _singleton;
  }

  DataBloc._internal();

  Stream<Map<String, dynamic>> get dataStream => _dataController.stream;

  Map<String, dynamic> get data => _dataController.value;

  dispose() {
    _dataController?.close();
  }

  insertData(Map<String, dynamic> data) {
    dataObject.addAll(data);
    _dataController.add(dataObject);
  }

  Map<String, dynamic> obtenerData() {
    Map<String, dynamic> dataR;
    _dataController.stream.listen((data) {
      dataR.addAll(data);
    });
    return dataR;
  }
}
