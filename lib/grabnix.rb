require 'tempfile'
require 'timeout'

class GrabNix
	def initialize
		check_binaries
		@time = Time.now.to_i.to_s
		@dir = get_tmp_path
		kapow
		exit 0
	end
	
	protected
	
	def check_binaries
		`which xclip`
		if $?.exitstatus == 1
			# xclip isn't in da haus
			raise "xclip doesn't exist. try `sudo apt-get install xclip`."
			exit 1
		end
		`which import`
		if $?.exitstatus == 1
			raise "import doesn't exist. try `sudo apt-get install imagemagick`."
			exit 1
		end
		true
	end
	
	def get_tmp_path
		t = Tempfile.new 'grabnix'
		tmpdir = File.dirname(t.path)
		t.delete
		tmpdir
	end
	
	def kapow
		# this is the good stuff
		img = @dir + '/' + @time + '.jpg'
		`import -quality 100 #{img}`
		req = `curl -si -F userfile=@#{img} -F app_upload=Upload http://www.grabup.com/app_upload.php`
		File.delete(img)
		url = /Location: (.+)/.match(req)
		set_clipboard url[1]
	end
	
	def set_clipboard(value)
		begin
			Timeout::timeout(0.4) do
				`echo -n #{value} | xclip -i -silent`
			end
		rescue Timeout::Error
			nil
		end
	end
end
