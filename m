Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86DD528
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279577; cv=fail; b=E7jR2k68frs/ItbXPHNamw8p1aY6t/i5wdpGxwalgvH9GkqI8fAjyGJQxM2DgtFepvmvrdiDGjjBIGsqH+Ko5enEVfGthQfIaP+u3LH07YX74yRZLLWtqJkhyQSrkzea7bflcWPBuPgqU1BqooWqWKOVYFk35d6d53OPj4gEXf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279577; c=relaxed/simple;
	bh=P0FaahO4TgSWVcHhcX5y56KwXVt2AIJaX/+vgIXa7jM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC4b4+ZnPNrTPF9wzC25E/1VI3iCqNyHlod/pJC/LPAvzMPeTyXBwL7U9UGwtaFgxeBCQrBmpIKZ7nmhWTijJ+j265CiLvvjUtE7G4qboLvL42iHxKljOjoFBCU4230/S7d3xJNrFkbxKVuKMHBZQgRV0SiUBU7/1eQRQ6cLLHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vNqBfX46; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vNqBfX46"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwJQXUS2mFRspG2nFTYBgOiXYZjAbKjZzmR6DzeDHcaSr9DpDCttUkIv0Xw6v4YtGl2YJ07Qz5eq2YJhajIfcuLeTvPkdeYviRwX8h9YThR4XCm59tQz4ugnsnAJN35EwpddDsiqfO9cnY3js1J3msSPmpJmd7ysCgeF5lQ7Ui0nGEAGgdzRL5E78j4VInZmA/qLW5NIdrm3r7fbhKVXXQC4BBGCPAfO0Xp9qJ7+jSHbb/CTgIxIzUG2TX4wT3Ux/NhN5LZom2kBxKtuBQ8k8IiPe0jLoDx3c4rxsB4VvTOYxrmwLnSwV9aeoTiydEsBRWEhyKfrNqtbJm5hoSadAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77NQELUNPnXWCbMyHqOObi+wkKdUX42wtZPlmI638D0=;
 b=w3h0Rx0fDZpJ360DzYOHKEzG+BgCKPNk5cBbsel9izq9cv4E8+dveek8wLPCfbq0KTmK1GRftPDrb3r2F3RTSFOmudv5aJd+Qu0JmYHHVpOSP4vjOrRdNnTW6aKPY/fUqM1F85h6sYmSr7K06rUB/dZnk6VFZpEZQ8c0AJGPpqykSVq6v4RNRT8T6EqjtoVdhir6675Ni+siRHrLZOYQM9xV//mCMAJ4e4GQkeq3qD6xQxBXY0aLiHqxHSvIopAUFl8soSubCiXtRqIIROH3MeQ0X4177okz+VMgHebVv6nhf5vxH2vBZQKCC3zPxpyCYkS7gX4CMLenQfZQp4NAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77NQELUNPnXWCbMyHqOObi+wkKdUX42wtZPlmI638D0=;
 b=vNqBfX4694udpHv+ORxx/ZX98GTzPcIA+UAEXhfTaACNsevnqQPyZMLaSvxfk8EmccJUUelCC5aW97BMZjGhJVpgBxrLAGC4vo0NE87sYNt13YE4ESvChnUVPK7OaPJJwougZgX8hN8bMdnXRidji3x7Q0pAkL17WfYIa8yCNe0=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:32:49 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::e6) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 06:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 06:32:48 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 01:32:45 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH v2 4/4] iommu/amd: Enable support for up to 2K interrupts per function
