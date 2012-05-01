package net.sodaware.apollo
{

    import net.sodaware.apollo.util.ObjectBag;
    import net.sodaware.apollo.util.ImmutableBag;

    /**
     * Base Entity System. Extend others if appropriate.
     */
    public class EntitySystem
    {
        
        private var systemBit:Number;
        
        private var typeFlags:Number;
        
        protected var world:World;
        
        /**
         * @var A bag of all active entities within this system.
         */
        private var activeEntities:ObjectBag;

        /**
         * Create a new Entity system that is registered to a set of components.
         * @param types A list of Class types this system handles.
         */
        public function EntitySystem(types:Array)
        {
            
            // Setup list of activity entities
            this.activeEntities = new ObjectBag();
			
            // Register with each type
			for(var i:uint = 0; i < types.length; i++) {
				var ct:ComponentType = ComponentTypeManager.getTypeFor(types[i] as Class);
                this.typeFlags |= ct.getBit();
			}
        }
        
        public function setSystemBit(bit:Number) : void {
            this.systemBit = bit;
        }
        
        /**
         * Called before processing entities.
         */
        protected function beforeProcess() : void
        {
        }

        /**
         * Main processing.
         */
        public function process() : void 
        {
            if (this.checkProcessing()) {
                this.beforeProcess();
                this.processEntities(this.activeEntities);
                this.afterProcess();
            }
        }

        /**
         * Called after the processing of entities ends.
         */
        protected function afterProcess() : void
        {
        }

        /**
         * All EntitySystems should override this function to provide processing.
         */
        public function processEntities(entities:ImmutableBag) : void
		{
		}
        
        /**
         * Check if system should execute.
         */
        public function checkProcessing() : Boolean
		{
			return false;
		}

        /**
         * Init system internals.
         */
        public function initialize() : void
        {
        }

        /**
		 * Called if an entity has been added that this system should manage.
         */
        protected function added(e:Entity) : void 
        {
        }

        /**
         * Called when an entity is enabled.
         */
        protected function enabled(e:Entity) : void
        {
        }

        /**
         * Called when an entity is disabled.
         */
        protected function disabled(e:Entity) : void
        {
        }

        /**
		 * Called when an entity has been removed or had its compoennt removed.
         */
        protected function removed(e:Entity) : void
        {
        }

        public function change(e:Entity) : void
        {
            
            var contains:Boolean = (this.systemBit & e.getSystemBits()) == systemBit;
            var interest:Boolean = (this.typeFlags & e.getTypeBits()) == typeFlags;
            
            if (interest && !contains && typeFlags > 0) {
                this.add(e);
            } else if (!interest && contains && typeFlags > 0) {
                this.remove(e);
            } else if (interest && contains && e.isEnabled() && typeFlags > 0) {
                this.enable(e);
            } else if (interest && contains && !e.isEnabled() && typeFlags > 0) {
                this.disable(e);
            }
            
        }

        private function add(e:Entity) : void
        {
            
            e.addSystemBit(this.systemBit);
            this.added(e);
            if (e.isEnabled()) {
                this.enable(e);
            }
        }

        private function enable(e:Entity) : void
        {
            if (this.activeEntities.contains(e)) {
                return;
            }
            
            this.activeEntities.add(e);
            this.enabled(e);
        }

        private function remove(e:Entity) : void {
            e.removeSystemBit(systemBit);
            if (e.isEnabled()) {
                this.disable(e);
            }
            this.removed(e);
        }

        private function disable(e:Entity) : void 
        {
            if (!this.activeEntities.contains(e)) {
                return;
            }
            
            this.disabled(e);
            this.activeEntities.removeObject(e);
        }
        
        public final function setWorld(world:World) : void
        {
            this.world = world;
        }

        /**
		 * Utility function to merge types lists.
         */
        protected static function getMergedTypes(requiredType:Class, otherTypes:Array) : Array
        {
			// Check inputs
			var length:int = 1;
			var types:Array;
			if (otherTypes && otherTypes.length > 0) {
				otherTypes.shift();
				types = new Array(1 + otherTypes.length);
			}
			
            types[0] = requiredType;
			if (otherTypes) {
				for (var i:int = 0; otherTypes.length > i; i++) {
					types[i + 1] = otherTypes[i];
				}
			}
            return types;
        }

    }

}
