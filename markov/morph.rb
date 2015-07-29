require './mecab'

module Morph
	def init_analyzer
		Mecab::setarg('-F%m %P-\t');
	end

	def analyze(text)
		#puts('analyze input : ' + text)
		#puts('--Mecab::analyze(text)--')
		#puts(Mecab::analyze(text))
		#puts('--Mecab::analyze(text).chomp--')
		#puts(Mecab::analyze(text).chomp)
		return Mecab::analyze(text).chomp.split(/\n/).map do |part|
			part.split(/\t/)
		end
	end

	def keyword?(part)
		#puts('keyword? input : ')
		#puts(part)
		return /名詞,(一般|代名詞,一般|固有名詞|サ変接続|形容動詞語幹)(,.+?)/ =~ part
	end

	module_function :init_analyzer, :analyze, :keyword?
end
