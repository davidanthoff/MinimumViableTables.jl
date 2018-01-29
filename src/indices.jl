# Operations on groups of indices

# Remove `NoIndex` from the list (TODO find a better name)
clean(t::Tuple{Vararg{AbstractIndex}}) = _clean(t...)
_clean(t, ts...) = (t, _clean(ts...)...)
_clean(::NoIndex, ts...) = _clean(ts...)
_clean() = ()

function project(t::Tuple{Vararg{AbstractIndex}}, n::Tuple{Vararg{Symbol}})
    return clean(map(Project(n), t))
end