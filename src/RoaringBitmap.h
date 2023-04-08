#pragma once

#include <godot_cpp/classes/ref_counted.hpp>
#include <roaring.hh>

class RoaringBitmap : public godot::RefCounted
{
    GDCLASS( RoaringBitmap, godot::RefCounted )

    void add( uint32_t value );
    void add_all( godot::TypedArray<uint32_t> values );
    void remove( uint32_t value );
    uint32_t get_maximum() const noexcept;
    uint32_t get_minimum() const noexcept;
    uint64_t get_cardinality() const noexcept;
    bool contains( uint32_t value ) const noexcept;
    bool is_empty() const noexcept;

    void intersection_of( godot::Ref<RoaringBitmap> other );
    void union_of( godot::Ref<RoaringBitmap> other );
    void difference_of( godot::Ref<RoaringBitmap> other );
    void symmetric_union( godot::Ref<RoaringBitmap> other );
    void swap( godot::Ref<RoaringBitmap> other );
    godot::TypedArray<uint32_t> to_array() const;

private:
    static void _bind_methods();

    roaring::Roaring _bitmap;
};
