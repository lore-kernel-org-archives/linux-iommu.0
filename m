Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC81C9DFE
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478213; cv=fail; b=Uyu+Z+6Ih6WKCgdcDQugxl3m8k7k1PO0orn93LugdfiuoDLTwu87nOnCxPNMc51VPzprH8ec9VnIYABqQ8MhCd4m9lMJn3ueEUAbBfi70uSwQgorDuBfNRx1dK/5EPpcDzuQ4e56vski1uDxcpEgnz1BKFMUAny4OLvvh7X2tnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478213; c=relaxed/simple;
	bh=I6EQiYw8K0f5jXKss9BxucItbForiWMKXniF8tpRkio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2DgaFgIycWjyUPh83TlHAecW+VqXEuVjFADPgqJ5tXyWqcd+oWSr89LA4trX3O2KAjqwh/iFdZKkhq6urJtQ5CegPU75TxBIUTF/0bi6jnJfhOmGNDWjPmnlofchwhbNFPt4WH+yqiPGVtGV3IDL9URgue/Zaw/77/JeeYaSg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pL5g7+G/; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pL5g7+G/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9CQbDOlR9vQkDc48mPzm7XyGHd10WJRkH8/I/M+AdYbFJ58FJik++LUGKBcV49vod1CH05WaxMy9F1OoSbFFHmGn2ONRuA8Pzp2TxMFGYjioo9kr9y/9IRJHNuTt6Z7VaFbqG1nm49xcUz/J3uZSCiXxbWcvaCagUg5SjTSZAuNKPt+obaDxhcZBkyuCRJOE/SMd2b96PwXe8dlmbNmLFNZtVhf9Zo0j77KFd9ig0I4xvbodSsJF/Qz/K90itP5R6PBYz1VWgowcqW+c0aje3oI8x6a6ECTfhS+sH4UjlMBS+k7u/M2nBoVocQjEA2UdtR5KHe4mUCQilydEZxM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=FrDso9ClcoqFGBxe20ZijbIvSToShbeHMUzFrhUdXEPOUsWQJ1+HvsDxO/IQNf5XXq/+qZ3MEqkCVa1jysvdhPw7naRL8AUQdX7Fa2v1v8Wt1rzHdjeEQCvXwNWX6A8da7hAx0CWcuaHOalNuZ/wgj3OVGvUBeVMgBPso0P2cdg4xglaUuWIAhQrYp/cnYL3rpZAzO6Yt17JWklGFx4n3akHbsGzoqJ6/qIkifywFgD5fKmj1SJClBgoQmdxVlwF/zjDnR1stDj77CWMUfjnM9bI+LFqgyot0dW4PjtZJ4kaKxF5EVt3J676x+pCa7MVB6fKWQ0cOaKMjFIzrJSBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgjJpIWUMULCYTGTfsX2DraU/FvbxstiAT4/BZSQ7n8=;
 b=pL5g7+G/cY1mWdyK2EImVO4SzpbsTKf47cOUYru6WmG9DjC3a9iy6IWxtzk6h6JJpCa9MOmUYjo47x0+3C4vTg3YdSdZhJ7I7esb+SbVC22g/Mm8Dc0utQZZi4QPUBFCb9th0nVvlFpd+JBAAaviSQ6OZhuwQx7JVmOYEAQsQss=
Received: from SA1P222CA0054.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::29)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Fri, 1 Nov
 2024 16:23:26 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::56) by SA1P222CA0054.outlook.office365.com
 (2603:10b6:806:2d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:26 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:22 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 01/10] iommu/amd: Misc ACPI IVRS debug info clean up
