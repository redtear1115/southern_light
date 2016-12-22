class Publisher

  def initalize
  end

  def publish
    copy
    push
  end

  private
  def copy
    puts %x( jekyll build )
    puts %x( git clone https://github.com/redtear1115/redtear1115.github.io.git _tmp)
    puts %x( cp -rf _site/* _tmp)
  end

  def push
    puts %x( cd _tmp && git add . )
    puts %x( cd _tmp && git commit -am "auto commit" )
    puts %x( cd _tmp && git push origin master )
    puts %x( rm -rf _tmp )
  end

end

# execute below
Publisher.new.publish
