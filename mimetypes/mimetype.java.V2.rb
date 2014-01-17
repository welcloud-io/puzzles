def mime_types(fichiers, table)

response = []

for i in 0..fichiers.size-1 do
    nomFichier = fichiers[i]
    if nomFichier.rindex(".") == nil
	response.push("UNKNOWN")
    else
	ext = nomFichier[nomFichier.rindex(".")+1..-1].downcase
	if table.has_key?(ext)
	    response.push(table[ext])
	else
	    response.push("UNKNOWN")
	end
    end
end

return response

end


require 'test/unit'

class TestsSession < Test::Unit::TestCase

  def test03
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
  end  

  def test03
	  
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html"]
    
    assert_equal ["text/html"], mime_types(file_list, extension_hash)
    
  end  
  
  def test04
	  
    extension_hash = { "html" => "text/html" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "UNKNOWN"], mime_types(file_list, extension_hash)
    
  end
  
  def test05
	  
    extension_hash = { "html" => "text/html", "gif" => "image/gif" }
    file_list = ["file.html", "file.gif"]
    
    assert_equal ["text/html", "image/gif"], mime_types(file_list, extension_hash)
    
  end  
	
  def test11

    extension_hash = {"html" =>  "text/html", "png" => "image/png", "gif" => "image/gif" }
    file_list = ["animated.gif", "portrait.png", "index.html"]
    
    assert_equal  ["image/gif", "image/png", "text/html"], mime_types(file_list, extension_hash)

  end
  
  def test12
    
    extension_hash = {"txt" => "text/plain", "xml" =>  "text/xml", "flv" => "video/x-flv" }
    file_list = ["image.png", "animated.gif", "script.js", "source.cpp"]   
    
    assert_equal  ["UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)
    
  end
  
  def test13

    extension_hash = { "wav" => "audio/x-wav", "mp3" => "audio/mpeg", "pdf" => "application/pdf" }
    file_list = ["a", "a.wav", "b.wav.tmp", "test.vmp3", "pdf", "mp3", "report..pdf", "defaultwav", ".mp3.", "final."]   
    
    assert_equal  ["UNKNOWN", "audio/x-wav", "UNKNOWN", "UNKNOWN", "UNKNOWN", "UNKNOWN", "application/pdf", "UNKNOWN", "UNKNOWN", "UNKNOWN"], mime_types(file_list, extension_hash)

  end

  def test14

    #~ extension_hash = { "png" => "image/png", "TIFF" => "image/TIFF", "css" => "text/css", "TXT" => "text/plain"}
    extension_hash = { "png" => "image/png", "tiff" => "image/TIFF", "css" => "text/css", "txt" => "text/plain"}
    file_list = ["example.TXT", "referecnce.txt", "strangename.tiff", "resolv.CSS", "matrix.TiFF", "lanDsCape.Png", "extract.cSs"]   
    
    assert_equal  ["text/plain", "text/plain", "image/TIFF", "text/css", "image/TIFF", "image/png", "text/css"], mime_types(file_list, extension_hash)

  end
  
  def test15

    extension_hash = { }
    file_list = []   
    
    assert_equal  [], mime_types(file_list, extension_hash)

  end 
  
end