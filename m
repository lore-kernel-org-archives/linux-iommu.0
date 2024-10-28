Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F9A59
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115171; cv=fail; b=qQi+fhDy61BXDVo/wpEHUeiDV1zq1/n2d7sIJOZrrrF2/yANpJu2yUzJKJyPgFMZEHbTxlAQ6SO+J+rGtw4OTFF9Ja6/+hvbOGmHnKnCwDxjUFXQ7YqapydrflK4H0RRuNSaKItVjm1JW02X0gXl6OEgw/v8N6FMY4lrFCx/Ktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115171; c=relaxed/simple;
	bh=KHsqkpD4abpjje+dCmoS/x2tsQqDQsU+nXiqwaQhFJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjxJD9x0QHhugRcr7VO05h7eU3ubp4stq0ZvtphMKsCdFTIZZrMLFjDtC0+/P2rIqNoScqRnBTaaEDC+hKdeLczN4kVdKFjQ/ir2Q56EtQrZTbrAy02VLf3L1zGyCdmYRFEg8FonOvXBA1MH4uGt8YzxYibSRQmqlp8IgAVJGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q8rBmOo6; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q8rBmOo6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGZ/ibZV3szFqsZJEKVccuR3jxQC8nvnrytSXphd8pIiPndaTIx8gZAQDvfO/YvvWx0yGspSEESGachjtCAHV2qOwrDE8TjxmWz6zfuxs0r6U3ZI0OzoTI89MxOLOUWLCE3ArPhkSgLo9KxbgKtNZ8lZ5wCIU+REdani85A/KHSBsZ3jQB5okaOpCVSrIJO/D4BZkS6ZisSLiXKIqWYmowLWVKuGx0QAFdJeLcZabqGKMrBFbGfBXJjTph5XfOp3108Nc0G/GUKGCG5EgJrQfsLHJ9US55cU5VuSUVbm+ERL2iF0ebZwjcXesD50kyJ2EyTvZ+XDVx0pAbXmVwjyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOu9JRqi0Z0MPx6ADzA6qF/sBkGAk4By3V7zoJTofN4=;
 b=oFkm8D7MJVl0TqyPcsvZTGuxmbktUagBkK6ho85xexZDQECgLXytPlHemzGMD4Ce/chiOPCxeGC8zcypn6+LK3CgRwePTv6mOH4VkddDQj1F82dKbvfqS7dkbmpjpIJP35kMheZHax2/98akCIcZbOmlfoi/cuaUL72WShA8v7d5bmOBPrI7+RAY1dZvni5b7QxLBORt8QEm3mdiARkO2NB35zuJ1wO5TkS29DlI6Pzy1gEj/7OWoIJjAfSA1YcHh1M8IN6SI09LkHcReE2/LccnZKmpmwOzvfpmIFCiN9TIBucFgY/BxKCXk8sE0a0oMbWaSt9ZsMqb0Wb2CDkjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOu9JRqi0Z0MPx6ADzA6qF/sBkGAk4By3V7zoJTofN4=;
 b=q8rBmOo61qPF/GOrjmyMuEj2TlfNxXC6yjK3A7b0zxR328FA2bPvq1vVwKZ0osZT7ETFTwb+2cpTtNNUsJey12b0WcehQZO0J7uQDqeU6bLcLTz6GJml3+NbDt+f+0fLwsb5OHs/1f1c+GBjHApA3E6IzfqxDWxKK5WqT+km46M=
Received: from PH7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:510:33d::29)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 11:32:45 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::1f) by PH7PR02CA0010.outlook.office365.com
 (2603:10b6:510:33d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:32:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:32:41 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v4 02/12] iommu/amd: Use ida interface to manage protection domain ID
