Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4C17BB25
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852640; cv=fail; b=baPR6v8ENnByPG0gmcNtmmC22SwDjW7ZEtQ/l7V8kfla+Ckn7FWck87+gw4fPJWcnaUDXEEaVknhEXjBYfolXztFZ0k07zLcvNLtZ91Ruoi7xHwRkSrwLIFo/Ir3hJS4dAEfVNc8GsL5Nh1MYsODJe3znUCscMCld8AXAVGJ4Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852640; c=relaxed/simple;
	bh=FTBZ52tmB5L0skLLqpkv9pkcn2Ux0nDK3H9DGim0s0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyjQ8IQvF7UvvfAeI+lVZzRHEvJ3y0b+q6FCPTzAkhrMuPLkvXE1Lm9IKtPoWzwGTdrnfw+lKKXeawh6GHSSo2bst9G1yiVxX95yrgtl82yv2Y+ZO9XlR5CgrXWYZKVS6evS2eyGAUNMtgI6sfOVsg6ThCKxWjN7x8vo+EemBEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5J6n5YTU; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5J6n5YTU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps3cC//embAJtQM/bW1tFdc0w804DsRAu7/Ws0KdllvNfAK0sII2dxAVfFyiBJQYY+XgSRBA5naFcWLh0W0sBTKCodK2gFh9ViJzCWDlT71PjHA9eb49xkDZdZjJXenzsrx7ag3v1OnYOZObZMD0+KOcwaIcuWcOz+CZliNhJ9TPIs63UcJ30iE8glxXcFu2ed7oRYV8ZuydM5TT6en1phB+YeIgCLjzcN6gybO9ct2SMOqjIcUVLpPk8Y58z2SoKjoounoZuHa9f+Xf7zDXRGdzuKEYZ3ZANDtm8L+lsZOUlGyCRxXjq4JZ1DFfkGtctwOR9ZXIDWlo/6Qit30Blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQmKKfiAu2nU4rK7kxrn1JqWClWeA2EBNtTYNihen2Y=;
 b=OXW9Mt/muStVSTHcPaMnC8LK60zURA1l+x6fIzA/v3jvWRYEEDextQ7YNuc4f44FBl/tDOiOxvsdATBc+PpkKxzBUhMd4s1/7lvESNi4cgGToVyVgrbTzsAB1b79gw0Vmp7iELIa/Hbwi6UK2emLzgJMLsyTRTd6A6P7VoPqegiBRNgLKm5iMbWn1Arx6NeRda2cFxDWNNdxhv91AYW1ZV1KNJDLd46SL6BkziX73c3kYAv0M8kkV/Y6vtgjd0znKtkNmG7Bcuf0XWXK2hlmrkD9z6h54Av4MTw6n6GQKlnJ+MW/TtrBDletK9z4Z26bGX0TvwDImWrZXo1ZK68IsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQmKKfiAu2nU4rK7kxrn1JqWClWeA2EBNtTYNihen2Y=;
 b=5J6n5YTUQvOCL4J5OvQuy/X7zJ0GK+R+SBm4S/QCIE2iYruIdmPSRlIyvRjXoqjaJ/P6Kh0GYCBkrs/f7bX0N+lFslsWp2v6SGHNHMw36niZZ5EAWeGGqOuIX0IdO/I/nPjlI/TRnNG+9p/0Y1zS/yuOpXxygoKcebZm/ucSCoo=
Received: from BN0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:408:ec::18)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:43:55 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::a0) by BN0PR04CA0103.outlook.office365.com
 (2603:10b6:408:ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 13:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:43:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:43:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 01/10] iommu/amd: Use ida interface to manage protection domain ID
