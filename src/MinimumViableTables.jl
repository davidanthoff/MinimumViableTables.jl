module MinimumViableTables

using Base: @pure, @propagate_inbounds, @_propagate_inbounds_meta, @_inline_meta, 
            getproperty

import Base: size, axes, getindex, setindex!, show, similar, copy, filter, map, findall,
             getproperty, in

import LinearAlgebra: cross, ×

using Indexing

export colnames, columns, getindexes, project, Project, addindex, rename, Rename

export AbstractIndex, AbstractUniqueIndex, NoIndex, UniqueIndex, HashIndex, UniqueHashIndex,
       SortIndex, UniqueSortIndex

export Table, ProductTable, ×, cross

export IsEqual, IsLess, IsLessEqual, IsGreater, IsGreaterEqual, In
export Equals, LessThan, LessEqualThan, GreaterThan, GreaterEqualThan, Within

include("interval.jl")

include("util.jl")
include("project.jl")
include("rename.jl")
include("index.jl")
include("indices.jl")
include("table.jl")
include("makeindex.jl")
include("predicates.jl")

include("producttable.jl")

end # module

# Fundamental relational algebra operations:
#
# Set and bag operations: union, setdiff, intersect, isunique, vcat (from Julia AbstractVector interface)
# Projections: project, Project{names} (also map)
# Selections: filter (accelerated when using filter predicates like IsEqual)
# Renames: rename, Rename{oldnames, newnames} (also map)
# Cartesian product: ProductTable - a matrix of named tuples?
#
# Add a new column based on existing columns: ?? (also map)
#
# The above also relate to joins with (abstract) relations... we can think about this...
#
# Some performance improvements:
#
# * The unique searching cases tend to return 0 or 1 elements. A "Nullable" like vector
#   (an immutable AbstractVector of length 0 or 1) could be a performance help in these
#   cases.
#
# * Perhaps use faster sorting (radix, etc)
#
# * Perhaps investigate performance of Dict
#
# * Primary keys (particulary lexicographical sort) and the ability to reorder a table
#   to suite one (or more) acceleration indexes (i.e. improve memory locality).
#
# * Think about memory locality and hash-based acceleration indexes.
#
# * Consider tables with row storage.
#
# * More views.