package net.sodaware.apollo
{

    /**
     * A base system to process entities at set intervals (in milliseconds).
     */
    public abstract class IntervalEntitySystem extends EntitySystem
    {
        
        /**
         * @var Time in milliseconds that have elapsed since the last process.
         */
        private var elapsed:int;
        
        /**
         * @var The length of time (in milliseconds) to wait between processes.
         */
        private var interval:int;
        
        
        // ----------------------------------------------------------------------
        // -- Execution Checking
        // ----------------------------------------------------------------------
        
        protected override function checkProcessing() : Boolean
        {
            this.elapsed += this.world.getDelta();
            if (this.elapsed >= this.interval) {
                this.acc -= this.interval;
                return true;
            }
            return false;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Construction
        // ----------------------------------------------------------------------
        
        /**
         * Create a new 
        public function IntervalEntitySystem(interval:int, ... types)
        {
            super(types);
            this.interval = interval;
        }
        
        
    }
    
}