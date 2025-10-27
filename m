Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8053328EA
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591305; cv=fail; b=EEOdih2Ip9ecPfYCwv6mfxsqwuOU6zMDNwvQfQb3LdMjiadMqYtZF3Cn3T8yrJw0Zmab2FNPW6pJf+NIMwBc5Q80bkJRfNVnGKgK6+c4DdyBf5jmquCqvbs9NwWRDZhveTEDBtHFGdgH4rPYYvh5E5rABzkf/yV1SyXx2hYBR7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591305; c=relaxed/simple;
	bh=i58xcaWKB2wrVnav1tch52hOZy9Lywni+Dwz4FBAWdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X59TbPxOScr03Dh9U4YuPCs6IGM2jya7jaUjtGG6OHrBHX8x0BkmXL5RvNKWdBsD/696/dGvSfY9Qc1C/AwcuJpNOVxAs00vfw/y7YHKCbkhiz4DLYhVVchvc7n6PdvigUu8Q28vjgd+n5ZKlqzfO26kgHIwIATtVEi6uxi1+/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZwQdZKpL; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZwQdZKpL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHuEwx+rudl6R3a3qnxvIXilQyM4U8Uw6YqctApKdpJryymx7PyzlEnpV6EDTg0VzrAtoI2dm4ZvO8liv7cWgdWVjZMPyOqXNxzZHNz9ZWbFDZCJAS1RC2iOthnUHGir1ie4gbQWgWZmuscdG3y1rTCjpqufiyyf7s1/2UW53h1Xb6LHAUKcnOU8dW1aeh8WWWlviUZXUUsCT8WmKNAbKde0JwBGrlvyQTscqc7vNWtzUx9LKxoufGIQZnWKLKzc2Py5Lnei4CzSROvldhkWN8FKOWryKio824/kLFVmN3aICjM7GWn9ACTeb7v9PMZELHkzdzWrK9DuULHen53K4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WASe06KkuNN/sCscGBbp1oXfZMXSmKx1r1HIiA+pfhw=;
 b=e9QnffOEvFNAWzDETNpR0wVCWE3145/xuKXtAw5HYpJw01jC8jywkwICIo2toyjuJxajzSB0Artzt9nrsRl2Sd8ZOd0EgFIMm1PnRgE5+qIlyZSbjIV9UZq8cgriMFurqfYbZTai84K/53NKok4rVk6c6DcJcdNkO+z9XPKlslbV6FFG+vC+S+KngAhBZZo6ufUzbWTWfnqmR351Lw+9/uyywNl95O8WM78sLbLC0JDOQlHkpbQQUaxOugicX0fhekOd1f8FzSdOC0VX6sC6gGo2QLXbbq/Bk3JfX7rbOqDlcPanQ/TFJjT80eNCsbr1ODYfUHdiWtG5NfJ5bkQt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WASe06KkuNN/sCscGBbp1oXfZMXSmKx1r1HIiA+pfhw=;
 b=ZwQdZKpL8xisXNSXZFP6VlQb7hILokgtLqhu7NtwmWk+aEjGnPYJ6le1gMCSu+RJ24kzSkO+hNlhIvEwAtixB3sVg9nJWYiX8xHAVHdZqxVBT97En/b3t3n7+91Qq4leMlKfAHeGQe0kBhNlkgt70tD19APwqRSmvcDKbwzy4eOVs0fpyu8QWxqB28nzoi7CPlqovD1aOE/lL75BYmjBs7j3v7gxjY9zNzT/7wOy7PCPBYDUfgDqU5NUwOAOshMHs79k3G1xzi9ovVUA039G6DeZs+FrUGl9M4Plb4iCjlSsoR2wTNfvz8Hw1+GvVDdSST42wjYOYUIIQMH9DY/d2Q==
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 18:55:00 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::81) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 18:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:54:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 11:54:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 11:54:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 11:54:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Mon, 27 Oct 2025 11:54:18 -0700
Message-ID: <e9b9d4730f275926423635e74abd7d9c07b51276.1761590851.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761590851.git.nicolinc@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 3955622f-cefb-4ebf-2310-08de158a548a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Z+w2wa/3oQCZAe3Cqjz804bSk0p444ZOtQ8iYS4jLeF8XeZxcWON73Jgvft?=
 =?us-ascii?Q?87Lo43w/L5NDoZBjWbDEwaFE8sFSJs+WRJXlWfs+QUIhfTRZioT6PAey7VQ6?=
 =?us-ascii?Q?qmMRFVJ4b/f570UqrJPz2euB5nzISS+nuazF5u7r8tkRwxu12KJnZAvduS0q?=
 =?us-ascii?Q?n68J6RTo6hzMPYfoOxlp/CimQHE173opBp/EhZ3WYowj07ujWzwone43nM7l?=
 =?us-ascii?Q?oA0MuTGgF3cX28TXttcUbfAd92rUs5g/5Q6o6V5n0PjQTS2vsGF+gLmLuCCF?=
 =?us-ascii?Q?udUhVF1cYarhMnFMLxOFKqSpB7AsvyzHS9dRkF6cxJI2ZmKXk9tWBF2RMzah?=
 =?us-ascii?Q?nbN0hEOMp9h9J42hOA6ORXWrebxRPb4fYjTaNoKRdXQFcG5dmoayC6ZXFKp9?=
 =?us-ascii?Q?I9N9EbE+u2TQjCJbZ5ybegiZENCWODcQEFO8tuhhONhnocuh2a8X/7u5s6fg?=
 =?us-ascii?Q?51d/Tbv6uPDu0p+gZEFMqjVxePOZ/d51BnBxNPqBuRE5duBMkxCdTMETJTuG?=
 =?us-ascii?Q?KiEvurkAq9FgnJl9GQVwx6h6mQZXbXcVlde0D62dFdm7iYqjvRguFg33COgK?=
 =?us-ascii?Q?cMuhI9xwbjNq1Dy7/GiDfWDtS+KJ7oBSr2WO/MyGLVy/b6WwngWtRsuVL/J1?=
 =?us-ascii?Q?Xo2Uy8Jfq/4FrRg3oWvuPw+dsmciqu+eI1HSgxj8qMeiWWWkHmhlk0DIirDk?=
 =?us-ascii?Q?5GEoX5kgJMy1vV5mN//E82QeqA07kRBfSD1STPAjusXYbSkTAThmnh3mBGDb?=
 =?us-ascii?Q?FNVo07TFpibIH3Mr5Xbj/uy3xp+FSqSgAJgfm6ocUoPkt7xxiitzoahwtMSd?=
 =?us-ascii?Q?/KSM9k30Kw+tEJ8tbF3cgNUG+W0zwO2HHrwQp+lfSWFyB7skQlQQGlFG9VrI?=
 =?us-ascii?Q?u9JGgRf5JIGfY6UgVFNjkODlU856Sxtfv0OCtNilXpXjZrb602eSONk1048n?=
 =?us-ascii?Q?iyyZiH3jbFly5V8l+nQYO4DBWvak+ts1MpOW43X9nOjkf8AUm3prVRSYXnlA?=
 =?us-ascii?Q?KIYvkTJ4qQFdSuraPWvk8pKOsMcEBkqYUyH8E8zA1W6zWJGeNzFKoJTIR8D7?=
 =?us-ascii?Q?qlI3eCMOJPQcEygE6Zu8Vlep9QWLtSr8P3/lyy6PqIBxzqZzkczfSmMUjeVS?=
 =?us-ascii?Q?9S0TwpVrVNYxkiIwH4T5XoodgV0tf6kBFZ4GvSl7tRS1o3GXkBNb9L2IKmhJ?=
 =?us-ascii?Q?OJztwFPYFz7MstZ17vboW1XVigFwal+MvubDuMEHYgWNok4G7NNzpsU6Bci5?=
 =?us-ascii?Q?E1zzhnDc98c6R/KStmL5Sc5IxcykPqYyNH0XjeMi0cdei/tX8YmXG+mePCRY?=
 =?us-ascii?Q?HNk7XUWNzCKS3leu9YZ0O6SjFLl/2bBaBweLdYrx807a02KsflvFik7SgnAS?=
 =?us-ascii?Q?mlL9gCGxVK/bHplBHP/2inqKJgyMzjNsxfQ8sSHKqyI/+6cKKtU7TJH/4b1v?=
 =?us-ascii?Q?QPFmPbJspS47G3OrQagJnmRxQ/zAVWMAn3UReyqAqEROKstnPUhahc7uzJ+E?=
 =?us-ascii?Q?+6CGIQqREMUCxA3YDCNFIs5oJe9IuQFVOvCuT92UxpadHb+U4UteLDZJ8G7e?=
 =?us-ascii?Q?Z3Z5JcBMlphj0qzYQPo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:54:59.9399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3955622f-cefb-4ebf-2310-08de158a548a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 43df0ae89d96f..b8a4bda12b571 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -922,6 +922,14 @@ struct arm_smmu_master {
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
index cc266b47810b0..f01c2a6b40cd5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3686,12 +3686,22 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_ids_cmp(const void *_l, const void *_r)
+{
+	const typeof_member(struct iommu_fwspec, ids[0]) *l = _l;
+	const typeof_member(struct iommu_fwspec, ids[0]) *r = _r;
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
@@ -3699,6 +3709,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	master->num_streams = fwspec->num_ids;
 
+	if (!ats_supported) {
+		/* Base case has 1 ASID entry or maximum 2 VMID entries */
+		master->build_invs = arm_smmu_invs_alloc(2);
+	} else {
+		/* Put the ids into order for sorted to_merge/to_unref arrays */
+		sort_nonatomic(fwspec->ids, fwspec->num_ids,
+			       sizeof(fwspec->ids[0]), arm_smmu_ids_cmp, NULL);
+		/* ATS case adds num_ids of entries, on top of the base case */
+		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
+	}
+	if (IS_ERR(master->build_invs)) {
+		kfree(master->streams);
+		return PTR_ERR(master->build_invs);
+	}
+
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
@@ -3736,6 +3761,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -3757,6 +3783,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
+	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-- 
2.43.0

