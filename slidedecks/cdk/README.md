---
marp: true
theme: default
paginate: true
footer: 'lg7983@gmail.com'
header: 'CKD - The good the bad and the ugly'
---

![bg right ](https://ih1.redbubble.net/image.1084494606.3667/fmp,x_small,gloss,wall_texture,product,750x1000.jpg)

# CDK - The GOOD The BAD and The Ugly

---

![bg left:40% 70%](img/laurent.png)

# About me

❤ Cloud

❤ Kubernetes

❤ DevOps

❤ Coaching

---

# Problem Statement

<!--
Lien avec les SRE qui doivent gérer de l'infrastructure avec du code
-->
SRE needs to :

- Manage infrastructures at scale (CDK)
- Manage applications configuration at scale ([CDKTF](https://www.terraform.io/cdktf) | [CDK8S](https://cdk8s.io/))
- Provide clients with services to deploy and maintain applications into the cloud

MUTUALIZE THOSE EFFORTS => LIBRARY CREATION

---
<!-- ![bg right 80%](https://bamfstyle.com/wp-content/uploads/2020/05/manwithnoname-main1.jpg) -->
![bg right 80%](img/the_good.jpg)
# The GOOD

---

![bg left 100%](img/aws-cdk.jpg)
# Features

- Programmatically manage AWS Cloud
- Use usual programming languages
- Polyglot libraries thanks to [JSSI](https://github.com/aws/jsii)
- Use standard language libraries as part of CDK projects

---

# Software Delivery Life Cycle

- Enable developers to manage their infrastructure with their preferred language
- Organize code with software architecture patterns
- Test code as any other code
- Review code as any other code
- Package code with application one

---

# One language to rule them all 1/2

![auto](img/pipelines.drawio.png)

---

# One language to rule them all 2/2

![auto](img/single-pipeline.drawio.png)

---

![bg right 80%](img/the_bad.jpg)
# The BAD

---

# An imperative vs declarative approach

- A **declarative approaches focus on the final state (what)** such as "I want a red car". It does not matter how this red car will be created.
- A **imperative approaches focus on the steps to reach a state (how)** such as "to create a red car you will have to perform those thousands steps to finally paint the car in red.

---

# Development best practices

| [Twelve factors app](https://12factor.net/config) | [AWS CDK Best Practices](https://docs.aws.amazon.com/cdk/v2/guide/best-practices.html) |
|--------------------|------------------------|
|Apps sometimes store config as constants in the code. This is a violation of twelve-factor, which requires strict separation of config from code. Config varies substantially across deploys, code does not.|In traditional AWS CloudFormation scenarios, your goal is to produce a single artifact that is parameterized so that it can be deployed to various target environments after applying configuration values specific to those environments. In the CDK, you can, and should, build that configuration right into your source code|

---

# Immutability, Idempotency, Predictability

- **Immutability**: recreate resources following specifications rather than modify resources in place.
- **Idempotency**: get the same result independently on how many time a code run
- **Predictability**: ensure the test results in an environment n is equal to the ones in an environment n-1

By the default those properties are guaranty by the underlying layers in a declarative approach, whereas its is up to the developer to ensure it in an imperative one.

---

![bg right 80%](img/the_ugly.jpg)

# The UGLY

---

![bg left 90%](img/ms-archi.drawio.png)

# Sample architecture

- Api GateWay
- Service mesh
- Compute
- Network
- Security
- Registry
- ...
  
---

# Pitfalls

- The imperative approach allows a huge flexibility in interconnecting systems. Good software architecture skills are required to keep the code maintainable.
- Avoid as much as possible to hardcode variables into lower levels, it drastically decreases the flexibility, at the end the code can't be easily deployed in a new environment.
- Keep the asset lifecycle steps separated (**separation of concerns**) to avoid a big monolith approach and keep flexibility

---

# Links

- <https://github.com/aws-samples/aws-cdk-examples>