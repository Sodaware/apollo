package tests.apollo
{
	
    import asunit.framework.TestCase;	
    import net.sodaware.apollo.Entity;
    import net.sodaware.apollo.World;
    import net.sodaware.apollo.Component;
    import net.sodaware.apollo.ComponentType;
    import net.sodaware.apollo.ComponentTypeManager;
    
    public class EntityManagerTest extends TestCase
    {
        
        public function EntityManagerTest(testMethod:String)
        {
            super(testMethod);
        }
        

        public function shouldCallAddedWhenCreated() : void
        {
            // Create world + add a mock system
            var world:World = new World();
            var mockSystemA:MockEntitySystem = new MockEntitySystem();
            
            world.getSystemManager().addSystem(mockSystemA);
            world.getSystemManager().initializeAll();
            
            var entity:Entity = world.createEntity();
            entity.refresh();
            entity.refresh();
            entity.refresh();
            
            world.execute();
            
            assertEquals(1, mockSystemA.changeCount);
        }
        
	}

}