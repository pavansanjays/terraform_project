# //create s3 bucket
# resource "aws_s3_bucket" "website" {
#   bucket="hr-terraform-state-demo-12345"
#   force_destroy=true                                                                                                                                

#   tags = {
#     Name="Terraform State Bucket"
#   }
# }

# //website config
# resource "aws_s3_bucket_website_configuration" "website" {

#   bucket = aws_s3_bucket.website.id

#   index_document {
#     suffix = "index.html"
#   }
# } // this enables http://bucket.s3-website-region.amazonaws.com

# //access control but this is old, we have to start new i.e bucket policy
# # resource "aws_s3_bucket_acl" "acl" {

# #   bucket = aws_s3_bucket.website.id
# #   acl    = "public-read"
# # }

# # //bukcet polcies used  instead of acl
# # resource "aws_s3_bucket_policy" "website_policy" {

# #   bucket = aws_s3_bucket.website.id

# #   policy = jsonencode({

# #     Version = "2012-10-17"

# #     Statement = [
# #       {
# #         Sid    = "PublicReadGetObject"

# #         Effect = "Allow"

# #         Principal = "*"

# #         Action = [
# #           "s3:GetObject"
# #         ]

# #         Resource = [
# #           "${aws_s3_bucket.website.arn}/*"
# #         ]
# #       }
# #     ]
# #   })
# # }  //it makes bucket as public, but aws wants bucket as private. so make it as comment so it is private now

# //enable versioning 
# resource "aws_s3_bucket_versioning" "versioning" {

#   bucket = aws_s3_bucket.website.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# //ownership

# resource "aws_s3_bucket_ownership_controls" "ownership" {

#   bucket = aws_s3_bucket.website.id

#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# //control public access
# resource "aws_s3_bucket_public_access_block" "block" {

#   bucket = "hr-terraform-state-demo-12345"

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }




