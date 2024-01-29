# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Docker Image and Containerization process](#docker-image-and-containerization-process)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Features pending implementation
- **Delivery Date:** A column to track delivery dates for orders. Can be used to gain valuable insights into various metrics, e.g.:
    - Track the number of orders made/shipped vs. delivered.
    - Track the success rate of deliveries per user to identify potential issues with addresses/unwanted customer behaviour.
    - In conjunction with Shipping Date, can be used to track 'time-to-delivery' providing valuable insights into potential issues with delivery service providers/bottlenecks.
    - Track and compare the performance (delivery succes/time-to-delivery) of various delivery service providers, etc.
    
    The feature was implemented successfully in feature branch `feature/add-delivery-date` and is ready to be merged into the production branch when required (provided there are no merge conflicts).

    NOTE: It is recommended that additional functionality implementing solutions mentioned above are done in separate branch(es).
    
    [Screenshot to be added]

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## Docker Image and Containerization process

The app is also available as a Docker image, which will careate the environment and take care of all the isntallations for you.

### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Install and setup

You can either pull the image prepared for you from DockerHub using `docker pull koko660/flask-orders-app` command or build the image yourself. The steps taken to containerize the application are described in detail in [_Containerization process.md_](https://github.com/Koko-66/Web-App-DevOps-Project/blob/main/Containerization%20process.md).

### Usage

#### Container Parameters and Environment Variables

v1.0: none required

## Versioning

Latest image: flask-orders-app:v1.0 

## Contributors 

- [Maya Iuga](https://github.com/maya-a-iuga)
- [Koko-66](https://github.com/koko-66)

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
