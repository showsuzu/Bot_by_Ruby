# coding: utf-8
require './unmo'

def prompt(unmo)
	return unmo.name + ':' + unmo.responder_name + '> '
end

puts('Unmo System prototype : noby')
noby = Unmo.new('noby')
while true
	print('> ')
	input = gets
	input.chomp!
	break if input == ''

	response = noby.dialogue(input)
	puts(prompt(noby) + response)
end

noby.save

