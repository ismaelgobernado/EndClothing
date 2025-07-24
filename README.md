#  Endclothing test

This repo contains the following targets: 

**ENDClothing** contains main functionality requested 

**ENDClothingtest** contains integration and unit test for Coordinator Models Network and ViewModels

#### Installing 
    Requires Xcode Version 16.2 (16C5032a)
    
#### Dependencies
    dependencies are linked via Package manager:
    [Kingfisher] (https://github.com/onevcat/Kingfisher) 8.5.0

### About the Provided Endpoint

In the current implementation of the Product struct, the id attribute is generated using a static incremental index due to the product data being received. The products from the provided endpoint contain **identical data**, leading to the situation where multiple products have the same attributes except for their id.

This design choice means that the id cannot serve as a reliable identifier for equality checks, as it does not reflect the unique qualities of the products themselves. Instead, we utilize a static incremental index to assign the id, ensuring that each instance of Product has a unique identifier for internal tracking.

To evaluate equality between different Product instances, we rely on the attributes that genuinely differentiate them: name, price, and image. The method isEqualExcludingID is implemented to compare these attributes, allowing for meaningful equality checks that are not influenced by the automatically generated id.

This approach enables us to handle products with identical characteristics effectively while maintaining a unique identifier for each product instance within the application.
