// [left, right)
auto binsearch(T : long, F)(T x, T y, F check)
{
    // left satisfies cond, right doesn't satisfy.
    T left = x;
    T right = y;

    while (right - left > 1)
    {
        T mid = left + (right - left) / 2;

        if (check(mid))
        {
            left = mid;
        }
        else
        {
            right = mid;
        }
    }
    return left;
}
//dfmt off
binsearch(ok, ng, delegate(auto t) {
	return {{_cursor_}}
});
//dfmt on
