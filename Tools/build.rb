#!/usr/bin/env ruby -wKU

###################################################################
# Build Jamoma
# Ruby Version - notoriously based on scripts by Jeremy Bernstein
###################################################################

require 'open3'
require 'fileutils'
require 'pathname'

require 'rexml/document'
include REXML

# This finds our current directory, to generate an absolute path for the require
libdir = "."
Dir.chdir libdir        # change to libdir so that requires work

if(ARGV.length == 0)
  puts "usage: "
  puts "build.rb <required:configuration> <optional:clean>"
  exit 0;
end

configuration = ARGV[0];
clean = false;
@debug = false;

if(ARGV.length > 1)
  if(ARGV[1] != "0" || ARGV[1] != "false")
    clean = true;
  end
end

if(ARGV.length > 2)
  if(ARGV[2] != "0" || ARGV[2] != "false")
    @debug = true;
  end
end

puts "Building Jamoma"
puts "==================================================="
puts "  configuration: #{configuration}"
puts "  clean: #{clean}"
#puts "  debug the build script: #{debug}"
puts "  "


@build_root = "../Jamoma/library/externals"
@svn_root = "../"
@fail_array = Array.new
@zerolink = false


#######
## SUB ROUTINES
#######

def create_logs
  # set up log files and ensure that the build_root is there
  `mkdir -p #{@build_root}` if !FileTest.exist?(@build_root)
  @build_log = File.new("#{@build_root}/_build.log", "w")
  @build_log.write("MAX BUILD LOG: #{`date`}\n\n")
  @build_log.flush
  @error_log = File.new("#{@build_root}/_error.log", "w")
  @error_log.write("MAX BUILD ERROR LOG: #{`date`}\n\n")
  @error_log.flush
  trap("SIGINT") { die }
end
  
def die
  close_logs
  exit 0
end

def close_logs
  @build_log.close
  @error_log.close
end

def log_build(str)
  @build_log.write(str)
  @build_log.write("\n\n")
  @build_log.flush
end

def log_error(str)
  @error_log.write(str)
  @error_log.write("\n\n")
  @error_log.flush
end

def zero_count
  @cur_total = 0
  @cur_count = 0
end

def get_count
  return @cur_total, @cur_count
end


def copydir(sourcepath, dstpath)
  out = ""
  err = ""

  puts "copy -v #{sourcepath}  -->  #{dstpath}"

  Open3.popen3("rm -rf #{dstpath}") do |stdin, stdout, stderr|
    out = stdout.read
    err = stderr.read
  end
  log_build(out)
  log_error(err)

  Open3.popen3("cp -R #{sourcepath} #{dstpath}") do |stdin, stdout, stderr|
    out = stdout.read
    err = stderr.read
  end
  log_build(out)
  log_error(err)

  return 0  
end


def build_xcode_project(projectdir, projectname, configuration, clean)
  out = ""
  err = ""

  Open3.popen3("nice xcodebuild -project #{projectname} -alltargets -configuration #{configuration} ZERO_LINK=\"NO\" #{"clean" if clean == true} build") do |stdin, stdout, stderr|
    if(@debug)
      puts "nice xcodebuild -project #{projectname} -alltargets -configuration #{configuration} ZERO_LINK=\"NO\" #{"clean" if clean == true} build"
    end
    out = stdout.read
    err = stderr.read
  end

  if /BUILD SUCCEEDED/.match(out)
    @cur_count+=1
    puts "#{projectname}: BUILD SUCCEEDED"
    log_build(out)
    return 1
  else
    @fail_array.push("#{projectdir}/#{projectname}")
    puts "#{projectname}: BUILD FAILED **************************************"
    log_error(out)
    log_error(err)
  end
  return 0
end


def build_project(projectdir, projectname, configuration, clean)
  if FileTest.exist?("#{projectdir}/#{projectname}")
    @cur_total+=1
    olddir = Dir.getwd
    Dir.chdir(projectdir)
    
    @cur_count += build_xcode_project(projectdir, projectname, configuration, clean)

    Dir.chdir(olddir)
  else
    puts"File Does not exist: #{projectdir}/#{projectname}"
  end
end


