from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

# Configure SQLite database
basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'products.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Product(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    category = db.Column(db.String(50), nullable=False)
    attributes = db.relationship('Attribute', backref='product', lazy=True)

class Attribute(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    value = db.Column(db.String(100))
    product_id = db.Column(db.Integer, db.ForeignKey('product.id'), nullable=False)

@app.route('/api/products', methods=['GET'])
def get_products():
    products = Product.query.all()
    return jsonify([{
        'id': p.id,
        'name': p.name,
        'category': p.category,
        'attributes': [{
            'id': a.id,
            'name': a.name,
            'value': a.value
        } for a in p.attributes]
    } for p in products])

@app.route('/api/products/<int:product_id>/attributes/<int:attribute_id>', methods=['PUT'])
def update_attribute(product_id, attribute_id):
    attribute = Attribute.query.get_or_404(attribute_id)
    if attribute.product_id != product_id:
        return jsonify({'error': 'Attribute does not belong to the specified product'}), 400
    
    data = request.json
    attribute.value = data.get('value', attribute.value)
    db.session.commit()
    return jsonify({'message': 'Attribute updated successfully'})

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        
        # Add sample data if the database is empty
        if not Product.query.first():
            # Electronics category
            laptop = Product(name='Laptop XYZ', category='Electronics')
            db.session.add(laptop)
            db.session.add(Attribute(name='Brand', value='TechCo', product=laptop))
            db.session.add(Attribute(name='Screen Size', value='15.6 inches', product=laptop))
            db.session.add(Attribute(name='RAM', value='8GB', product=laptop))

            # Clothing category
            shirt = Product(name='Cotton T-Shirt', category='Clothing')
            db.session.add(shirt)
            db.session.add(Attribute(name='Size', value='M', product=shirt))
            db.session.add(Attribute(name='Color', value='Blue', product=shirt))
            db.session.add(Attribute(name='Material', value='100% Cotton', product=shirt))

            # Home Goods category
            pillow = Product(name='Memory Foam Pillow', category='Home Goods')
            db.session.add(pillow)
            db.session.add(Attribute(name='Size', value='Standard', product=pillow))
            db.session.add(Attribute(name='Firmness', value='Medium', product=pillow))
            db.session.add(Attribute(name='Material', value='Memory Foam', product=pillow))

            db.session.commit()

    app.run(debug=True)
