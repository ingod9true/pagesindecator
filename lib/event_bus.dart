import 'dart:async';

class EventBus {

  StreamController _streamController;

  StreamController get streamController => _streamController;

  var sync = false;

  EventBus(bool sync){
    this.sync = sync;
    _streamController = StreamController.broadcast(sync: sync);
  }

  EventBus.customController(StreamController controller)
      : _streamController = controller;

  Stream<T> on<T>(){
  if (T == dynamic) {
  return streamController.stream as Stream<T>;
  } else {
  return streamController.stream.where((event) => event is T).cast<T>();
  }
  }

  void fire(event) {
    streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}
