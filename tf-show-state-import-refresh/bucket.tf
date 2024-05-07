resource "aws_s3_bucket" "bckt1" {
  bucket = "tf-bucket1-rdrothbarth"
}

resource "aws_s3_bucket" "bckt2" {
  bucket = "tf-bucket2-rdrothbarth"
}

resource "aws_s3_bucket" "bckt3" {
  bucket = "tf-bucket3-rdrothbarth"
}


#se form preciso mudar o nome de um recurso usar: terraform state mv <"resource"."nome antigo"> <"resource"."nome novo">
#os imports estão na documentação de cada resource
