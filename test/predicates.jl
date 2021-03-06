@testset "predicates" begin
    @testset "IsEqual" begin
        pred = IsEqual{(:a, :b), Tuple{Int, Float64}}((1, 2.0))
        @test IsEqual(a=1, b=2.0) === pred

        @test pred((a=1, b=2.0)) === true
        @test pred((a=1, b=2.1)) === false
        @test pred((b=2.0, a=1)) === true
        @test pred((b=2.0, a=2)) === false
        @test pred((a=1, b=2.0, c=false)) === true
        @test pred((a=1, b=2.1, c=false)) === false
        @test_throws Exception pred((a=1))

        va = [2,   3,   1]
        vb = [4.0, 6.0, 2.0]
        t = Table{(:a, :b), NamedTuple{(:a,:b), Tuple{Int, Float64}}, Tuple{Vector{Int}, Vector{Float64}}, Tuple{}}((va, vb), ())
        
        @test map(pred, t) == [false, false, true]
        @test findall(pred, t) == [3]
        @test filter(pred, t) == Table(a = [1], b = [2.0])

        t2a = accelerate(t, UniqueIndex{(:a,)})
        @test map(pred, t2a) == [false, false, true]
        @test findall(pred, t2a) == [3]
        @test filter(pred, t2a) == Table(a = [1], b = [2.0])
        t2b = accelerate(t, UniqueIndex{(:b,)})
        @test map(pred, t2b) == [false, false, true]
        @test findall(pred, t2b) == [3]
        @test filter(pred, t2b) == Table(a = [1], b = [2.0])
        t2ab = accelerate(t, UniqueIndex{(:a,:b)})
        @test map(pred, t2ab) == [false, false, true]
        @test findall(pred, t2ab) == [3]
        @test filter(pred, t2ab) == Table(a = [1], b = [2.0])
        t2ba = accelerate(t, UniqueIndex{(:b,:a)})
        @test map(pred, t2ba) == [false, false, true]
        @test findall(pred, t2ba) == [3]
        @test filter(pred, t2ba) == Table(a = [1], b = [2.0])
        
        t3a = accelerate(t, SortIndex{(:a,)})
        @test map(pred, t3a) == [false, false, true]
        @test findall(pred, t3a) == [3]
        @test filter(pred, t3a) == Table(a = [1], b = [2.0])
        t3b = accelerate(t, SortIndex{(:b,)})
        @test map(pred, t3b) == [false, false, true]
        @test findall(pred, t3b) == [3]
        @test filter(pred, t3b) == Table(a = [1], b = [2.0])
        t3ab = accelerate(t, SortIndex{(:a,:b)})
        @test map(pred, t3ab) == [false, false, true]
        @test findall(pred, t3ab) == [3]
        @test filter(pred, t3ab) == Table(a = [1], b = [2.0])
        t3ba = accelerate(t, SortIndex{(:b,:a)})
        @test map(pred, t3ba) == [false, false, true]
        @test findall(pred, t3ba) == [3]
        @test filter(pred, t3ba) == Table(a = [1], b = [2.0])
        
        t4a = accelerate(t, UniqueSortIndex{(:a,)})
        @test map(pred, t4a) == [false, false, true]
        @test findall(pred, t4a) == [3]
        @test filter(pred, t4a) == Table(a = [1], b = [2.0])
        t4b = accelerate(t, UniqueSortIndex{(:b,)})
        @test map(pred, t4b) == [false, false, true]
        @test findall(pred, t4b) == [3]
        @test filter(pred, t4b) == Table(a = [1], b = [2.0])
        t4ab = accelerate(t, UniqueSortIndex{(:a,:b)})
        @test map(pred, t4ab) == [false, false, true]
        @test findall(pred, t4ab) == [3]
        @test filter(pred, t4ab) == Table(a = [1], b = [2.0])
        t4ba = accelerate(t, UniqueSortIndex{(:b,:a)})
        @test map(pred, t4ba) == [false, false, true]
        @test findall(pred, t4ba) == [3]
        @test filter(pred, t4ba) == Table(a = [1], b = [2.0])
        
        t5a = accelerate(t, HashIndex{(:a,)})
        @test map(pred, t5a) == [false, false, true]
        @test findall(pred, t5a) == [3]
        @test filter(pred, t5a) == Table(a = [1], b = [2.0])
        t5b = accelerate(t, HashIndex{(:b,)})
        @test map(pred, t5b) == [false, false, true]
        @test findall(pred, t5b) == [3]
        @test filter(pred, t5b) == Table(a = [1], b = [2.0])
        t5ab = accelerate(t, HashIndex{(:a,:b)})
        @test map(pred, t5ab) == [false, false, true]
        @test findall(pred, t5ab) == [3]
        @test filter(pred, t5ab) == Table(a = [1], b = [2.0])
        t5ba = accelerate(t, HashIndex{(:b,:a)})
        @test map(pred, t5ba) == [false, false, true]
        @test findall(pred, t5ba) == [3]
        @test filter(pred, t5ba) == Table(a = [1], b = [2.0])
        
        t6a = accelerate(t, UniqueHashIndex{(:a,)})
        @test map(pred, t6a) == [false, false, true]
        @test findall(pred, t6a) == [3]
        @test filter(pred, t6a) == Table(a = [1], b = [2.0])
        t6b = accelerate(t, UniqueHashIndex{(:b,)})
        @test map(pred, t6b) == [false, false, true]
        @test findall(pred, t6b) == [3]
        @test filter(pred, t6b) == Table(a = [1], b = [2.0])
        t6ab = accelerate(t, UniqueHashIndex{(:a,:b)})
        @test map(pred, t6ab) == [false, false, true]
        @test findall(pred, t6ab) == [3]
        @test filter(pred, t6ab) == Table(a = [1], b = [2.0])
        t6ba = accelerate(t, UniqueHashIndex{(:b,:a)})
        @test map(pred, t6ba) == [false, false, true]
        @test findall(pred, t6ba) == [3]
        @test filter(pred, t6ba) == Table(a = [1], b = [2.0])
    end

    @testset "IsLess" begin
        pred = IsLess{(:a, :b), Tuple{Int, Float64}}((2, 4.0))
        @test IsLess(a=2, b=4.0) === pred

        @test pred((a=1, b=2.0)) === true
        @test pred((a=2, b=4.0)) === false
        @test pred((a=2, b=3.9)) === true
        @test pred((b=2.0, a=1)) === true
        @test pred((b=4.0, a=2)) === false
        @test pred((a=1, b=2.0, c=false)) === true
        @test pred((a=3, b=2.0, c=false)) === false
        @test_throws Exception pred((a=1))

        va = [2,   3,   1]
        vb = [4.0, 6.0, 2.0]
        t = Table{(:a, :b), NamedTuple{(:a,:b), Tuple{Int, Float64}}, Tuple{Vector{Int}, Vector{Float64}}, Tuple{}}((va, vb), ())

        @test map(pred, t) == [false, false, true]
        @test findall(pred, t) == [3]
        @test filter(pred, t) == Table(a = [1], b = [2.0])

        t3a = accelerate(t, SortIndex{(:a,)})
        @test map(pred, t3a) == [false, false, true]
        @test findall(pred, t3a) == [3]
        @test filter(pred, t3a) == Table(a = [1], b = [2.0])
        t3b = accelerate(t, SortIndex{(:b,)})
        @test map(pred, t3b) == [false, false, true]
        @test findall(pred, t3b) == [3]
        @test filter(pred, t3b) == Table(a = [1], b = [2.0])
        t3ab = accelerate(t, SortIndex{(:a,:b)})
        @test map(pred, t3ab) == [false, false, true]
        @test findall(pred, t3ab) == [3]
        @test filter(pred, t3ab) == Table(a = [1], b = [2.0])
        t3ba = accelerate(t, SortIndex{(:b,:a)})
        @test map(pred, t3ba) == [false, false, true]
        @test findall(pred, t3ba) == [3]
        @test filter(pred, t3ba) == Table(a = [1], b = [2.0])
        
        t4a = accelerate(t, UniqueSortIndex{(:a,)})
        @test map(pred, t4a) == [false, false, true]
        @test findall(pred, t4a) == [3]
        @test filter(pred, t4a) == Table(a = [1], b = [2.0])
        t4b = accelerate(t, UniqueSortIndex{(:b,)})
        @test map(pred, t4b) == [false, false, true]
        @test findall(pred, t4b) == [3]
        @test filter(pred, t4b) == Table(a = [1], b = [2.0])
        t4ab = accelerate(t, UniqueSortIndex{(:a,:b)})
        @test map(pred, t4ab) == [false, false, true]
        @test findall(pred, t4ab) == [3]
        @test filter(pred, t4ab) == Table(a = [1], b = [2.0])
        t4ba = accelerate(t, UniqueSortIndex{(:b,:a)})
        @test map(pred, t4ba) == [false, false, true]
        @test findall(pred, t4ba) == [3]
        @test filter(pred, t4ba) == Table(a = [1], b = [2.0])
    end

    @testset "IsLessEqual" begin
        pred = IsLessEqual{(:a, :b), Tuple{Int, Float64}}((2, 4.0))
        @test IsLessEqual(a=2, b=4.0) === pred

        @test pred((a=1, b=2.0)) === true
        @test pred((a=2, b=4.0)) === true
        @test pred((a=2, b=4.1)) === false
        @test pred((b=2.0, a=1)) === true
        @test pred((b=4.1, a=2)) === false
        @test pred((a=2, b=4.0, c=false)) === true
        @test pred((a=3, b=2.0, c=false)) === false
        @test_throws Exception pred((a=1))

        va = [2,   3,   1]
        vb = [4.0, 6.0, 2.0]
        t = Table{(:a, :b), NamedTuple{(:a,:b), Tuple{Int, Float64}}, Tuple{Vector{Int}, Vector{Float64}}, Tuple{}}((va, vb), ())

        @test map(pred, t) == [true, false, true]
        @test findall(pred, t) == [1, 3]
        @test filter(pred, t) == Table(a = [2, 1], b = [4.0, 2.0])

        t3a = accelerate(t, SortIndex{(:a,)})
        @test map(pred, t3a) == [true, false, true]
        @test findall(pred, t3a) == [1, 3]
        @test filter(pred, t3a) == Table(a = [2, 1], b = [4.0, 2.0])
        t3b = accelerate(t, SortIndex{(:b,)})
        @test map(pred, t3b) == [true, false, true]
        @test findall(pred, t3b) == [1, 3]
        @test filter(pred, t3b) == Table(a = [2, 1], b = [4.0, 2.0])
        t3ab = accelerate(t, SortIndex{(:a,:b)})
        @test map(pred, t3ab) == [true, false, true]
        @test findall(pred, t3ab) == [1, 3]
        @test filter(pred, t3ab) == Table(a = [2, 1], b = [4.0, 2.0])
        t3ba = accelerate(t, SortIndex{(:b,:a)})
        @test map(pred, t3ba) == [true, false, true]
        @test findall(pred, t3ba) == [1, 3]
        @test filter(pred, t3ba) == Table(a = [2, 1], b = [4.0, 2.0])
        
        t4a = accelerate(t, UniqueSortIndex{(:a,)})
        @test map(pred, t4a) == [true, false, true]
        @test findall(pred, t4a) == [1, 3]
        @test filter(pred, t4a) == Table(a = [2, 1], b = [4.0, 2.0])
        t4b = accelerate(t, UniqueSortIndex{(:b,)})
        @test map(pred, t4b) == [true, false, true]
        @test findall(pred, t4b) == [1, 3]
        @test filter(pred, t4b) == Table(a = [2, 1], b = [4.0, 2.0])
        t4ab = accelerate(t, UniqueSortIndex{(:a,:b)})
        @test map(pred, t4ab) == [true, false, true]
        @test findall(pred, t4ab) == [1, 3]
        @test filter(pred, t4ab) == Table(a = [2, 1], b = [4.0, 2.0])
        t4ba = accelerate(t, UniqueSortIndex{(:b,:a)})
        @test map(pred, t4ba) == [true, false, true]
        @test findall(pred, t4ba) == [1, 3]
        @test filter(pred, t4ba) == Table(a = [2, 1], b = [4.0, 2.0])
    end

    @testset "IsGreater" begin
        pred = IsGreater{(:a, :b), Tuple{Int, Float64}}((2, 4.0))
        @test IsGreater(a=2, b=4.0) === pred

        @test pred((a=3, b=6.0)) === true
        @test pred((a=2, b=4.0)) === false
        @test pred((a=2, b=4.1)) === true
        @test pred((b=2.0, a=1)) === false
        @test pred((b=4.1, a=2)) === true
        @test pred((a=1, b=2.0, c=false)) === false
        @test pred((a=3, b=2.0, c=false)) === true
        @test_throws Exception pred((a=1))

        va = [2,   3,   1]
        vb = [4.0, 6.0, 2.0]
        t = Table{(:a, :b), NamedTuple{(:a,:b), Tuple{Int, Float64}}, Tuple{Vector{Int}, Vector{Float64}}, Tuple{}}((va, vb), ())

        @test map(pred, t) == [false, true, false]
        @test findall(pred, t) == [2]
        @test filter(pred, t) == Table(a = [3], b = [6.0])

        t3a = accelerate(t, SortIndex{(:a,)})
        @test map(pred, t3a) == [false, true, false]
        @test findall(pred, t3a) == [2]
        @test filter(pred, t3a) == Table(a = [3], b = [6.0])
        t3b = accelerate(t, SortIndex{(:b,)})
        @test map(pred, t3b) == [false, true, false]
        @test findall(pred, t3b) == [2]
        @test filter(pred, t3b) == Table(a = [3], b = [6.0])
        t3ab = accelerate(t, SortIndex{(:a,:b)})
        @test map(pred, t3ab) == [false, true, false]
        @test findall(pred, t3ab) == [2]
        @test filter(pred, t3ab) == Table(a = [3], b = [6.0])
        t3ba = accelerate(t, SortIndex{(:b,:a)})
        @test map(pred, t3ba) == [false, true, false]
        @test findall(pred, t3ba) == [2]
        @test filter(pred, t3ba) == Table(a = [3], b = [6.0])
        
        t4a = accelerate(t, UniqueSortIndex{(:a,)})
        @test map(pred, t4a) == [false, true, false]
        @test findall(pred, t4a) == [2]
        @test filter(pred, t4a) == Table(a = [3], b = [6.0])
        t4b = accelerate(t, UniqueSortIndex{(:b,)})
        @test map(pred, t4b) == [false, true, false]
        @test findall(pred, t4b) == [2]
        @test filter(pred, t4b) == Table(a = [3], b = [6.0])
        t4ab = accelerate(t, UniqueSortIndex{(:a,:b)})
        @test map(pred, t4ab) == [false, true, false]
        @test findall(pred, t4ab) == [2]
        @test filter(pred, t4ab) == Table(a = [3], b = [6.0])
        t4ba = accelerate(t, UniqueSortIndex{(:b,:a)})
        @test map(pred, t4ba) == [false, true, false]
        @test findall(pred, t4ba) == [2]
        @test filter(pred, t4ba) == Table(a = [3], b = [6.0])
    end

    @testset "IsGreaterEqual" begin
        pred = IsGreaterEqual{(:a, :b), Tuple{Int, Float64}}((2, 4.0))
        @test IsGreaterEqual(a=2, b=4.0) === pred

        @test pred((a=2, b=3.9)) === false
        @test pred((a=2, b=4.0)) === true
        @test pred((a=4, b=6.0)) === true
        @test pred((b=2.0, a=1)) === false
        @test pred((b=4.1, a=2)) === true
        @test pred((a=2, b=4.0, c=false)) === true
        @test pred((a=3, b=2.0, c=false)) === true
        @test_throws Exception pred((a=1))

        va = [2,   3,   1]
        vb = [4.0, 6.0, 2.0]
        t = Table{(:a, :b), NamedTuple{(:a,:b), Tuple{Int, Float64}}, Tuple{Vector{Int}, Vector{Float64}}, Tuple{}}((va, vb), ())

        @test map(pred, t) == [true, true, false]
        @test findall(pred, t) == [1, 2]
        @test filter(pred, t) == Table(a = [2, 3], b = [4.0, 6.0])

        t3a = accelerate(t, SortIndex{(:a,)})
        @test map(pred, t3a) == [true, true, false]
        @test findall(pred, t3a) == [1, 2]
        @test filter(pred, t3a) == Table(a = [2, 3], b = [4.0, 6.0])
        t3b = accelerate(t, SortIndex{(:b,)})
        @test map(pred, t3b) == [true, true, false]
        @test findall(pred, t3b) == [1, 2]
        @test filter(pred, t3b) == Table(a = [2, 3], b = [4.0, 6.0])
        t3ab = accelerate(t, SortIndex{(:a,:b)})
        @test map(pred, t3ab) == [true, true, false]
        @test findall(pred, t3ab) == [1, 2]
        @test filter(pred, t3ab) == Table(a = [2, 3], b = [4.0, 6.0])
        t3ba = accelerate(t, SortIndex{(:b,:a)})
        @test map(pred, t3ba) == [true, true, false]
        @test findall(pred, t3ba) == [1, 2]
        @test filter(pred, t3ba) == Table(a = [2, 3], b = [4.0, 6.0])
        
        t4a = accelerate(t, UniqueSortIndex{(:a,)})
        @test map(pred, t4a) == [true, true, false]
        @test findall(pred, t4a) == [1, 2]
        @test filter(pred, t4a) == Table(a = [2, 3], b = [4.0, 6.0])
        t4b = accelerate(t, UniqueSortIndex{(:b,)})
        @test map(pred, t4b) == [true, true, false]
        @test findall(pred, t4b) == [1, 2]
        @test filter(pred, t4b) == Table(a = [2, 3], b = [4.0, 6.0])
        t4ab = accelerate(t, UniqueSortIndex{(:a,:b)})
        @test map(pred, t4ab) == [true, true, false]
        @test findall(pred, t4ab) == [1, 2]
        @test filter(pred, t4ab) == Table(a = [2, 3], b = [4.0, 6.0])
        t4ba = accelerate(t, UniqueSortIndex{(:b,:a)})
        @test map(pred, t4ba) == [true, true, false]
        @test findall(pred, t4ba) == [1, 2]
        @test filter(pred, t4ba) == Table(a = [2, 3], b = [4.0, 6.0])
    end

    @testset "In (Interval)" begin
        pred = In{(:a,), Tuple{Interval{Int}}}((2..3,))
        @test In(a=2..3) === pred

        @test pred((a=1, b=2.0)) === false
        @test pred((a=2, b=4.0)) === true
        @test pred((a=3, b=6.0)) === true
        @test pred((b=2.0, a=1)) === false
        @test pred((b=4.0, a=2)) === true
        @test pred((a=2, b=4.0, c=false)) === true
        @test pred((a=3, b=2.0, c=false)) === true
        @test_throws Exception pred((b=1.0))

        va = [2,   3,   1]
        vb = [4.0, 6.0, 2.0]
        t = Table{(:a, :b), NamedTuple{(:a,:b), Tuple{Int, Float64}}, Tuple{Vector{Int}, Vector{Float64}}, Tuple{}}((va, vb), ())

        @test map(pred, t) == [true, true, false]
        @test findall(pred, t) == [1, 2]
        @test filter(pred, t) == Table(a = [2, 3], b = [4.0, 6.0])

        t3a = accelerate(t, SortIndex{(:a,)})
        @test map(pred, t3a) == [true, true, false]
        @test findall(pred, t3a) == [1, 2]
        @test filter(pred, t3a) == Table(a = [2, 3], b = [4.0, 6.0])
        t3b = accelerate(t, SortIndex{(:b,)})
        @test map(pred, t3b) == [true, true, false]
        @test findall(pred, t3b) == [1, 2]
        @test filter(pred, t3b) == Table(a = [2, 3], b = [4.0, 6.0])
        t3ab = accelerate(t, SortIndex{(:a,:b)})
        @test map(pred, t3ab) == [true, true, false]
        @test findall(pred, t3ab) == [1, 2]
        @test filter(pred, t3ab) == Table(a = [2, 3], b = [4.0, 6.0])
        t3ba = accelerate(t, SortIndex{(:b,:a)})
        @test map(pred, t3ba) == [true, true, false]
        @test findall(pred, t3ba) == [1, 2]
        @test filter(pred, t3ba) == Table(a = [2, 3], b = [4.0, 6.0])
        
        t4a = accelerate(t, UniqueSortIndex{(:a,)})
        @test map(pred, t4a) == [true, true, false]
        @test findall(pred, t4a) == [1, 2]
        @test filter(pred, t4a) == Table(a = [2, 3], b = [4.0, 6.0])
        t4b = accelerate(t, UniqueSortIndex{(:b,)})
        @test map(pred, t4b) == [true, true, false]
        @test findall(pred, t4b) == [1, 2]
        @test filter(pred, t4b) == Table(a = [2, 3], b = [4.0, 6.0])
        t4ab = accelerate(t, UniqueSortIndex{(:a,:b)})
        @test map(pred, t4ab) == [true, true, false]
        @test findall(pred, t4ab) == [1, 2]
        @test filter(pred, t4ab) == Table(a = [2, 3], b = [4.0, 6.0])
        t4ba = accelerate(t, UniqueSortIndex{(:b,:a)})
        @test map(pred, t4ba) == [true, true, false]
        @test findall(pred, t4ba) == [1, 2]
        @test filter(pred, t4ba) == Table(a = [2, 3], b = [4.0, 6.0])
    end

    @testset "Equals" begin
        pred = Equals(:a, :b)
        
        @test pred((a=1, b=1)) === true
        @test pred((a=2, b=4.0)) === false
        @test pred((a=1, b=1, c=2.0)) === true
        @test pred((a=2, b=4.0, c=2.0)) === false
        @test pred((b=1, a=1)) === true
        @test pred((b=2, a=4.0)) === false

        va = [2, 3, 1]
        vb = [2, 1, 3]
        t = Table(a = va, b = vb)

        @test map(pred, t) == [true, false, false]
        @test findall(pred, t) == [1]
        @test filter(pred, t) == Table(a = [2], b = [2])

        @test Predicate(pred, (a=1,)) === IsEqual((b=1,))
        @test Predicate(pred, (b=1,)) === IsEqual((a=1,))
    end

    @testset "LessThan" begin
        pred = LessThan(:a, :b)
        
        @test pred((a=1, b=0)) === false
        @test pred((a=1, b=1)) === false
        @test pred((a=1, b=2)) === true
        @test pred((a=1, b=1, c=2.0)) === false
        @test pred((a=1, b=2, c=2.0)) === true
        @test pred((b=1, a=1)) === false
        @test pred((b=2, a=1)) === true

        va = [2, 3, 1]
        vb = [2, 1, 3]
        t = Table(a = va, b = vb)

        @test map(pred, t) == [false, false, true]
        @test findall(pred, t) == [3]
        @test filter(pred, t) == Table(a = [1], b = [3])

        @test Predicate(pred, (a=1,)) === IsGreaterEqual((b=1,))
        @test Predicate(pred, (b=1,)) === IsLess((a=1,))
    end

    @testset "LessEqualThan" begin
        pred = LessEqualThan(:a, :b)
        
        @test pred((a=1, b=0)) === false
        @test pred((a=1, b=1)) === true
        @test pred((a=1, b=2)) === true
        @test pred((a=1, b=0, c=2.0)) === false
        @test pred((a=1, b=1, c=2.0)) === true
        @test pred((a=1, b=2, c=2.0)) === true
        @test pred((b=0, a=1)) === false
        @test pred((b=1, a=1)) === true
        @test pred((b=2, a=1)) === true

        va = [2, 3, 1]
        vb = [2, 1, 3]
        t = Table(a = va, b = vb)

        @test map(pred, t) == [true, false, true]
        @test findall(pred, t) == [1, 3]
        @test filter(pred, t) == Table(a = [2, 1], b = [2, 3])

        @test Predicate(pred, (a=1,)) === IsGreater((b=1,))
        @test Predicate(pred, (b=1,)) === IsLessEqual((a=1,))
    end

    @testset "GreaterThan" begin
        pred = GreaterThan(:a, :b)
        
        @test pred((a=1, b=0)) === true
        @test pred((a=1, b=1)) === false
        @test pred((a=1, b=2)) === false
        @test pred((a=1, b=0, c=2.0)) === true
        @test pred((a=1, b=1, c=2.0)) === false
        @test pred((a=1, b=2, c=2.0)) === false
        @test pred((b=0, a=1)) === true
        @test pred((b=1, a=1)) === false
        @test pred((b=2, a=1)) === false

        va = [2, 3, 1]
        vb = [2, 1, 3]
        t = Table(a = va, b = vb)

        @test map(pred, t) == [false, true, false]
        @test findall(pred, t) == [2]
        @test filter(pred, t) == Table(a = [3], b = [1])

        @test Predicate(pred, (a=1,)) === IsLessEqual((b=1,))
        @test Predicate(pred, (b=1,)) === IsGreater((a=1,))
    end

    @testset "GreaterEqualThan" begin
        pred = GreaterEqualThan(:a, :b)
        
        @test pred((a=1, b=0)) === true
        @test pred((a=1, b=1)) === true
        @test pred((a=1, b=2)) === false
        @test pred((a=1, b=0, c=2.0)) === true
        @test pred((a=1, b=1, c=2.0)) === true
        @test pred((a=1, b=2, c=2.0)) === false
        @test pred((b=0, a=1)) === true
        @test pred((b=1, a=1)) === true
        @test pred((b=2, a=1)) === false

        va = [2, 3, 1]
        vb = [2, 1, 3]
        t = Table(a = va, b = vb)

        @test map(pred, t) == [true, true, false]
        @test findall(pred, t) == [1, 2]
        @test filter(pred, t) == Table(a = [2, 3], b = [2, 1])

        @test Predicate(pred, (a=1,)) === IsLess((b=1,))
        @test Predicate(pred, (b=1,)) === IsGreaterEqual((a=1,))
    end

    @testset "Within" begin
        pred = Within(:a, :b, 1)
        
        @test pred((a=1, b=-1)) === false
        @test pred((a=1, b=0)) === true
        @test pred((a=1, b=1)) === true
        @test pred((a=1, b=2)) === true
        @test pred((a=1, b=3)) === false
        @test pred((a=1, b=-1, c=2.0)) === false
        @test pred((a=1, b=1, c=2.0)) === true
        @test pred((a=1, b=3, c=2.0)) === false
        @test pred((b=-1, a=1)) === false
        @test pred((b=1, a=1)) === true
        @test pred((b=3, a=1)) === false

        va = [2, 3, 1]
        vb = [2, 1, 3]
        t = Table(a = va, b = vb)

        @test map(pred, t) == [true, false, false]
        @test findall(pred, t) == [1]
        @test filter(pred, t) == Table(a = [2], b = [2])

        @test Predicate(pred, (a=1,)) === In((b=0..2,))
        @test Predicate(pred, (b=1,)) === In((a=0..2,))
    end
end
