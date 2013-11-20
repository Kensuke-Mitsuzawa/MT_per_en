#! /usr/bin/python
# -*- coding:utf-8 -*-

import codecs, sys, os, glob, re;

TMC_dir_path='./unziped_moses/lm_model/TMC';

file_stack=[];
for root, dirs, files in os.walk(TMC_dir_path):
    for f in glob.glob(os.path.join(root, '*')):
        file_stack.append(f);

sentence_stack=[];
one_sentence_stack=[];
without_period_flag=False;

for i, file_path in enumerate(file_stack):
    try:
        with codecs.open(file_path, 'r', 'utf-8') as lines:
            for line in lines:
                line=line.strip();
                if re.search(ur'\.', line):
                    items=line.split(u'.');
                    for item_index, part_of_sent in enumerate(items):
                        if without_period_flag==True and item_index==0:
                            one_sentence_stack.append(part_of_sent+u' .\n');
                            sentence_stack.append(u' '.join(one_sentence_stack));
                            one_sentence_stack=[];
                            without_period_flag=False;
                        elif not part_of_sent==u'' and item_index==(len(items)-1):
                            one_sentence_stack.append(part_of_sent);
                            without_period_flag=True;
                        elif not part_of_sent==u'':
                            #なんだか想定と違う動きもしてるっぽいけど，まあいいか
                            sentence_stack.append(part_of_sent+u' .\n');
                else:
                    without_period_flag=True;
                    one_sentence_stack.append(line);

    except IOError:
        pass;

with codecs.open('./unziped_moses/lm_model/unified_lm_train.data', 'w', 'utf-8') as f:
    f.writelines(sentence_stack);
