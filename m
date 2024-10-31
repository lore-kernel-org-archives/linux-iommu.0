Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E41946C8
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366211; cv=fail; b=YZLYl0M5SFcuWVfNiok6uJNFjBRlVnQsvQujGukpBdugLegYTZNV0zlUDiqVFQfezInS+a9EETL0glW9QdDV/6v2lYW/bKQ0tcaoa+Pm5ElP1YRWCC+RJfvkeK3eNAh5/oTMqOm181+4SFaWmKkGY2NXRfYnR0L+MdxKJT/div4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366211; c=relaxed/simple;
	bh=Vq81mRBYJcs3juIMPOi2BohITasMJmFEoGwurSlLkk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7aofjJ+WsQ1fbx3DZViBEv9Aqr3MsTdP2pLY/e3+cDX/nC+m32V338PabmNXE7Btyi2MV58Ss5YzdeW3vARpJICNc2r/61JRdosPbr765BDGpz/t2TL0Bu4R86kXuTNNlV61ZUvelR/6qz0NfjZVk3q2f9CYHs/uvh/zC050mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sctWvwHZ; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sctWvwHZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE27XytnoEmdbxUorGEHQJ4r7hKuLFD3mdNroHvdFk0gkLQROvJ+O+CGJDHYnB98K8cOasyzgMrK/kzMAWwDcOEQWBIlwFqI3NA4r5U/nRUrDnq4XbUmt1hRP9V/Qha8byhANj4FDAj++OGjuJTUG64HKG07C5VpWP7sCiI1bRekJ09+WVySj67E/2nptFabQL565txzj/VdEcHaZWCukepjhidSg/B8rFEEcheNLSTpl3MPxelWV7fLqQrsTgxYEwiLJUniOi6iUR6pmPlqAsLGDdAnuv4/1w3mW8d9MhcGrlK1ruBWqvOOsqR+z4pBZOv2EbyxCOyt2u6DhH2f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEPp+Qb5jbzvUJp0ewDSsOcaVFtsC7Ozi7jNsnnyDIQ=;
 b=DHryn4kracFydLYVMbbKtsgNcGvd3O3GebtofyyplY6g0WAP2/nrBq1C8s/XLt396ISdtQNc4N7Eb8bhtweqAqjg2OXdNciixfj9hWyenfaR18oayVmjtbYqrpjozjF1oNyKXKiZMBpiUykoax0aNuHVGU1rFDR80PcteDwwVoPgurYvNoaRqAUi0hrb7Hfpmsxo+rJcb4don5a318nVXfB/T01iXPwR0Lqccn/NLxWO3qiDDMq0qg3rl2on+QSVoMv2iwxuE0+GIY2kW6qxH0cbWV9Q2fUC7PIwR7RCRrfSX1Z3CzAmTSIZoD83o8NNS4e2pnFJRf5PNPJCwgqaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEPp+Qb5jbzvUJp0ewDSsOcaVFtsC7Ozi7jNsnnyDIQ=;
 b=sctWvwHZ9LJjeQeYN5wm1Y0qePBwEUvstS+M1AcqKVuUtDyhDYFziZufeLCzP+lZcGM9NYqS6fzJLi5J8I+vRAJC5hI6f2h+pg1QspxtOF6KEJNPQkRh+qlJ49TH8JB0L5LW/E1iILt+MXwJivQZsIZCDqGi+Z/76m9whLAbGwQ=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Thu, 31 Oct 2024 09:16:46 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::5a) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15 via Frontend
 Transport; Thu, 31 Oct 2024 09:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:16:46 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:16:41 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 01/10] iommu/amd: Misc ACPI IVRS debug info clean up
