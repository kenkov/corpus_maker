TEST_PERC = 30
TOKENIZER = mecab -Owakati

main: conv train_test_set word_tokenize char_tokenize

conv:
	cut -f1 conv.txt > conv.src.txt
	cut -f2 conv.txt > conv.dst.txt
	cat conv.src.txt conv.dst.txt > sent.txt

train_test_set:
	python train_test_corpus.py -p ${TEST_PERC} conv.txt conv.train.txt conv.test.txt

	cut -f1 conv.train.txt > conv.train.src.txt
	cut -f2 conv.train.txt > conv.train.dst.txt
	cat conv.train.src.txt conv.train.dst.txt >sent.train.txt

	cut -f1 conv.test.txt > conv.test.src.txt
	cut -f2 conv.test.txt > conv.test.dst.txt
	cat conv.test.src.txt conv.test.dst.txt >sent.test.txt

word_tokenize:
	${TOKENIZER} conv.src.txt >conv.word.src.txt
	${TOKENIZER} conv.dst.txt >conv.word.dst.txt
	paste conv.word.src.txt conv.word.dst.txt >conv.word.txt
	cat conv.word.src.txt conv.word.dst.txt >sent.word.txt

	${TOKENIZER} conv.train.src.txt >conv.word.train.src.txt
	${TOKENIZER} conv.train.dst.txt >conv.word.train.dst.txt
	paste conv.word.train.src.txt conv.word.train.dst.txt >conv.word.train.txt
	cat conv.word.train.src.txt conv.word.train.dst.txt >sent.word.train.txt

	${TOKENIZER} conv.test.src.txt >conv.word.test.src.txt
	${TOKENIZER} conv.test.dst.txt >conv.word.test.dst.txt
	paste conv.word.test.src.txt conv.word.test.dst.txt >conv.word.test.txt
	cat conv.word.test.src.txt conv.word.test.dst.txt >sent.word.test.txt

char_tokenize:
	sed -e "s/\(.\)/\1 /g" conv.src.txt | sed -e "s/\s$$//g" >conv.char.src.txt
	sed -e "s/\(.\)/\1 /g" conv.dst.txt | sed -e "s/\s$$//g" >conv.char.dst.txt
	paste conv.char.src.txt conv.char.dst.txt >conv.char.txt
	cat conv.char.src.txt conv.char.dst.txt >sent.char.txt

	sed -e "s/\(.\)/\1 /g" conv.train.src.txt | sed -e "s/\s$$//g" >conv.char.train.src.txt
	sed -e "s/\(.\)/\1 /g" conv.train.dst.txt | sed -e "s/\s$$//g" >conv.char.train.dst.txt
	paste conv.char.train.src.txt conv.char.train.dst.txt >conv.char.train.txt
	cat conv.char.train.src.txt conv.char.train.dst.txt >sent.char.train.txt

	sed -e "s/\(.\)/\1 /g" conv.test.src.txt | sed -e "s/\s$$//g" >conv.char.test.src.txt
	sed -e "s/\(.\)/\1 /g" conv.test.dst.txt | sed -e "s/\s$$//g" >conv.char.test.dst.txt
	paste conv.char.test.src.txt conv.char.test.dst.txt >conv.char.test.txt
	cat conv.char.test.src.txt conv.char.test.dst.txt >sent.char.test.txt


clean:
	rm sent.txt
	rm conv.{src,dst}.txt conv.{train,test}.txt conv.train.{src,dst}.txt conv.test.{src,dst}.txt sent.{train,test}.txt
	rm conv.word.txt conv.word.{src,dst}.txt conv.word.{train,test}.txt conv.word.train.{src,dst}.txt conv.word.test.{src,dst}.txt sent.word.{train,test}.txt sent.word.txt
	rm conv.char.txt conv.char.{src,dst}.txt conv.char.{train,test}.txt conv.char.train.{src,dst}.txt conv.char.test.{src,dst}.txt sent.char.{train,test}.txt sent.char.txt
