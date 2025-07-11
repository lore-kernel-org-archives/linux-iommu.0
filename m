Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6831F873B
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266464; cv=fail; b=YBgpvZfWM5SOqAFeauJr4DZtqLBV5aWyH7+nGqNbZ6qACf4WGQL/P/B0RGwf9XgDaS3hecLpY/Bol6EtlwBASLWMHxcuDNHWpvqIdur/R8Mw6UpDI2YQNU1H0JbUrxt52bD/LJDV30ZfMAIPE+yHjeBb+uq/g6vIomSFIY1aiMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266464; c=relaxed/simple;
	bh=9hUZT5962i20Hd2u5bdjmQv2O+dtm0y6ZYI4yaB7Ipw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZonFMLA2douzWyQlAOO30TQ+eXwZtMSbWhkHLIrFsKaoy/wacz+1OAJ3qqTR2KJN+uH2LY94S2bm4gTi9RdlD/KHLRRtoIXY2Kc0rHBCnLbSU+88cFMfBRVWlq5g7SbKPfzFaQ4AZmmai+P+MexV+GSL3qnB4k75vJX61FnQufg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgxEg9Dl; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgxEg9Dl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7/LWwvh+FO+yVLuYiGr76g1OcVnyW1JcMwQp1GTWo+dxSdqtgCJP5hmi0Pl8RoxX2PkZVr1GhNHpxxiWUE1WuEE4Irn4xBl/RS1ihZcSEK+fnZ1vfWwq3TqTXN09AXBTaU++lpd0TWcUTzMvY7PxnLp8ZLaAVwRKx4dU2LkCEZ9oyuK9NY5YzgEoPTypB2/V7uh3TyeC6iwywZY92FC8yn3/oSH6AbGm3VR2as1YNM4xEreK3tTiLNEDteo0Z/2Z6ez9FY0WK7v4D+cDeW4Q9B2+Sscgugb/yTv98a8V+Xd8bRUMb7J8TzhodDZkM/Vnk78illYee4/hvswaCR1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=figFQ8fxg9cXbHIG0cfZPreruTH0LhnZAOnvAX19R1M=;
 b=rOiv6+R57yn9bx8a8MPLrkt4XNZTTmtLh1m86wZdlh2YycIBtOaKFnQ6NxcVUPAh6Hr9gHA7NKQiTHF44+Wt9IWs5c7o9szaY2a10VBO7GVDp54xR0BwQjdSV2rsXMpbR566D8Kuzou4c7IgWS5cB0747c5jBs8o/5/0AYPxLTwgo8ZimAHl/f0CeT55zq/B/bc3vGsE3MKoyLZmD1jtzpOvSuZb+/FLS762DKs5taYaBWAIotus1GV7ND/dcYvTTfib9GVK+Rc7xElC7NLJn/4ceggQLVu6jrKV57YpaEDyhbYoE7sUUUnIvv1t13mjG2z6u6LsWHsFfqrEBPDEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=figFQ8fxg9cXbHIG0cfZPreruTH0LhnZAOnvAX19R1M=;
 b=PgxEg9DllxhG3c+oDMq0SqbQVZrcWuVomMZRxR7MC6u4d5D1QIftmWVYgAYWJ4cJgTReb6zNDqPQIcgxVFNo6OTa0vOeSjcZsaAKp8Bs1pS1L7jcxzuIRFxC2OjmvF4jnI6QWnxdJxsR8I18nwOmpc0hTret3otxO02RhN6pHI3af0nBB/n1UvZl3xfGAE/x3NJePzNKf7yEzsOkU1DrkLmjSj0HwXJHWygStSpHby0XOoBvPov/QhHtaKKGzQmsLCv1qekxPTVRa5Mw9fNF+mBTPgwwmVlAmRFdFQG+PjUhsfzzuvrwFGYqooDcTtexddaQod54qEivny8Abb+aDw==
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 20:40:54 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::2d) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Fri,
 11 Jul 2025 20:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 20:40:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 13:40:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Jul 2025 13:40:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 13:40:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc v2] iommu/arm-smmu-v3: Revert vmaster in the error path
