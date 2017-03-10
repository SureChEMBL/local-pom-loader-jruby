require 'java'

module LocalPomLoader
  VERSION = '0.0.1'

  def LocalPomLoader.load_java_deps(deps, repo = nil)
    cmd = "local-pom-loader"

    deps.each do |dep|
      cmd += " " + dep.join(":")
    end

    if repo != nil
      cmd += " --repo " + repo
    end

    classpath = `#{cmd}`
    if $?.exitstatus != 0
      raise "Command #{cmd} exited with non-zero exit code"
    end

    jars = classpath.strip.split(":")
    jars.each do |jar|
      require jar
    end
  end
end
