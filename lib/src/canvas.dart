import 'dart:math';

import 'package:graficos/graficos.dart';

class Canvas {
  Bitmap stage;

  Canvas({int width = 4, int height = 4, Color color}) {
    if (color == null) {
      stage = Bitmap.fromBlack(width: width, height: height);
    }
    stage = Bitmap(width: width, height: height);
    stage.fill(color);
  }

  void drawLineGMC(Line line) {
    // x= coluna | y =linha
    final int _xIni = line.start.x;
    final int _yIni = line.start.y;
    final int xFim = line.end.x;
    final int yFim = line.end.y;
    //Preenche ponto inicial e final
    stage.putPixel(_xIni, _yIni, line.color);
    stage.putPixel(xFim, yFim, line.color);
    //se for mesma linha ou coluna
    int newXIni = _xIni;
    int newYIni = _yIni;
    int newXFim = line.end.x;
    int newYFim = line.end.y;
    void linhaColunaImpar() {
      if(newYFim>1){
      //altera matriz I
      newXFim = ((newXFim + 1) / 2).floor();
      newYFim = ((newYFim + 1) / 2).floor();
      stage.putPixel(_xIni, _yIni, line.color);
      stage.putPixel(newXFim, newYFim, line.color);
      //altera matriz II
      // newXIni = ((newXIni + 1) / 2).floor();
      // newYIni = ((newYIni + 1) / 2).floor();
      // newXIni = newXFim;
      // newYIni = newYFim;
      // stage.putPixel(newXIni, newYIni, line.color);
      // stage.putPixel(xFim, yFim, line.color);
      linhaColunaImpar();
      }
    }
     linhaColunaImpar();
    if (newYFim == 1 && newXFim > 1) {
      var teste = (newXFim / 2).floor();
      for (var k = 1; k <= teste; k++) {
        newXIni++;
        stage.putPixel(newXIni, newYIni, line.color);
        newXFim--;
        stage.putPixel(newXFim, newYFim, line.color);
      }
    }

    // no caso de se for 3 linhas
    // if (newYFim == 2 && newXFim >= 2) {
    //   var teste = (newXFim / 2).floor();
    //   print('teste= $teste');
    //   if(teste == 1 || teste == 0){
    //     stage.putPixel(newXIni+1, newYIni+1, line.color);
    //     stage.putPixel(newXFim-1, newYFim-1, line.color);
    //   }
    //   for (var k = 1; k < teste; k++) {
    //     newXIni++;
    //     newXFim--;
    //     stage.putPixel(newXIni, newYIni, line.color);
    //     stage.putPixel(newXFim, newYFim, line.color);
    //   }
    //   newYIni++;
    //   newYFim--;
    //   for (var k = 1; k < teste; k++) {
    //     newXIni++;
    //     newXFim--;
    //     stage.putPixel(newXIni, newYIni, line.color);
    //     stage.putPixel(newXFim, newYFim, line.color);
    //   }
    // }
  }

  void drawLine(Line line) {
    /*if (line.start.y == line.end.y) {
      for (var i = line.start.x; i <= line.end.x; i++) {
        stage.setPixel(Point(x: i, y: line.start.y), line.color);
      }
    } else if (line.start.x == line.end.x) {
      for (var i = line.start.y; i <= line.end.y; i++) {
        stage.setPixel(Point(x: line.start.x, y: i), line.color);
      }
    } else {*/
    //pinta pixel inicial
    // stage.setPixel(Point(x: line.start.x, y: line.start.y), line.color);
    //pinta pixel final
    //stage.setPixel(Point(x: line.end.x, y: line.end.y), line.color);
    int x0 = line.start.x;
    int y0 = line.start.y;
    int x1 = line.end.x;
    int y1 = line.end.y;

    int dx = x1 - x0;
    int dy = y1 - y0;
    int d = 2 * dx - dy;
    int incr_e = 2 * dy;
    int incr_ne = 2 * (dy - dx);
    int x = x0;
    int y = y0;
    stage.putPixel(x, y, line.color);
    while (x <= x1) {
      if (d <= 0) {
        d += incr_e;
        x++;
      } else {
        d += incr_ne;
        x++;
        y++;
      }
      stage.putPixel(x, y, line.color);
    }
  }

  void drawLine2(Line line) {
    Point initial_p = line.start;
    Point final_p = line.end;

    int posx = initial_p.x;
    int posy = initial_p.y;

    int fposx = final_p.x;
    int fposy = final_p.y;

    bool xdecres; // x decrescente
    bool ydecres; // y decrescente

    posx > fposx ? xdecres = true : xdecres = false;
    posy > fposy ? ydecres = true : ydecres = false;

    int dx = (fposx - posx).abs();
    int dy = (fposy - posy).abs();
    int decision;
    int inc_e;
    int inc_ne;

    Color pixel_color = line.color;

    //var line_size = sqrt(pow(dx, 2) + pow(dy, 2));

    //***************************************************************************
    // Modificação para desenhar retas com ângulo de 90 graus
    //***************************************************************************
    if (dx == 0) {
      // Verifica se a reta é invariante no eixo x
      int posi = posy;
      while (posi <= fposy) {
        stage.putPixel(posx, posi, pixel_color);
        ydecres ? posi-- : posi++;
      }
      return;
    }

    //***************************************************************************
    // Modificação para desenhar retas nos 8 octantes
    //***************************************************************************
    if (dy > dx) {
      decision = (2 * dx) - dy;
      inc_e = 2 * dx;
      inc_ne = 2 * (dx - dy);
      while (posy != fposy) {
        if (decision <= 0) {
          decision += inc_e;
          ydecres ? posy-- : posy++;
        } else {
          decision += inc_ne;
          ydecres ? posy-- : posy++;
          xdecres ? posx-- : posx++;
        }
        stage.putPixel(posx, posy, pixel_color);
      }
      return;
    }

    decision = (2 * dy) - dx;
    inc_e = 2 * dy;
    inc_ne = 2 * (dy - dx);
    while (posx != fposx) {
      if (decision <= 0) {
        decision += inc_e;
        xdecres ? posx-- : posx++;
      } else {
        decision += inc_ne;
        xdecres ? posx-- : posx++;
        ydecres ? posy-- : posy++;
      }
      stage.putPixel(posx, posy, pixel_color);
    }
  }

  String _colorToConsole(Color color) {
    var text = '██';
    var escape = String.fromCharCode(27);
    var resetAttributes = "${escape}[0m";
    var r = color.r;
    var g = color.g;
    var b = color.b;
    var foreground = "${escape}[38;2;$r;$g;${b}m";
    var cmd = foreground + text + resetAttributes;
    //'"${String.fromCharCode(27)}[38;2;255;0;0;48;2mCOLORFUL TEXT{String.fromCharCode(27)}[0m"'
    //var result = await Process.run('powershell', ['-Command', 'Write-Host', 'cmd'], runInShell: false);
    // stdout.write(result.stdout);
    //stdout.write(result.stderr);
    return cmd;

    /* var greyscale = color.r / 3 + color.g / 3 + color.b / 3;
    if (greyscale > 120) {
      return '1 ';
    } else {
      return '0 ';
    }*/
  }

  renderToConsole() {
    var result = '';
    var indice = 0;
    for (var y = 0; y < stage.height; y++) {
      var line = '';
      for (var x = 0; x < stage.width; x++) {
        line += _colorToConsole(stage.data[indice]);
        indice++;
      }
      result += line + '\r\n';
    }

    print(result);
  }
}
