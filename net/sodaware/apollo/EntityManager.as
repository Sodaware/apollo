package net.sodaware.apollo
{
	
	import net.sodaware.apollo.util.ObjectBag;
	import net.sodaware.apollo.util.ImmutableBag;
	
	public class EntityManager
	{
		private var world:World;
		private var activeEntities:ObjectBag;				// Bag of Entity objects
		private var removedAndAvailable:ObjectBag;		// Bag of Entity objects
		private var nextAvailableId:int;
		private var count:int;
		private var uniqueEntityId:Number;
		private var totalCreated:Number;
		private var totalRemoved:Number;
		
		private var componentsByType:ObjectBag;	// Bag of Bag of Components [bag[bag[component, component], bag[component, component]]
		
		private var entityComponents:ObjectBag; 		// Bag of components
		
		public function EntityManager(world:World)
		{
			
			this.world = world;
			
			this.activeEntities = new ObjectBag();
			this.removedAndAvailable = new ObjectBag();
			
			this.componentsByType = new ObjectBag();

			this.entityComponents = new ObjectBag();
			
		}
		
		public function create() : Entity
		{
			
			// Check for entities in the available pool first
			var e:Entity = this.removedAndAvailable.removeLast() as Entity;
			
			if (e == null) {
				e = new Entity(world, this.nextAvailableId++);
			} else {
				e.reset();
			}
			
			e.setUniqueId(this.uniqueEntityId++);
			this.activeEntities.set(e.getId(), e);
			this.count++;
			this.totalCreated++;
			
			return e;
			
		}
		
		public function remove(e:Entity) : void
		{
			
			this.activeEntities.set(e.getId(), null);
		
			e.setTypeBits(0);

			this.refresh(e);

			this.removeComponentsOfEntity(e);

			this.count--;
			this.totalRemoved++;

			// Add to available pool
			this.removedAndAvailable.add(e);
			
		}

		private function removeComponentsOfEntity(e:Entity) : void
		{
			
			for (var a:int = 0; this.componentsByType.getSize() > a; a++) {
				
				var components:ObjectBag = this.componentsByType.get(a) as ObjectBag;
			
				if (components != null && e.getId() < components.getSize()) {
					components.set(e.getId(), null);
				}
				
			}
			
		}

		/**
		 * Check if entity is active.
		 *
		 * @param entityId ID of entity
		 * @return True if active, false if not.
		 */
		public function isActive(entityId:int) : Boolean
		{
			return (this.activeEntities.get(entityId) != null);
		}

		public function addComponent(e:Entity, component:Component) : void
		{
			var type:ComponentType = ComponentTypeManager.getTypeFor(Object(component).constructor); 

			if (type.getId() >= this.componentsByType.getCapacity()) {
				this.componentsByType.set(type.getId(), null);
			}
			
			var components:ObjectBag = this.componentsByType.get(type.getId()) as ObjectBag;
			
			if (components == null) {
				components = new ObjectBag();
				this.componentsByType.set(type.getId(), components);
			}
			
			components.set(e.getId(), component);
			
			e.addTypeBit(type.getBit());
		}

		public function refresh(e:Entity) : void
		{
			var systemManager:SystemManager = world.getSystemManager();
			
			var systems:ObjectBag = systemManager.getSystems();
			var s:int = systems.getSize();
			for (var i:int = 0; s > i; i++) {
				systems.get(i).change(e);
			}
		}

		public function removeComponent(e:Entity, component:Component) : void
		{
			var type:ComponentType = ComponentTypeManager.getTypeFor(Object(component).constructor);
			this.removeComponentByType(e, type);
		}

		public function removeComponentByType(e:Entity, type:ComponentType) : void
		{
			var components:ObjectBag = componentsByType.get(type.getId()) as ObjectBag;
			components.set(e.getId(), null);
			e.removeTypeBit(type.getBit());
		}

		public function getComponent(e:Entity, type:ComponentType) : Component
		{
			var componentTypeId:int = type.getId();
			
			if (componentTypeId >= this.componentsByType.getCapacity()) {
				return null;
			}

			var bag:ObjectBag = this.componentsByType.get(componentTypeId) as ObjectBag;
			if (bag != null && e.getId() < bag.getCapacity()) {
				return bag.get(e.getId()) as Component;
			}
			
			return null;
		}

		public function getEntity(entityId:int) : Entity
		{
			return this.activeEntities.get(entityId) as Entity;
		}

		/**
		*
		* @return Number of active entities
		*/
		public function getEntityCount() : int {
			return count;
		}

		/**
		*
		* @return Number of entities created in total.
		*/
		public function getTotalCreated() : Number {
			return totalCreated;
		}

		/**
		*
		* @return Number of entities that have been removed since
		* world created.
		*/
		public function getTotalRemoved() : Number {
			return totalRemoved;
		}

		public function getComponents(e:Entity)  : ImmutableBag
		{
			this.entityComponents.clear();
			for (var a:int = 0; componentsByType.getSize() > a; a++) {
				var components:ObjectBag = componentsByType.get(a) as ObjectBag;
				if(components != null && e.getId() < components.getSize()) {
					var component:Component = components.get(e.getId()) as Component;
					if(component != null) {
						entityComponents.add(component);
					}
				}
			}
			return entityComponents;
		}

	}
}
