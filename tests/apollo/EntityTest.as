package tests.apollo
{
	
	import asunit.framework.TestCase;	
	import net.sodaware.apollo.Entity;
	import net.sodaware.apollo.World;
	import net.sodaware.apollo.Component;
	import net.sodaware.apollo.ComponentType;
	import net.sodaware.apollo.ComponentTypeManager;

	public class EntityTest extends TestCase
	{

		public function EntityTest(testMethod:String)
		{
  	    	super(testMethod);
  	  	}

		public function shouldHaveRefreshPendingOnCreation() : void {
			var world:World = new World();
			var entity:Entity = world.createEntity();
			assertEquals(true, entity.isRefreshPending());
		}

		public function shouldRefreshOnAddComponent() : void {
			var world:World = new World();
			var entity:Entity = world.createEntity();

			entity.cancelRefresh();

			entity.addComponent(new Component());

			assertTrue(entity.isRefreshPending);
		}

	
		public function shouldRefreshOnRemoveComponent() : void {
			var world:World = new World();
			var entity:Entity = world.createEntity();

			entity.cancelRefresh();

			var component:Component = new Component();

			entity.addComponent(component);

			entity.cancelRefresh();

			entity.removeComponent(component);

			assertTrue(entity.isRefreshPending());
		}

		public function shouldRefreshOnRemoveComponentUsingType() : void {
			var world:World = new World();
			var entity:Entity = world.createEntity();

			entity.cancelRefresh();

			var component:Component = new Component();

			entity.addComponent(component);

			entity.cancelRefresh();

			var type:ComponentType = ComponentTypeManager.getTypeFor(Object(component).constructor);
			entity.removeComponentByType(type);
			
			assertTrue(entity.isRefreshPending());
		}

	}
}