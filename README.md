#Machine Translation model between Persian and English

#Files you need
* TEP: Teheran English Parallel corpus, you can download form OPUS project page(download command is written in get\_parallel.sh)
* TMC: Teheran Monollingual Corpus, this corpus is needed to construct language model on persian side. This corpus is not open to public. You can contact project leader [Mr.Mohammad Taher Pilehvar](http://www.pilevar.com/taher/) and [TMC introduction page](http://ece.ut.ac.ir/nlp/resources.htm)
* Python\_virastar: transliteration library between arabic character and roman character. [About detail](https://github.com/Kensuke-Mitsuzawa/Python_viraster)

#Usage
First you have to put unpacked TMC directory in ````./unziped_moses/lm_model/````.  
Next, you need to select MOSES path in your environment(rewrites path in ./get\_parallel.sh)  
And, finally run ./get\_parallel.sh .
