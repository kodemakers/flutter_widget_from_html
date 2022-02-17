part of '../core_ops.dart';

const kAttributeAHref = 'href';
const kAttributeAName = 'name';
const kTagA = 'a';

class TagA {
  final WidgetFactory wf;

  TagA(this.wf);

  BuildOp get buildOp => BuildOp(
        defaultStyles: (_) => const {
          kCssTextDecoration: kCssTextDecorationUnderline,
        },
        onTree: (tree) {
          final href = tree.element.attributes[kAttributeAHref];
          if (href == null) {
            return;
          }

          final url = wf.urlFull(href) ?? href;
          final recognizer = wf.buildGestureRecognizer(
            tree,
            onTap: () => wf.onTapUrl(url),
          );
          if (recognizer == null) {
            return;
          }

          tree.styleBuilder.enqueue(_builder, recognizer);
        },
      );

  static HtmlStyle _builder(HtmlStyle style, GestureRecognizer value) =>
      style.copyWith(gestureRecognizer: value);
}
