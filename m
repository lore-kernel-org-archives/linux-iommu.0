Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C317B421
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951534; cv=fail; b=Tiwz8C+r0L/FRXP18oZEYS5j/IsnWLf4nKAIx+DCJMAXq5c3AVLQfRQ7N0Atn9uY38+qdCrfINgwcL6+bapu8ULqau7rvKjtANFO1Lj/TdH5YvOenmLKZ6ZJYXTZjuQax/Xpb6s4xKbpgvGVna/F5JHr5G0Xbg3hILt1lrhdpa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951534; c=relaxed/simple;
	bh=4gC+u9XpA/7Uz5MDzGOGTYk1wOOhizhh9h+L5Oo7dvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYEDl9TjOPmTwTaHuAhB0zesrlGrRrDQ7ycisR667AalEf/eqoyuIxCiprrrI1uHHWuKvri7//FI6BWvGrD5zm8zlhBKN+8f/keyRAtJ9LuWbsTqbThFtP7A5Wd4wcXmc/dYHaUWO5PsV+LHOBj4t5IKWxcLky9lcg08aLUTpSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J9I+XGDF; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J9I+XGDF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAUqqtWyDguPoQMKuqAVRNNvV3HZ59ADP6QVWdxJ1mFzX94/jP3V4CU+deq1ByDuLYagMwzq57nl7f7Dm89LfD5jXWaVp1PgWjFi+J0SZDUezyO712bE+dX3UNnCw+95tIUc0qTJO8M2THC65q5Yq7gwh0Eou4XkW8+gLQFr5EArXy8jArhEXa3KyWcuUKfVXe55GS67DegkwcyujAl0vYUg7IFXnpVaYz3D5Nah/3k8Q/mwctKDV3neroej3KU3CE5uhju+yp/lCXTyqX3W6VrcPu4b230T0ELNPPEmesuMd80pvfk6iUYVGJIgJkJIurxfn+0uLU2CmzYWEbwRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/9KVGmojtSy3sO7qga6GL3T6ZEQTS/HDgfXbhRuVWs=;
 b=vcff5GZkUJlMcDaWXxGBQiJJzeIhuOSpiyMbm5mPQb4Kl5BRXlJVR3wNbcYElATpvy6K+rd4m++DTLKHk/11uT+l0dleJ7z+hzjY88NUPZagVDF3Ya8NrVlRnz9z9kujJ8uVNeOfNZbR5oN+Rl8IstKTcoeB0M6Q6Y0VHUqdg+E4YtDwRl7pyJx70jC34wpy2j0K7wp0+I4bWFKvLlbqQr+UuCyPeqO8FfsxfFq57NctHrWkyBP0aED+GZRWxphRx18ovFDEvwlhTtQV+gclv26JRJ3jv2l7VHq3C9UEm2CsD/82bzFPeNFRQgDbN2D04q7lg/n/zZXDs1jLcKOkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/9KVGmojtSy3sO7qga6GL3T6ZEQTS/HDgfXbhRuVWs=;
 b=J9I+XGDFwfV4eE0miUY46sQysbobBA0gwTBOxMtf4l/oGGPvby0bvtpr09SzFIrRvr5HtFBrm4FdJp0b16kzRoV892L1KSnKW6nnB/firCvqbqmRGypgnsWBiQZOwQA9SCqz8ipIu+N/TbGwohN0pvVujpoT3uXqKbMfGEN9Jwc=
Received: from BN1PR10CA0016.namprd10.prod.outlook.com (2603:10b6:408:e0::21)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 06:58:46 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::5a) by BN1PR10CA0016.outlook.office365.com
 (2603:10b6:408:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 06:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 06:58:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 01:58:43 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 01/10] iommu/amd: Use ida interface to manage protection domain ID
