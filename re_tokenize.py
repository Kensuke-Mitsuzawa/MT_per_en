#! /usr/bin/python
# -*- coding:utf-8 -*-
"""
tokenizeの仕方が不完全なので，完全にtokenizeするスクリプト
文末の.,?!が最後のtokenとくっついている現象に対処
"""
import re, sys, codecs;

input_path=sys.argv[1];
rewritten_stack=[];
with codecs.open(input_path, 'r', 'utf-8') as lines:
    for line in lines:
        """
        if re.search(ur'.+\.|!|\?$', line):
            new_line=re.sub(ur'(.+)(\.|!|\?)$', ur'\1 \2', line);
            rewritten_stack.append(new_line);
        elif re.search(ur'\s.+\.|\?|!\s\.', line):
            new_line=re.sub(ur'\s(.+)(\.|\?|!)\s\.', ur'\s\1 \2\s\.', line);
            print new_line;
            rewritten_stack.append(new_line);
        """
        if re.search(ur'\.+', line):
            line=re.sub(ur'(\.+)', ur' \1', line);
        if re.search(ur'\?+', line):
            line=re.sub(ur'(\?+)', ur' \1', line);
        if re.search(ur'!+', line):
            line=re.sub(ur'(!+)', ur' \1', line);
        if re.search(ur',+', line):
            line=re.sub(ur'(,+)', ur' \1', line);
        if re.search(ur'-(\w+)', line):
            line=re.sub(ur'-(\w+)', ur'- \1', line);
        if re.search(ur'"\w', line):
            line=re.sub(ur'"(\w)', ur'" \1', line);
        if re.search(ur'\w"', line):
            line=re.sub(ur'(\w)"', ur'\1 "', line);
        if re.search(ur'\."', line):
            line=re.sub(ur'(\.)"', ur'\1 "', line);
        if re.search(ur'\(\w', line):
            line=re.sub(ur'\((\w)', ur'( \1 "', line);
        if re.search(ur'\w\)', line):
            line=re.sub(ur'(\w+)\)', ur'\1 )', line);
        if re.search(ur'\w:', line):
            line=re.sub(ur'(\w):', ur'\1 :', line);
        rewritten_stack.append(line);

output_name=input_path+u'.rewritten';
with codecs.open(output_name, 'w', 'utf-8') as f:
    f.writelines(rewritten_stack);
