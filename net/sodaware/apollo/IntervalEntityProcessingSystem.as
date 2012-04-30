package net.sodaware.apollo
{
    
    import net.sodaware.apollo.utils.ObjectBag;

    /**
     * Process entities at regular intervals.
     */
    public abstract class IntervalEntityProcessingSystem extends IntervalEntitySystem
    {

        /**
         * Create a new IntervalEntityProcessingSystem attached to a component.
         * @param requiredType Component to listen to.
         * @param otherTypes Additional component types to attach to.
         */
        public function IntervalEntityProcessingSystem(interval:int, requiredType:Class, ... otherTypes)
        {
            super(interval, this.getMergedTypes(requiredType, otherTypes));
        }
        
        /**
         * Process an entity.
         * @param e Entity to process
         */
        protected abstract function process(e:Entity) : void;
        
        
        protected override function processEntities(entities:ObjectBag) : void
        {
            for (var i:int = 0, s = entities.size(); s > i; i++) {
                this.process(entities.get(i));
            }
        }
        
    }

}
