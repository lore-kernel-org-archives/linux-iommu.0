Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5C262FDC
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017662; cv=fail; b=Z5qVALJ8Txi1Y175KR/4TvqKBZC1LT0nvPOfYhIw9Z3D/CEymvy5ucfa9HLPE8mDBFeikJ+NFRDn5wAQx0V+aC7WaY1+AVJoW63u2HCjhKFt3sTSspKMNUdEQqhIU9IZnFkvmkGAHqit2vaNIvR8vZvaq8Vihom+KTurExPMui4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017662; c=relaxed/simple;
	bh=sWuqRpa8UH7ClvgUEGFHSRhEjJAOdvpopY4gh6NrVF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1BrGc3ojXa/RnmwC35JTFeyePxnMTnCG3/xO45x9lVvA5Ko6TPGOUvkGh8l//4urFRHP/6SqKIDu0MhpTQVkwxVbFIr8eVMUXxuVe0PP0aHtCS5qLncwAxiKJ81E19c5ZSBcBtho0X8SmQ6s6Yhn1LjZgejhKXnHldsKhRzUrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WUUC57Sl; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WUUC57Sl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lixYhH6EJ7gDeHh4CkcFVB4ll3OWzZmwHdeqqso6gAixnDRuqWdwLzQObGQPNMBQxNU4cCzkzhl1YuYiXudv7A2sz24pqgBd+g8/ImKuH4zSmjGmKGs68Qa4dDhQccWcVXWUne+Al1/LyNzGmWrpkc3V9gYJZyoaDyRxe4psPBvHMXvF0t+G4bXIwAI8AAsBqZUTXPzmXHjgFBJ2QzHk/eCWeXkI/nvIPbF1/S4EOZkqZqyqR1GsS6iWI5MA24KhvaHQNfQok2i/VJxilSLqMPeST9DmzQ//wG0LGISlGIHT1tPCdT8ZGcU5gdkYao3tPJi7bLdCHJOnK96byLRJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKknU0F0wAoW11teczERtNB7+osUJZGcNOpLfWhQ/H4=;
 b=tOetnRBFMJn02diPpEDa0PpjpAZsS8G/73Jo/EZKKPqTKx7Te+IVkrAVDwJzPqK+LQkrn2x27+m+5yw2VE00ma6AVf3IcSlrJ+klrAdxUww+ZYB6AfXmGC4LS9cuPEJ9JgNMNUwnkXsocLMJ54EClws2f6xxGZ1dNM2npdVrH2xD4lvhjsIfBH/n1/sB3YzjaKwIpJIJVQLC4vgqSxXjRgtFNmR3fP+hPKSMN+TWlsD58s6nggwXX9MU4JAYKkKSH+vF4Eg1BKUcE9LvXAXIefU6yr+PPkIBw/YtZRx7aECSWXtsiNDjKd71qD6s5vLaCk1Q/jGC8g3ZsasP94JWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKknU0F0wAoW11teczERtNB7+osUJZGcNOpLfWhQ/H4=;
 b=WUUC57SlYYHlDDiPBwIfcHtTISzT7pR2kmeBlWugeZotk3/gU3bjw8XSQO0HLPoCskFQYx1VV4FLJ97k+o3W026X6lVqubi78A6+xApFW4XQy+v/Ut68rrPvde8rq3aeOHFw26FtTlOPQUL7qVOdday6aOm3hduEKyx7OKic1qc=
Received: from BN9P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::26)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 06:14:13 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::52) by BN9P222CA0021.outlook.office365.com
 (2603:10b6:408:10c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 4 Jun 2025 06:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 06:14:13 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 01:14:10 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <joao.m.martins@oracle.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] iommu/amd: Add efr[HATS] max v1 page table level
