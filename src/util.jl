@pure function _issubset(a::Tuple{Vararg{Symbol}}, b::Tuple{Vararg{Symbol}})
    for sa ∈ a
        if sa ∉ b
            return false
        end
    end
    return true
end

@pure function _issetequal(a::NTuple{N, Symbol}, b::NTuple{N, Symbol}) where {N}
    for sa ∈ a
        if sa ∉ b
            return false
        end
    end
    return true
end
@pure _issetequal(::Tuple{Vararg{Symbol}}, ::Tuple{Vararg{Symbol}}) = false

@pure function _headsubset(a::Tuple{Vararg{Symbol}}, b::Tuple{Vararg{Symbol}})
    out = ()
    for s ∈ a
        if s ∈ b
            out = (out..., s)
        else
            return out
        end
    end
    return out
end

@pure function _intersect(a::Tuple{Vararg{Symbol}}, b::Tuple{Vararg{Symbol}})
    out = ()
    for s ∈ a
        if s ∈ b
            out = (out..., s)
        end
    end
    return out
end

@pure function _setdiff(a::Tuple{Vararg{Symbol}}, b::Tuple{Vararg{Symbol}})
    out = ()
    for s ∈ a
        if s ∉ b
            out = (out..., s)
        end
    end
    return out
end

@generated function _eltypes(a::Tuple{Vararg{AbstractVector}})
    Ts = []
    for V in a.parameters
        push!(Ts, eltype(V))
    end
    return Tuple{Ts...}
end

@generated function _makevectors(::Type{Ts}, dims::Tuple{Int}) where {Ts <: Tuple}
    exprs = [:(Vector{$T}(uninitialized, dims)) for T ∈ Ts.parameters]
    return quote
        @_inline_meta
        return tuple($(exprs...))
    end
end

@generated function _values(nt::NamedTuple{names}) where {names}
    exprs = [:(getproperty(nt, $(Expr(:quote, n)))) for n in names]
    return quote
        @_inline_meta
        return tuple($(exprs...))
    end
end

# index of the last value of vector a that is less than but not equal to x;
# returns 0 if x is less than all values of v.
function searchsortedlastless(v::AbstractVector, x, lo::Int = first(keys(v)), hi::Int = last(keys(v)))
    lo = lo-1
    hi = hi+1
    @inbounds while lo < hi-1
        m = (lo+hi)>>>1
        y = v[m]
        if isless(y, x)
            lo = m
        else
            hi = m
        end
    end
    return lo
end

function searchsortedfirstgreater(v::AbstractVector, x, lo::Int = first(keys(v)), hi::Int = last(keys(v)))
    lo = lo-1
    hi = hi+1
    @inbounds while lo < hi-1
        m = (lo+hi)>>>1
        if isless(x, v[m])
            hi = m
        else
            lo = m
        end
    end
    return hi
end

_all(f, ::Tuple{}, ::Tuple{}) = true
@generated function _all(f, t1::NTuple{n, Any}, t2::NTuple{n, Any}) where {n}
    exprs = [:(f(t1[$i], t2[$i])) for i = 1:n]
    out = reduce((final, expr) -> :($final && $expr), exprs) # short-circuiting...
    return quote
        @_inline_meta
        return $out
    end
end

_valuetype(::Type{NamedTuple{names, T}}) where {names, T} = T
_valuetype(::NamedTuple{names, T}) where {names, T} = T

@generated function _cat_types(::Type{T1}, ::Type{T2}) where {T1 <: Tuple, T2 <: Tuple}
    return Tuple{T1.parameters..., T2.parameters...}
end

# unroll loop for isless, isequal on tuples and named tuples
# TODO migrate this to Base

#@inline isequal(a, b) = Base.isequal(a, b)

# @generated function Base.isequal(a::NTuple{n, Any}, b::NTuple{n, Any}) where {n}
#     if n === 0
#         return true
#     end

#     expr = :(isequal(a[1], b[1]))
#     for i = 2:n
#         expr = :($expr && isequal(a[$i], b[$i]))
#     end
#     return quote
#         @_inline_meta
#         return $expr
#     end
# end

# @generated function Base.isequal(a::NamedTuple{names}, b::NamedTuple{names}) where {nanes}
#     n = length(names)
#     if n === 0
#         return true
#     end

#     expr = :(isequal(a.$(names[1]), b.$(names[1])))
#     for i = 2:n
#         expr = :($expr && isequal(a.$(names[i]), b.$(names[i])))
#     end
#     return quote
#         @_inline_meta
#         return $expr
#     end
# end

# #@inline isless(a, b) = Base.isless(a, b)

# @generated function Base.isless(a::NTuple{n, Any}, b::NTuple{n, Any}) where {n}
#     if n === 0
#         return true
#     end

#     expr = :(isless(a[1], b[1]))
#     for i = 2:n
#         expr = :($expr || (isequal(a[$i-1], b[$i-1]) && isless(a[$i], b[$i]))) 
#     end
#     return quote
#         @_inline_meta
#         return $expr
#     end
# end

# @generated function Base.isless(a::NamedTuple{names}, b::NamedTuple{names}) where {nanes}
#     n = length(names)
#     if n === 0
#         return true
#     end

#     expr = :(isless(a.$(names[1]), b.$(names[1])))
#     for i = 2:n
#         expr = :($expr || (isequal(a.$(names[i-1]), b.$(names[i-1])) && isless(a.$(names[i]), b.$(names[i]))))
#     end
#     return quote
#         @_inline_meta
#         return $expr
#     end
# end

# TODO check behavior of Base.hash for 
#  * large tuples (the algorithm uses recursion - does inference bail out at some point?)
#  * named tuples (that invokes `Tuple(::NamedTuple)`...)
