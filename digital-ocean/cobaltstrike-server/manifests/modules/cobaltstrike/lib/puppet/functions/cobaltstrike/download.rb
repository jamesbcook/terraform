require 'net/http'
Puppet::Functions.create_function(:'cobaltstrike::download') do
  dispatch :download do
    param 'String', :key
    param 'String', :output
  end

  def gettoken(key)
    uri = URI("https://www.cobaltstrike.com/download?dlkey=#{key}")
    res = Net::HTTP.get(uri)
    res.split("\n").grep(/download-btn/)[0].split('/')[2]
  end

  def download(key, output)
    return if key == ''
    token = gettoken(key)
    uri = URI("https://www.cobaltstrike.com/downloads/#{token}/cobaltstrike-trial.tgz")
    resp = Net::HTTP.get(uri)
    File.open(output, 'wb') { |f| f.write(resp) }
  end
end
