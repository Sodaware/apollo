package net.sodaware.apollo
{

	import net.sodaware.apollo.util.ImmutableBag;

	/**
	 * The main entity class. Only create these using the World class,
     * not with a New constructor.
	 */
	public final class Entity
	{

		private var id:int;
		private var uniqueId:Number;
		private var typeBits:Number;
		private var systemBits:Number;

		private var world:World;
		private var entityManager:EntityManager;

		private var enabled:Boolean;

		private var refreshPending:Boolean;
		
		public function isRefreshPending() : Boolean
		{
			return this.refreshPending;
		}
		
		public function cancelRefresh() : void
		{
			this.refreshPending = false;
		}

		/**
		 * Returns true if the Entity is enabled, false if not.
		 */
		public function isEnabled() : Boolean {
			return this.enabled;
		}
		
		/**
		 * Enable the entity so it will be processed by systems.
		 */
		public function enable() : void {
			if (!this.enabled) {
				this.refresh();
			}
			this.enabled = true;
		}
		
		/**
		 * Disable the entity so it will not be processed.
		 */
		public function disable() : void {
			if (this.enabled) {
				this.refresh();
			}
			this.enabled = false;
		}

		public function Entity(world:World, id:int)
		{
			this.world = world;
			this.entityManager = this.world.getEntityManager();
			this.id = id;
			this.enabled = true;
			this.refreshPending = false;
			this.refresh();
		}
		
		/**
         * Internal ID for this entity. ID's are unique whilst
         * entities are alive, but may be reused once an instance has
         * een destroyed. Use UniqueID for somethign that can be serialized.
		 */
		public function getId() : int {
			return this.id;
		}
		
		public function setUniqueId(uniqueId:Number) : void {
			this.uniqueId = uniqueId;
		}
		
		/**
         * Unique ID that will never be reused.
		 */
		public function getUniqueId() : Number {
			return uniqueId;
		}
		
		public function getTypeBits() : Number {
			return this.typeBits;
		}

		public function addTypeBit(bit:Number) : void {
			this.typeBits |= bit;
		}

		public function removeTypeBit(bit:Number) : void {
			this.typeBits &= ~bit;
		}
		
		public function getSystemBits() : Number {
			return this.systemBits;
		}
		
		public function addSystemBit(bit:Number) : void {
			this.systemBits |= bit;
		}

		public function removeSystemBit(bit:Number) : void{
			this.systemBits &= ~bit;
		}
		
		public function setSystemBits(systemBits:Number) : void {
			this.systemBits = systemBits;
		}

		public function setTypeBits(typeBits:Number) : void{
			this.typeBits = typeBits;
		}

		public function reset() : void
		{
			this.systemBits = 0;
			this.typeBits = 0;
			this.enable();
		}

		public function toString() : String {
			return "Entity[" + id + "]";
		}

		/**
		 * Add a component to this entity.
		 * 
		 * @param component The component to add.
		 */
		public function addComponent(component:Component) : void
        {
			this.entityManager.addComponent(this, component);
			this.refresh();
		}

		/**
		 * Removes a component from this entity.
		 * 
		 * @param component The component to remove.
		 */
		public function removeComponent(component:Component) : void
		{
			this.entityManager.removeComponent(this, component);
			this.refresh();
		}
		
		/**
		 * Remove a component from the entiy using its component type
		 * (this is faster than removing the object).
		 * 
		 * @param type ComponentType of component to remove.
		 */
		public function removeComponentByType(type:ComponentType) : void
		{
			this.entityManager.removeComponentByType(this, type);
			this.refresh();
		}

		/**
		 * Checks if the entity has been deleted.
		 * 
		 * @return True if entity alive + active.
		 */
		public function isActive() : Boolean
		{
			return this.entityManager.isActive(this.id);
		}
		
		public function isAlive() : Boolean
		{
			return (this.world.getEntity(id) != null);
		}

		/**
		 * Fetch a component from an entity using its type. This is
		 * the fastest way to do it.
		 * @return Component instance, or null if entity does not have component.
		 */
		public function getComponent(type:ComponentType) : Component
		{
			return this.entityManager.getComponent(this, type);
		}

		/**
		 * Get all components attached to this entity.
		 * @return All entity components
		 */
		public function getComponents() : ImmutableBag
		{
			return entityManager.getComponents(this);
		}

		/**
		 * Refresh entity. Call this after adding components so
         * systems will update.
		 */
		public function refresh() : void {
			
			if (this.refreshPending) {
				return;
			}
			
			this.world.refreshEntity(this);
			this.refreshPending = true;
		}
		
		/**
		 * Delete this entity from the world.
		 */
		public function kill() : void
		{
			this.world.deleteEntity(this);
		}

		/**
		 * Set the group of the entity. Same as World.setGroup().
		 * 
		 * @param group The group to set.
		 */
		public function setGroup(group:String) : Entity
		{
			this.world.getGroupManager().set(group, this);
			return this;
		}
		
		/**
		 * Assign a tag to this entity. Same as World.addTag().
		 * 
		 * @param tag Tag to add.
		 */
		public function addTag(tag:String) : Entity
		{
			this.world.getTagManager().addTag(this, tag);
			return this;
		}

		/**
		 * Set unique name for this entity. Same as World.setName
		 * 
		 * @param name Name to set
		 */
		public function setName(name:String) : Entity
		{
			this.world.getNameManager().setName(this, name);
			return this;
		}


	}

}
