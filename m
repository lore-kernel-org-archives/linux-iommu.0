Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68B5221
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056991; cv=fail; b=hzeQxTK553GsVOY/QFmXu2lvQ5gKP1NNFidD0SILFy/FmWhZkhfaEWFJ92iazMl7EmyulGuiZAzTpjjxKl5fsfIxzGUz4YuWwpectHXwkoXjyke43dhzWVcRlXrwns2jil/W8xZHwWh3syoETFMXT2P6ba5cm+rLK1o3VSpPd54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056991; c=relaxed/simple;
	bh=qu0DUPvyhNRJYbiPjr8U9AwIqp9dE2Ao56IejIJ8uZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/13Uu4l7zcZoFzBoya/4H9nvlp9jeWGvvB/L107v+vaVWWBsOxXQZ/7gn7KZZr91nFKlh95AlcMSn2Evyt545qlloILNZM0C9ovlX45pqaLTkFxmENdUKcquJGidC2d7UPG5fI8zy41XoJgviSgAaELPwOhkNUCJNxPvyNV30U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TPvv/kdw; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TPvv/kdw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieY1GMhmUUyp69Ya4YCllO+ebLPE/zoMM8ICcjRmzHkFJNb7ZQBkjb3l+VaCL+C1BzZgj3A3oJ0MAZf4kXOANT1KH1jn2/wVvOl27VB1ljrU13GsvIWdf81GAAgfiLa/ICEr6wZir/KpisbYZSIfZMgVqF00IXYeSAVgGxKJkZMHHxX41g+k/RnpOpHHWdO5DtuY99PxF54L5CvjpTlBsaDzIoEICs4uhM3mhB61UXgqUs57YVmhdAyedbNQI2UIV3yLkqaFiYYMBnpwHuZPoeKbcYsz+4UIjVfy5+eD+wrBuyFSB/FcqXU9GFENiX1ikT0PNm+S42FNDJ/sX64NxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxBLByno7BXOY2RUyDid1HG7RtQUhZ/endPwDC4JaB4=;
 b=K4HdBF4sX2UNl4EX9gqAKfIUWczvSfRKrBJlJQ/GKjcuNnyC95Bp52Xq/CFfr6mTWCG9zlfIC7lNqzVNMmWHerFyB6bkOzpX1MZRuArIdlHpZsMYaDO+oqW/qjmjxcmvk9PMN6R1S7v+ZbuhrKfs2U3tIOIuumCs3pHqRTKK0H4wrSwZB5Kb/8Ifa4q6axUkc8FcOPTVhNHb3rg/NcPTtyvln9ORTTM5xZVWnle5j3gYIsf54x7g5m5CdNi1UTiLS+VBaW0OlKzzmA6r5jcT+o/WSU8h+YkdZsXxpuFDSncRQofjTsLbxaQ/Kw+FW5JCQ6rTOKPTu9ro0El+P816Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxBLByno7BXOY2RUyDid1HG7RtQUhZ/endPwDC4JaB4=;
 b=TPvv/kdwKtIK3VLp09pkXsHOLKQJ5IQic8QitEn1LoveArqt/2LOIaocwmz4S7fOsxeVbZOaHiIHqPdLJnGIrgrvESp5x0ZmkD/gqq9Uuaq7Ukwc8Elwz88JP3gDTKKqLIh1TriRxeF3+0r6KNEUci6eP2E5g15S2m11H3LnL7k=
Received: from BN8PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:60::41)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:36:21 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::ba) by BN8PR12CA0028.outlook.office365.com
 (2603:10b6:408:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 05:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:36:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:36:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 01/10] iommu/amd: Use ida interface to manage protection domain ID
