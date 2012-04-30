package net.sodaware.apollo
{
    
    /**
     * The ComponentType is used to enable fast lookups between Component class
     * and entities they are attached to. Uses bit masks for speed. See the
     * ComponentTypeManager class for more.
     */
    public class ComponentType
    {
        
        /**
         * @var Next available ComponentType bit.
         */
        private static var nextBit:Number = 1;

        /**
         * @var Next available ComponentType id.
         */
        private static var nextId:int = 0;
        
        /**
         * @var Bit for this component type.
         */
        private var bit:Number;
        
        /**
         * @var ID of this component type.
         */
        private var id:int;
        
        
        // ----------------------------------------------------------------------
        // -- Public Getters
        // ----------------------------------------------------------------------
        
        /**
         * Get the bit for this ComponentType (e.g. 1, 2, 4, 8 etc).
         */
        public function getBit() : Number
        {
            return this.bit;
        }
        
        /**
         * Get the ID of this component type.
         */
        public function getId() : int
        {
            return this.id;
        }
                
        
        // ----------------------------------------------------------------------
        // -- Internal Helpers
        // ----------------------------------------------------------------------
        
        /**
         * Initialize the ComponentType and set its bit and ID.
         */
        private function init() : void
        {
            this.bit = ComponentType.nextBit;
            ComponentType.nextBit = ComponentType.nextBit << 1;
            this.id = ComponentType.nextId++;
        }
        
        
        // ----------------------------------------------------------------------
        // -- Construction
        // ----------------------------------------------------------------------
        
        public function ComponentType()
        {
            this.init();
        }
        
    }

}