package tests
{
	import asunit.framework.TestSuite;
	import tests.apollo.*;
	import tests.apollo.util.*;
	
	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
			super();

			// TODO: Create a method of adding these automatically
			
			addTest(new EntityTest("shouldHaveRefreshPendingOnCreation"));
			addTest(new EntityTest("shouldRefreshOnAddComponent"));
			addTest(new EntityTest("shouldRefreshOnRemoveComponent"));
			addTest(new EntityTest("shouldRefreshOnRemoveComponentUsingType"));
         
     	    addTest(new EntityManagerTest("shouldCallAddedWhenCreated"));

			addTest(new ObjectBagTest("getBagDimensionsTest"));
			addTest(new ObjectBagTest("addObjectToBagTest"));
			addTest(new ObjectBagTest("addObjectToBagAndResizeTest"));
			addTest(new ObjectBagTest("containsTest"));
			addTest(new ObjectBagTest("getInvalidItemTest"));
			addTest(new ObjectBagTest("removeInvalidItemTest"));
			addTest(new ObjectBagTest("removeValidItemTest"));
			addTest(new ObjectBagTest("clearEmptyBagTest"));
			addTest(new ObjectBagTest("clearBagTest"));
			addTest(new ObjectBagTest("createObjectBagTest"));


			addTest(new ComponentTypeManagerTest("shouldNotCreateComponentTypeForInvalidClassTest"));
			addTest(new ComponentTypeManagerTest("shouldCreateComponentTypeForValidTypeTest"));
			addTest(new ComponentTypeManagerTest("getIdForInvalidTypeTest"));
			addTest(new ComponentTypeManagerTest("getBitForInvalidTypeTest"));
		}
	}
	
}