Date: Wed, 16 Oct 2024 05:34:52 +0000
Message-ID: <20241016053501.97497-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b5105e-99bb-4514-6f56-08dceda4776a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?twrgSBFiVaFRi5wANg5ejzOpsytW3c6o+cN7YvWnjnCYBrXlR/40q4IuWHEv?=
 =?us-ascii?Q?N8N4Gkppwh79/cu4U2pm7VKEQgPnRw0VgaPn6iuOrjzgJW9sNfXrKdn8Be0l?=
 =?us-ascii?Q?Js1XpVbmOLDV8oLhijA7nbBzRwpWrybukr1L1loCRmrrkP6Nkpfvobdu9YMe?=
 =?us-ascii?Q?+AU3XoWue3EDZJVWKFnD06P7MFQG/qzzNux5uJWo0JJYVXiHIno3KvOrteiU?=
 =?us-ascii?Q?TY3I2T2dHIlDPZteBavG9/+VJOtuFCb6Xsnm8vSWIDDiWyhe4WX5KB5ICJex?=
 =?us-ascii?Q?M2gD3ZSguSLC7/7Zve1rZ7P6bq0eR/MkYqYGDk6ojLtDE096z1numsVIC2GD?=
 =?us-ascii?Q?oiSI2YYH1Z2aeBzFSnwfBCtpJLSXGjHhb24xIvO2/b/NENelWDcBfrJcZMl5?=
 =?us-ascii?Q?ISCsyJMycZcaz1U9B11b3GFfMM/8lPewVwamSBAD7GA/XdLhpI4w5gymOb0V?=
 =?us-ascii?Q?vrAPYw2dW4ohBzA2YASLYOHz3K4W/VJ5lIWpXJ1srXULuGCXIA7NW8RafwY7?=
 =?us-ascii?Q?a5KHftTuU2qYScBZO4ksBkmMULD4GQ5mD2rRrJm4m5kaYSWPAVVB/zhUeAYS?=
 =?us-ascii?Q?E9DbHJO+gbfHVnFDbdNktTWW4a/pODvs4t3VWd7F4BcQz4ZLYQdWmg8P8iWu?=
 =?us-ascii?Q?IurZc0DyDH1KDSJhvm7W+aIEKAE3cLzEoCXfkz1M1rObdMx3BvwfuB3gqsP9?=
 =?us-ascii?Q?ySyRhCkaKMSSbXW4+fHOJc4UfyeTBCCSLe24isIso05DdTlba5YkIYdM5ulk?=
 =?us-ascii?Q?kUjHyRmt/J3hM69qXrZYhRkPFQl0+lphfjM2Ddp6vdXa4+jPjD0m3anb0jG5?=
 =?us-ascii?Q?bNSOVQr/O+ogo/vyQnHSy7zKcTRJARpHWbEIa1DWuiumB/LKa9/QItgqe+Ut?=
 =?us-ascii?Q?HTUandJzaDSC1IgD39QLFqVdZXsOuKySxpRhN5+bNIfN+YE/eHuZc025ue+d?=
 =?us-ascii?Q?4hKefAWY1h9Ocsm/xci5qy5YJhV3aUsgudKhQhR7gQXIUa+4H8ylb90OJvkJ?=
 =?us-ascii?Q?QGlUIPcWYdd11FRzLDIYBR3LVuezEvM+4Z5eEicWGZMbgZHSlePGDZelXGqy?=
 =?us-ascii?Q?f5P9Hr3HmLLpupS53y1kGC8GY2Kdi5zHE+8Dt03h74xLTyGjhPCoLyPzHn54?=
 =?us-ascii?Q?xrhIOOyrSS87mzR6Z5paiNfPhv3lkukTika2Rjnd6z0/Uv7XOqMFrwpIfzli?=
 =?us-ascii?Q?tBwEObwbOapGDPjf9Agjt9mLbGaJ2qThxOhz5q5eUidc2DnxD6sMcwlkJv4H?=
 =?us-ascii?Q?86+LYEHPO1Thc3W3gmUAuwPDrhwrhGaP7pIACd2xNXsvR/KKK6qL4xZ6EvZj?=
 =?us-ascii?Q?05G8xCXKxf8dJRzF/Ys2kEOldqUUXfQ7vjvNs6LERBtadPHudvOrFDw6CUyi?=
 =?us-ascii?Q?1dqQGgf14Cobf5y7rK1b5xrlDjMp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:36:21.2870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b5105e-99bb-4514-6f56-08dceda4776a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211

Replace custom domain ID allocator with IDA interface.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +
 drivers/iommu/amd/amd_iommu_types.h |  3 --
 drivers/iommu/amd/init.c            | 29 +++++----------
 drivers/iommu/amd/iommu.c           | 58 ++++++++++++++---------------
 4 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..6f28f435ed62 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,6 +46,8 @@ extern int amd_iommu_gpt_level;
 extern unsigned long amd_iommu_pgsize_bitmap;
 
 /* Protection domain ops */
+int amd_iommu_pdom_id_alloc(int min, int max);
+void amd_iommu_pdom_id_destroy(void);
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid);
 void protection_domain_free(struct protection_domain *domain);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 601fb4ee6900..d32a86434de3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -912,9 +912,6 @@ struct unity_map_entry {
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
-/* allocation bitmap for domain ids */
-extern unsigned long *amd_iommu_pd_alloc_bitmap;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 43131c3a2172..a1156d928bc4 100644
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
@@ -1082,7 +1076,11 @@ static bool __copy_device_table(struct amd_iommu *iommu)
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
@@ -2994,9 +2992,7 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	iommu_free_pages(amd_iommu_pd_alloc_bitmap,
-			 get_order(MAX_DOMAIN_ID / 8));
-	amd_iommu_pd_alloc_bitmap = NULL;
+	amd_iommu_pdom_id_destroy();
 
 	free_unity_maps();
 }
@@ -3064,19 +3060,14 @@ static int __init early_amd_iommu_init(void)
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
index 8364cd6fa47d..3a8a77bcd2c1 100644
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
+static DEFINE_IDA(pdom_ids);
+
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
@@ -1640,31 +1645,19 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
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
@@ -1709,7 +1702,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	domain_id_free(gcr3_info->domid);
+	pdom_id_free(gcr3_info->domid);
 
 	iommu_free_page(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1736,6 +1729,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 {
 	int levels = get_gcr3_levels(pasids);
 	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int domid;
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
@@ -1744,11 +1738,14 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
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
 
@@ -2259,7 +2256,7 @@ void protection_domain_free(struct protection_domain *domain)
 	WARN_ON(!list_empty(&domain->dev_list));
 	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
 		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
-	domain_id_free(domain->id);
+	pdom_id_free(domain->id);
 	kfree(domain);
 }
 
@@ -2267,15 +2264,16 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
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
+	domid = amd_iommu_pdom_id_alloc(1, MAX_DOMAIN_ID - 1);
+	if (domid <= 0)
 		goto err_free;
+	domain->id = domid;
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
@@ -2319,7 +2317,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 
 	return domain;
 err_id:
-	domain_id_free(domain->id);
+	pdom_id_free(domain->id);
 err_free:
 	kfree(domain);
 	return NULL;
-- 
2.31.1

