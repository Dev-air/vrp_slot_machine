CREATE TABLE IF NOT EXISTS `vrp_slot_machine` (
  `user_id` int(255) NOT NULL,
  `pills` int(255) NOT NULL,
  `body_armor` int(255) NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=euckr;