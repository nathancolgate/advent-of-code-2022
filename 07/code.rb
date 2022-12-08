input = File.read(File.expand_path("./input.txt"))

class ElfFolder
  attr_accessor :files, :folders, :parent, :name
  def initialize(name,parent)
    @parent = parent
    @name = name
    @files = []
    @folders = []
  end
  def size
    files.map(&:size).sum + folders.map(&:size).sum
  end
end

class ElfFile
  attr_accessor :name, :size
  def initialize(name,size)
    @name = name
    @size = size
  end
end

@commands = input.split("\n")
@command_index = 0
@root = ElfFolder.new("/",nil)
@current_folder = nil
def cd(dir)
  @current_folder = case dir
  when "/"
    @root
  when ".."
    @current_folder.parent
  else
    @current_folder.folders.detect {|f| f.name == dir}
  end
  @command_index += 1
end
def ls
  loop do
    @command_index += 1
    break unless command = @commands[@command_index]
    if match = command.match(/^dir (.+)$/)
      @current_folder.folders << ElfFolder.new(match[1],@current_folder)
    elsif match = command.match(/^(\d+) (.+)$/)
      @current_folder.files << ElfFile.new(match[2],match[1].to_i)
    else
      break
    end
  end
end
loop do
  break unless command = @commands[@command_index]
  if match = command.match(/^\$ cd (.+)$/)
    cd(match[1])
  elsif match = command.match(/^\$ ls$/)
    ls
  end
end

# Part 1
folders = ObjectSpace.each_object(ElfFolder)
puts folders.select {|f| f.size <= 100000}.map(&:size).sum

# Part 2
target_size = 30000000 - (70000000 - @root.size)
folders = folders.sort {|a,b| a.size <=> b.size}
i = 0
loop do
  if folders[i].size >= target_size
    puts folders[i].size
    break
  end
  i += 1
end
