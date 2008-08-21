CREATE TABLE `items` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `location_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `body` text,
  `rawbody` text,
  `published` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `locations` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `title` text,
  `desc` text,
  `lat` varchar(255) default NULL,
  `long` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `zip` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `oauth_remote_access_tokens` (
  `id` int(11) NOT NULL auto_increment,
  `oauth_remote_service_provider_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `token_object` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `oauth_remote_service_providers` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `authenticate_url` varchar(255) default NULL,
  `consumer_key` varchar(255) default NULL,
  `consumer_secret` varchar(255) default NULL,
  `authorize_url` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `location_id` int(11) default NULL,
  `login` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `first_name` varchar(80) default NULL,
  `last_name` varchar(80) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `title` varchar(255) default NULL,
  `desc` text,
  `gravatar` varchar(255) default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20080711172923');

INSERT INTO schema_migrations (version) VALUES ('20080711173000');

INSERT INTO schema_migrations (version) VALUES ('20080712030831');

INSERT INTO schema_migrations (version) VALUES ('20080818185834');

INSERT INTO schema_migrations (version) VALUES ('20080818190423');

INSERT INTO schema_migrations (version) VALUES ('20080819205150');

INSERT INTO schema_migrations (version) VALUES ('20080820193354');