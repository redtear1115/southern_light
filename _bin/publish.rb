class Publisher
  def initalize
  end

  def publish
    puts %x( jekyll build )
    puts %x( cd _site )
    puts %x( git add . )
    puts %x( git commit -am "auto commit" )
    puts %x( git push origin master )
  end
end

Publisher.new.publish
