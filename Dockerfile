apiVersion: v1
kind: List
items:
  - kind: Deployment
    apiVersion: apps/v1
    metadata:
      name: fruit-shop
    spec:
      replicas: 1
      selector:
        matchLabels:
          name: fruit-shop
      template:
        metadata:
          labels:
            name: fruit-shop
        spec:
          containers:
            - name: fruit-shop
              image: quay.io/sgahlot/mongo-quickstart:1.1.0-SNAPSHOT
              imagePullPolicy: Always
              ports:
                - containerPort: 8080
                  protocol: TCP
  - kind: Service
    apiVersion: v1
    metadata:
      name: fruit-shop
      labels:
        name: fruit-shop
    spec:
      ports:
        - port: 8080
          protocol: TCP
          targetPort: 8080
      selector:
        name: fruit-shop
  - kind: Route
    apiVersion: route.openshift.io/v1
    metadata:
      name: fruit-shop
      labels:
        name: fruit-shop
    spec:
      port:
        targetPort: 8080
      to:
        kind: Service
        name: fruit-shop
