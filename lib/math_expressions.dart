import 'package:math_expressions/math_expressions.dart';

class MathExpressions {
  static String evaluateExpression(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toString();
  }

  static String simplifyExpression(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    return exp.simplify().toString();
  }

  static String differentiateExpression(String expression, String variable) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    Expression diff = exp.derive(variable);
    return diff.simplify().toString();
  }
}