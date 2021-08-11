#!/usr/bin/env python
'''
Copyright (c) 2015, Nick Ulle <nick.ulle@gmail.com>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
'''

from string import Template
from pandocfilters import toJSONFilter, RawBlock, RawInline


def unpack_code(value, language):
    ''' Unpack the body and language of a pandoc code element.
    Args:
        value       contents of pandoc object
        language    default language
    '''

    caption = ""
    title = ""
    [[label, classes, attributes], contents] = value

    if len(classes) > 0:
        language = classes[0]

    if len(attributes) > 0:
        caption = attributes[0][1]
    if len(attributes) > 1:
        title = attributes[1][1]

    return {'contents': contents, 'language': language,
            'caption': caption, 'label': label, 'title': title}


def unpack_metadata(meta):
    ''' Unpack the metadata to get pandoc-minted settings.
    Args:
        meta    document metadata
    '''
    settings = meta.get('pandoc-minted', {})
    if settings.get('t', '') == 'MetaMap':
        settings = settings['c']

        # Get language.
        language = settings.get('language', {})
        if language.get('t', '') == 'MetaInlines':
            language = language['c'][0]['c']
        else:
            language = None

        return {'language': language}

    else:
        # Return default settings.
        return {'language': 'text'}
    

def minted(key, value, format, meta):
    ''' Use minted for code in LaTeX.
    Args:
        key     type of pandoc object
        value   contents of pandoc object
        format  target output format
        meta    document metadata
    '''
    if format != 'latex':
        return

    # Determine what kind of code object this is.
    if key == 'CodeBlock':
        template = Template(
            '\\begin{longlisting}\n'\
            '\\begin{myminted}{$language}{$title}\n$contents\n\\end{myminted}\n'\
            '\\caption{$caption}\n\\label{$label}\n\\end{longlisting}'
        )
        Element = RawBlock
    elif key == 'Code':
        template = Template('\\mintinline[$attributes]{$language}{$contents}')
        Element = RawInline
    else:
        return

    settings = unpack_metadata(meta)

    code = unpack_code(value, settings['language'])

    return [Element(format, template.substitute(code))]


if __name__ == '__main__':
    toJSONFilter(minted)
