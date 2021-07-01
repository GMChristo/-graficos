import 'package:graficos/graficos.dart';

void main(List<String> args) async {
  // coluna x linha
  var canvas = Canvas(width: 20, height: 5, color: Color.white());

  //canvas.stage.setPixel(Point(x: 3, y: 3), Color.white());

  // canvas.drawLine(Line(start: Point(x: 0, y: 0), end: Point(x: 7, y: 0), color: Color.red()));

  // canvas.drawLine(Line(start: Point(x: 0, y: 0), end: Point(x: 0, y: 7), color: Color.red()));

  // canvas.drawLine(Line(start: Point(x: 0, y: 0), end: Point(x: 3, y: 3), color: Color.red()));
  canvas.drawLineGMC(Line(start: Point(x: 0, y: 0), end: Point(x: 19, y: 4), color: Color.red()));

  canvas.renderToConsole();
}
