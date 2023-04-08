#include "RoaringBitmap.h"

#include "godot_cpp/variant/utility_functions.hpp"

void RoaringBitmap::add(uint32_t value)
{
    _bitmap.add(value);
}
void RoaringBitmap::add_all(godot::TypedArray<uint32_t> values)
{
    for (int i = 0; i < values.size(); i++)
    {
        _bitmap.add(values[i]);
    }
}

void RoaringBitmap::remove(uint32_t value)
{
    _bitmap.remove(value);
}

uint32_t RoaringBitmap::get_maximum() const noexcept
{
    return _bitmap.maximum();
}

uint32_t RoaringBitmap::get_minimum() const noexcept
{
    return _bitmap.minimum();
}
size_t RoaringBitmap::get_cardinality() const noexcept
{
    return _bitmap.cardinality();
}
bool RoaringBitmap::contains(uint32_t value) const noexcept
{
    return _bitmap.contains(value);
}
bool RoaringBitmap::is_empty() const noexcept
{
    return _bitmap.isEmpty();
}
void RoaringBitmap::intersection_of(godot::Ref<RoaringBitmap> other)
{
    _bitmap &= other->_bitmap;
}
void RoaringBitmap::union_of(godot::Ref<RoaringBitmap> other)
{
    _bitmap |= other->_bitmap;
}
void RoaringBitmap::difference_of(godot::Ref<RoaringBitmap> other )
{
    _bitmap -= other->_bitmap;
}
void RoaringBitmap::symmetric_union(godot::Ref<RoaringBitmap> other )
{
    _bitmap ^= other->_bitmap;
}
void RoaringBitmap::swap(godot::Ref<RoaringBitmap> other)
{
    _bitmap.swap(other->_bitmap);
}
godot::TypedArray<uint32_t> RoaringBitmap::to_array() const
{
    godot::TypedArray<uint32_t> array;
    for (auto it = _bitmap.begin(); it != _bitmap.end(); ++it)
    {
        array.append(*it);
    }
    return array;
}


void RoaringBitmap::_bind_methods()
{
    godot::ClassDB::bind_method(godot::D_METHOD("add", "value"), &RoaringBitmap::add);
    godot::ClassDB::bind_method(godot::D_METHOD("remove", "value"), &RoaringBitmap::remove);
    godot::ClassDB::bind_method(godot::D_METHOD("add_all", "values"), &RoaringBitmap::add_all);
    godot::ClassDB::bind_method(godot::D_METHOD("get_maximum"), &RoaringBitmap::get_maximum);
    godot::ClassDB::bind_method(godot::D_METHOD("get_minimum"), &RoaringBitmap::get_minimum);
    godot::ClassDB::bind_method(godot::D_METHOD("get_cardinality"), &RoaringBitmap::get_cardinality);
    godot::ClassDB::bind_method(godot::D_METHOD("contains", "value"), &RoaringBitmap::contains);
    godot::ClassDB::bind_method(godot::D_METHOD("is_empty"), &RoaringBitmap::is_empty);
    godot::ClassDB::bind_method(godot::D_METHOD("intersection_of", "other"), &RoaringBitmap::intersection_of);
    godot::ClassDB::bind_method(godot::D_METHOD("union_of", "other"), &RoaringBitmap::union_of);
    godot::ClassDB::bind_method(godot::D_METHOD("difference_of", "other"), &RoaringBitmap::difference_of);
    godot::ClassDB::bind_method(godot::D_METHOD("symmetric_union", "other"), &RoaringBitmap::symmetric_union);
    godot::ClassDB::bind_method(godot::D_METHOD("swap", "other"), &RoaringBitmap::swap);
    godot::ClassDB::bind_method(godot::D_METHOD("to_array"), &RoaringBitmap::to_array);
}