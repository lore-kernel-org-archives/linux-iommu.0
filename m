Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61792147F2
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615170; cv=fail; b=BuBjJhQqMtlw0lcIx19A27zs5n0YtX0jn0WKmuT1r6Rij8kLqt5OYbpq2RMcK+T7o06T3ASMtWDmYqQdp+U8vS/57dzmz4d6vdGIg7siw1VPx4/pdcXuqdZ7VL8e1Reb8dDMuIAJFLDz/5r2o1L0g9vbvarWiMxcMK/2IErbwxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615170; c=relaxed/simple;
	bh=T9HkXAGbrNYr+Rk8JaVxua4FJEzfPRacTCm+rYV09/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFRyvSRFCUsP6Ul0QRh7c5p7y0RRQuDNJiMbag+RhK8BZFS5PHfZiKIXfUeNSg6gAEqCFanYG/qfV+N+IWSsqT4q/bmUQkhURiXoKAn+MlfCcJlumwltAwR33S04GaxJ0ub8ekqcRxBMOZKLOb3+Cp+9Gzfso5DWV0K1veCa7TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mQesqWqW; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mQesqWqW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCu3jgatyILcoHBA1ivB7qLAUhy3cL2kCafhCDPognrkO3cmyWncSeBilS6R2T7z1iU8QRr7SPaF8D9WD1XMMsFNWdjsMtQGRCSqiKdVrf+jqXOx0FTU3mw55zXXRhEpHnmJqcMkfjG0woNIEi6Lt7gkWScBjdxu2BsKgfF3vuW8MZQlpExLZKY94KLrazOnaH+HDaBbQ4t+M6JDTXYkUYkS0CghOjOqpfCFWP+sXAELTq/5FSNXgqVlrHfh/jqCemO4SwhtZjXjomp569pmZs0ZqNTTNmakKtYrEGJCJhm9vgpZI0FIbEksty3CDfmlaKIQJwQ3f7Gw9nq2RIwyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNzbEk5S0wE2PhBbCIeT0BHtgYsBJjx97tPVvXPEmak=;
 b=WtjH5t+VQhaPO/p8+fDPRpUSqkNFKshaqpHTkjcwsZiUibW/C3Hvxa8cDIQQ8IJc8eIGfZuJhz9Cob8/kv3GMhkXYhcncclUHZTCYnlmhO1/DGd+uZ7v9ICG7VihwnN3c9S9RxoS/kgjZK34GKte8s0NPrbzmZiKeOA8Vouz3QusOh9hZHfy1jGvUpRA0yucZ3KihX2+Xub57yV6TmKX61OlvOr7rVP7sLXgX4FXyFBf7wUDxwEN7nov8MLk0/UlEIOMmeUH7Rex9vIPyI9iydpubHLMRyEmHYeRmupSQwS8tMIH16MHrzGL9wKO1b9niIJbRgxidB593aoBRPBbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNzbEk5S0wE2PhBbCIeT0BHtgYsBJjx97tPVvXPEmak=;
 b=mQesqWqWisFT2pkNcIermn52eoKmgsPE6K6SGtLZygMlKUl3fSztnZ6JqkV+FqvN1To0FaaeQ9dz9exG79TwRMOPWFEMyggpkHE7UMGDakbKVi653qCV+hBOLNrAc9UosrT+GEEgTYaHwftQXaNxpP6QOiQutRMKrXJujk9lBGQ=
