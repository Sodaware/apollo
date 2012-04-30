package net.sodaware.apollo
{
    
    import flash.utils.Dictionary;
    import net.sodaware.apollo.util.ObjectBag;
    
    /**
     * Manages systems registered with a World instance. Use this to retrieve
     * instances of other systems.
     */
    public class SystemManager
    {
        /**
         * @var The World instance this manager belongs to.
         */
        private var world:World;
        
        /**
         * @var A map of System Class => System instance objects
         */
        private var systems:Dictionary;
        
        /**
         * @var An unordered bag of system objects.
         */
        private var bagged:ObjectBag;
        
        
        // ----------------------------------------------------------------------
        // -- Adding / Removing Systems
        // ----------------------------------------------------------------------
        
        /**
         * Add a system to the manager and register it with the SystemBitManager. After
         * adding all systems, call initializeAll.
         * 
         * @param system The system to add.
         * @return The added system.
         */
        public function addSystem(system:EntitySystem) : EntitySystem
        {
            system.setWorld(this.world);
            
            this.systems[Object(system).constructor] = system;
            
            if (!this.bagged.contains(system)) {
                this.bagged.add(system);
            }
            
            system.setSystemBit(SystemBitManager.getBitFor(Object(system).constructor));
            
            return system;
        }
        
        /**
         * Remove a system from this manager. Does not delete the object or remove
         * it from the SystemBitManager.
         * 
         * @param system The system to remove.
         * @return True if removed, false if not.
         */
        public function removeSystem(system:EntitySystem) : Boolean
        {
            if (!this.bagged.contains(system)) {
                return false;
            }
            
            // Remove from collections
            this.bagged.removeObject(system);
            this.systems[Object(system).constructor] = null;
            
            return true;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Retrieving Systems
        // ----------------------------------------------------------------------
        
        /**
         * Retrieve a system by its class type.
         *
         * @param systemType The class of the system to retrieve.
         * @return The retrieved system. or null if not found.
         */
        public function getSystem(systemType:Class) : EntitySystem
        {
            return this.systems[systemType] as EntitySystem;
        }
        
        /**
         * Get a bag of all registered systems.
         *
         * @return ObjectBag of registered systems.
         */
        public function getSystems() : ObjectBag
        {
            return this.bagged;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Querying
        // ----------------------------------------------------------------------
        
        /**
         * Get the number of systems registered with this manager.
         * @return Number of systems.
         */
        public function countSystems() : int
        {
            return this.bagged.getSize();
        }
        
        
        // ----------------------------------------------------------------------
        // -- Updating / Initializing
        // ----------------------------------------------------------------------
        
        /**
         * Call the "process" function for all enabled systems.
         */
        public function processAll() : void
        {
            
            for (var i:int = 0; i < this.bagged.getSize(); i++) {
                EntitySystem(this.bagged.get(i)).process();
            }
            
        }
        
        /**
         * After adding all systems to the world, you must initialize them all.
         */
        public function initializeAll() : void
        {
            for (var i:int = 0; i < this.bagged.getSize(); i++) {
                this.bagged.get(i).initialize();
            }
        } 
                
        
        // ----------------------------------------------------------------------
        // -- Construction
        // ----------------------------------------------------------------------
        
        /**
         * Create a new system manager attached to a World.
         * @var world The world this SystemManager manages.
         */
        public function SystemManager(world:World)
        {
            this.world = world;
            this.systems = new Dictionary();
            this.bagged = new ObjectBag();
        }
        
    }

}