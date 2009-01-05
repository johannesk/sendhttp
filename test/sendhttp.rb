require 'test/unit'


require 'base64'

class Test_sendhttp < Test::Unit::TestCase

	def test_donwload
		payload= Base64::b64encode((rand*100000000000000).round.to_s).strip
		Thread.new do
			`echo "#{payload}" | ./sendhttp -t 5 -p 12345 -q 1 - @ data`
		end
		sleep(1)
		assert_equal(payload, `wget http://localhost:12345/data -O - 2> /dev/null`.strip)
	end

end