Date: Thu, 31 Oct 2024 09:16:15 +0000
Message-ID: <20241031091624.4895-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f86e4b-b74e-40ca-6914-08dcf98cbe40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wfHkOpqIxSaVTxpvj8JXT4IgAqM3v9zR+O/5rG1m5Z4oYjR6NtXVtlya8T+V?=
 =?us-ascii?Q?Slrhbp8qLxBPQ5sVNqJBjbaVwQuKl8aL5y8UBrDnTWvkCNYcTJo3RR9LsMy2?=
 =?us-ascii?Q?MiC21kLaQfig3ItwjP8foUhXhYvf6lSdCw3AqtkIJkVLlXXYc/R740q7nn2Z?=
 =?us-ascii?Q?DPHgUJR3DKmyHFkxw9Lt6bGPvkyJwGtLlQGzc9cDzpxYvYJIs+mn+Ruc6MmE?=
 =?us-ascii?Q?rdJGb7j3nW8Wt/JIKnmSs2PmO4Di3H3TFavRb6dgjNBepw3J7XgDv9QxCJBG?=
 =?us-ascii?Q?Zyzmmkq3W6KvwLKnF/yonM4V1Dw57O/Wp0oWpDvlEsBU9oI1svJP4ryG8RKa?=
 =?us-ascii?Q?VGeLg/hJYgfLuxaXbqtz0YEpgbTMcuAOy2FrMcT1pWL2eHbtLI+MScMtU4kF?=
 =?us-ascii?Q?ddAxgZezdcc0VSkgYQuK6Qf0V5tJXrltrjXWvuJsf2MLdpai4TxyvfnJ3E0z?=
 =?us-ascii?Q?aM4onfZJCGaOeERcWjmlx7YmNsWOa0at2Hg2Q8Q4y4LN8tTv28Es2tTcjrbA?=
 =?us-ascii?Q?X+m71eH7AlaaIwNOwpDwhf8qesCoJ1xjphohL6/nW3orpNedm9v7+f+X3cAN?=
 =?us-ascii?Q?0Epi2eJk3O5ho4NxyJfPMAdnVQRclZ2Koyki05pHED+qp/V5G5nj4VhQVFpt?=
 =?us-ascii?Q?fhpIUd8J4FgMh6+nBl7dBhxfbj6pGDhKNzjGORDNLFScaOzKLGB9nXg/5dwA?=
 =?us-ascii?Q?mzG0WqfuQGsa27L5pFpvV6mNCzjpoUrNbU5qPWYfL4iY5uqKgd8dwg6a2ujH?=
 =?us-ascii?Q?XVG8GDRlgjlNuU1vsd2shfktc26NRLJONEdA33r3tEM0pT5tw/j4PbdSd7om?=
 =?us-ascii?Q?5oLyQxhWNYnesE+/xPMvAJXr4UFxptF2com3hDEEyur/hQK+ww6K8VpnDIAL?=
 =?us-ascii?Q?SdXnkUrWjUXiww0Qbi8RcdzFqJezjEnv/2EpV9u9uXCGWHsoxnRb/hqpEtkb?=
 =?us-ascii?Q?gJzWePFS2XQeIfhfB0Stsr2jJFzTDKH7LNxMrBL+KWR6mGP9hfh3WEmBoAuU?=
 =?us-ascii?Q?XqpBnlDYb2vBmcxsznyalLLM+tVLzYzr8/iR+j4/VafafIKcf+xitL5mAneQ?=
 =?us-ascii?Q?e9iNfub5NQheATP9pkk6c9N025u0tOmBY0DspOQgYhHyoLkg1ZibIMQU+FZc?=
 =?us-ascii?Q?DrmBrrudCHbuA258dkqO6+xc1f4Qg83N3sUlzxC4BUdYmt1O37+rF5alLjT3?=
 =?us-ascii?Q?NYO+lH85giYdVptEInIAecm6C5b5IODNeG8ZdHRASHwTYvBWnPDvysK8+1p4?=
 =?us-ascii?Q?0D6yYQ4alFzcWFyJBcDJdQtB/y3GeXLUUqjtU2BXY/G6LIYGli0XM9fPKlSj?=
 =?us-ascii?Q?0b6e3qosWQuE1OHhhoPddrn35KknCvUIz9ZyG7m+k4GyshP8afJ1N97pGNY0?=
 =?us-ascii?Q?w4UGbCKR7aY22Bscurq+ew/f96Gjm9FVPYbnUbB8s8axMFUxWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:16:46.0835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f86e4b-b74e-40ca-6914-08dcf98cbe40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

* Remove redundant AMD-Vi prefix.
* Print IVHD device entry settings field using hex value.
* Print root device of IVHD ACPI device entry using hex value.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            | 35 +++++++++++++----------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 601fb4ee6900..dadc65808951 100644
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
index 43131c3a2172..aa9bf81a6ec9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1243,7 +1243,7 @@ static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u32 *devid,
 	entry->cmd_line	= cmd_line;
 	entry->root_devid = (entry->devid & (~0x7));
 
-	pr_info("%s, add hid:%s, uid:%s, rdevid:%d\n",
+	pr_info("%s, add hid:%s, uid:%s, rdevid:%#x\n",
 		entry->cmd_line ? "cmd" : "ivrs",
 		entry->hid, entry->uid, entry->root_devid);
 
@@ -1335,15 +1335,14 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
@@ -1354,8 +1353,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_SELECT_RANGE_START:
 
-			DUMP_printk("  DEV_SELECT_RANGE_START\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x\n",
+			DUMP_printk("  DEV_SELECT_RANGE_START\tdevid: %04x:%02x:%02x.%x flags: %#02x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1368,8 +1366,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS:
 
-			DUMP_printk("  DEV_ALIAS\t\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x devid_to: %02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS\t\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1386,9 +1383,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_ALIAS_RANGE:
 
-			DUMP_printk("  DEV_ALIAS_RANGE\t\t "
-				    "devid: %04x:%02x:%02x.%x flags: %02x "
-				    "devid_to: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_ALIAS_RANGE\t\tdevid: %04x:%02x:%02x.%x flags: %#02x devid_to: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1405,8 +1400,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT:
 
-			DUMP_printk("  DEV_EXT_SELECT\t\t devid: %04x:%02x:%02x.%x "
-				    "flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT\t\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1418,8 +1412,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_EXT_SELECT_RANGE:
 
-			DUMP_printk("  DEV_EXT_SELECT_RANGE\t devid: "
-				    "%04x:%02x:%02x.%x flags: %02x ext: %08x\n",
+			DUMP_printk("  DEV_EXT_SELECT_RANGE\tdevid: %04x:%02x:%02x.%x flags: %#02x ext: %08x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid),
@@ -1432,7 +1425,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 			break;
 		case IVHD_DEV_RANGE_END:
 
-			DUMP_printk("  DEV_RANGE_END\t\t devid: %04x:%02x:%02x.%x\n",
+			DUMP_printk("  DEV_RANGE_END\t\tdevid: %04x:%02x:%02x.%x\n",
 				    seg_id, PCI_BUS_NUM(e->devid),
 				    PCI_SLOT(e->devid),
 				    PCI_FUNC(e->devid));
@@ -1465,11 +1458,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
@@ -1529,11 +1523,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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

