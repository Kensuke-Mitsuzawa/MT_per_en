python_vira_path="../../lib/Python_virastar/"
SRILMdirectory="/cl/work/smt/tools/srilm/bin/i686-m64/"
MOSESdirectory="/cl/work/smt/tools/mosesdecoder/"

#翻訳モデル用のファイルを構築
#wget http://opus.lingfil.uu.se/download.php?f=TEP%2Fen-fa.txt.zip
#unzip ./download.php\?f\=TEP%2Fen-fa.txt.zip
#mkdir unziped_moses
#mv ./TEP.en-fa.* unziped_moses
#echo "Shuffleing training parallel corpus..."
#pypy shuffle_TEC.py
#cd $python_vira_path
#pypy for_dataset.py -preper -w -m a_l ../../folklore_corpus/mt_per_en/unziped_moses/TEP.en-fa.fa ../../folklore_corpus/mt_per_en/unziped_moses/TEP.en-fa.fa.roman
#cd ../../folklore_corpus/mt_per_en/
#echo "Normalizing TEP corpus..."
#pypy re_tokenize.py ./unziped_moses/TEP.en-fa.fa.roman
#pypy re_tokenize.py ./unziped_moses/TEP.en-fa.en

#言語モデル用のファイル構築
#どうもこの命令ではきちんと文がつながっていない気がする
#find ./unziped_moses/lm_model/TMC/ | grep "\txt$" | xargs cat > ./unziped_moses/lm_model/unified_lm_train.data
#こっちの命令をつかうこと
#pypy TMC_unify.py
#cd $python_vira_path
#pypy for_dataset.py -preper -w -m a_l ../../folklore_corpus/mt_per_en/unziped_moses/lm_model/unified_lm_train.data\
	# ../../folklore_corpus/mt_per_en/unziped_moses/lm_model/unified_lm_train.data.roman
#cd ../../folklore_corpus/mt_per_en/
#echo "Normalizing TMC corpus..."
#pypy re_tokenize.py ./unziped_moses/lm_model/unified_lm_train.data.roman

#: <<'#__COMMENT_OUT__'
#ここにデータセットの分割
train=599844
dev=6121
eval_=6121
cd ./unziped_moses
#split TEP.en-fa.fa.roman.rewritten -l $train proc1
split TEP.en-fa.fa.shuffled -l $train proc1
mv proc1aa TEP.en-fa.roman.train.fa
split proc1ab -l $dev proc2
mv proc2aa TEP.en-fa.roman.dev.fa
mv proc2ab TEP.en-fa.roman.eval.fa 

#split TEP.en-fa.en.rewritten -l $train proc1
split TEP.en-fa.en.shuffled -l $train proc1
mv proc1aa TEP.en-fa.roman.train.en
split proc1ab -l $dev proc2
mv proc2aa TEP.en-fa.roman.dev.en
mv proc2ab TEP.en-fa.roman.eval.en

rm proc1ab

cd ../
echo "File split is finished. It's getting start training translation model"
#$SRILMdirectory/ngram-count -order 3 \
#	-text ./unziped_moses/lm_model/unified_lm_train.data.roman.rewritten \
#	-lm ./unziped_moses/lm_model/TMC.lm \
#	-kndiscount \
#	-unk

$SRILMdirectory/ngram-count -order 3 \
	-text ./unziped_moses/lm_model/unified_lm_train.data \
	-lm ./unziped_moses/lm_model/TMC.lm \
	-kndiscount \
	-unk

$MOSESdirectory/scripts/training/train-model.perl -root-dir ./unziped_moses/ \
	-corpus unziped_moses/TEP.en-fa.roman.train \
	-f fa -e en \
	-alignment grow-diag-final-and \
	-lm 0:3:/work/kensuke-mi/tmp_working/persian_preprocessing/folklore_corpus/mt_per_en/unziped_moses/lm_model/TMC.lm\
	-external-bin-dir /cl/work/smt/tools/giza-pp/bin\


#check if moses system works correctly
#$MOSESdirectory/bin/moses -f ./unziped_moses/model/moses.ini

#Optimization with mert-moses.pl. It takes huge time.(option:--threds:multi threds, --nbest:output 20 best result)
/cl/work/smt/tools/mosesdecoder/scripts/training/mert-moses.pl ./unziped_moses/TEP.en-fa.roman.dev.fa ./unziped_moses/TEP.en-fa.roman.dev.en /cl/work/smt/tools/mosesdecoder/bin/moses ./unziped_moses/model/moses.ini --mertdir /cl/work/smt/tools/mosesdecoder/bin/ --nbest 20 --threads=10

#__COMMENT_OUT__

$MOSESdirectory/bin/moses -f ./unziped_moses/model/moses.ini < ./unziped_moses/TEP.en-fa.roman.eval.fa > ./unziped_moses/mytrasnlation.en
$MOSESdirectory/scripts/generic/multi-bleu.perl ./unziped_moses/TEP.en-fa.roman.eval.en < ./unziped_moses/mytrasnlation.en > before_mert.txt

$MOSESdirectory/bin/moses -f ./mert-work/moses.ini < ./unziped_moses/TEP.en-fa.roman.eval.fa > ./unziped_moses/mytrasnlation.en
$MOSESdirectory/scripts/generic/multi-bleu.perl ./unziped_moses/TEP.en-fa.roman.eval.en < ./unziped_moses/mytrasnlation.en > after_mert.txt

python ~/smail.py
