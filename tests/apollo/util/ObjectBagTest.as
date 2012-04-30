package tests.apollo.util
{
	
	import asunit.framework.TestCase;	
	import net.sodaware.apollo.util.ObjectBag;

	public class ObjectBagTest extends TestCase
	{

		public function ObjectBagTest(testMethod:String)
		{
  	    	super(testMethod);
  	  	}
		
			
		// ------------------------------------------------------------
		// -- Retrieving Bag Info
		// ------------------------------------------------------------
	
		public function getBagDimensionsTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			
			assertEquals(1, bag.getCapacity()); //, "->getCapacity() does not return correct size");
			assertEquals(0, bag.getSize()); //, "->getCapacity() returns correct result");
			assertTrue(bag.isEmpty()) ; //, "->isEmpty() returns correct result");
		}
		
			
		// ------------------------------------------------------------
		// -- Adding bag objects
		// ------------------------------------------------------------
	
		public function addObjectToBagTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			var e:Object = new Object();
			
			assertEquals(0, bag.getSize()); //, "ObjectBag::create() returns an empty bag");
			bag.add(e);
			assertEquals(1, bag.getSize()); //, "->add updates size of bag");
			assertEquals(e, bag.get(0)); //, "->get returns correct item");
		}
		
		public function addObjectToBagAndResizeTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			var e:Object = new Object();
		
			assertEquals(0, bag.getSize()); //, "ObjectBag::create() returns an empty bag");
			bag.add(e);
			assertEquals(1, bag.getSize()); //, "->add updates size of bag");
			assertEquals(e, bag.get(0)); //, "->get returns correct item");
			bag.add(e);
			assertEquals(2, bag.getSize()); //, "->add updates size of bag");
			assertEquals(2, bag.getCapacity()); //, "->add updates size of bag");
		}
	
	
		// ------------------------------------------------------------
		// -- Retrieving Bag Objects
		// ------------------------------------------------------------
	
		public function containsTest() : void
		{
			var bag:ObjectBag =  new ObjectBag(1);
			var test:Object = new Object();
			var test2:Object = new Object();
			
			bag.add(test);
		
			// Check item was added
			assertEquals(1, bag.getCapacity()); //, "->getCapacity() returns correct size");
			assertEquals(1, bag.getSize()); //, "->getCapacity() returns correct result");
			assertFalse(bag.isEmpty()); //, "->isEmpty() returns correct result");
		
			// Check item can be found
			assertTrue(bag.contains(test)); //, "->contains finds item that is present");
			assertFalse(bag.contains(test2)); //, "->contains does not find item that is not present");
		
		}
	
		public function getInvalidItemTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			
			assertNull(bag.get(-1));
			assertNull(bag.get(0));
			assertNull(bag.get(1));
			assertNull(bag.get(2));
		}
	
	
		// ------------------------------------------------------------
		// -- Removing bag objects
		// ------------------------------------------------------------

		public function removeInvalidItemTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			
			assertNull(bag.remove(-1))
			assertNull(bag.remove(0))
			assertNull(bag.remove(1))
			assertNull(bag.remove(2))
		}
	
		public function removeValidItemTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			bag.add(new Object());
			bag.add(new Object());

			assertEquals(2, bag.getSize())
		
			assertNotNull(bag.remove(1))
			assertEquals(1, bag.getSize())
		
			assertNull(bag.get(2))
			assertNull(bag.get(1))
		
			var obj:Object = new Object();
			bag.add(obj)
			assertEquals(2, bag.getSize())
		
			bag.removeObject(obj)
			assertEquals(1, bag.getSize())
		
			assertNull(bag.get(2))
			assertNull(bag.get(1))
		
		}

		public function clearEmptyBagTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			assertEquals(0, bag.getSize())
			bag.clear()
			assertEquals(0, bag.getSize())
		}
	
		public function clearBagTest() : void
		{
			var bag:ObjectBag = new ObjectBag(1);
			bag.add(new Object)
			assertEquals(1, bag.getSize())
			bag.clear()
			assertEquals(0, bag.getSize())
		}
		
				
		// ------------------------------------------------------------
		// -- Creation tests
		// ------------------------------------------------------------
	
		public function createObjectBagTest() : void
		{
			var bag:ObjectBag = new ObjectBag(12)
			assertEquals(12, bag.getCapacity()); //, "ObjectBag::create() returns bag with correct capacity")
		}

	}
}
