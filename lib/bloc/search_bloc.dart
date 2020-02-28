import 'package:rotary/src/dto/search_dto.dart';
import 'package:rotary/src/models/search.dart';
import 'package:rotary/src/providers/http/search_provider.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  SearchProvider searchProvider = new SearchProvider();
  final _dataControllerOpc1 = BehaviorSubject<List<Search>>();
  final _dataControllerOpc2 = BehaviorSubject<List<Search>>();
  final _dataControllerOpc3 = BehaviorSubject<List<Search>>();
  static final SearchBloc _singleton = new SearchBloc._internal();

  factory SearchBloc() {
    return _singleton;
  }

  SearchBloc._internal();

  Stream<List<Search>> get dataOpc1Stream => _dataControllerOpc1.stream;

  List<Search> get dataOpc1 => _dataControllerOpc1.value;

  Stream<List<Search>> get dataOpc2Stream => _dataControllerOpc2.stream;

  List<Search> get dataOpc2 => _dataControllerOpc2.value;

  Stream<List<Search>> get dataOpc3Stream => _dataControllerOpc3.stream;

  List<Search> get dataOpc3 => _dataControllerOpc3.value;

  dispose() {
    _dataControllerOpc1?.close();
    _dataControllerOpc2?.close();
    _dataControllerOpc3?.close();
  }

  searchData(SearchDto searchDto, int opc) async {
    switch (opc) {
      case 1:
        await searchProvider.getSearchUsuarios(searchDto).then((res) {
          _dataControllerOpc1.sink.add(res);
        });
        break;
      case 2:
        await searchProvider.getSociosSeach(searchDto).then((res) {
          _dataControllerOpc2.sink.add(res);
        });
        break;
      case 3:
        await searchProvider.getSociosSeachInactivos().then((res) {
          _dataControllerOpc3.sink.add(res);
        });
        break;
      default:
    }
  }
}
