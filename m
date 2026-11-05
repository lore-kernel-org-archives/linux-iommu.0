Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852599;
	b=K6iIc+OZR67XLyWyG/1sSSO0b4g/kJH+M9WAhX60v8AJADJxL180TyvKj6D/fc0cFCSV
	 /nzYsTKlgSUgsNvoQ49UOx9CNnGm5YWLRgMD1IOtA2At0CTPFrAWvEwJPpZ479cTQLbWF
	 hHqBU8TJE/fHlsvhCql6zvKM2kD4OJe0935JIaKMKJoeeaX6Y5bhuq7XDRndb/oOUt9L1
	 sQugEarS6T1PQAra9V5aGjV/LRBAxgFr14VehsTda218bLkXP87WDCayTDv67xaexRAcq
	 aUQmGKDHInZBkqsBdfN/Ww4RmTTn7kyB4UuGdtLrV1DaR2bl4N0+8wQzI7SR28QEAgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852599;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+d52GBAtD+gX1Ig9UA4VB7oofyNbGsMLTidxHaLANks=;
	b=sOMC6Y5uFglSn1THiWIM5mcdUidyz/88GAINAw6ITen8492ea6o/5TQATdbmkUkZYhFf
	 rIip7zdrhTXVfl5Ot6wiEIU+vWeJGMMgtNy4iKJ+u38bYCBQrXKhFqBrdyPK0mvj1xsEd
	 4JAwNytOxQrtqHyoU4B8LgY3h4/1KLdFpMtigi8aiBmCP9oqfJOaX90STZP0mATCiySE8
	 yOd4VVn3QhDCQZpbB1ugrvt91IQutXYF14F0M12fRjZ6hr7huPoTKlWdI6oW9NcBZ30BQ
	 uC/CAr++a2+7BEhiE0DA62htKXD7Dg5HC0pkLl7UVYcVc+kBpavhzPb5qhc4OqYb5NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lRYf5MLZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.46
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7C606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F7C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lRYf5MLZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLSc0baWp//AM/2LEfG6bs3V85e8declUjig02N8UVGRJwITTILT7UN/sS86QrkFkReAguruoDe9HZH6S08cKumOFsKIKU8NaBSjuwcpaM/8GmfUg+7W7NdzQr1RMeTi/ys/As9rAsUvfCvR0MDtxnwEY0fajSovKw4FaY+Hbt/J0IhOVVhCpZJl/zWNhQcqFvU69W0o9pljsMlk808ogNIVowZeYt5k9dSUswmwX6yu/g2zePfV8ElR2Oe26ys6f7rNodU3O9zx6YaO56EkxJcbwD1L5SSvxxO6tlJrh79kuWH2Ry/6GL2w1ss3dkNjEQKdTAkYZLFpQKWknQbnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d52GBAtD+gX1Ig9UA4VB7oofyNbGsMLTidxHaLANks=;
 b=rjyYOfqQJ3pbZtwQj/+C5uHE+rKm3XnzDE0LJc+QBY+d2+sPKwK7HqzckKsxMQqIOFAgFFrgutgzpEm7+w/VV+J0toNiZQ6LWxCVuw/JMy8MLOZ5Yj/SbJBfNlnj3ezr28VVeyHyBNyiLudG3h8iyORur92mymn9fA/jcP5ykFk6XFdg4jB1vx3o7/DGB8UjJYm8vnDfWGEd2Xiu5WPJHF7SM0g0lc0xpgxLH82yjMOm8Ejx1Zz5iTNlzu/BvlvGAFZ0C/7Jr8q8x7CjjfEOIQGWuDOCVdxNZUYVF+0XOZGp61/dkBsPdJphMSSwXKSE1rrcasosrUHF7nS+h7+3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d52GBAtD+gX1Ig9UA4VB7oofyNbGsMLTidxHaLANks=;
 b=lRYf5MLZFZfskWVswxsc/I8qeORaCKLtsY8bTfY8jdO7p5JtITLD5PdB8ghYN4RrW5/xqPbzQ2ta7lr6wSF2+OdJrtTtK54L+uUaZHqPui51NoIeyT5GiDlLSMrfMa/GOw3syyULGGWu3F8rUasYqV4lKSrJ5XysUOLNCq8k6Uk=
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:23:14 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::d) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:23:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 04:23:14 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:23:11 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/7] iommu/amd: Improve updates, GCR3 teardown, and completions
Date: Thu, 5 Nov 2026 04:22:47 +0000
Message-ID: <20261105042254.399163-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3877f853-652a-45bd-5b81-08df3af4824e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|10067099003|3023799007|13003099007|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	pXI4xCsSt1qHorM3+eOlWHbNAsiTOLx7yOp2aq9fKIN8YNiHSJ4aUZkbNJPC7fwR+CIEFlxB7a98esLdNDJos4spMobEmixj/+RnXB5Rl6oKjkv1aHdP3L4JgOVZKodDCa5bm2ek4e9XtKF26FU33lTxlWdF+NqYdVcVZM3DKNg8q7FV5iiSpFVHYVgVP8vfH3KaSe9eUpX0QHKheX4TijHyxgIqezxYl7Syyy1gufi8v/nENjaw5hBYwGMah03T1/RMaKZyTZpboiXteVlGaE6qxUtxworXFSXeeazIy6e0gcNBuDk/0FI4SR2ap0pMgA7enbobw8Tw/Dr3b2HXidUGVeRzRQQcVe1ImUwH5rq3QcdyCnAeeSDBHiGpb3m44Fw6xn8pTuweDmByYZVfoB+MrxPmKq0GjaljH6nrFORUuCFrHdXth03SNlUcBMIGc6Dsh+hRM0iehATJ1XJzsYFKElkFhRZYdCRXhm97ij+ODaGRphmq1OgICyQ5kXLEHYyNiltU2T5Fp/4OBr3Zz8m5ehW6+67qh8VbTghwHjMHH2IMiyvKzaR0KeuicO0xAkGL/7C0aLZilVSEJCLLBcyKswNSI1fyqGR7riYc8lw23Tkp4vaRZweEo0gFBfmMkLqd+fswokWGJ5BEPnN+wMVyM3xvQ1nK+/J/Py6NpmgkD0/uYwRe0M7TVEJhTaIZixgNKPyXfQXNCpagJ3dy6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(3023799007)(13003099007)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GbaaWCf1hgKvx9HTw8FRHKi9JW7lUAi0C6mh2OHKtXhFbJz2HNUtAmF1boczYcnpzSg6/qwCeZnnyAZoRQMJnxKQ03CSuH92C9pkChrbu6TOOH9ULA2oh3XJmd23JwwJidO8OZSkm07yN9uFLXpRG4w5vno4XwdFZfzzcCJ21QKo5Ba6tXmB9BYYknIRHKeNMbNoJC100nwCUm0AKI5fzfzEhhEDGntE9QIqreXbCgjPyItEOxor8ipys3pb/IQOj4WSwxAvNQIFZ8G7naTw7v+0Lj2rQPaDI1XhskspdYkTJFUiVhUqbyicYZMyvY+DUge+/g1DS4mT6jUu4ej07BCWMeLfXsqYGzuDUWyL95ixWIXzql/f9/UnVU7kQY2b00I8hjO1fIudIAhvWYvqrZzzBh2K5RjR33fazYozYBAHlZuwEIDfJB1UuKGqjIDf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:23:14.1800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3877f853-652a-45bd-5b81-08df3af4824e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956

