N = 8

function isplaceok(a, n, c)
    okcount = okcount + 1
    for i = 1, n - 1 do
        if a[i] == c or a[i] - i == c - n or a[i] + i == c + n then
            return false
        end
    end
    return true
end

function printsolution(a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "Q" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
end

function checkqueue(a)
    for k, sub in pairs(a) do
        isvalid = true
        for i = 1, N do
            if not isplaceok(sub, i, sub[i]) then
                isvalid = false
                break
            end
        end
        if isvalid then
            printsolution(sub)
        end
    end
end


function perms(a, sub)
    if #sub >= N then
        t = {}
        for k, v in pairs(sub) do
            t[k] = v
        end
        table.insert(a, t)
        return
    end

    for i = 1, N do
        table.insert(sub, i)
        perms(a, sub)
        table.remove(sub)
    end
end

okcount = 0

a = {}

perms(a, {})

checkqueue(a)

print(okcount)
