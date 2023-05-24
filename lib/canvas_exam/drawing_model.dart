import 'dart:math';

import 'package:make_source/canvas_exam/edge_painter.dart';
import 'package:make_source/canvas_exam/node_painter.dart';

class DrawingModel {
  final List<NodePainter> _nodeList = List.empty(growable: true);
  final List<EdgePainter> _edgeList = List.empty(growable: true);

  DrawingModel() {
    _nodeList.clear();
    _edgeList.clear();
  }

  void addNode(NodePainter node) {
    _nodeList.add(node);
  }

  void addEdge(EdgePainter edge) {
    _edgeList.add(edge);
  }

  NodePainter? getNode(x, y) {
    const radius = 30.0;
    for (final node in _nodeList) {
      final distance = sqrt((node.x - x) * (node.x - x) + (node.y - y) * (node.y - y));
      if (distance <= radius) {
        return node;
      }
    }
    return null;
  }

  List getNodeList() {
    return _nodeList;
  }

  List getEdgeList() {
    return _edgeList;
  }
}
