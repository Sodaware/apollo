package net.sodaware.apollo
{

	import net.sodaware.apollo.util.ObjectBag;

	/**
	 * The primary instance for the framework. It contains all the managers.
	 * 
	 * You must use this to create, delete and retrieve entities.
	 * 
	 * It is also important to set the delta each game loop iteration.
	 * 
	 * @author Arni Arent
	 *
	 */
	public class World
	{
		private var systemManager:SystemManager;
		private var entityManager:EntityManager;
		private var tagManager:TagManager;
		private var groupManager:GroupManager;
		private var nameManager:NameManager;		

		private var delta:int;
		private var refreshed:ObjectBag;
		private var deleted:ObjectBag;
		
		
		// ----------------------------------------------------------------------
		// -- Manager getters
		// ----------------------------------------------------------------------

		public function getGroupManager() : GroupManager {
			return this.groupManager;
		}

		public function getSystemManager() : SystemManager {
			return this.systemManager;
		}

		public function getEntityManager() : EntityManager {
			return this.entityManager;
		}

		public function getTagManager() : TagManager {
			return this.tagManager;
		}
		
		public function getNameManager() : NameManager {
			return this.nameManager;
		}
		
		
		// ----------------------------------------------------------------------
		// -- Entity Management
		// ----------------------------------------------------------------------

		/**
		 * Create and return a new entity.
		 * @return Entity Newly created entity.
		 */
		public function createEntity() : Entity {
			return this.entityManager.create();
		}
		
		/**
		 * Retrieve an entity with a specific ID.
		 * @param entityId ID of the entity to retrieve.
		 * @return Entity The retrieved entity.
		 */
		public function getEntity(entityId:int) : Entity{
			return entityManager.getEntity(entityId);
		}
		
		/**
		 * Notifies all systems of changes to the entity.
		 * @param e Entity The entity to retfresh
		 */
		public function refreshEntity(e:Entity) : void {
			this.refreshed.add(e);
		}
		
		
		/**
		 * Delete an entity from the world.
		 * @param e Entity The entity to delete.
		 */
		public function deleteEntity(e:Entity) : void
		{    
			// Disable entity, and add to deleted queue (if not already present)
			e.disable();
			if(!this.deleted.contains(e)) {
				this.deleted.add(e);
			}
		}
		
		
		// ----------------------------------------------------------------------
		// -- Delta Timing
		// ----------------------------------------------------------------------
		
		/**
		 * Get the amount of time since the last game loop.
		 * @return Delta in milliseconds.
		 */
		public function getDelta() : int
		{
			return this.delta;
		}
		
		/**
		 * Set the time in milliseconds since the last game loop. 
		 * @param delta Delta.
		 */
		public function setDelta(delta:int) : void
		{
			this.delta = delta;
		}
		
		
		// ----------------------------------------------------------------------
		// -- Execution
		// ----------------------------------------------------------------------
		
		/**
		 * Update internals. Call this at the start of every game loop. For example,
		 * if you're using Flixel call it in the state's "update" loop.
		 */
		public function execute() : void
		{
			
			// Handle refreshed entities
			if (!this.refreshed.isEmpty()) {
				for(var i:int = 0; this.refreshed.getSize() > i; i++) {
					var e:Entity = this.refreshed.get(i) as Entity;
					this.entityManager.refresh(e);
					e.cancelRefresh();
				}
				this.refreshed.clear();
			} 
			
			// Remove deleted entities
			if (!this.deleted.isEmpty()) {
				for(var i:int = 0; deleted.getSize() > i; i++) {
					var e:Entity = this.deleted.get(i) as Entity;
					this.groupManager.remove(e);
					this.entityManager.remove(e);
				}
				this.deleted.clear();
			}
			
		}
		
		
		// ----------------------------------------------------------------------
		// -- Construction
		// ----------------------------------------------------------------------
		
		public function World() {
			this.entityManager = new EntityManager(this);
			this.systemManager = new SystemManager(this);
			this.tagManager = new TagManager(this);
			this.groupManager = new GroupManager(this);
			this.nameManager new NameManager(this);
			
			this.refreshed = new ObjectBag();
			this.deleted = new ObjectBag();
		}
		
	}
}
