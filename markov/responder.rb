class Responder
	def initialize(name, dictionary)
		@name = name
		@dictionary = dictionary
	end

	def response(input, parts, mood)
		return ''
	end

	attr_reader :name
end

class WhatResponder < Responder
	def response(input, parts, mood)
		return "#{input}って何？"
	end
end

class RandomResponder < Responder
	def response(input, parts, mood)
		return select_random(@dictionary.random)
	end
end

class PatternResponder < Responder
	def response(input, parts, mood)
		@dictionary.pattern.each do |ptn_item|
			if m = ptn_item.match(input)
				resp = ptn_item.choice(mood)
				next if resp.nil?
				return resp.gsub(/%match%/, m.to_s)
			end
		end

		return select_random(@dictionary.random)
	end
end

class TemplateResponder < Responder
	def response(input, parts, mood)
		keywords = []
		parts.each do |word, part|
			keywords.push(word) if Morph.keyword?(part)
		end
		count = keywords.size
		#puts("-----count-----")
		#puts(count)
		if count > 0 and templates = @dictionary.template[count]
			#puts("-----templates-----")
			#puts(templates)
			template = select_random(templates)
			#puts("-----template-----")
			#puts(template)
			return template.gsub(/%noun%/){keywords.shift}
		end

		return select_random(@dictionary.random)
	end
end

class MarkovResponder < Responder
	def response(input, parts, mood)
		keyword, p = parts.find{|w, part| Morph::keyword?(part)}
		#puts("-----Markov::response-----")
		#puts(keyword)
		#puts(p)
		#puts("-----")
		resp = @dictionary.markov.generate(keyword)
		#puts(resp)
		#puts("-----")
		return resp unless resp.nil?

		return select_random(@dictionary.random)
	end
end
