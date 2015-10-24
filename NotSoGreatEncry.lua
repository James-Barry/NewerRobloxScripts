--[[-------------------------------------------------
This isn't the best way to do encryption.
---------------------------------------------------]]

ss = string.sub
sl = string.len
sb = string.byte
sc = string.char

function strToNum(str)
tbl = {}
    for i=1,sl(str) do
        table.insert(tbl,sb(ss(str,i,i))-sb('a'))
    end
    sum = 0
    for i,v in ipairs(tbl) do
        sum = sum+v*26^(i-1) -- This makes the computer cry.
    end
return sum
end

function numToStr(num)
    --tbl = {} -- the string we're building
    local bigstr = ""
    repeat
    stn = num%26
    bigstr = bigstr..sc(stn+sb('a'))
    --table.insert(tbl,sc(stn+sb('a')))
    num = (num-stn)/26
    until num == 0
return bigstr
end

test = strToNum("helloworld")
testKey = strToNum("jamesjohn")
crypt = test-testKey

print("Encrypted = "..numToStr(crypt))
print("Decrypted = "..numToStr(crypt+testKey))

