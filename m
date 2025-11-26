Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1842F5302
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119470; cv=fail; b=WbL3OM6Jf1KXKrHk9xg1ZzT3jwTMCXtdg2CF8xFYw0P4xI0OLXH/xrPpbYmTdBFtInP9BilBRx+lO5x9eUBwa0LzzrfP2t+SS+mus31tsCykahY5PQycpsKTQ5vAklVdf3saGdzTo9tFjLxvoFMzoFJyiMBLGu+gmrFzSpkUAgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119470; c=relaxed/simple;
	bh=SifUX95XoiQQzD/kDWMNM10gJQyOaKAdroV+/O6p8a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hurS2NFkPa5CuenWurXwOYJ53oH+LobLMuLFF4riK11GogCDP4jDqxCtcQ2hWGdyD3JYcuseYo7x9LhxfVV4Zf575hxoWXxJ6lTF4cWkKJnRsfvS/W/ItLZKJ1VgJAPPgB6mFPSRys1kgT8loip3ehA7mNnngoIiI8mynKflNAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=naCcWFln; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="naCcWFln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/xZ0LJXxsApyvzwbsnpcR6urpB3vHjG/DoLztFc8XKcvVVvtacgYzmljdErRhZU99y3cajrdagbRl9hLlBLPyUixv3NTEXY6a5ASR2T0JkH9ULmy6dZYJFhsJ7fEuEOEAbEv88cPe0I6QfI7NP+Zn/JqYO+eLkqjiItxFKWJDV2v5F0X1JmGePt5Wp409ods7aERMSZh6eg8ogJkzknkyicdqLD7E8FUknA1X/GWbfyiR4+BSm2s3mBjHP2+ZnxUfcs3WA+lE1H2jiMzVqNgwcIQDJEdAihkt2YfKDFhH7obadyb7us7nY88lJvUJ/+5qLf8/pzB04IPOtszXML3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTyglggHnM7R4czbRlwlHjByTv4VfR4ZiiD7B+F603Y=;
 b=IPGJIO4sXxuo002WTCGQ5AmbV3NXhX1r121fmgCm6eHDvrSKfkop1TN87B+vX8tzoL4U0BSUyGsYqz2r8m7EgoUpx5tTTbT3LP2rQtoXjFgDB4VrKiOLIrqczOSSjqP694TeWsAQc7mwCGwGHH7XhmJHaW4H+geJz+oN/poFkUjHiwoXil8W/DhOgElOvgjTNduIEjW4TNl5OIHGO+tSloUBFdCu891VISX3xDEaQXD/HwE3pEvP1XVjKIWjKqgeaXb9n0Sgk33tP2W63LfHzFV5zLg5daaUqQm3rJrzxtWEs+UopdJ/BkA14zRkVvp6TQnqprDJxvlOZ1E9skbFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTyglggHnM7R4czbRlwlHjByTv4VfR4ZiiD7B+F603Y=;
 b=naCcWFlns2YV1rLSkzNIMQmsjgSWcgn6JfU68PLVedF8uZqRL5WSFxwql31dOSWAoPV5TymXoJYvrbkLa/Z6Uwj18P5YPKPI3yzOzlhmj5Cf8/hxLsUipdngZX+6jxrbpTF6Udh7nZktdH6X2vEf6o2h/iNL9l5BJtPURr3mKIQFB6SBq5ZcdzeJEnJMw/GQ8YPM3xqC+8q6c02pI16C+qjQGf5CZ+lRadvKZRka/59b0X4j8adPGsu1kgE6Rl1uHD4rQG73cOMsKHF9XISCVGeHKTWTFBgSEeKq40GC9Hy6rIBHZz7NXLurwtB8eDUjaTdCTsHGuqNiNea7/cdNUg==
