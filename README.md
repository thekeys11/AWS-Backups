# Descripción del Código
Este código utiliza Terraform para crear un Vault de Backup de AWS, un plan de backup y reglas de backup para recursos específicos en función de las etiquetas.

# Recurso Creado
Este código de Terraform permite crear un Vault de AWS backups con los planes definidos dependiendo el ambiente (Diario, Semanal, Mensual) y los componentes que son necesarios respaldar.(S3, EC2, RDS, EFS)

# main
Este código de Terraform crear uno o dos de los enlaces VPC de API Gateway, uno para una API REST (aws_api_gateway_vpc_link) y otro para una API HTTP (aws_apigatewayv2_vpc_link).

- Resource **aws_backup_vault**
  El número de Vaults de Backup que se crean depende de la longitud de la variable var.backup_vault_name. Además, se especifica una clave de KMS para cifrar los datos de backup y se agrega una etiqueta de rol para facilitar su identificación.

- Resource **aws_backup_plan" "backup-plan**
  Se crean reglas de backup para recursos específicos utilizando las etiquetas. Para cada regla especificada en la variable var.rules, se crea una regla de backup en el Vault de Backup recién creado. Además, se especifica el tiempo de inicio y finalización de las ventanas de backup, la frecuencia de backup y la duración del ciclo de vida.

- Resource **aws_backup_selection**
  crea una selección de backup de recursos específicos que deben ser copiados al Vault de Backup creado anteriormente. La selección se realiza en función de las etiquetas del recurso y se especifica una política de eliminación para los puntos de recuperación de backup.

# Variables
El código utiliza las siguientes variables:

- **backup_vault_name:** variable se utiliza para especificar el nombre o nombres de los almacenes de copias de seguridad de AWS en los que se quieren hacer las copias de seguridad. (EC2, RDS, EFS)
- **key:** variable se utiliza para especificar las claves que se utilizarán para etiquetar (tags) las copias de seguridad de AWS
- **value:** variable se utiliza para especificar los valores que se utilizarán para etiquetar las copias de seguridad de AWS. (true or false)
- **rules:** variable se utiliza para especificar las reglas de copia de seguridad que se quieren aplicar. (Diario, Semanal, Mensual)

# Uso del Modulo

Esto es un ejemplo para un proyecto nuevo que requiere alguno de los dos integradores de API **vpc_link_apirest** y **vpc_link_apihttp**.

- main.tf
```terraform
module "backup" {
  source            = "./modules/backups"
  aws_region        = var.aws_region
  key               = var.key
  value             = var.value
  backup_vault_name = var.backup_vault_name
  rules             = var.rules
  kms_backup        = var.kms_backup
}
```
- variables.tf
```terraform
variable "kms_backup" {
  type = string
}
variable "backup_vault_name" {
  type = list(string)
}
variable "key" {
  type = list(string)
}
variable "value" {
  type = list(string)
}
variable "rules" {}
```

- terraform.tfvars
```terraform
use_selection_tag         = [true, true]
key                       = ["info:backup_RDS", "info:backup_EC2"]
value                     = ["true", "true"]
backup_resource           = []
backup_vault_name         = ["RDS", "EC2"]
backup_plan_name          = ["RDS", "EC2"]
selection_name            = ["backup_resources", "backup_resources"]
backup_selection_role_arn = "arn:aws:iam::726663883567:role/IONIX-AWS-BACKUP-ROLE"
rules = [
  {
  name                     = "diario"
  schedule                 = "cron(00 20 * * ? *)"
  start_window             = 60
  completion_window        = 180
  delete_after             = 8
  enable_continuous_backup = true
  },
  {
    name                     = "semanal"
    schedule                 = "cron(0 12 ? * sat *)"
    start_window             = 60
    completion_window        = 180
    delete_after             = 30
    enable_continuous_backup = false
  },
  {
    name                     = "mensual"
    schedule                 = "cron(0 12 1 * ? *)"
    start_window             = 60
    completion_window        = 180
    delete_after             = 182
    enable_continuous_backup = false
  }
]
```

terraform version - Terraform v1.4.5
Provider AWS -  version = "5.7.0"
