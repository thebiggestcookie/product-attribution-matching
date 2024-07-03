import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [products, setProducts] = useState([]);
  const [selectedProduct, setSelectedProduct] = useState(null);

  useEffect(() => {
    fetchProducts();
  }, []);

  const fetchProducts = async () => {
    try {
      const response = await axios.get(`${process.env.REACT_APP_API_URL}/api/products`);
      setProducts(response.data);
    } catch (error) {
      console.error('Error fetching products:', error);
    }
  };

  const handleProductSelect = (product) => {
    setSelectedProduct(product);
  };

  const handleAttributeUpdate = async (productId, attributeId, newValue) => {
    try {
      await axios.put(`${process.env.REACT_APP_API_URL}/api/products/${productId}/attributes/${attributeId}`, {
        value: newValue
      });
      fetchProducts();
    } catch (error) {
      console.error('Error updating attribute:', error);
    }
  };

  return (
    <div className="App">
      <h1>Product Attribution Matching Tool</h1>
      <div style={{ display: 'flex' }}>
        <div style={{ width: '30%', marginRight: '20px' }}>
          <h2>Products</h2>
          <ul>
            {products.map(product => (
              <li key={product.id} onClick={() => handleProductSelect(product)}>
                {product.name} ({product.category})
              </li>
            ))}
          </ul>
        </div>
        <div style={{ width: '70%' }}>
          <h2>Product Details</h2>
          {selectedProduct ? (
            <div>
              <h3>{selectedProduct.name}</h3>
              <p>Category: {selectedProduct.category}</p>
              <h4>Attributes:</h4>
              <ul>
                {selectedProduct.attributes.map(attr => (
                  <li key={attr.id}>
                    {attr.name}:
                    <input 
                      value={attr.value} 
                      onChange={(e) => handleAttributeUpdate(selectedProduct.id, attr.id, e.target.value)}
                    />
                  </li>
                ))}
              </ul>
            </div>
          ) : (
            <p>Select a product to view details</p>
          )}
        </div>
      </div>
    </div>
  );
}

export default App;

