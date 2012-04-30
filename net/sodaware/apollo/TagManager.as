package net.sodaware.apollo
{
    
    import flash.utils.Dictionary;

    /**
     * Manages entity tags. An entity can only have one group, but can
     * have multiple tags.
     */
    public class TagManager
    {
        
        /**
         * @var The world this tag manager belongs to.
         */
        private var world:World;
        
        /**
         * @var A map of tag => object bag
         */
        private var tags:Dictionary;
        
        
        // ----------------------------------------------------------------------
        // -- Setting Tags
        // ----------------------------------------------------------------------
        
        /**
         * Add a tag to an entity.
         * 
         * @param e The entity to tag.
         * @param tag The tag to set.
         */
        public function addTag(e:Entity, tag:String) : void
        {
            var tagEntities:ObjectBag = this._getTagContainer(tag);
            
            // Add entity if not already present
            if (!tagEntities.contains(e)) {
                tagEntities.add(e);
            }
            
        }
        
        /**
         * Remove a tag from an entity.
         * 
         * @param e The entity to untag
         * @param tag The tag to remove.
         */
        public function removeTag(e:Entity, tag:String) : void
        {            
            var tagEntities:ObjectBag = this._getTagContainer(tag);
            tagEntities.remove(e);
        }
        
        /**
         * Check if an entity has a tag.
         *
         * @param e The entity to check.
         * @param tag The tag to search for.
         * 
         * @return True if has tag, false if not.
         */
        public function hasTag(e:Entity, tag:String) : Boolean
        {
            var tagEntities:ObjectBag = this._getTagContainer(tag);
            return tagEntities.contains(e);
        }
        
        /**
         * Get all entities that have a tag.
         *
         * @param tag The tag to search for.
         * @return ObjectBag of entities with this tag.
         */
        public function getTagEntities(tag:String) : ObjectBag
        {
            return this._getTagContainer(tag);
        }
        
        /**
         * Get all entities that have one or more of a list of tags.
         * 
         * @param tagList One or more tags to search for.
         * @return ObjectBag of entities that have one or more tags set.
         */
        public function getEntitiesWithTags(... tagList) : ObjectBag
        {
            var entities:ObjectBag = new ObjectBag();
            
            // Fetch all tags
            foreach (var tag:String in tagList) {
                var group:ObjectBag = this._getTagContainer(tag);
                entities.addAll(entities);
            }
            return entities;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Helpers
        // ----------------------------------------------------------------------
        
        private function _getTagContainer(tag:String) : ObjectBag
        {
            
            // Get tag group
            var tagContainer:ObjectBag = this.tags[tag];
            
            // Initialise if not set
            if (!tagContainer) {
                tagContainer = new ObjectBag();
                this.tags[tag] = tagContainer;
            }
            
            return tagContainer;
            
        }
        
        
        // ----------------------------------------------------------------------
        // -- Construction
        // ----------------------------------------------------------------------
        
        public function TagManager(world:World)
        {
            this.world = world;
            this.tags = new Dictionary();
        }
        
    }

}