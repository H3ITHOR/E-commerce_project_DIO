# criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

#drop database ecommerce;
# Criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Adress varchar(30),
        constraint unique_cpf_client unique (CPF)
);

desc clients;


create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10),
        classification_kids bool default false,
        category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis')not null,
        avaliação float default 0,
        size varchar(10),
        productValue int
);

desc product;


create table payments(
		idPayment int auto_increment primary key,
        idPayClient int,
        typePaymentProduct int,
        limitAvailable float,
        constraint fk_payments_product foreign key (typePaymentProduct) references product(idProduct),
        constraint fk_payments_client foreign key (idPayClient) references clients(idClient)
);

desc payments;


create table orders(
		idOrder INT auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Cancelado', 'Confirmado','Em processamento') default 'Em processamento',
        orderDescription VARCHAR(255),
        sendValue float
        default 10,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

desc orders;


create table ProductStorage(
		idProdStorage INT auto_increment primary key,
        storageLocation VARCHAR(255),
        quantity int
        default 0
);


create table supplier(
		idSupplier int auto_increment primary key,
		SocialName varchar(255) not null,
		CNPJ char(15) not null,
		contact char(11) not null,
        constraint unique_supplier unique(CNPJ)
);

desc supplier;


create table seller(
		idSeller int auto_increment primary key,
        socialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15) not null,
        CPF char(11),
        location varchar(255),
        contact char(11) not null,
        constraint unique_CNPJ_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

desc seller;


create table productSeller(
		seller_idPseller int,
        product_idProduct int,
        prodQuantity int default 1,
        primary key (seller_idPseller, product_idProduct),
        constraint fk_product_seller foreign key (seller_idPseller) references seller(idSeller),
        constraint fk_product_product foreign key (product_idProduct) references product(idProduct)
        
);

desc productSeller;


create table productOrder(
		product_idOProduct int,
        order_idPorder int,
        prodOrderQuantity int default 1,
        prodStatus enum('Disponível', 'Sem estoque') default 'Disponível',
        primary key(product_idOProduct, order_idPorder),
        constraint fk_product_order foreign key (order_idPorder) references orders(idOrder),
        constraint fk_Oproduct_product foreign key (product_idOProduct) references product(idProduct)
);

desc productOrder;


create table productHasStorage(
		product_idSProduct int,
        storage_idPstorage int,
        primary key(product_idSProduct, storage_idPstorage),
        constraint fk_product_Storage foreign key (storage_idPstorage) references ProductStorage(idProdStorage),
        constraint fk_Sproduct_product foreign key (product_idSProduct) references product(idProduct)
);

desc productHasStorage;


create table productSupplier(
		product_idSuProduct int,
        supplier_idPsupplier int,
        primary key (product_idSuProduct, supplier_idPsupplier),
        constraint fk_product_Supplier foreign key (supplier_idPsupplier) references supplier(idSupplier),
        constraint fk_Suproduct_product foreign key (product_idSuProduct) references product(idProduct)
);

desc productSupplier;