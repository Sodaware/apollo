package net.sodaware.apollo.util
{
    
    public interface ImmutableBag
    {
        function get(index:int) : Object;
        function getSize() : int;
        function isEmpty() : Boolean;
    }

}