Date: Wed, 28 Aug 2024 13:43:08 +0000
Message-ID: <20240828134317.6239-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828134317.6239-1-vasant.hegde@amd.com>
References: <20240828134317.6239-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b221f9-3361-4a54-b4e7-08dcc7677608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXM19tc8UNnvGj9rA/ioy5mou1XEO/JIp3oTJvsc9wKKnP16CP+q5pCU4T4X?=
 =?us-ascii?Q?UEnejSlhHAZmQz5MHVINBawpaoHBak6F7Sv7vKcgaiyQ7zYBQUUAmhvvi9RB?=
 =?us-ascii?Q?3gDaavAzMYYXYddOGAfiTOkPP6yk0uK4uEsEOm9bpAaXBQD7z9M99ef6fv6u?=
 =?us-ascii?Q?eyDwbgPrIz9eGuCjeRYOZBkCyIyOuD051f1VeJFuZ3DWQYTRt75/bkEuZFej?=
 =?us-ascii?Q?P3kW6wdKpm+iLoqXU/f0FWDLmUX6zKCjq9XQcZNXlGm7mt+n9W2+SMd4SpmZ?=
 =?us-ascii?Q?4sTmC8ZdndVn8FQBnFAoFx1KR8UtMxaLjTx0nXnK5e/VDYoLNLFo1yrUz0yu?=
 =?us-ascii?Q?myBjprH+HZTPcnMPBOh5NLWOtuac5thwf/I1dOZteu8PCSMMx4QuvcNsHXCI?=
 =?us-ascii?Q?JnOOZQMEbIWGquPHbVxdJKa14SGiy2D0Q36gP1d+rdZ9H2HuQOeS4HJG3U94?=
 =?us-ascii?Q?jIELBjv/9E6PMxQDG3kF3bxTufbK670Ly72smKoTbvCKc75nUDGFIPpnr1sw?=
 =?us-ascii?Q?JRfmT0WuY1KuCEyizptg5sfT6PurFBsqZDfJBVYyrKHePieZllUAfM45vf+c?=
 =?us-ascii?Q?CsapOC7ttvvVqrJ+B69erNkvULbXzqXc+L86Mu45MaS6JnL/5quWr3ny8DJN?=
 =?us-ascii?Q?PhWzE82uzcE5QRGNFIzeSRrNQDQsd8NQjddRlm2rog+/BaGLpXzOK/Nlht7f?=
 =?us-ascii?Q?cWOeG8yGMcD5QdbIeV6jnI3mHB3/aPiRaZgaOB9f77FavSvrX4ajPeRq+MPz?=
 =?us-ascii?Q?8giUq8BpHMeVAWy2EOBJcXbOkDlBBEDwp14/EMp07O0HyJfpEl6HpFJWnTku?=
 =?us-ascii?Q?W2JEeChLckM2NVWfk7tvMimM4w3lqd1zpbjhkVCfgWi2r/zVZQNNCAeXfAOk?=
 =?us-ascii?Q?RbovP1yN4ZqSx91lPVWSYU7YiPEkZcEJDqIXaPj9MaygyMNcqpiOMhLPY/El?=
 =?us-ascii?Q?WN0K2M7dhWrsVctlRDEo1ZItJsi/kQUZm7OVGpq0uPqnLdAIKVZtOKy4CrcO?=
 =?us-ascii?Q?5OUuolbKtv4sdLl4Zdp3ESN/SrE0TXPIUb8FG2Map7/K9ORtJVPv21fDTAJe?=
 =?us-ascii?Q?uLwLcwobbd1tH5cnEEbNufxUlMcN/RrPIgPd1EdssMgzUX4imuIxhPCCmxqK?=
 =?us-ascii?Q?7WLZApMdOMRLhrte+a8PpToMRbdY7GOh0TAhXA0kfAnNVIMX2MUl0e4VmYD8?=
 =?us-ascii?Q?/MQL26hKErd69QQYJsowYCA+/sqrTeIfiXdwRynkcsji1iOOOp/Uwx+syE4p?=
 =?us-ascii?Q?G+TRNWsLwMUK1quh4YuErsszLYNALG9wncqyjM0pSDblLsfiPUWzd9XR6TD7?=
 =?us-ascii?Q?HUVNgfFfZ506lEEzWPHvof9TAfeOdue6qLuERfqSRYYSrFa9RzlpOO4oZf6L?=
 =?us-ascii?Q?Dn+lC/lC73UnsfACfefTQELyxYfHL2MpGfdrEKCPOUQDpacxDFuHO+qqVTwS?=
 =?us-ascii?Q?bb9iZcfUXfS1T1UHJNrAo6CgEoF89wCk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:43:55.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b221f9-3361-4a54-b4e7-08dcc7677608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

Replace custom domain ID allocator with IDA interface.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  3 --
 drivers/iommu/amd/init.c            | 29 ++++++---------
 drivers/iommu/amd/iommu.c           | 56 ++++++++++++++---------------
 4 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 705dd364afe3..b4b38fd2bac1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -45,6 +45,8 @@ extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
 /* Protection domain ops */
