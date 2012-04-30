package net.sodaware.apollo
{
    
    import flash.utils.Dictionary;

    /**
     * Manages entity named lookups. An entity may only have one name, and each
     * name must be unique. Good for fast(ish) friendly lookups. Names are
     * case-sensitive.
     */
    public class NameManager
    {
        
        /**
         * @var The world this manager belongs to.
         */
        private var world:World;
        
        /**
         * @var A map of name => entity
         */
        private var nameLookup:Dictionary;
        
        
        // ----------------------------------------------------------------------
        // -- Setting / Unsetting Names
        // ----------------------------------------------------------------------
        
        /**
         * Set the name for an entity.
         *
         * @param e The entity to set a name for.
         * @param name The name to set.
         */
        public function setName(e:Entity, name:String) : void
        {
            this.nameLookup[tag] = e;
        }
        
        /**
         * Remove a name. Does not destroy the entity.
         * 
         * @param name The name to remove.
         */
        public function removeName(name:String) : void
        {
            this.nameLookup.remove(name);
        }
        
        
        // ----------------------------------------------------------------------
        // -- Retrieving names / entities
        // ----------------------------------------------------------------------
        
        /**
         * Check if a name exists.
         * 
         * @param name The name to search for.
         * @return True if name exists, false if not.
         */
        public function nameExists(name:String) : Boolean
        {
            return this.nameLookup.containsKey(name);
        }
        
        /**
         * Get entity with a name.
         * 
         * @param name The name to search for.
         * @return The entity with this name, or null if not found.
         */
        public function getEntity(name:String) : Entity
        {
            return this.nameLookup[name] as Entity;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Construction
        // ----------------------------------------------------------------------
        
        public function NameManager(world:World)
        {
            this.world = world;
            this.nameLookup = new Dictionary();
        }
        
    }

}