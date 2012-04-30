package net.sodaware.apollo
{

    import flash.utils.Dictionary;
    import net.sodaware.apollo.util.ObjectBag;
    
    
    /**
     * Manages groups of of entities. A group can have many entities, but an
     * entity may only have one group. Use this to group like entities. For single
     * identifiers, use NameManager. For multiple groups per entity, use TagManager.
     */
    public class GroupManager
    {
        
        /**
         * @var The world this Manager belongs to.
         */
        private var world:World;
        
        /**
         * @var Empty bag. Returned when group is empty to prevent empty collections
         * being created at runtime.
         */
        private var EMPTY_BAG:ObjectBag;
        
        /**
         * @var A dictionary of group_name:String => entities:ObjectBag
         */
        private var entitiesByGroup:Dictionary;
        
        /**
         * @var Quick lookup of entity groups
         */
        private var groupByEntity:ObjectBag;


        // ----------------------------------------------------------------------
        // -- Adding / Removing Groups
        // ----------------------------------------------------------------------

        /**
         * Set the group that an entity belongs to. An entity can only belong
         * to one group at a time. 
         *
         * @param group Group for this entity.
         * @param e Entity to add to group.
         */
        public function set(group:String, e:Entity) : void
        {
            
            // Remove entity from other groups
            this.remove(e);
            
            var entities:ObjectBag = this.entitiesByGroup[group] as ObjectBag;
            if (!entities) {
                entities = new ObjectBag();
                this.entitiesByGroup[group] = entities;
            }
            
            entities.add(e);
            
            this.groupByEntity.set(e.getId(), group);
        }
        
        /**
         * Removes an entity from a group.
         * @param e The entity to remove.
         */
        public function remove(e:Entity) : void
        {
            
            if (e.getId() < this.groupByEntity.getCapacity()) {
                
                var group:String = this.groupByEntity.get(e.getId()) as String;
                
                if (group != null) {
                    this.groupByEntity.set(e.getId(), null);
                    
                    var entities:ObjectBag = this.entitiesByGroup[group];
                    
                    if (entities != null) {
                        entities.removeObject(e);
                    }
                }
                
            }
            
        }
        
        
        // ----------------------------------------------------------------------
        // -- Retrieving Groups / Group Contents
        // ----------------------------------------------------------------------
        
        /**
         * Get a collection of all entities that belong to a group.
         * 
         * @param groupName Name of the group to search for.
         * @return Bag of entities.
         */
        public function getEntities(groupName:String) : ObjectBag
        {
            var bag:ObjectBag = this.entitiesByGroup[groupName] as ObjectBag;
            
            if (!bag) {
                return this.EMPTY_BAG;
            }
            
            return bag;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Querying Groups & Entities
        // ----------------------------------------------------------------------
        
        /**
         * Get the group that an entity belongs to.
         * 
         * @param e The entity to look up.
         * @return The group name this entity belongs to, or null if it has no group.
         */
        public function getGroupOf(e:Entity) : String
        {
            if (e.getId() < groupByEntity.getCapacity()) {
                return groupByEntity.get(e.getId()) as String;
            }
            
            return null;
        }
        
        /**
         * Checks if an entity is a member of any group.
         * 
         * @param e Entity to lookup.
         * @return True if entity has a group, false not.
         */
        public function isGrouped(e:Entity) : Boolean
        {
            return (this.getGroupOf(e) != null);
        }
        
        
        // ----------------------------------------------------------------------
        // -- Construction
        // ----------------------------------------------------------------------
        
        /**
         * Create a new GroupManager for a world.
         *
         * @param world The world this group manager belongs to.
         */
        public function GroupManager(world:World)
        {
            this.world = world;
            this.entitiesByGroup = new Dictionary();
            this.groupByEntity = new ObjectBag();
            this.EMPTY_BAG = new ObjectBag();
        }
        
    }
    
}