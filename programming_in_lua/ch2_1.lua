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

function addqueue(a, n)
    if n > N then
        printsolution(a)
        -- os.exit()
    end

    for c = 1, N do
        if isplaceok(a, n, c) then
            a[n] = c
            addqueue(a, n + 1)
        end
    end
end

okcount = 0

addqueue({}, 1)

print(okcount)
