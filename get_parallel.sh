#bash関係のコマンドはぜんぶここに書いていく
python_vira_path=../../lib/Python_virastar/
#ここにmoses pathとISRMLのパスを記述する

#wget http://opus.lingfil.uu.se/download.php?f=TEP%2Fen-fa.txt.zip
#unzip ./download.php\?f\=TEP%2Fen-fa.txt.zip
#mkdir unziped_moses
#mv ./TEP.en-fa.* unziped_moses
#cd $python_vira_path
#pypy for_dataset.py -preper -w -m a_l ../../folklore_corpus/mt_per_en/unziped_moses/TEP.en-fa.fa ../../folklore_corpus/mt_per_en/unziped_moses/TEP.en-fa.fa.roman
#cd ../../folklore_corpus/mt_per_en/
#find ./unziped_moses/lm_model/TMC/ | grep "\txt$" | xargs cat > ./unziped_moses/lm_model/unified_lm_train.data
#cd $python_vira_path
#pypy for_dataset.py -preper -w -m a_l ../../folklore_corpus/mt_per_en/unziped_moses/lm_model/unified_lm_train.data\
	# ../../folklore_corpus/mt_per_en/unziped_moses/lm_model/unified_lm_train.data.roman

#ここにZWNJの処理をするすくりぷとを

#ここにデータセットの分割にかんするスクリプトを
train=599844
dev=6121
eval_=6121
cd ./unziped_moses
split TEP.en-fa.fa.roman -l $train proc1
mv proc1aa TEP.en-fa.fa.roman.train
split proc1ab -l $dev proc2
mv proc2aa TEP.en-fa.fa.roman.dev
mv proc2ab TEP.en-fa.fa.roman.eval 

split TEP.en-fa.en -l $train proc1
mv proc1aa TEP.en-fa.en.train
split proc1ab -l $dev proc2
mv proc2aa TEP.en-fa.en.dev
mv proc2ab TEP.en-fa.en.eval

rm proc1ab

mkdir fa_side
mv TEP.en-fa.fa.roman* fa_side/

mkdir en_side
mv TEP.en-fa.en* en_side/
