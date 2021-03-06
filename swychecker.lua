local x = os.clock()
swydec = {}

local filename = {"R:\\Juegos\\swconquest\\modules\\swconquest-branch\\module.ini"}

local s,raw=0,{}
for l in io.lines(filename[1]) do
  s=s+1
  raw[s]={}
  for w in l:gmatch("%S+") do table.insert(raw[s], w) end
end

local count=tonumber(raw[2][1])
local sum=0
local scns={}
for i=1,#raw do
  if raw[i][1] and raw[i][1]:find("load(.+)resource") ~=nil then
  scns[#scns+1]=raw[i][3]
  --print( scns[#scns])
  if  io.open(filename[1]:match("(.+)module.ini").."Resource\\"..raw[i][3]..".brf") and
      io.open(filename[1]:match("(.+)module.ini").."..\\..\\CommonRes\\"..raw[i][3]..".brf")  then
    print(raw[i][1])
    sum=sum+1
  end
  end
end
 print(sum.." missing BRFs")
 

 
-- http://stackoverflow.com/a/11130774
-- Lua implementation of PHP scandir function
function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    for filename in popen('dir "'..filename[1]:match("(.+)module.ini")..'Resource\\*.brf" /b'):lines() do
        --print(filename)
        i = i + 1
        t[i] = filename
    end
    return t
end

local sum=0
print("----------------------")
test=scandir()
for _,a in pairs(test) do

    for _,b in pairs(scns) do
        if a==b..".brf" then
            found=true
            break
        end
    end
    if not found then
      print(a)
      sum=sum+1
    end
    found=false
end

 print("these "..sum.." unused BRFs are in folder but not referenced in module.ini")

 print(os.clock()-x.."s")