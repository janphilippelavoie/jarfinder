
-- arguments
local folder = arg[1]
local className = arg[2]
assert(folder and className, "Missing arguments: findclass.lua foldername classname")

local main, containsClass, printResults


main = function()
  local results = {}
  local jars  = io.popen('find ' .. folder .. ' -name \\*jar')

  for jar in jars:lines() do
      if containsClass(jar, className) then
        results[#results + 1] = jar
      end
  end
  printResults(results)
end

containsClass = function(jarFile, className)
  local content = io.popen('jar tf ' .. jarFile)
  for classFile in content:lines() do
    if string.find(classFile, className) then
      return true
    end
  end
  return false
end

printResults = function(results)
  print("Jar containing " .. className)
  for _, jar in ipairs(results) do
    print(jar)
  end
end

main()