Date: Mon, 28 Oct 2024 11:31:38 +0000
Message-ID: <20241028113148.5774-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 87501ac9-3ed3-4e9c-815a-08dcf7443dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYQ9Q6HauB7lD8b3VE4BclpLOEhPO0SqpSmKoF0wCyEb3Li7BMvJOb0jLf4R?=
 =?us-ascii?Q?ngaBpenmsPWIE2mD4gx17JFDB7ha8mBVa79eT+17sAYFFemCBRWiAVP47Wws?=
 =?us-ascii?Q?kE5XMZHOHr78txRFSvDY53M90ua0yAPmBXqehOMpUpLfTfowJg4HYZKHcE5n?=
 =?us-ascii?Q?IM8odKcth145n7n/d2umFJgWWaZAJuL2J0jmv8mWtZu6Hz92rTiaw9R7IXMe?=
 =?us-ascii?Q?U8epgxUk0HIauh8xOqojJg8MnDixIDkNlvTUMD2AWD6oJ8I6ach2QP01ygiq?=
 =?us-ascii?Q?rqVWTjwNLjwiIytpwsIXd/oku6TCot+Tis4XbUz+ouy6ggiHKVZGhgLxkBo0?=
 =?us-ascii?Q?k8oIPXj0SOFp1nni1WRxWXIeaW3sgd4LYLn51N/3IdDt2MZXysjlzi/33FX4?=
 =?us-ascii?Q?JCRFBDEPVlALsQNqAGXOBXkgz8NkqO8G0AXWN5Qz6xkAJ/T5H5p7HC1TlCJ/?=
 =?us-ascii?Q?MsoZTnoRxPCrzP2WZM8S+5ByehLxiJ8Avs8TaWxawavD2LtnUz8T1hXDAdMc?=
 =?us-ascii?Q?HH216McUwFNJv2IS84kW6nz8VKS5LlYLUEiU5gsWULdxJQwVHhbSL1Oflo7m?=
 =?us-ascii?Q?YG1toQT6InuYStzfM6xp9iN+lk9TSRoaIgl/4cvhilkhsRLOpv3PsOt6AIlu?=
 =?us-ascii?Q?BsXNhTweEcvjJuK9oK+F8RJDt2b6w2+2m9vOqj4bPWcT7HjHkqxW2pa9AghQ?=
 =?us-ascii?Q?B8/tp0F8jCBPUh3qI7R5I3BdYFN6OansqnsX/K3P3NhZ5TnnS+RsD4OMRVZ6?=
 =?us-ascii?Q?jMLB3kgp8Q8jrilLbekYYBiX8p63JybjNBr/fnrGFDgNJQ6XCoVV+DDYZKtf?=
 =?us-ascii?Q?O1Q4sY6XfgZvf3NyrHF/w7jFaVy0vXpup6kUgAxi1/mbu/i46UGelaSVJ3a4?=
 =?us-ascii?Q?XcF574SwfgL6hxrmg3Dz/oiLGFazN/l49v8ARLVfKz8uwx9M+LqfOQPgu4q9?=
 =?us-ascii?Q?iByqPZVUpyociOIUiQRGSEfhKpWN1qWzEZgOXfsnXa7Y7N5PSsRgHkWnWcsx?=
 =?us-ascii?Q?CEevlmkHRkakaIfKEUWW0zGKRIz+V3I0IVTZLPrZMbwYqldQ5IDrVF8o+zpf?=
 =?us-ascii?Q?s//eyd9cXvyhu3skXftixxJoDJ/O+k/A/65vYMfYRajt+zrVozTESHePPSMc?=
 =?us-ascii?Q?xHOAdfzbC8tHwObe14N8lKhstjE7Xs5rlEM+EmA6eojRwaR8njnZCzFztTpd?=
 =?us-ascii?Q?Fcppp8FEcDFvcGpJDP3kNONnzWqmvv2k+Yo9ZhCr4/N5N1arU+NgzMCSoaxf?=
 =?us-ascii?Q?QjhLbM3vQNehpC86mG6oLYWGmoOAoGlf/MClTi5vAn3xvA2CZXPVWjO97a5h?=
 =?us-ascii?Q?QtWyd6ZDocywZaMf4ARUoZ4dDl4ssPoLjy2nPYJ5ew72my8has1qeRKmNUT8?=
 =?us-ascii?Q?adgKs/6uQ1Qcpnhq4FcjUGDZF+/jufPD0/vqa37oNBaDpa81/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:32:44.6659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87501ac9-3ed3-4e9c-815a-08dcf7443dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858

