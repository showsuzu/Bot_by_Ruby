# coding: utf-8
require 'natto'
require 'nkf'

module Mecab
	Analyze = Natto::MeCab.new

	def setarg(*opt)
		#puts('setarg : ')
		#puts(opt)
	end

	def analyze(text)
		#puts('analyze input test : ' + text)
		#text = NKF::nkf('-XSs', text)
		#puts(text)
		#puts(Analyze.parse(text))
		Analyze.parse(text)
	end

	module_function :setarg, :analyze
end

if $0 == __FILE__

	Mecab::setarg('-F%m %P-\n');

	while line = gets() do
		line.chomp!
		break if line.empty?
		puts(Mecab::analyze(line))
	end
end