Date: Tue, 18 Mar 2025 12:01:23 +0530
Message-ID: <20250318063123.2556-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318063123.2556-1-sarunkod@amd.com>
References: <20250318063123.2556-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c372a79-05ea-431b-c5f0-08dd65e6b382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cuWBP/4R9q63AiygvmT+27n3c1FYB+7XjXzudmfmWbSP1OueGX+85uyoxl+P?=
 =?us-ascii?Q?u1emfn3tVeDBO/OzjWU76QjLwiK5nLP2Yzxr4RSu4rhEEEt3ct6VMx8uWkOa?=
 =?us-ascii?Q?aFYOg7JGupvKEAhpKFx1M86oKmCnN5VgnQOUPc4F/eCNJf6htE9kk9qYxBt/?=
 =?us-ascii?Q?6dQYXXLb7Skx4S1xzH9cxmbdJlHP+UHpXK1TjuoDyq78wA5FrdXH59tMnFFZ?=
 =?us-ascii?Q?GtDjK087LLin19PMAJW2JXzGlvZOY9NPMI22td4zqzg6xn2hOOK1t2UW8rcC?=
 =?us-ascii?Q?/qRmSRc6ZAY6gWVU6WvpSefNFGimXMQL9p0MWhTOi9Oh4ZJMXSvlzYsJ8/b6?=
 =?us-ascii?Q?6zVct0wc4IVq+eDA9UrjYqYw2lxsMGYF5DuzqAIwOHIRFJENL1CR3UE5os6u?=
 =?us-ascii?Q?KcKhnCQX+Izujhj0gljX/hl4j7QoDdlNiZ5nl89aXfxVhmhhii0DrfAL86Re?=
 =?us-ascii?Q?Jb0Zs/sMgj1Ds9EBZDj1ckiBk7I7OWDfu8kMuoKeuXHWmIpoY8ZxtIbNG0xM?=
 =?us-ascii?Q?TcT6xzw5Foc033xCTy5TQ7vMyeqvhalhtxVxuAXESBBHASiKkpkSMwny5WIW?=
 =?us-ascii?Q?uPkTdfMXv0U7zL6V3rdtwYmqNdLHOkkJFfwzo7u/FV1baltzzlWEnTczIdig?=
 =?us-ascii?Q?R6AXLOJtLABqw5ytBzExqqcEK+/tEFLg5xbNhqRqsx6Y7DEyfvC+FiYvb4na?=
 =?us-ascii?Q?PbRUJvbyeGNv/y6XZlYusS6WTPRcu8G5U+e2V24lGGMiOCRyV57nMkE/FM2+?=
 =?us-ascii?Q?S/jj8vO7giFldsGLv8OD7FGNcHGQiuTnxBYPMUt4YBAcScT1G+hbfJ5rAHAh?=
 =?us-ascii?Q?pUHvU4Z+OqVCDVNNDqJYXguh2WSOhgcwgp1TiABsZ0/SIvO5a7SqaGskuoHA?=
 =?us-ascii?Q?sfgEgs1zE2rDgZx7Ujy9sUFqBWlnBH5Nhy5BSmDd2bz/AjpjzzAHXEdIG65X?=
 =?us-ascii?Q?UFOK0MVTp71BxM2FPAPMGsuyBAy983XpPomN+QOpienSm3Fn5ms6dIVQMKHN?=
 =?us-ascii?Q?gnx+5ly5PIdpJdCB3mYuC9RrYOpLpGe9sNgUt3VoE5deaZwGADLa9Sgyah2k?=
 =?us-ascii?Q?N24lb3zBcBc0QP6uIol1IED7sFDyF2MNW7r58exqyzo/buXUZQ4SXIkwaCAk?=
 =?us-ascii?Q?YNySHyqrAZrm4SYf3vw5AWgFzTxVLf+getDsLIw2PN/w++y4DkHLqL7+ViQL?=
 =?us-ascii?Q?QVPJ1MBI44qQ73A7f9NiyKNp6o0KXRKCn2Je97dbbvCSpSFwPuhHXqsP5vEn?=
 =?us-ascii?Q?D/64xl4cadNLgn+b5xLc6TBTG37f2yNz8Z51UQYNqY59wQk4VyBxHCSF9hPA?=
 =?us-ascii?Q?FnuTGlRy4ZReVeIQqqAv4h7wZIoI3iHIdvITGcD8BYNJxfmoXn+eBS8jiJcp?=
 =?us-ascii?Q?f2Cs1F971Q9Dm+N2zWrP7vIZsqhMGijtMPiSq+a5tNtIbK6pWvo737GVy749?=
 =?us-ascii?Q?GF5JfApzXtuE+qBTbP+ukisxbm4A3tyysvFKJ26ffOrnEmrsFdegVIT5rBNL?=
 =?us-ascii?Q?A0DY4U/OXLbAjh0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:32:48.3491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c372a79-05ea-431b-c5f0-08dd65e6b382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

From: Kishon Vijay Abraham I <kvijayab@amd.com>

