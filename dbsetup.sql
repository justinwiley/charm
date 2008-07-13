create database charm_development;

create database charm_test;

create database charm_production;

grant all on charm_development.* to "charmer"@"localhost" identified by "charmer08";

grant all on charm_test.* to "charmer"@"localhost" identified by "charmer08";

grant all on charm_production.* to "charmer"@"localhost" identified by "charmer08";