Replace custom domain ID allocator with IDA interface.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++--
 drivers/iommu/amd/init.c            | 31 ++++------------
 drivers/iommu/amd/iommu.c           | 55 +++++++++++++----------------
 3 files changed, 34 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 601fb4ee6900..e70f6299f765 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -912,14 +912,14 @@ struct unity_map_entry {
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
-/* allocation bitmap for domain ids */
-extern unsigned long *amd_iommu_pd_alloc_bitmap;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
 extern int amd_iommu_max_glx_val;
 
+/* IDA to track protection domain IDs */
+extern struct ida pdom_ids;
+
 /* Global EFR and EFR2 registers */
 extern u64 amd_iommu_efr;
 extern u64 amd_iommu_efr2;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 43131c3a2172..8922c0b63316 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -194,12 +194,6 @@ bool amd_iommu_force_isolation __read_mostly;
 
 unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
 
-/*
- * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
- * to know which ones are already in use.
- */
-unsigned long *amd_iommu_pd_alloc_bitmap;
-
 enum iommu_init_state {
 	IOMMU_START_STATE,
 	IOMMU_IVRS_DETECTED,
@@ -1082,7 +1076,12 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		if (dte_v && dom_id) {
 			pci_seg->old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
 			pci_seg->old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
-			__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+			/* Reserve the Domain IDs used by previous kernel */
+			if (ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC) != dom_id) {
+				pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
+				memunmap(old_devtb);
+				return false;
+			}
 			/* If gcr3 table existed, mask it out */
 			if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
 				tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
@@ -2994,9 +2993,7 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	iommu_free_pages(amd_iommu_pd_alloc_bitmap,
-			 get_order(MAX_DOMAIN_ID / 8));
-	amd_iommu_pd_alloc_bitmap = NULL;
+	ida_destroy(&pdom_ids);
 
 	free_unity_maps();
 }
@@ -3064,20 +3061,6 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	/* Device table - directly used by all IOMMUs */
-	ret = -ENOMEM;
-
-	amd_iommu_pd_alloc_bitmap = iommu_alloc_pages(GFP_KERNEL,
-						      get_order(MAX_DOMAIN_ID / 8));
-	if (amd_iommu_pd_alloc_bitmap == NULL)
-		goto out;
-
-	/*
-	 * never allocate domain 0 because its used as the non-allocated and
-	 * error value placeholder
-	 */
-	__set_bit(0, amd_iommu_pd_alloc_bitmap);
-
 	/*
 	 * now the data structures are allocated and basically initialized
 	 * start the real acpi table scan
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..1b2175fb3877 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-direct.h>
+#include <linux/idr.h>
 #include <linux/iommu-helper.h>
 #include <linux/delay.h>
 #include <linux/amd-iommu.h>
@@ -52,8 +53,6 @@
 #define HT_RANGE_START		(0xfd00000000ULL)
 #define HT_RANGE_END		(0xffffffffffULL)
 
-static DEFINE_SPINLOCK(pd_bitmap_lock);
-
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
@@ -70,6 +69,12 @@ struct iommu_cmd {
 	u32 data[4];
 };
 
+/*
+ * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
+ * to know which ones are already in use.
+ */
+DEFINE_IDA(pdom_ids);
+
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
@@ -1640,31 +1645,14 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  *
  ****************************************************************************/
 
-static u16 domain_id_alloc(void)
+static int amd_iommu_pdom_id_alloc(void)
 {
-	unsigned long flags;
-	int id;
-
-	spin_lock_irqsave(&pd_bitmap_lock, flags);
-	id = find_first_zero_bit(amd_iommu_pd_alloc_bitmap, MAX_DOMAIN_ID);
-	BUG_ON(id == 0);
-	if (id > 0 && id < MAX_DOMAIN_ID)
-		__set_bit(id, amd_iommu_pd_alloc_bitmap);
-	else
-		id = 0;
-	spin_unlock_irqrestore(&pd_bitmap_lock, flags);
-
-	return id;
+	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
 
-static void domain_id_free(int id)
+static void pdom_id_free(int id)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&pd_bitmap_lock, flags);
-	if (id > 0 && id < MAX_DOMAIN_ID)
-		__clear_bit(id, amd_iommu_pd_alloc_bitmap);
-	spin_unlock_irqrestore(&pd_bitmap_lock, flags);
+	ida_free(&pdom_ids, id);
 }
 
 static void free_gcr3_tbl_level1(u64 *tbl)
@@ -1709,7 +1697,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	domain_id_free(gcr3_info->domid);
+	pdom_id_free(gcr3_info->domid);
 
 	iommu_free_page(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1736,6 +1724,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 {
 	int levels = get_gcr3_levels(pasids);
 	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int domid;
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
@@ -1744,11 +1733,14 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	gcr3_info->domid = domain_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
+	if (domid <= 0)
+		return -ENOSPC;
+	gcr3_info->domid = domid;
 
 	gcr3_info->gcr3_tbl = iommu_alloc_page_node(nid, GFP_ATOMIC);
 	if (gcr3_info->gcr3_tbl == NULL) {
-		domain_id_free(gcr3_info->domid);
+		pdom_id_free(domid);
 		return -ENOMEM;
 	}
 
@@ -2259,7 +2251,7 @@ void protection_domain_free(struct protection_domain *domain)
 	WARN_ON(!list_empty(&domain->dev_list));
 	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
 		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
-	domain_id_free(domain->id);
+	pdom_id_free(domain->id);
 	kfree(domain);
 }
 
@@ -2267,15 +2259,16 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable;
+	int pgtable, domid;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	domain->id = domain_id_alloc();
-	if (!domain->id)
+	domid = amd_iommu_pdom_id_alloc();
+	if (domid <= 0)
 		goto err_free;
+	domain->id = domid;
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
@@ -2319,7 +2312,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 
 	return domain;
 err_id:
-	domain_id_free(domain->id);
+	pdom_id_free(domain->id);
 err_free:
 	kfree(domain);
 	return NULL;
-- 
2.31.1

