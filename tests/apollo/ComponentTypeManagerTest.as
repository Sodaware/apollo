package tests.apollo
{
	
    import asunit.framework.TestCase;	
    import net.sodaware.apollo.Entity;
    import net.sodaware.apollo.World;
    import net.sodaware.apollo.Component;
    import net.sodaware.apollo.ComponentType;
    import net.sodaware.apollo.ComponentTypeManager;
    
    public class ComponentTypeManagerTest extends TestCase
    {
        
        public function ComponentTypeManagerTest(testMethod:String)
        {
            super(testMethod);
        }

        // 
        public function shouldNotCreateComponentTypeForInvalidClassTest() : void
        {
            assertEquals(null, ComponentTypeManager.getTypeFor(String));
        }

        public function shouldCreateComponentTypeForValidTypeTest() : void
        {
            // Add a component
            var type:ComponentType = ComponentTypeManager.getTypeFor(MockComponent);
            
            // Check it added something
            assertNotNull(type);
            assertEquals(1, ComponentTypeManager.getBit(MockComponent));
            assertEquals(1, ComponentTypeManager.getId(MockComponent));
            
            // Check what was added is valid
            assertEquals(type.getBit(), ComponentTypeManager.getBit(MockComponent));
            assertEquals(type.getId(), ComponentTypeManager.getId(MockComponent));
        }

        public function getBitForInvalidTypeTest() : void
        {
            assertEquals(0, ComponentTypeManager.getBit(String));
        }

        public function getIdForInvalidTypeTest() : void
        {
            assertEquals(0, ComponentTypeManager.getId(String));
        }
        
	}

}