Received: from DS7PR03CA0337.namprd03.prod.outlook.com (2603:10b6:8:55::25) by
 MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Wed, 26 Nov 2025 01:11:02 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::cc) by DS7PR03CA0337.outlook.office365.com
 (2603:10b6:8:55::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Wed,
 26 Nov 2025 01:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 01:11:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:41 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 17:10:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Tue, 25 Nov 2025 17:10:09 -0800
Message-ID: <da24bfca47fec6886915c1707ca58eccf3cd4116.1764119291.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764119291.git.nicolinc@nvidia.com>
References: <cover.1764119291.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 766cce6b-9fe6-48f2-bcdd-08de2c88aa48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C0dGwRoYh5sjSp/cR3SunbXv6OiTyiPBQtqhrQtFrMJu+Uim+tx4nSf0n1ef?=
 =?us-ascii?Q?w0sD8u1HFRjK3cddCMuj6Dpw91ilnE4bV1459iIocG/5fcvvF6qkiJykoY9X?=
 =?us-ascii?Q?gXryfL20gXbhxqLBOimnVjI859r4Wq536oh3+INTRZaLcL94o8wqwEQeoWJR?=
 =?us-ascii?Q?5Kj7gAHVgbqPzU+b0i8GaIj2t8Fu3IQPs/1S2h7akP05x1yNkj5SybKaUeaZ?=
 =?us-ascii?Q?ctOxBiRmT9XUn09L+Xk0pilvORlYvJvES+0+aLgllpHcl6NwRkRZqOA1IkTE?=
 =?us-ascii?Q?lbKoqYG2I+mnzYUq8jHKTiw2dvtvf+8lK4XB11fJs9SJDV3Yitz1LWI39n5G?=
 =?us-ascii?Q?l1pkMLTcJ0CA1ur33zO2RoEs+KaysEUmbcVn1YNqSx7hCl0FpZUmtODlv5PH?=
 =?us-ascii?Q?UUY3CcoxY4BU7Hx6IdsORW7OvPeLT9BQ7CG9hgviQ7/yVMUP2c5Q4fv4MbGx?=
 =?us-ascii?Q?qwzNb2or8CjzAY/NlRPINSZa/5gHCv3iJ0Gu2aSZ+W5KUDdsEKFfELGdLSV8?=
 =?us-ascii?Q?wklDE9ItjlRqKZcRnzRiboA6BbGBGRFsljBf0jNKeuNNX/PHJzpOWJ4aA+nU?=
 =?us-ascii?Q?cCtv09Z1K3RVAISTYr9vtNnCOozj6L0ETmDpFSiQ2ti76IrESYKzADOh3pTS?=
 =?us-ascii?Q?tbHDO8UYVQKG8TSuzYyZeYtkw4qmApTCpD7K3YZrcMqEVIM1/DLQoT/qqb35?=
 =?us-ascii?Q?yzQ0JkxS/K7PZw2GSke29Ll4vpqGteAOBjOgYDDMV6m3Ix4wvQV22VadUQ96?=
 =?us-ascii?Q?HmrvsxkOCEL0SEZG0MmLlK9dGPQeHVwLMydDd0tSct+FuOScxOc/r5JNXedF?=
 =?us-ascii?Q?3RbzQtk+sxXI+ZUUjeo3DMr/vp1auLXgiPcx3rKuZ/4TwrZnxBZuFhi3gIcn?=
 =?us-ascii?Q?xQJbswdnRA0KmiaY9GixPNz9UsmZKx5OsZQ5hrkB3HAla4nh2RQB97N7iRiu?=
 =?us-ascii?Q?DXF56cpQbpSuXSBxOOom86YU/6s+tzgyCoPvq4E+xqOXKXOtP4+fie0UspsQ?=
 =?us-ascii?Q?3j/c1UmmbFDYmWoTyO840gR7y83HfIZ81K09iQ7jEPgm6hWyHAu8wOc1N/cc?=
 =?us-ascii?Q?4N/sItRg4CIESX7SHGWUe0BNodRTlNI8cJKlyDYLM+p7hfKCBUj0Sr6aahTb?=
 =?us-ascii?Q?Yt07sTMI6Nt0lTAFlhXnhxcWzlJxJ23AlQET0z2ytnP+4lOUerp0pfvbKH/e?=
 =?us-ascii?Q?zbb+4WvEJdzanULTJx9Mm7Tv1scIGpDmrk4WNkQnxByYnKkcgb0JtIxtA3xr?=
 =?us-ascii?Q?/ME8H10qSB57PEZHi+EXW+UtduzM2WSnoWZOkfKVpdylgNv3RqyBKRK8lsQ2?=
 =?us-ascii?Q?iVWDsni6nyD00izOIOZil+R+jKTq0AXQ9b8src6dMM8kDc5HZA2tLT9IvJTX?=
 =?us-ascii?Q?H0bIgcj5CctwMm/cmuOlLhTYpPmKY6pDfWsDs1kECAbNu/xl089c8jOlGCyk?=
 =?us-ascii?Q?iHx7JCwEBWT+gJ2Clf4PJAbLxyw+YzNNGOoxnpiioItyHeLKoiNPMNJ5plxX?=
 =?us-ascii?Q?701dQxqgtGMD7WC/WgKm36UKsCmv0ghMIYGbc+W70qzRGjCmPvDzABZF+jeJ?=
 =?us-ascii?Q?QWqv489u5Z9RyZGot/s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:11:01.5676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766cce6b-9fe6-48f2-bcdd-08de2c88aa48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

When a master is attached from an old domain to a new domain, it needs to
build an invalidation array to delete and add the array entries from/onto
the invalidation arrays of those two domains, passed via the to_merge and
to_unref arguments into arm_smmu_invs_merge/unref() respectively.

Since the master->num_streams might differ across masters, a memory would
have to be allocated when building an to_merge/to_unref array which might
fail with -ENOMEM.

On the other hand, an attachment to arm_smmu_blocked_domain must not fail
so it's the best to avoid any memory allocation in that path.

Pre-allocate a fixed size invalidation array for every master. This array
will be used as a scratch to fill dynamically when building a to_merge or
to_unref invs array. Sort fwspec->ids in an ascending order to fit to the
arm_smmu_invs_merge() function.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c6fb84fc9201..922a599ce0f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -929,6 +929,14 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	/*
+	 * Scratch memory for a to_merge or to_unref array to build a per-domain
+	 * invalidation array. It'll be pre-allocated with enough enries for all
+	 * possible build scenarios. It can be used by only one caller at a time
+	 * until the arm_smmu_invs_merge/unref() finishes. Must be locked by the
+	 * iommu_group mutex.
+	 */
+	struct arm_smmu_invs		*build_invs;
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f6bca44c78bf..81b5e28a5868 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3707,12 +3707,22 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
+{
+	const typeof_member(struct arm_smmu_stream, id) *l = _l;
+	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+
+	return cmp_int(*l, *r);
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
 	int i;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	bool ats_supported = dev_is_pci(master->dev) &&
+			     pci_ats_supported(to_pci_dev(master->dev));
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
 				  GFP_KERNEL);
@@ -3720,14 +3730,35 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	master->num_streams = fwspec->num_ids;
 
-	mutex_lock(&smmu->streams_mutex);
+	if (!ats_supported) {
+		/* Base case has 1 ASID entry or maximum 2 VMID entries */
+		master->build_invs = arm_smmu_invs_alloc(2);
+	} else {
+		/* ATS case adds num_ids of entries, on top of the base case */
+		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
+	}
+	if (!master->build_invs) {
+		kfree(master->streams);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
-		struct rb_node *existing;
-		u32 sid = fwspec->ids[i];
 
-		new_stream->id = sid;
+		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+	}
+
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort_nonatomic(master->streams, master->num_streams,
+		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+		       NULL);
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
+		u32 sid = new_stream->id;
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
@@ -3757,6 +3788,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -3778,6 +3810,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
+	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-- 
2.43.0

