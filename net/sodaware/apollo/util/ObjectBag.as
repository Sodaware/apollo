package net.sodaware.apollo.util
{

    /**
     * An ObjectBag is a collection for holding objects that do not need to be
     * in any particular order. It can grow to accomodate more items, so is more
     * flexible than an array.
     */
    public class ObjectBag implements ImmutableBag
    {
        /**
         * @var data Internal bag data.
         */
        private var data:Array = new Array();

        /**
         * @var _size Number of items currently in the bag. Can differ from 
         * capacity, so can't use array length.
         */
        private var _size:int = 0;
        
        
        // ----------------------------------------------------------------------
        // -- Adding / Retrieving Items
        // ----------------------------------------------------------------------

        /**
         * Add an object to the ObjectBag. Will automatically resize the bag if
         * capacity is reached.
         * 
         * @param item The object to add.
         */
        public function add(item:Object) : void
        {
            // Automatically grow
            if (this._size == this.data.length) {
                this.grow();
            }
            
            this.data[this._size++] = item;
        }

        /**
         * Add all items from another ObjectBag to this bag.
         * @param items The items to add.
         */
        public function addAll(items:ObjectBag) : void
        {
            // TODO: Check bag is valid

            for (var i:int = 0; items.getSize() > i; i++) {
                this.add(items.get(i));
            }
            
        }
 

        /**
         * Set a specific index in the ObjectBag. 
         * 
         * @param index Index to set.
         * @param item The object to set.
         */
        public function set(index:int, item:Object) : void
        {
            // Gow bag if required
            if (index >= this.data.length) {
                this.grow(index * 2);
                this._size = index + 1;
            } else if (index >= this._size) {
                this._size = index + 1;
            }
            
            this.data[index] = item;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Retrieving Items
        // ----------------------------------------------------------------------

        /**
         * Returns the object at the specified index.
         * 
         * @param index Index of the object to return.
         * @return Object at this index.
         */
        public function get(index:int) : Object
        {
            return this.data[index];
        }
        

        // ----------------------------------------------------------------------
        // -- Removing Items
        // ----------------------------------------------------------------------

        /**
         * Remove an element from the ObjectBag at a specific index and return 
         * it. Returns NULL if index is out of range.
         * 
         * @param index The index of the object to remove
         * @return The removed object.
         */
        public function remove(index:int) : Object
        {
            // Check item is within range
            if (this._size == 0 || index >= this.data.length) {
                return null;
            }
            
            // Fetch item at index
            var item:Object = this.data[index];
            
            // Swap with element at end of array
            this.data[index] = this.data[--this._size];
            
            // Remove last element
            this.data[this._size] = null;

            // Return value
            return item;
        }
        
        /**
         * Remove and return the last object in the ObjectBag.
         * 
         * @return Last element, or null if ObjectBag is empty.
         */
        public function removeLast() : Object
        {
            if (this._size == 0) {
                return null;
            }
            
            var item:Object = this.data[--this._size];
            data[this._size] = null;
            return item;
        }

        /**
         * Removes the first occurence of an object from the bag.
         * 
         * @param item The object to remove.
         * @return True if object removed, false if not.
         */
        public function removeObject(item:Object) : Boolean
        {
            var pos:int = this.indexOf(item);
            if (pos == -1) {
                return false;
            }
            this.remove(pos);
            return true;
        }
        
        /**
         * Removes all items from the specified bag.
         * 
         * @param bag Bag containing objects to remove.
         * @return True if anything removed.
         */
        public function removeAll(bag:ObjectBag) : Boolean
        {
            var modified:Boolean = false;

            for (var i:int = 0; i < bag.getSize(); i++) {
                modified = modified || this.removeObject(bag.get(i));
            }

            return modified;
        }
        
       /**
         * Remove ALL objects from the ObjectBag.
         */
        public function clear() : void 
        {
            for (var i:int = 0; i < this._size; i++) {
                this.data[i] = null;
            }
            
            this._size = 0;
        }
 
        
        // ----------------------------------------------------------------------
        // -- ObjectBag Queries
        // ----------------------------------------------------------------------
        
        /**
         * Check if the bag contains a specific object.
         * 
         * @param item The object to search for.
         * @return True if bag contains the object, false if not.
         */
        public function contains(item:Object) : Boolean
        {
            return (this.indexOf(item) != -1);
        }
        
        /**
         * Get the position of an object in the ObjectBag. Returns -1 if not found.
         *
         * @param item The object to search for.
         * @return The index of the object, or -1 if not found.
         */
        public function indexOf(item:Object) : int
        {  
            for (var i:int = 0; this._size > i; i++) {
                if (item == this.data[i]) {
                    return i;
                }
            }

            return -1;
        }

        /**
         * Returns the number of objects stored in the ObjectBag.
         * 
         * @return Number of objects in this bag.
         */
        public function getSize() : int {
            return this._size;
        }

        /**
         * Returns the current bag capacity. Adding more items than this will cause
         * the bag to grow.
         * 
         * @return Bag capacity.
         */
        public function getCapacity() : int
        {
            return this.data.length;
        }

        /**
         * Check if the bag is empty.
         * 
         * @return True if bag contains no objects.
         */
        public function isEmpty() : Boolean
        {
            return (this._size == 0);
        }
        

        // ----------------------------------------------------------------------
        // -- Internal Helpers
        // ----------------------------------------------------------------------

        /**
         * Resize the bag to a new capcity. If no new capacity specified, will increase bag size
         * by 50%.
         *
         * @param newCapacity The new capacity of the bag. Use -1 to auto-grow.
         */
        private function grow(newCapacity:int = -1 ) : void
        {
            if (newCapacity == -1) {
                newCapacity = (this.data.length * 3) / 2 + 1;
            }
           
            var oldData:Array = data;
            this.data = new Array(newCapacity);

            for (var i:int = 0; i < oldData.length - 1; i++) {
                this.data[i] = oldData[i];
            }
            
        }
        
        
        // ----------------------------------------------------------------------
        // -- Construction
        // ----------------------------------------------------------------------

        /**
         * Create a new object bag with an initial capacity.
         * @param capacity Initial capacity of bag. Default is 16.
         */
        public function ObjectBag(capacity:int = 16) 
        {
            this.data = new Array(capacity);
        }
        
    }

}