+int amd_iommu_pdom_id_alloc(int min, int max);
+void amd_iommu_pdom_id_destroy(void);
 struct protection_domain *protection_domain_alloc(unsigned int type);
 void protection_domain_free(struct protection_domain *domain);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c7432296bb90..5072ff46edc8 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -909,9 +909,6 @@ struct unity_map_entry {
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
-/* allocation bitmap for domain ids */
-extern unsigned long *amd_iommu_pd_alloc_bitmap;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6b15ce09e78d..bc1fecb67687 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -192,12 +192,6 @@ bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
-/*
- * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
- * to know which ones are already in use.
- */
-unsigned long *amd_iommu_pd_alloc_bitmap;
-
 enum iommu_init_state {
 	IOMMU_START_STATE,
 	IOMMU_IVRS_DETECTED,
@@ -1080,7 +1074,11 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		if (dte_v && dom_id) {
 			pci_seg->old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
 			pci_seg->old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
-			__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
+			if (amd_iommu_pdom_id_alloc(dom_id, dom_id) != dom_id) {
+				pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
+				memunmap(old_devtb);
+				return false;
+			}
 			/* If gcr3 table existed, mask it out */
 			if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
 				tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
@@ -2992,9 +2990,7 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	iommu_free_pages(amd_iommu_pd_alloc_bitmap,
-			 get_order(MAX_DOMAIN_ID / 8));
-	amd_iommu_pd_alloc_bitmap = NULL;
+	amd_iommu_pdom_id_destroy();
 
 	free_unity_maps();
 }
@@ -3062,19 +3058,14 @@ static int __init early_amd_iommu_init(void)
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
 	/*
 	 * never allocate domain 0 because its used as the non-allocated and
 	 * error value placeholder
 	 */
-	__set_bit(0, amd_iommu_pd_alloc_bitmap);
+	if (amd_iommu_pdom_id_alloc(0, 0) != 0) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	/*
 	 * now the data structures are allocated and basically initialized
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 82c0ee527732..a4f3d14e4ce3 100644
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
@@ -54,8 +55,6 @@
 
 #define DEFAULT_PGTABLE_LEVEL	PAGE_MODE_3_LEVEL
 
-static DEFINE_SPINLOCK(pd_bitmap_lock);
-
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
@@ -72,6 +71,12 @@ struct iommu_cmd {
 	u32 data[4];
 };
 
+/*
+ * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
+ * to know which ones are already in use.
+ */
+static DEFINE_IDA(pdom_ids);
+
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
@@ -1642,31 +1647,19 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  *
  ****************************************************************************/
 
-static u16 domain_id_alloc(void)
+int amd_iommu_pdom_id_alloc(int min, int max)
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
+	return ida_alloc_range(&pdom_ids, min, max, GFP_ATOMIC);
 }
 
-static void domain_id_free(int id)
+void amd_iommu_pdom_id_destroy(void)
 {
-	unsigned long flags;
+	ida_destroy(&pdom_ids);
+}
 
-	spin_lock_irqsave(&pd_bitmap_lock, flags);
-	if (id > 0 && id < MAX_DOMAIN_ID)
-		__clear_bit(id, amd_iommu_pd_alloc_bitmap);
-	spin_unlock_irqrestore(&pd_bitmap_lock, flags);
+static void pdom_id_free(int id)
+{
+	ida_free(&pdom_ids, id);
 }
 
 static void free_gcr3_tbl_level1(u64 *tbl)
@@ -1711,7 +1704,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	domain_id_free(gcr3_info->domid);
+	pdom_id_free(gcr3_info->domid);
 
 	iommu_free_page(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1738,6 +1731,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 {
 	int levels = get_gcr3_levels(pasids);
 	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int domid;
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
@@ -1746,11 +1740,14 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	gcr3_info->domid = domain_id_alloc();
+	domid = amd_iommu_pdom_id_alloc(1, MAX_DOMAIN_ID - 1);
+	if (domid <= 0)
+		return -ENOSPC;
+	gcr3_info->domid = domid;
 
 	gcr3_info->gcr3_tbl = iommu_alloc_page_node(nid, GFP_ATOMIC);
 	if (gcr3_info->gcr3_tbl == NULL) {
-		domain_id_free(gcr3_info->domid);
+		pdom_id_free(domid);
 		return -ENOMEM;
 	}
 
@@ -2267,7 +2264,7 @@ void protection_domain_free(struct protection_domain *domain)
 		iommu_free_page(domain->iop.root);
 
 	if (domain->id)
-		domain_id_free(domain->id);
+		pdom_id_free(domain->id);
 
 	kfree(domain);
 }
@@ -2302,16 +2299,17 @@ struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable;
+	int pgtable, domid;
 	int ret;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	domain->id = domain_id_alloc();
-	if (!domain->id)
+	domid = amd_iommu_pdom_id_alloc(1, MAX_DOMAIN_ID - 1);
+	if (domid <= 0)
 		goto out_err;
+	domain->id = domid;
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
-- 
2.31.1

