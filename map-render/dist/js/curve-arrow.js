(function() {
  var CurveArrow;

  CurveArrow = (function() {
    function CurveArrow(canvas) {
      this.canvas = canvas;
    }

    CurveArrow.prototype.draw = function(x0, y0, x1, y1, color) {
      var H, L, W, ang, ctx, dx, dy, hx, l, xm, xp, ym, yp;
      W = x1 - x0;
      H = y1 - y0;
      L = Math.pow(Math.pow(H, 2) + Math.pow(W, 2), 0.5);
      l = 10;
      dx = l * H / L;
      dy = l * W / L;
      xm = (x0 + x1) / 2 + dx;
      ym = (y0 + y1) / 2 - dy;
      ctx = this.canvas.getContext('2d');
      ctx.fillStyle = color;
      ctx.strokeStyle = color;
      ctx.lineWidth = 4;
      ctx.lineCap = 'round';
      ctx.beginPath();
      ctx.moveTo(x0, y0);
      ctx.quadraticCurveTo(xm, ym, x1, y1);
      ctx.stroke();
      xp = (x0 + x1) / 2 + dx / 2;
      yp = (y0 + y1) / 2 - dy / 2;
      hx = 6;
      ang = Math.atan(~~(xp - x1) / ~~(y1 - yp));
      if (yp > y1) {
        ang += Math.PI;
      }
      ctx.save();
      ctx.translate(x1, y1);
      ctx.rotate(ang);
      ctx.beginPath();
      ctx.moveTo(-hx / 1.2, -hx);
      ctx.lineTo(0, 0);
      ctx.lineTo(hx / 1.2, -hx);
      ctx.stroke();
      return ctx.restore();
    };

    return CurveArrow;

  })();

  window.CurveArrow = CurveArrow;

}).call(this);

//# sourceMappingURL=../maps/curve-arrow.js.map