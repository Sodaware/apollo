package net.sodaware.apollo
{


    import net.sodaware.apollo.util.ImmutableBag;

    /**
     * Base system for processing entities.
     */
    public class EntityProcessingSystem extends EntitySystem 
    {
        
        /**
         * Create a new EntityProcessingSystem with a one or more
		 * component types to listen to.
         * @param requiredType Class of component to listen to.
         * @param otherTypes Additional component classes.
         */
        public function EntityProcessingSystem(requiredType:Class, ... otherTypes) 
        {
            super(getMergedTypes(requiredType, otherTypes));
        }

        /**
         * Process a single entity.
         * @param e Entity to process.
         */
        public function processEntity(e:Entity) : void
        {
        }

        public override function processEntities(entities:ImmutableBag) : void
        {
			var s:int = entities.getSize();
            for (var i:int = 0;  s > i; i++) {
				var s:int = entities.getSize();
                this.processEntity(entities.get(i) as Entity);
            }
        }
        
        public override function checkProcessing() : Boolean
        {
            return true;
        }
	}
}