Date: Fri, 1 Nov 2024 16:22:55 +0000
Message-ID: <20241101162304.4688-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: e190283b-100b-4431-df41-08dcfa918375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NDA4cyHbtglpAquYQMohnmcetrUjG1yN9/BRkkZ/8KDvTkJRMMHfaSpVekhx?=
 =?us-ascii?Q?kgiLcljgr2l4ohHfg0CARRSwik0sybPv120zERmYZ/93yj8X5co09bB0xBIo?=
 =?us-ascii?Q?B3R13p0Wk72QBG/3HTqkKavgHQucnzncLVwBb6tqzBeWAXlsCG4/E+PT5N1B?=
 =?us-ascii?Q?0dtHUb8g0vB5vP21JEXPcFBRxIC+3b+u5QXXBfbZhD7jg/GC68c5XYZ8CmBe?=
 =?us-ascii?Q?6xsidB+3xJnyeeauQ2pJzQaPkNdfRykcTbn/99URBlhRkLCLqng2CNa//rDA?=
 =?us-ascii?Q?kusDrLvAmNkqaoPoOuK5/6dm/RBpIGW6eXotzUshxa/TS76osbS3q39wBDnU?=
 =?us-ascii?Q?EEXAZKLJK+2sxXhMxAg12ltO9K6fYi6jG5StOcFbtWjFHBL4C6i5NBX0Ptac?=
 =?us-ascii?Q?TAZGKhGlITaceCudEdH51WeNqGCQ7nBJBUVUXX9kjnCFI1Uq6C2mNXGDQ9dl?=
 =?us-ascii?Q?tyd6+CpXYWzNrYN9RxfDIZqr4DrZvxClYE4DJ8rHrM9+iE8vG5SdNks8M67A?=
 =?us-ascii?Q?GfR3OqAa5D7RrkBCHm8MY9MBfkF2mPtrih/LQaKmnaHjCwH27jt9mMsA/XRS?=
 =?us-ascii?Q?wRnEqv6VNRFDvNoN+dFmf9VdTHLBK1d+hiEMdVmezhseykzKJul6R9Au84r0?=
 =?us-ascii?Q?QFGaehtfeqXti9eIMvfu94lu70zbQYREnXDkkdd2BMhNmPaBkj3UqolzZP5t?=
 =?us-ascii?Q?1aghZx25du4GaVBOS5rBGFyTDF9XT/Ilwg1dz9YK03oLYbWDdKKsoQC4Qy04?=
 =?us-ascii?Q?jZedd9AWGwTSApEXZ9L0fqSlRB1JX/AqWd1gi7Gl3eY2GH9OfR03V2l5e8EB?=
 =?us-ascii?Q?1XTs807GCJy8cfI3FAqi+Q60FORLOXjeLCSdFyt32i8/FvFMF4FP1jx1I2J0?=
 =?us-ascii?Q?Av8nyY/E0UUd9cd8ybCR+egD3t9WQ7UUqfI3OBh6ZfuPaz3gUTjx5luNvnMD?=
 =?us-ascii?Q?s/eSaeuv+T00WPSuGG2GRtDoPaaIk/Z0sAWNfypRyMI6Ug1RP3N//lERveaE?=
 =?us-ascii?Q?Fq8XXDXSjFFI6GJcjCe+Z/4+AXIQpCHiYvIJbSbFRXu8e1w9uOXjCC+cPsNx?=
 =?us-ascii?Q?GmVPhdmUSx78EUt7bxRK1Ki8AvlNY+0jfT9cZBwXrol3IH0aZvsWZmkv+BwD?=
 =?us-ascii?Q?JN4ZF33mlKaU1wZs5isR5eToSZSVDhYJ9cJ80R1AO4fR9oImozSFn/G+qPYw?=
 =?us-ascii?Q?t9kY/tGxDWqCFRBQ+j66uYTkCeiQ86SOa9ocGepCzGwMw+kMnPTEgeyYv5ev?=
 =?us-ascii?Q?qAl50PlVNRvfJxGPU842ZCqTDGnlliu+6LdxC651M8jFBwC6fPOjTUFHHjTO?=
 =?us-ascii?Q?BpQDpOehlVPFb5Elpz5TExWNiLQydvUlkNyp4BOigVdWBtt2WPFrkZ4O6Rmd?=
 =?us-ascii?Q?sARJb5pnVAFEUP8fyjroJ9yXLqmNFpf/tVVpRb66bDmZojuzig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:26.1728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e190283b-100b-4431-df41-08dcfa918375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864