AMD IOMMU optionally supports up to 2K interrupts per function on newer
platforms. Support for this feature is indicated through Extended
Feature 2 Register (MMIO Offset 01A0h[NumIntRemapSup]). Allocate 2K IRTEs
per device when this support is available.

Co-developed-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 15 ++++++---
 drivers/iommu/amd/init.c            | 16 +++++++++-
 drivers/iommu/amd/iommu.c           | 48 +++++++++++++++++++++++------
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2efb47dba270..78821d45669d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -112,6 +112,10 @@
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
 
+#define FEATURE_NUM_INT_REMAP_SUP	GENMASK_ULL(9, 8)
+#define FEATURE_NUM_INT_REMAP_SUP_2K(x) \
+	(FIELD_GET(FEATURE_NUM_INT_REMAP_SUP, x) == 0x1)
+
 /* Note:
  * The current driver only support 16-bit PASID.
  * Currently, hardware only implement upto 16-bit PASID
@@ -175,6 +179,9 @@
 #define CONTROL_GAM_EN		25
 #define CONTROL_GALOG_EN	28
 #define CONTROL_GAINT_EN	29
+#define CONTROL_NUM_INT_REMAP_MODE	43
+#define CONTROL_NUM_INT_REMAP_MODE_MASK	0x03
+#define CONTROL_NUM_INT_REMAP_MODE_2K	0x01
 #define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
@@ -309,14 +316,13 @@
 #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
 #define DTE_IRQ_REMAP_ENABLE    1ULL
 
-/*
- * AMD IOMMU hardware only support 512 IRTEs despite
- * the architectural limitation of 2048 entries.
- */
 #define DTE_INTTABLEN_MASK      (0xfULL << 1)
 #define DTE_INTTABLEN_VALUE_512 9ULL
 #define DTE_INTTABLEN_512       (DTE_INTTABLEN_VALUE_512 << 1)
 #define MAX_IRQS_PER_TABLE_512  BIT(DTE_INTTABLEN_VALUE_512)
+#define DTE_INTTABLEN_VALUE_2K	11ULL
+#define DTE_INTTABLEN_2K	(DTE_INTTABLEN_VALUE_2K << 1)
+#define MAX_IRQS_PER_TABLE_2K	BIT(DTE_INTTABLEN_VALUE_2K)
 
 #define PAGE_MODE_NONE    0x00
 #define PAGE_MODE_1_LEVEL 0x01
@@ -847,6 +853,7 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
+	unsigned int max_irqs;		  /* Maximum IRQs supported by device */
 	u32 max_pasids;			  /* Max supported PASIDs */
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9a311c627090..c99b2e34f3b4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1061,7 +1061,8 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		int_tab_len = old_devtb[devid].data[2] & DTE_INTTABLEN_MASK;
 		if (irq_v && (int_ctl || int_tab_len)) {
 			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
-			    (int_tab_len != DTE_INTTABLEN_512)) {
+			    (int_tab_len != DTE_INTTABLEN_512 &&
+			     int_tab_len != DTE_INTTABLEN_2K)) {
 				pr_err("Wrong old irq remapping flag: %#x\n", devid);
 				memunmap(old_devtb);
 				return false;
@@ -2737,6 +2738,17 @@ static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
 		iommu->irtcachedis_enabled ? "disabled" : "enabled");
 }
 
+static void iommu_enable_2k_int(struct amd_iommu *iommu)
+{
+	if (!FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		return;
+
+	iommu_feature_set(iommu,
+			  CONTROL_NUM_INT_REMAP_MODE_2K,
+			  CONTROL_NUM_INT_REMAP_MODE_MASK,
+			  CONTROL_NUM_INT_REMAP_MODE);
+}
+
 static void early_enable_iommu(struct amd_iommu *iommu)
 {
 	iommu_disable(iommu);
@@ -2749,6 +2761,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
+	iommu_enable_2k_int(iommu);
 	iommu_enable(iommu);
 	amd_iommu_flush_all_caches(iommu);
 }
@@ -2805,6 +2818,7 @@ static void early_enable_iommus(void)
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
+			iommu_enable_2k_int(iommu);
 			iommu_set_device_table(iommu);
 			amd_iommu_flush_all_caches(iommu);
 		}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bc06cf060f35..fc420fdf8539 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2392,8 +2392,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	}
 
 out_err:
