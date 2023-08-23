import 'dart:async';
import 'package:flutter/material.dart';

import 'base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  get todoStream => _eventStreamController.stream;

  Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) throw Exception("Not base event");
      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent baseEvent);

  @mustCallSuper
  dispose() {
    _eventStreamController.close();
  }
}