Various enhancement to command completion handling, fix page accounting
issue, remove redundant dte flush, etc.

- attach_device() publishes a device on dev_list under the domain lock,
  then writes the DTE after dropping it. change_top() and dirty tracking
  walk that list under the same lock, so the new DTE can store a stale
  page-table root or drop the HDAT bit. detach_device() clears the DTE
  before taking the lock, and a concurrent walk can make the entry valid
  again. Hold the domain lock across both the list update and the DTE
  write. defer_attach and use_vapic are updated only after attach
  succeeds. change_top() no longer repeats the alias clone and DTE flush
  that set_dte_entry() already performs.

- GCR3 intermediate pages were allocated with get_zeroed_page() and
  freed with iommu_free_pages(), so the IOMMU page counters drift on
  teardown. Allocate them with iommu_alloc_pages_node_sz() on the
  IOMMU node. A clear does not allocate a missing intermediate table,
  and a two-level table frees its level-1 pages as well as the leaves.

- iommu_flush_irt_and_complete() reserved a completion-wait sequence
  before the invalidate commands were queued, and dropped it if queueing
  failed. Reserve the sequence only after those commands are queued.

Full series including other cleanup is available at :
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v1

Vasant Hegde (7):
  iommu/amd: Drop redundant flushes when the page table top changes
  iommu/amd: Fix page-counter drift in multi-level GCR3 table teardown
  iommu/amd: Do not allocate GCR3 tables when clearing a PASID
  iommu/amd: Allocate the completion sequence after queueing commands
  iommu/amd: Free the level-1 tables of a two-level GCR3 table
  iommu/amd: Update device attach state only after a successful attach
  iommu/amd: Write the DTE under the domain lock on attach and detach

 drivers/iommu/amd/iommu.c | 97 ++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

-- 
2.31.1

