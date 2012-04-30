package tests.apollo
{

    import net.sodaware.apollo.EntitySystem;
    import net.sodaware.apollo.Entity;

    public class MockEntitySystem extends EntitySystem
    {
        
        public var changeCount:int = 0;
        
        public override function change(e:Entity) : void
        {
            this.changeCount++;
        }
        
        public override function checkProcessing() : Boolean
        {
            return true;
        }
        
    }

}