Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298863CB
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270564; cv=fail; b=gywuIOr+FRD7pcTG6wp9rMNGjKw0FMMim9zs+6EJZniitIP6iV9RBHWUPhwhiz/r4mR0j1vdL3pi95cp8gwys7rc9N5Qq3Tmys3A/rjmPdotA6Ein0MKAxOFbLg3EvK55XRm1hmZ95VXK64KfHLxzmp5X8QueTLVOU/QFbXrljk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270564; c=relaxed/simple;
	bh=wsk5ezih8eVJImb07ygNOJB7K2XhxJbZhDGb9K0FaL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Unqxm/Qic1q3MEtI9SI6gQGWDoU6eKFQ3PQbdWDzWC1XyCbr31o0sYI56nNf84sS9CO0PCMPqwAA6WJwbCAk42Uk9mUUR9xS+48kffzpDsOxPTUWjE6XyzGEmhIu63+rOQDW2zbrEm3ZtxZFX+dO7ZORCqVWRGHNSvaToUv7Bq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SRWXM7vO; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SRWXM7vO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWKvLx6r6tcYU9wEMQwp0IVS1+CiGUvynKPSpBmCfjqEBv7H+UkiriejXlbTkpPWUMO89ms+rJW4k5AsqpatAqLpzComUYZOu21gGNE19qZ5unsjKrG7zDbataRB55ftBoX5PxvG27Fg3w07jvDzVvua3pzWEjn0SxdU12Nk3qfA9BJoaQEJ6Cq+8kgBMQNIPtaZ8ypBNNH0EzZ2CcyHuqZHh5cmr8iZnt9zJDkFjtN/OONPDmgKmzaIS56CiSqueEfikX/iczI9r6A2zidUTRx0olVKzIW6P4lp49/3JFJq48VrEd7mjybuzH2V53dW84UMDcOtS8Nl+hIOD3H+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tohOmhCxOsKEE+pfgLUoN87TDp9T5zMwwJM4k0TJYHw=;
 b=NZ747xE4AVF29CtHcrlnDtiTtTEs8o+auF8tHjstLozdW/mTjWYy7t/U6FM8IRz4KOlK1O7KZFqYNWYzDo05Dx7ODsQ9IUtsuI0mmNH0xg/YhY81N1c9eX2yTL2i0wJdAYbjA6eGDIA/f46OvuZl0dJFkUm851NPyw8yVKgKPoaftbqnezH6XtDfhrpqqpsCudr4RmZylhobn7hGvrmhneJRz78olKNhBCW4MvMtoeWGP/WojmfFtBjFiG7/GgJ4ne4UPz5YKO5Qu/KsCnOOaCJ85Raa3KPgvl6ag/kHk6ncXYyNpg1jc+oJsh0IToltMWZdj2ke3F0GWVnwVJ8nSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tohOmhCxOsKEE+pfgLUoN87TDp9T5zMwwJM4k0TJYHw=;
 b=SRWXM7vOY1M3mKoKi3OsTWxC8OOEvePHhHmjnLWCKcQ1o1sNa0VFow4x7dTgFGUhKGRldUTXMsb+BwvocppSc2/2hCNDFWlscrUg0Zy1rSMU9o4mZWTD7PwuxVRpRpTqNz1QxHV9vMS8DncFvGnEpxsVtrvS0OJUyHlQR01B7TY=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 06:42:34 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::22) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 06:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:42:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:40:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 02/12] iommu/amd: Use ida interface to manage protection domain ID