Date: Fri, 11 Jul 2025 13:40:20 -0700
Message-ID: <20250711204020.1677884-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b206e98-ee5f-4861-1717-08ddc0bb3b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YPZkHDndP+silLWCJAHeKRNLgeA0ts3ocW08jIsZhWa7Wkl0CoUCu+WSymG?=
 =?us-ascii?Q?K06RA/zfL2aTbkxoo405qFl5SIKNrhtBqE5BTdvWdjkuRam0Q9qSNk+4dizA?=
 =?us-ascii?Q?2L96a5L+99dmYABl/IGpaMQ4Q6RAQG6byD7Z6YISmqKua8iqSViFrhlnDpUr?=
 =?us-ascii?Q?/M8z9KX/vw0XH/w7i6Z3Xh0VfdQqT5vXJu6VmMWdWoqwZP02uFYNI8ysaNFN?=
 =?us-ascii?Q?iQGgRr7e6Dipdc+MhdvrwG7VSc6R8fs4InoBSqWZXomqufpQMnWDYJvL2GH3?=
 =?us-ascii?Q?HBCztV/ETV84kei68lfEXocUrZmGvl36GlOCgBGhzLPhW8ebWc/coRvoMQ0b?=
 =?us-ascii?Q?JAmj3Xm7yCn1PcmLk8hi0RHZDNqKpBxqqMO9A+F9wKMUuxeTLtmzEZf3Qwr1?=
 =?us-ascii?Q?VHWJXzUvZwOMW7vYHwPliA6B76mzgLxsYwcM1T8hjiwZg4bObqt5+mw8hstl?=
 =?us-ascii?Q?p/+04XfmCB/bE6PgBmfQXB63FanewINO+zUvm/na/MPaKsBtXLH9aAhsUL6z?=
 =?us-ascii?Q?yYHZY6aP5VNVbLL96Z0ujDZrmSBIdniOgH7Zhs+WGyMg0lsmzNECAZ8aTyBh?=
 =?us-ascii?Q?QiCr5Ut8JDv5y26D2c39D1I7uRVUg3W7w4xbXAfd0tbL6H9JEw7SaXkWeDvW?=
 =?us-ascii?Q?S9ArrYWNVoa86gVkE8LUZJIgsqkKzM6/RF3RGpq9DpFFf9FWsipxiZ1QAB9N?=
 =?us-ascii?Q?pcRuKpymRw6SKxl3FwlgDMi8RxlIl6Tg+tQF2H/eQZH9q2+7Gwa121pmkTM+?=
 =?us-ascii?Q?FneEhRhEs9nEnjF/2nw/o7KykC3Agi7+6cQ0N59Cea7OLLWAd9t/CfEv4pmG?=
 =?us-ascii?Q?ThyLPY+hP5UsngSbR0xcfEKgxgjCbn2IZEEXR09pQF9utnBIr9+9P+rMgOZR?=
 =?us-ascii?Q?UPzP4vW2YF0f8asLTDvtl8eFKbz/G3sDPDJOzkBFkfuJvU7Q6nwm4pZI42Wr?=
 =?us-ascii?Q?IXpOZA4v5LGNT/w3oD4QbRdjbDUfSCEytRorrynIgD0dkn8rbhd+fYdaVSpr?=
 =?us-ascii?Q?TN5RKvQQY5HetAkurh9Zra+w6ivRW3WO33e7vDjS/dfGcxjrWY/eQV3Apg8i?=
 =?us-ascii?Q?3/ldh+DMIcn3WsmNUnZxV9+8mTnmi9BIn5aKjQZa5Z6YdRaJOv7qiRjEnBzY?=
 =?us-ascii?Q?B71o48GiNDI8xHMIT8EHVCcP3lOAJh5dMt7vstFeVGFCDPNCkzyT/NYQym4j?=
 =?us-ascii?Q?p2ozMjKgT1AgkbT2xj+uQLI5iaTeRhxfqE6imMtMbl82jaTqggiTtzclptIk?=
 =?us-ascii?Q?0Jnj5YB8XT2Vr8EYD6pV6bm9lc/l/YrU1CADqY2AwALm5lqNvsP6f7AimXeN?=
 =?us-ascii?Q?Na5QuIuXlvEXonhFdQzcmqbgnGUKrRI4rZE7baxyG/MVrW6YV5dGzbJZwDGV?=
 =?us-ascii?Q?yKBZ4i7010Y3ODG0jMyMIYdqTfY2i4ZLuphdHw/Dd9Jm6A/DgCeeAjcLnewF?=
 =?us-ascii?Q?yKd8gGSvkV/Zk5P+vfevxRrQjoM9//pcdJRXpkCC1QPRV5KkgrjXYuxbFjRU?=
 =?us-ascii?Q?iluhGBNqXOkptj+XUtHxaRuxqVsSbHvwG/k2QAtBTL//pSQn2CsNJ5fFig?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 20:40:54.1914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b206e98-ee5f-4861-1717-08ddc0bb3b5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

The error path for err_free_master_domain leaks the vmaster. Move all
the kfrees for vmaster into the goto error section.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v2:
 * Simplify commit message
 * Add "Reviewed-by" from Jason and Pranjal
v1:
 https://lore.kernel.org/all/20250710233003.1662029-1-nicolinc@nvidia.com/

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 181d07bc1a9d..3c79cdbbd9e7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2906,8 +2906,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
 		if (!master_domain) {
-			kfree(state->vmaster);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_free_vmaster;
 		}
 		master_domain->domain = new_domain;
 		master_domain->master = master;
@@ -2941,7 +2941,6 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		    !arm_smmu_master_canwbs(master)) {
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
-			kfree(state->vmaster);
 			ret = -EINVAL;
 			goto err_iopf;
 		}
@@ -2967,6 +2966,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	arm_smmu_disable_iopf(master, master_domain);
 err_free_master_domain:
 	kfree(master_domain);
+err_free_vmaster:
+	kfree(state->vmaster);
 	return ret;
 }
 
-- 
2.43.0

