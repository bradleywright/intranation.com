#!/usr/bin/env python
from docutils.writers import html4css1
from docutils import nodes

class MyHTMLWriter(html4css1.Writer):
    """
    This docutils writer will use the MyHTMLTranslator class below.

    """
    def __init__(self):
        html4css1.Writer.__init__(self)
        self.translator_class = MyHTMLTranslator


class MyHTMLTranslator(html4css1.HTMLTranslator):
    """
    This is a translator class for the docutils system.
    It will produce a minimal set of html output.
    (No extra divs, classes over ids.)

    """
    def should_be_compact_paragraph(self, node):
        if(isinstance(node.parent, nodes.block_quote)):
            return 0
        return html4css1.HTMLTranslator.should_be_compact_paragraph(self, node)

    def visit_section(self, node):
        self.section_level += 1

    def depart_section(self, node):
        self.section_level -= 1

    def visit_reference(self, node):
        """Override base visit_reference as I don't want any of their classes.

        This is cribbed directly from: docutils.writers.html4css1.HTMLTranslator.visit_reference"""
        #atts = {'class': 'reference'}
        atts = {}
        if 'refuri' in node:
            atts['href'] = node['refuri']
            if ( self.settings.cloak_email_addresses
                 and atts['href'].startswith('mailto:')):
                atts['href'] = self.cloak_mailto(atts['href'])
                self.in_mailto = 1
            #atts['class'] += ' external'
            atts['rel'] = 'external'
        else:
            assert 'refid' in node, \
                   'References must have "refuri" or "refid" attribute.'
            atts['href'] = '#' + node['refid']
            #atts['class'] += ' internal'
        if not isinstance(node.parent, nodes.TextElement):
            assert len(node) == 1 and isinstance(node[0], nodes.image)
            #atts['class'] += ' image-reference'
        self.body.append(self.starttag(node, 'a', '', **atts))

if __name__ == '__main__':
    from docutils.core import publish_parts
    import sys
    parts = publish_parts(writer=MyHTMLWriter(), source=open(sys.argv[1]).read())
    print parts['body']
