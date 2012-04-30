package net.sodaware.apollo
{
	
	import net.sodaware.apollo.util.ImmutableBag;

	/**
	 * A basic system for running functions after a set amount of time
     * has expired. Similar to IntervalEntitySystem, except it only
     * runs once until reset.
	 */
	public class DelayedEntitySystem extends EntitySystem
	{
		private var delay:int;
		private var running:Boolean;
		private var acc:int;

		public function DelayedEntitySystem(... types)
		{
			super(types);
		}
		
		protected final function processEntities(entities:ImmutableBag) : void
		{
			this.processEntities(entities, acc);
			this.stop();
		}

		protected override final function checkProcessing() : Boolean
		{
			if (this.running) {
				this.acc += world.getDelta();
				
				if (this.acc >= delay) {
					return true;
				}
			}
			
			return false;
		}
		
		protected function processEntities(entities:ImmutableBag, accumulatedDelta:int) : void
		{
			
		}
		
        /**
         * Start a new delayed execution. Will count down to delay and
         * then run.
         */
		public function startDelayedRun(delay:int) : void
		{
			this.delay = delay;
			this.acc = 0;
			this.running = true;
		}

		public function getInitialTimeDelay() : int
		{
			return this.delay;
		}

		public function getRemainingTimeUntilProcessing() : int
		{
			return (this.running) ?
				this.delay - this.acc :
				0;
		}
		
        /**
         * Checks if system is currently counting down to an
         * execution. 
         */
		public function isRunning() : Boolean
		{
			return this.running;
		}
		
		/**
		 * Cancels execution.
		 */
		public function stop() : void
		{
			this.running = false;
			this.acc = 0;
		}
		
	}

}
