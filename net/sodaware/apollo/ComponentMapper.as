package net.sodaware.apollo
{

    import flash.utils.Dictionary;

    public class ComponentMapper
    {
		
		private var type:ComponentType;
		private var em:EntityManager;
		private var classType:Class;
		
		public function ComponentMapper(classType:Class, em:EntityManager)
		{
			this.em 		= em;
			this.type 		= ComponentTypeManager.getTypeFor(classType);
			this.classType	= classType;
		}
		
		public function get(e:Entity) : Component
		{
			return em.getComponent(e, this.type);
		}
		
    }

}