Date: Tue, 10 Sep 2024 06:58:03 +0000
Message-ID: <20240910065812.6091-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: b05dc367-c179-4973-a303-08dcd166043d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pat3hqI9QS4r2aqdEMd10QcbCDCsG7wq5amrcUqYYxb0ya7RKOdLE6wLMw5L?=
 =?us-ascii?Q?iKlq+/3KxoOBtpBmG28zhAmWeA1GG+RGpX38JK2vUbevDdtGhC9DNExA3nOk?=
 =?us-ascii?Q?AwT6ibPaEYcQQxmfaUikfc6sg/FZpXtZee821Z2FI9ijZNcukqp/VB5gxPpz?=
 =?us-ascii?Q?fpiZz19YjNasmpCrUCEzfefT6QX1Ya/JK0hsfIgcHZogn5xXghvAb9KOA22C?=
 =?us-ascii?Q?XzCuaNudUz7EmECjupsHpIMGlU53UKejc515dYetb+bJF6jMG2fb/h8EyLLB?=
 =?us-ascii?Q?MaQ+e6+HX3xWw387aqb6XG8gUGFAlJRNaSqAkV4zLn0fe35biRpriXN9kFYr?=
 =?us-ascii?Q?eINLNhMWlxNG3Onig34dA1Ld1JRZ1W+B8nQi9IW2/GMBAbBHs37XaUaPSyCv?=
 =?us-ascii?Q?nzgr9GKtipFrCq1/93ZeBb4NHrAttckYzQHxoeX3MNjfm7rh8D5I1IpOfd/0?=
 =?us-ascii?Q?LX4UlIcO1CvTFfOFywQsvJ0BpX3JHLw0PFrxQECen8+sti9lfdDZwLO7MbNV?=
 =?us-ascii?Q?tKjhdTdaengsrvUjazTPXHvF2wBhr7k1/hWTwk4QNHZutKsz8+OEhKHVd6Hj?=
 =?us-ascii?Q?HOYyd81OXbOs+tQpp+nulx3vSIKJyf6sJhTyhnZSb9zLO9nMAXd3r7CFzlQR?=
 =?us-ascii?Q?kNWeVZkEmPvaA3Mp0D3Jw9VhKFrD9mSaHLS0bfRKUKiyA0CfO2hyllmQNlEi?=
 =?us-ascii?Q?t/w+d7IOAuCRkn2eMVbmO44Z5HQlsEbmbj2o5DNuwtzeve6uvztA3Fs94Ocj?=
 =?us-ascii?Q?QZXWV56yLcJPoV2wYZ3fqxQjBFQryYlg/Yj7+sRqY6TOXOeaJ1NbWjfNS+eg?=
 =?us-ascii?Q?E4w066phewKUqca04KzxAeeB9R5lMia/YU0HuuXl/1dxmvjDTbhEtu8Xoh/I?=
 =?us-ascii?Q?QKBH32mVBquTLTr26BmjzXSecS10KXhjfzq26GqpzMwyg7i7CKzpevwhPfoZ?=
 =?us-ascii?Q?0g8sJnlBGBrSsHKoYyFDQL2d9OMjgKrdilNcBET2pLoQH47u8eqaW+yfHJkm?=
 =?us-ascii?Q?GnrCVWDXY1dZ5DiDey4L3RdVs1GWUaU5LICwkyZtiTkPlkOWgLDh7EAvynLJ?=
 =?us-ascii?Q?vb3O7nApt46DvEi5i0FCP2KHChXA2Q7T+jnaj+kP1Asi5R+idwbiv3VqAPH+?=
 =?us-ascii?Q?sl6ipHshPIH5a840p+/xV+1oVWlmaNPBAt0Nb110Oml/q4iMbtK73SSQwvYU?=
 =?us-ascii?Q?vFFhZ5FxWaKwD1IiU+/cf+yZbRpudqLdjRpJDNv2gVTdWVjuWzp9alE3X4AT?=
 =?us-ascii?Q?QzxXJaN3gCqnnGZTTxpLNdxF0TyGoAGbT/RRiGQIsgfKT0F3xW7/eq7+D8Gk?=
 =?us-ascii?Q?y7wB0UHKzPzLbjz0L1r3zGhjpwJp4ICqA8BhYsL+FjkjflBOXxJXgW5F3dwz?=
 =?us-ascii?Q?0C0wDhTCBjcUYKnvRuw5wbQer59gqKqDEVyeE7GGOzS8ftfuEWaezLDehhLq?=
 =?us-ascii?Q?Ts/lRJFEd5uFmmvDepYhuzuipt1dYPJR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:58:46.6847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05dc367-c179-4973-a303-08dcd166043d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

Replace custom domain ID allocator with IDA interface.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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
index 154f90e7b98e..fc1969011ff9 100644
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

