#! /usr/bin/python
# -*- coding:utf-8 -*-

import codecs, sys, random;

en_side_path='./unziped_moses/TEP.en-fa.en';
fa_side_path='./unziped_moses/TEP.en-fa.fa';

parallel_stack=[];
fa_side_line_que=codecs.open(fa_side_path, 'r', 'utf-8').readlines();
with codecs.open(en_side_path, 'r', 'utf-8') as lines:
    for i, line in enumerate(lines):
        parallel_stack.append( (i, line, fa_side_line_que[i]) );

random.shuffle(parallel_stack);

en_shuffled=codecs.open('./unziped_moses/TEP.en-fa.en.shuffled', 'w', 'utf-8');
fa_shuffled=codecs.open('./unziped_moses/TEP.en-fa.fa.shuffled', 'w', 'utf-8');

for parallel_tuple in parallel_stack:
    en_shuffled.write(parallel_tuple[1]);
    fa_shuffled.write(parallel_tuple[2]);

en_shuffled.close();
fa_shuffled.close();
