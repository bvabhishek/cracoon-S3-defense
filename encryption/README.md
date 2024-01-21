## Defence with Encryption

Note: Please configure your AWS CLI credentials while performing this lab

Using Server Side encryption with Customer provided keys.

Go to encryption dire

Step 1: Create a secrete file called secret.txt

```bash
echo "Welcome to CRACOON 2024, Your secret coupon is HASDJFH324878QWER" > secret.txt
```
Step 2: Lets generate a ecnryption key with AES-128-CBC encryption algorithm with openssl
note openssl is a widely used open-source cryptographic library and toolset

```bash
openssl enc -aes-128-cbc -k secret -P
```
Step 3: lets make the key an environmental variable

```bash
export key=<value of key>
```

```bash
export s3bucket=<value of s3 bucket>
```

Step 4: Lets upload the secret file along with the header encryption key
```bash
aws s3 cp secret.txt s3://$s3bucket/ --sse-c --sse-c-key $key
```

Now, Go to the console and try to access or view the secret file 

Step 5: Try to download the secret file 

```bash
aws s3 cp s3://$s3bucket/secret.txt .
```
It is clear that
* we wont be able to retrive or access those objects which have client side encryption.
* we wont be able to view the encrypted object in AWS Console

Step 6: Lets retrive it with our encryption key

```bash
aws s3 cp s3://$s3bucket/secret.txt . --sse-c --sse-c-key $key
```
Destroy the resources
```bash
terraform destroy -auto-approve
```