Date: Wed, 30 Oct 2024 06:35:46 +0000
Message-ID: <20241030063556.6104-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 203d1cca-bd14-40d1-2b5e-08dcf8ae097b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wp13oCmAzEyIk1OG89+J5lUVyn9MEsYX6l9za/57SUrSfEj2zk4zwAsmRVAy?=
 =?us-ascii?Q?fQ3wqO8A/QJF+v8/VD271Wf/DC9/f5IVEVIJmZY0gthgq5y+GHPuo0SD87tN?=
 =?us-ascii?Q?jFfV7jW6zS/FDB8kIkrV416fmltL/2IAUwpFrIP4ajCR1aq+7M5SROPrv5iy?=
 =?us-ascii?Q?vQd0buIuCRyxYUcEbvHs1CVZFaJS3NeXe6GVKZJshaNWtnQahcNMoyYpZc6e?=
 =?us-ascii?Q?tyxe3CKuYUjOLR+pPkNRx9RWtMJnbOBFyvt7cyx4njFC8BDGgFU03w0+0Z6J?=
 =?us-ascii?Q?/1YQ+2SVHW3BI/o4uS8Xm+Z643xio2ggSOYMeybcH1NAJysKyTpzevE4nx7p?=
 =?us-ascii?Q?8dxZHET1tzQODZ7/e0K4MbElcrHdqo8t/M+xSLLMxL9u5QZ4++YHcCQVkeWc?=
 =?us-ascii?Q?d5GSa2HfQx4DKrHY//sDNUr7+SImxzPqj4Qv5/1X/Od0UnMI7MmrquWWtwdu?=
 =?us-ascii?Q?AZZdwLkdD4QD5Y9QFA1vfLzugXEuyi2d3TVRKHIp70IL9Z7yBODNf1JPLryv?=
 =?us-ascii?Q?S+tA6ZBHoAQ8P00gK20OUoHxoIoXPtQNeg436ycHVBYu1uMx0DxH6oDoRInM?=
 =?us-ascii?Q?m1zC2nzVA6Ly6lzsmqmKfhP/FF/cXQOcbkOU7FUdcw6ET01LL9ChoWyEhZYm?=
 =?us-ascii?Q?xEGMBRD2YmVGAKMOEzOBInH5u6ZSprnl84TYJSmgBxXZpRzgnFFeN+/uUYRS?=
 =?us-ascii?Q?fCdzCNrANV/HhgUPowUD6jAMr3rgCkfFK1G8vMzZ23TmBAxqOZFHZ3Bf2L1R?=
 =?us-ascii?Q?GqseHI/Ld65YNutJNopTRDwHsokAJqvE8ZmQsetZ13qB+C1Q+zElsRbnOfW4?=
 =?us-ascii?Q?okAAQ5fqob2vlQVfjIn+2np5IuRsP54kIChibksRpDYwgRtlIs3lkaDDUFFN?=
 =?us-ascii?Q?hTaFdZrpdLNc2HDPYc6OisRBmBJbCvphk4KeL5Y0azcErwcZYW9e3Rq4HFXj?=
 =?us-ascii?Q?uhPcQhX6vJv8UE39ZEJbybBjeXZndLl4IjDIKBtHeA+P1yWiQB6BESa/PmRw?=
 =?us-ascii?Q?wrYNDq8+bYW3HHuLJVSXOHlGfil34EzMk9sOhpqdgJVzw2k6I4TuD0aw0giV?=
 =?us-ascii?Q?QgsCRI5CrvHzwPNfrwZsQB6fAPoJk61zMtzelcUA+JCnUS8dVk0DpaU+D77Y?=
 =?us-ascii?Q?mCc6SXsTgvxB++gEP4KT72nQBU///htJWFk9diKSNMPAHCr595oFGpq6Mh7R?=
 =?us-ascii?Q?V/w35z4JbDy3IfXH8Ii3zdJ3m+6BuPerJWHRiEhfcGVWSfnfZKovz4L3L3i9?=
 =?us-ascii?Q?CfHkE2RO5ml2HE3QYRnLi9xjmhOHOH9e09szEVyI70kpznib/Lx0/xGNYmGI?=
 =?us-ascii?Q?usl34PZjjA8p/NDLC3Izwl51fJNUaY0DVL3leZp+ya9da9F1HIFDFBegBg/U?=
 =?us-ascii?Q?UVka6Zw1w7mLkMkC1h0JN7KvUhH9/9U82kuvJt7l5P+ERTCIIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:42:34.4332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 203d1cca-bd14-40d1-2b5e-08dcf8ae097b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

Replace custom domain ID allocator with IDA interface.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++--
 drivers/iommu/amd/init.c            | 31 ++++------------
 drivers/iommu/amd/iommu.c           | 56 +++++++++++++----------------
 3 files changed, 35 insertions(+), 58 deletions(-)

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
index 45fdba48d54d..f01edc7a8d46 100644
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
@@ -2989,9 +2988,7 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	iommu_free_pages(amd_iommu_pd_alloc_bitmap,
-			 get_order(MAX_DOMAIN_ID / 8));
-	amd_iommu_pd_alloc_bitmap = NULL;
+	ida_destroy(&pdom_ids);
 
 	free_unity_maps();
 }
@@ -3059,20 +3056,6 @@ static int __init early_amd_iommu_init(void)
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
index 477aaf76b7ad..1e4f678a2cac 100644
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
@@ -1643,31 +1648,14 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  *
  ****************************************************************************/
 
-static u16 domain_id_alloc(void)
+static int pdom_id_alloc(void)
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
@@ -1712,7 +1700,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	domain_id_free(gcr3_info->domid);
+	pdom_id_free(gcr3_info->domid);
 
 	iommu_free_page(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1739,6 +1727,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 {
 	int levels = get_gcr3_levels(pasids);
 	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int domid;
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
@@ -1747,11 +1736,14 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	gcr3_info->domid = domain_id_alloc();
+	domid = pdom_id_alloc();
+	if (domid <= 0)
+		return -ENOSPC;
+	gcr3_info->domid = domid;
 
 	gcr3_info->gcr3_tbl = iommu_alloc_page_node(nid, GFP_ATOMIC);
 	if (gcr3_info->gcr3_tbl == NULL) {
-		domain_id_free(gcr3_info->domid);
+		pdom_id_free(domid);
 		return -ENOMEM;
 	}
 
@@ -2262,7 +2254,7 @@ void protection_domain_free(struct protection_domain *domain)
 	WARN_ON(!list_empty(&domain->dev_list));
 	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
 		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
-	domain_id_free(domain->id);
+	pdom_id_free(domain->id);
 	kfree(domain);
 }
 
@@ -2277,16 +2269,18 @@ static void protection_domain_init(struct protection_domain *domain, int nid)
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 {
 	struct protection_domain *domain;
+	int domid;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	domain->id = domain_id_alloc();
-	if (!domain->id) {
+	domid = pdom_id_alloc();
+	if (domid <= 0) {
 		kfree(domain);
 		return NULL;
 	}
+	domain->id = domid;
 
 	protection_domain_init(domain, nid);
 
@@ -2361,7 +2355,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 
 	ret = pdom_setup_pgtable(domain, type, pgtable);
 	if (ret) {
-		domain_id_free(domain->id);
+		pdom_id_free(domain->id);
 		kfree(domain);
 		return ERR_PTR(ret);
 	}
@@ -2493,7 +2487,7 @@ void amd_iommu_init_identity_domain(void)
 	domain->ops = &identity_domain_ops;
 	domain->owner = &amd_iommu_ops;
 
-	identity_domain.id = domain_id_alloc();
+	identity_domain.id = pdom_id_alloc();
 
 	protection_domain_init(&identity_domain, NUMA_NO_NODE);
 }
-- 
2.31.1