+
 	iommu_completion_wait(iommu);
 
+	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
+	else
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
+
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
@@ -3079,6 +3085,13 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
+{
+	if (dev_data && dev_data->max_irqs == MAX_IRQS_PER_TABLE_2K)
+		return DTE_INTTABLEN_2K;
+	return DTE_INTTABLEN_512;
+}
+
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
@@ -3093,7 +3106,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
 	new |= iommu_virt_to_phys(table->table);
 	new |= DTE_IRQ_REMAP_INTCTL;
-	new |= DTE_INTTABLEN_512;
+	new |= iommu_get_int_tablen(dev_data);
 	new |= DTE_IRQ_REMAP_ENABLE;
 	WRITE_ONCE(dte->data[2], new);
 
@@ -3174,13 +3187,14 @@ static inline size_t get_irq_table_size(unsigned int max_irqs)
 }
 
 static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
-					       u16 devid, struct pci_dev *pdev)
+					       u16 devid, struct pci_dev *pdev,
+					       unsigned int max_irqs)
 {
 	struct irq_remap_table *table = NULL;
 	struct irq_remap_table *new_table = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	unsigned long flags;
-	int order = get_order(get_irq_table_size(MAX_IRQS_PER_TABLE_512));
+	int order = get_order(get_irq_table_size(max_irqs));
 	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
@@ -3242,13 +3256,14 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 }
 
 static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
-			   bool align, struct pci_dev *pdev)
+			   bool align, struct pci_dev *pdev,
+			   unsigned long max_irqs)
 {
 	struct irq_remap_table *table;
 	int index, c, alignment = 1;
 	unsigned long flags;
 
-	table = alloc_irq_table(iommu, devid, pdev);
+	table = alloc_irq_table(iommu, devid, pdev, max_irqs);
 	if (!table)
 		return -ENODEV;
 
@@ -3259,7 +3274,7 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
 
 	/* Scan table for free entries */
 	for (index = ALIGN(table->min_index, alignment), c = 0;
-	     index < MAX_IRQS_PER_TABLE_512;) {
+	     index < max_irqs;) {
 		if (!iommu->irte_ops->is_allocated(table, index)) {
 			c += 1;
 		} else {
@@ -3529,6 +3544,14 @@ static void fill_msi_msg(struct msi_msg *msg, u32 index)
 	msg->data = index;
 	msg->address_lo = 0;
 	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	/*
+	 * The struct msi_msg.dest_mode_logical is used to set the DM bit
+	 * in MSI Message Address Register. For device w/ 2K int-remap support,
+	 * this is bit must be set to 1 regardless of the actual destination
+	 * mode, which is signified by the IRTE[DM].
+	 */
+	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		msg->arch_addr_lo.dest_mode_logical = true;
 	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
 }
 
@@ -3591,6 +3614,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	struct amd_ir_data *data = NULL;
 	struct amd_iommu *iommu;
 	struct irq_cfg *cfg;
+	struct iommu_dev_data *dev_data;
+	unsigned long max_irqs;
 	int i, ret, devid, seg, sbdf;
 	int index;
 
@@ -3609,6 +3634,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (!iommu)
 		return -EINVAL;
 
+	dev_data = search_dev_data(iommu, devid);
+	max_irqs = dev_data ? dev_data->max_irqs : MAX_IRQS_PER_TABLE_512;
+
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
@@ -3616,7 +3644,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
 
-		table = alloc_irq_table(iommu, devid, NULL);
+		table = alloc_irq_table(iommu, devid, NULL, max_irqs);
 		if (table) {
 			if (!table->min_index) {
 				/*
@@ -3637,9 +3665,11 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		bool align = (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI);
 
 		index = alloc_irq_index(iommu, devid, nr_irqs, align,
-					msi_desc_to_pci_dev(info->desc));
+					msi_desc_to_pci_dev(info->desc),
+					max_irqs);
 	} else {
-		index = alloc_irq_index(iommu, devid, nr_irqs, false, NULL);
+		index = alloc_irq_index(iommu, devid, nr_irqs, false, NULL,
+					max_irqs);
 	}
 
 	if (index < 0) {
-- 
2.34.1