* Remove redundant AMD-Vi prefix.
* Print IVHD device entry settings field using hex value.
* Print root device of IVHD ACPI device entry using hex value.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 35 +++++++++++++----------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fdb0357e0bb9..af87b1d094c1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -468,7 +468,7 @@ extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
 	do {							\
 		if (amd_iommu_dump)				\
-			pr_info("AMD-Vi: " format, ## arg);	\
+			pr_info(format, ## arg);	\
 	} while(0);
 
 /* global flag if IOMMUs cache non-present entries */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0e0a531042ac..3a7b2b0472fa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1239,7 +1239,7 @@ static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u32 *devid,
 	entry->cmd_line	= cmd_line;
 	entry->root_devid = (entry->devid & (~0x7));
 
-	pr_info("%s, add hid:%s, uid:%s, rdevid:%d\n",
+	pr_info("%s, add hid:%s, uid:%s, rdevid:%#x\n",
 		entry->cmd_line ? "cmd" : "ivrs",
 		entry->hid, entry->uid, entry->root_devid);
 
@@ -1331,15 +1331,14 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		switch (e->type) {
 		case IVHD_DEV_ALL:
 
-			DUMP_printk("  DEV_ALL\t\t\tflags: %02x\n", e->flags);
+			DUMP_printk("  DEV_ALL\t\t\tsetting: %#02x\n", e->flags);
 
 			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
 				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
-			DUMP_printk("  DEV_SELECT\t\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x\n",
+			DUMP_printk("  DEV_SELECT\t\t\tdevid: %04x:%02x:%02x.%x flags: %#02x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1350,8 +1349,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_SELECT_RANGE_START:
 
-			DUMP_printk("  DEV_SELECT_RANGE_START\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x\n",
+			DUMP_printk("  DEV_SELECT_RANGE_START\tdevid: %04x:%02x:%02x.%x flags: %#02x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1364,8 +1362,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS:
 
-			DUMP_printk("  DEV_ALIAS\t\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x devid_to: %02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS\t\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1382,9 +1379,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS_RANGE:
 
-			DUMP_printk("  DEV_ALIAS_RANGE\t\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x "
-				    "devid_to: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS_RANGE\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1401,8 +1396,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT:
 
-			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT\t\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1414,8 +1408,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT_RANGE:
 
-			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
-				    "%04x:%02x:%02x.%x flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT_RANGE\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1428,7 +1421,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_RANGE_END:
 
-			DUMP_printk("  DEV_RANGE_END\t\t devid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_RANGE_END\t\tdevid: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
@@ -1461,11 +1454,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			else
 				var = "UNKNOWN";
 
-			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_SPECIAL(%s[%d])\t\tdevid: %04x:%02x:%02x.%x, flags: %#02x\n",
 				    var, (int)handle,
 				    seg_id, PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
-				    PCI_FUNC(devid));
+				    PCI_FUNC(devid),
+				    e->flags);
 
 			ret = add_special_device(type, handle, &devid, false);
 			if (ret)
@@ -1525,11 +1519,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			}
 
 			devid = PCI_SEG_DEVID_TO_SBDF(seg_id, e->devid);
-			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %04x:%02x:%02x.%x, flags: %#02x\n",
 				    hid, uid, seg_id,
 				    PCI_BUS_NUM(devid),
 				    PCI_SLOT(devid),
-				    PCI_FUNC(devid));
+				    PCI_FUNC(devid),
+				    e->flags);
 
 			flags = e->flags;
 
-- 
2.34.1

