// from https://ei1333.github.io/luzhiled/snippets/structure/union-find.html
class UnionFind
{
public:
    long[] par;

    this(long size)
    {
        par = new long[](size);
        foreach (i; 0 .. size)
        {
            par[i] = -1;
        }
    }

    long size(long x)
    {
        return -(par[find(x)]);
    }

    long find(long x)
    {
        if (par[x] < 0)
        {
            return x;
        }
        par[x] = find(par[x]);
        return par[x];
    }

    bool is_same(long x, long y)
    {
        return find(x) == find(y);
    }

    bool unite(long x, long y)
    {
        x = find(x);
        y = find(y);

        if (x == y)
        {
            return false;
        }
        if (par[x] > par[y])
        {
            par[y] += par[x];
            par[x] = y;
        }
        else
        {
            par[x] += par[y];
            par[y] = x;
        }
        return true;
    }
}