Date: Wed, 4 Jun 2025 06:13:25 +0000
Message-ID: <df0f8562c2a20895cc185c86f1a02c4d826fd597.1749016436.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749016436.git.Ankit.Soni@amd.com>
References: <cover.1749016436.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaaa76d-d69b-4525-8fda-08dda32f072d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vC/YFkbyWTAxVf+8QGyaJguciJ+j7ZI0AKw7TYpYalQkjVUAqEZHMIBe3dNa?=
 =?us-ascii?Q?dGqWCcdew7/mkyht7LafcYSDCNPY0PRO6eXD+bmzGl93mp9FLjo/husIUrce?=
 =?us-ascii?Q?pEZYdNLQBrENGgpnoR8StART+kpdeKKM2apg0IXtDJyoL+51+h5QBPEFIVIy?=
 =?us-ascii?Q?Ih1xG9LvX+USIxlFZW32ePfMLrbEMOcARYw4pR3jTNI/RiH49HUdXI28IL8A?=
 =?us-ascii?Q?07yD7K19R9M2B1kwm03f0gLtigABI6tWk3GP/xgr4UWTQykJEboql6Ql4PRJ?=
 =?us-ascii?Q?uopvyVsp8EOYSY6QUxCh+tlFGcmgrrTxmqWc17NtE1/2ZA/B49EFYNZsIj9p?=
 =?us-ascii?Q?KDH7UTROSPw2uI33usyfiJ36yrl4z2+lPb8zCX7toz6vKV3lXmJTcuEUd/xY?=
 =?us-ascii?Q?KgsATunHvTpHdXmzoTscqIKEJTn0+YTeDp+S8rccOG0GtFc839KFStNYDNwu?=
 =?us-ascii?Q?F532LchJXh018rAZRfFn0IzXNWKspuJYuPHo2+9Q55IQFRLTAIPwavXqBjK/?=
 =?us-ascii?Q?HCPVtg9UpvAzV/Lz3wCc2/FaitTkEr4f3yHtPDGZ1Z7Dghis/CdqO/okYopS?=
 =?us-ascii?Q?8YseBpxG9sZXzEkCHi6SDaMo41NefVNPi4BVPkPy7/VXLr+y9WaT8+K+nBkI?=
 =?us-ascii?Q?tG2qvcQPougKbx/0urTvi2qGb+r5CcX7TQSCGxpmVsth7DlV2e4Ujc55uTGS?=
 =?us-ascii?Q?fF57QCegw7or9mwlMlx8OEfim6qXWHBBjFhGSs9ZaeV4SyDmkD7lmpl2ROEk?=
 =?us-ascii?Q?iqkSO3nO4mEtS742nWuBJK5nLVDQ1+tbbTsMruaen5piWOqnc9oz/z9nDhzd?=
 =?us-ascii?Q?j7TH6OrrG+y7ycEICux7MR2+qsg4qgK8Myb0Fj8I3yeDQSEhhM4D9U+wQ+zn?=
 =?us-ascii?Q?8NQRGy016L2bXaYq7/fkZaGxSgOe22iNU3czdLHhzIWEENcg3NCDyqSTelhq?=
 =?us-ascii?Q?w3xJcXaoTLU/H9bYSu6mYKuzIcL28rwOCoYjneElJp7etxQcS1QYDG2YzaXC?=
 =?us-ascii?Q?4RHzxOU+s8sTUGNj9Bv3wJ2kHPmg3CNql/HV/ENiJTX+A22vJI6LHw3CztfA?=
 =?us-ascii?Q?lvC51M1Rk51dS/LdZALRY8RlMTKWSRA0KZWUxbY8WafQhZYJrb/K8QcVSxFc?=
 =?us-ascii?Q?orgBD0VaGv7+c5kmuFvPmkHWZl/0EHMephL+ENHWaMZgVYSXO1PZxNp/zvxU?=
 =?us-ascii?Q?zoWB/xSucTRBYEjblDfsgv9OfzBdng0SJ5Do6ClWeuFRHM1/vlo7Qba738a7?=
 =?us-ascii?Q?YeePkCfNvrWUCzPfwpAjOVxmlc+GLRQEIvF6ECZ+FadHIWU0nM15eegVbJB2?=
 =?us-ascii?Q?Hg5HW4KcBH1yD6cEhlmX34x9kOPKJe9jmzFYHgGln7EaIlADAHXs9EZXQhKa?=
 =?us-ascii?Q?kcE0d8NJ9ENJmjZNZXKhrKpdFNdrkPSNfG4JgzSWPYGGVjkD+N8A6JHVw2HK?=
 =?us-ascii?Q?Ba60w3AHuMdyu7N6tel6r5t2EgeTIMqnQHCxn93Vqns77UifZ+BNEvD4mViQ?=
 =?us-ascii?Q?WgJhbxQTnYwaMekCjGmTo0R8mHyqi4I7fWA+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 06:14:13.5261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaaa76d-d69b-4525-8fda-08dda32f072d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

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
index fddfad4a9009..0bf3744c7b3a 100644
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
index 69291cef73f7..35ee7b0648af 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -94,6 +94,7 @@
 #define FEATURE_GA		BIT_ULL(7)
 #define FEATURE_HE		BIT_ULL(8)
 #define FEATURE_PC		BIT_ULL(9)
+#define FEATURE_HATS		GENMASK_ULL(11, 10)
 #define FEATURE_GATS		GENMASK_ULL(13, 12)
 #define FEATURE_GLX		GENMASK_ULL(15, 14)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5dda0f6d2492..1b4f4c324e9c 100644
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
index 4d308c071134..a91e71f981ef 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -125,7 +125,7 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 		goto out;
 
 	ret = false;
-	if (WARN_ON_ONCE(pgtable->mode == PAGE_MODE_6_LEVEL))
+	if (WARN_ON_ONCE(pgtable->mode == amd_iommu_hpt_level))
 		goto out;
 
 	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
@@ -526,7 +526,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > PAGE_MODE_6_LEVEL);
+	       pgtable->mode > amd_iommu_hpt_level);
 
 	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
 	iommu_put_pages_list(&freelist);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8a9babd6dfa7..9c67f0be2b35 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2534,7 +2534,7 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 static inline u64 dma_max_address(enum protection_domain_mode pgtable)
 {
 	if (pgtable == PD_MODE_V1)
-		return ~0ULL;
+		return PM_LEVEL_SIZE(amd_iommu_hpt_level);
 
 	/* V2 with 4/5 level page table */
 	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
-- 
2.43.0