Received: from CH0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:b0::8)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 10:52:43 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::32) by CH0PR03CA0003.outlook.office365.com
 (2603:10b6:610:b0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 10:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 10:52:43 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 05:52:38 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iommu/amd: Add efr[HATS] max v1 page table level
Date: Wed, 7 May 2025 10:51:48 +0000
Message-ID: <96b1109a095fa343e5c8a0dc6b8e1dd1f39605c4.1746613368.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746613368.git.Ankit.Soni@amd.com>
References: <cover.1746613368.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: c378ba56-8372-40b1-cb72-08dd8d554b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ciPsjOhJaCp7a2OMWar9FAY69AO72bwqcij1wKxHNVZLHoxsqzN9tPmKLHSU?=
 =?us-ascii?Q?7hPhEZT/oyixydlQuFoxs9G0EGVjS39MDeArfiGr4FdOzhLPclggz+lPrwQq?=
 =?us-ascii?Q?+p0PZNF3f16gE2c7E/34hlpKZ+dYSX8T6JgeJTlc+ixJg6NWuTDIjoSN978b?=
 =?us-ascii?Q?M/hy+/BiyPKp1to2aFQX4hZdKvTRRr7h/xN/F/42j2Pt+V7BQO9tjdDA+SNr?=
 =?us-ascii?Q?VmrM2FxLGnnEnAXCZUxyuPhWyaJEFW2eNwroxXjXTXeHEPa7Y7QooC4i2f6k?=
 =?us-ascii?Q?LfnbgSxK0Hn2gNRSWhnBXZybjuIc+J1EPg5MZGKv53/QFOA/clauqlyGvrnD?=
 =?us-ascii?Q?ArqskQsWpD8p5kq/9vkuTCcfIvtSA9UOeR8mD9upFVbGzu31dpFl7GXGo89M?=
 =?us-ascii?Q?R6iMhDomWZc7jh9mJRGY7yZyQeesHp3768oo1F4OFmb5lvWkd0ouc7owlTvz?=
 =?us-ascii?Q?eDtdBld0UEmFoUSlcTrDRHYSYzkvnMt6nLsBGaA5z6qK2Xo0zmkeiWldKinu?=
 =?us-ascii?Q?zcBtNqNrlKWumn7CncaNKkItu8KM4VgmVsNp1tNlpsX2gssHwM3lh+tLHMPb?=
 =?us-ascii?Q?ByJXg7yUZ+nntbyQkX6w48lNJL0mgC95wvhUVh6F0o0DUz9dleZuXaD/NBav?=
 =?us-ascii?Q?Gpq7+2A5fz9qYIqTfTZooRPqdvcwKGhyiWJ2LBsaCct6KxO9jP607tlnHiTA?=
 =?us-ascii?Q?bS+l1TTK3bnuSPzyTtwy14UPd9Dse/hP5+44yKDTu9Xh+Kxc/U0EqnbMm3nr?=
 =?us-ascii?Q?nQEmm/ymAOgx+kuEJ7b8zPO4m8S79JHZK8QssJfPNbswSk1iP899xc+TPSw2?=
 =?us-ascii?Q?9xlvulm1sLP7esqtdIeofedsqi82q5fuEpgL4nm9d3KDfog2kGrc7etW9xbK?=
 =?us-ascii?Q?fz37Y0K3TQ0SKb0ry5EZm03d+3euQRbUvpj3Js+iNEy5Ua1drAwxeN5ZBrez?=
 =?us-ascii?Q?PLS8TKruGM53Trxp3AcheXIYkGa2IWlCXefyM3VvzzSz2M4fVbAn4GNACyOl?=
 =?us-ascii?Q?FE19EgzZXbQGrwDErR9IlwXHS+jkynh1WhrGu9sCf6uvutRiOWayR0lmBYQo?=
 =?us-ascii?Q?Pi8Rypzrd4KVKKn9HN1kcAqhfn4V/i4wo+s/1l2zhydSnkQmrO6JvQHmff+W?=
 =?us-ascii?Q?ZRLomStG9egRd7JUcCxNdpl+cztEGNyAuRIsVgB++kQ0bEQjC7noDJuPX81J?=
 =?us-ascii?Q?qoCM+zxqo/qvlYOgTrkEBPCbiQlrWy3gu6i0UQkij4LeZM5T4dWjvFHeASgj?=
 =?us-ascii?Q?KPJYXVFDQ1/v++4+hRcdOok2EVdQos/jgshZGPEfubURqrYM9JZRlVfaApTh?=
 =?us-ascii?Q?UhPiaE++E/+5PGLFxgYWWmd2przHXbkxKFv36LEN3rtf/4ylck6O9KoACCGQ?=
 =?us-ascii?Q?8IVOqluaQkcOwVwtknDPB1p2V+fiG+++hBLQK99LRZGwU6JCt0RoYZLCKv/y?=
 =?us-ascii?Q?8wco4MVEebiCqVcPOyON5jylphgEHsWj+tJI5vG2QUcK9eBOvMXBBPKFohrS?=
 =?us-ascii?Q?HUK+4B6eMGvSfDHDfEmoALYlN9VK4RWw3Tjk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:52:43.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c378ba56-8372-40b1-cb72-08dd8d554b57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150

The EFR[HATS] bits indicate maximum host translation level supported by
IOMMU. Adding support to set the maximum host page table level as indicated
by EFR[HATS]. If the HATS=11b (reserved), the driver will attempt to use
guest page table for DMA API.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 16 ++++++++++++++++
 drivers/iommu/amd/io_pgtable.c      |  4 ++--
 drivers/iommu/amd/iommu.c           |  2 +-
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bb14c4800dd0..0286120ad4a5 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -42,6 +42,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
+extern u8 amd_iommu_hpt_level;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 284ff4309660..6bf81197c2c8 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -96,6 +96,7 @@
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
 #define FEATURE_PC		BIT_ULL(9)
+#define FEATURE_HATS		GENMASK_ULL(11, 10)
 #define FEATURE_GATS		GENMASK_ULL(13, 12)
 #define FEATURE_GLX		GENMASK_ULL(15, 14)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cfda9f89fe1d..311c2ae45d09 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -152,6 +152,8 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
+/* Host page table level */
+u8 amd_iommu_hpt_level;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -3052,6 +3054,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
+	u8 efr_hats;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3096,6 +3099,19 @@ static int __init early_amd_iommu_init(void)
 	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
 		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
 
+	efr_hats = FIELD_GET(FEATURE_HATS, amd_iommu_efr);
+	if (efr_hats != 0x3) {
+		/*
+		 * efr[HATS] bits specify the maximum host translation level
+		 * supported, with LEVEL 4 being initial max level.
+		 */
+		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
+	} else {
+		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
+			     efr_hats);
+		amd_iommu_hatdis = true;
+	}
+
 	if (amd_iommu_pgtable == PD_MODE_V2) {
 		if (!amd_iommu_v2_pgtbl_supported()) {
 			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 26cf562dde11..0d8bc06f63d7 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -132,7 +132,7 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 		goto out;
 
 	ret = false;
-	if (WARN_ON_ONCE(pgtable->mode == PAGE_MODE_6_LEVEL))
+	if (WARN_ON_ONCE(pgtable->mode == amd_iommu_hpt_level))
 		goto out;
 
 	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
@@ -531,7 +531,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > PAGE_MODE_6_LEVEL);
+	       pgtable->mode > amd_iommu_hpt_level);
 
 	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
 	iommu_put_pages_list(&freelist);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4e9a57377b8c..f7e641571127 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2503,7 +2503,7 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 static inline u64 dma_max_address(enum protection_domain_mode pgtable)
 {
 	if (pgtable == PD_MODE_V1)
-		return ~0ULL;
+		return PM_LEVEL_SIZE(amd_iommu_hpt_level);
 
 	/* V2 with 4/5 level page table */
 	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
-- 
2.43.0

