package net.sodaware.apollo
{
	 
    import net.sodaware.apollo.util.ImmutableBag;
    
    /**
     * Base system to process entities only after a certain amount of time has passed.
     */
    public class DelayedEntityProcessingSystem extends DelayedEntitySystem
    {
        
        public function DelayedEntityProcessingSystem(requiredType:Class, ... otherTypes)
        {
            super(getMergedTypes(requiredType, otherTypes));
        }
		
        protected function processEntity(e:Entity, accumulatedDelta:int) : void
        {
        }
        
        public final override function processEntities(entities:ImmutableBag, accumulatedDelta:int) : void
        {
            for (var i:int = 0, s = entities.size(); s > i; i++) {
                this.processEntity(entities.get(i), accumulatedDelta);
            }
        }
    }

}
