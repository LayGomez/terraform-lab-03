# random_id: genera un sufijo único para el nombre del bucket
# (los nombres de bucket S3 deben ser globalmente únicos)

resource "random_id" "sufijo" {
  byte_length = 4
}

# RECURSO 1: bucket S3
resource "aws_s3_bucket" "app" {
  bucket = "${var.proyecto}-${random_id.sufijo.hex}"

  tags = {
    Name      = "${var.proyecto}-bucket"
    ManagedBy = "Terraform"
  }
}

# RECURSO 2: usuario IAM
resource "aws_iam_user" "app" {
  name = var.nombre_usuario
  tags = { ManagedBy = "Terraform" }
}

# RECURSO 3: política IAM que da acceso al bucket
# Depende de los dos recursos anteriores (referencias cruzadas)
resource "aws_iam_user_policy" "s3_access" {
  name = "${var.nombre_usuario}-s3-policy"
  user = aws_iam_user.app.name # depende del usuario

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["s3:GetObjetct", "s3:PutObject", "s3:ListBucket", "s3:DeleteObjetct"]
      Resource = [
        aws_s3_bucket.app.arn,
        "${aws_s3_bucket.app.arn}/*",
      ]
    }]
  })
}