def find_and_build_project(projectdir, configuration, clean)
  rgx = /.xcodeproj$/
  Dir.foreach(projectdir) do |file|
    if rgx.match(file)
        build_project(projectdir, file, configuration, clean)
    end
  end
end


def build_dir(dir, configuration, clean)
  dir = "#{@svn_root}/#{dir}"
  return if !FileTest.exist?(dir) || !FileTest.directory?(dir)

  Dir.foreach(dir) do |subf|
    next if /^\./.match(subf)
    next if /common/.match(subf)
    next if !FileTest.directory?("#{dir}/#{subf}")
    find_and_build_project("#{dir}/#{subf}", configuration, clean)
  end
end



###################################################################
# CREATE LOG FILES AND RESET COUNTERS
###################################################################
create_logs
zero_count


###################################################################
# FRAMEWORK
###################################################################
puts "Building Frameworks..."
zero_count
build_project("#{@svn_root}/SourceCode/ThirdParty/TTBlue/library", "TTBlue.xcodeproj", configuration, true)
build_project("#{@svn_root}/SourceCode/Framework", "Jamoma.xcodeproj", configuration, true)
ex_total, ex_count = get_count
puts ""


###################################################################
# EXTERNALS
###################################################################
puts "Building TTBlue Externals..."

zero_count
build_dir("SourceCode/ThirdParty/TTBlue/examples", configuration, clean)  
ex_total, ex_count = get_count
if("#{configuration}" == "Development")
  puts "copying Development"
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Development/tt.balance~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.balance~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Development/tt.dcblock~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.dcblock~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Development/tt.degrade~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.degrade~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Development/tt.filter~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.filter~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Development/tt.limiter~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.limiter~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Development/tt.overdrive~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.overdrive~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Development/tt.ramp~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.ramp~.mxo")
else
  puts "copying Deployment"
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Deployment/tt.balance~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.balance~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Deployment/tt.dcblock~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.dcblock~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Deployment/tt.degrade~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.degrade~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Deployment/tt.filter~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.filter~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Deployment/tt.limiter~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.limiter~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Deployment/tt.overdrive~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.overdrive~.mxo")
  copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/Build_Mac/Deployment/tt.ramp~.mxo", "#{@svn_root}/Jamoma/library/externals/mac/tt.ramp~.mxo")
end
puts ""

puts "copying help ttblue files"
copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/examples/tt.balance~/tt.balance~.maxhelp", "#{@svn_root}/Jamoma/documentation/jamoma-help/tt.balance~.maxhelp")
copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/examples/tt.dcblock~/tt.dcblock~.maxhelp", "#{@svn_root}/Jamoma/documentation/jamoma-help/tt.dcblock~.maxhelp")
copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/examples/tt.degrade~/tt.degrade~.maxhelp", "#{@svn_root}/Jamoma/documentation/jamoma-help/tt.degrade~.maxhelp")
copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/examples/tt.filter~/tt.filter~.maxhelp", "#{@svn_root}/Jamoma/documentation/jamoma-help/tt.filter~.maxhelp")
copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/examples/tt.limiter~/tt.limiter~.maxhelp", "#{@svn_root}/Jamoma/documentation/jamoma-help/tt.limiter~.maxhelp")
copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/examples/tt.overdrive~/tt.overdrive~.maxhelp", "#{@svn_root}/Jamoma/documentation/jamoma-help/tt.overdrive~.maxhelp")
copydir("#{@svn_root}/SourceCode/ThirdParty/TTBlue/examples/tt.ramp~/tt.ramp~.maxhelp", "#{@svn_root}/Jamoma/documentation/jamoma-help/tt.ramp~.maxhelp")
puts ""

puts "Building Jamoma Externals..."

zero_count
build_dir("SourceCode/MaxObjects", configuration, clean)  
ex_total, ex_count = get_count
puts ""


###################################################################
# FINISH UP
###################################################################

puts "=================DONE===================="
puts "\nFailed projects:" if @fail_array.length > 0
@fail_array.each do |loser|
  puts loser
end

###################################################################
# CLOSE LOG FILES
###################################################################
close_logs
puts ""
exit 0;


