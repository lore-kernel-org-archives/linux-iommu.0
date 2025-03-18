Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43078D528
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279538; cv=fail; b=OhHww16Ux988xGd40jE3Gf0eGkLPJ6TkW8q3kHXBZu3/ctyezsg4Vquky+LTDVv2LW8XbqMeOvc9LKz5proln/vcnvctBehDDFEspXMjwje9bzI9ev1CGicNiVDgmAmxhC1EZ1xl/Sdr3Bsam+BQ/xciXgWVPuU8uzqeUnDVTeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279538; c=relaxed/simple;
	bh=Ky9h83Byt5kaI8q5k4xrLIa0RSkuqwD0hF7XXqcX3yM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssJBsNlQSZsUqk1pkiavOMHnZnLtig59KJBtcZ1d05YQMl+zUu7V4ZeaIhfFOH2OFQI/MBymIocv/YtTWgkJCI/wPejuCD0E2LTqC01LeVExYTKmtR5jhaB8sxp99EGh1NJUYAmS8JCou78qZpEAlf7jNAKdSqefz87uJQdV7Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ahRPMdO4; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ahRPMdO4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2TePkVYymGvjegdhN8A+N4LWQHG7K+T8rNLNqpTpHaY6z03lw+9R95RCaEas2l1s5ztHMRl9/Xuye/BDwaBAwsixBci7AeArd3KNsAg/YNq14RYC0hjrtrQ9VMZsCm+GIdw41RGiFveWhdZifGnhO3dxrGCXIgZJByjcTayNOSpWUu2aTSXCYDOrssV6L1OJ1zgbBNJblCJmrx1Np73MO6a16GEsIFLkPSGyJgUHgS8pYUQLCPDH+o3qlsoLjhO4wkV43tzuvNCV9AnsURTAf0vNTZXXukBeK84vFxBMKIt13vPSDEweLONllNo5t7fWMHZxNkHOdecRt82zvftlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lz6jjvhT+8uxMa9tBNjZSomQTh4wXdfRF3bkQgr5/I=;
 b=COeMm+Bz5dbod4nVT9reH3sUjyEMTfmRAKbB5HIJFIapBVPJYR3N1cWASGdNCk9d5RXvehGy2BqnGzaX7qftYpuiUBhrA1r84xtFU3Fnk3i9zwh+3hc0Xsh4qRiD1WjwRXyfCOaxMrAgdEUCLu8RyqnZjltVzqQGNCwo7b1alEzDhqfviyYVavXT0kZpQKInc5fA26Pjxy6jRaQ3o+k+32ryuZ02m6CTZoa8jZiytvy3Rgh6HvrF1Cj5IGcpo2ESJZ4DjLyZfvyqOi7kzQwGEA9SM+Tp1Xfn1F5OIj4SyruCLmHuMlkzXkk22cmAQfOh3hE2HQJkjE7uunzSzjbjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lz6jjvhT+8uxMa9tBNjZSomQTh4wXdfRF3bkQgr5/I=;
 b=ahRPMdO4+2vCIWxgHYRZf/yco9kKS/NGz64NK9HXip6UC6zAcFl2JnvWKhVwPF88FEc0YrCwndsg/1oPCf6O6JgIMw194WoL8b9Syrsq+Fhpc/Zd02rJjOulfDytC9jof0pY5Zrb+UUVH3y6Ij9ctHzgSvaXygNEkSJiRt9y4TU=
Received: from PH7P221CA0087.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::23)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:32:12 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::7b) by PH7P221CA0087.outlook.office365.com
 (2603:10b6:510:328::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 06:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 06:32:11 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 01:32:08 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH v2 2/4] iommu/amd: Replace slab cache allocator with page allocator
Date: Tue, 18 Mar 2025 12:01:21 +0530
Message-ID: <20250318063123.2556-3-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 4008834c-fe32-4280-95aa-08dd65e69d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eDUhPt9/zjHVzwX+LtjWwFHtOpSv6yg4LmcjzYb5KSrNTaE4p+QFilEGWLqe?=
 =?us-ascii?Q?r4qWhkRhmm+5eZ7nIi+PWHPdWk1dUtwVWcLDWJiedKfd4/+qTp3+0cGkX2S7?=
 =?us-ascii?Q?FQYHtl1vbTbckjeoAJcUUjcJ/KinwGyvrnngNL+bxH6VSLpUVfk3whzdy5on?=
 =?us-ascii?Q?/lhakH9Z7PvdK55FLedeFdJtZNIqDJJVYVygTCQ60sF130/z8iO6KtC0ANy4?=
 =?us-ascii?Q?7A26LdOt0hlnXTrhsNUkMmQ7CuN28wpr2eKGQv8vnWGWfrN2JydGjxjK0FoM?=
 =?us-ascii?Q?1jf0BVbaNEUBxFTKN1VdqhHPoLI6u4MFLEFXAOz1z2RLvR6nXaUFLQT4CvZN?=
 =?us-ascii?Q?jaDSNz4asBffpD04UBSr3wLwK2oVfiA5z8/mTZcvrHTlnAmbiUI/VvKLdzQb?=
 =?us-ascii?Q?zgSDU9fQNyyL24l+g7U/A14j76LoCzlzngwE7ywASQE5ISMan878rXYvF8vx?=
 =?us-ascii?Q?i2hnp7VmPUszJJYcV/8PjvNWaChUaJAU/RKpp3sqtQ0H3kWj5SergmgiV9mE?=
 =?us-ascii?Q?/vJW/Y4utCw8AM/xggq73DX0MJsa7EROKrtxdWJc9BLtt2KuBStND3XX8j1V?=
 =?us-ascii?Q?/bo8hLhLZC/+ocIZ6Meplj27FK4w6gP6swcnU5DQsbSVghJmEJ5rqYJz98RG?=
 =?us-ascii?Q?H3/au6PC/DZREUpL04eMQ+t39TXyi1gCiNMO9nTRp44AV/NeJY7fI8BKT5pa?=
 =?us-ascii?Q?kIMOUqfgkTz+8hXZjgxyYQPhghZK1H6fmFHinzYDU8N+qYVeMkfqp9jJBXAm?=
 =?us-ascii?Q?8PljOa9NJEaVm1hIBaxbTylFh1ZsOLWoEkNSGgMTZyE09M0fnoYkPmaStTal?=
 =?us-ascii?Q?geXVFAtWABFjSBXDH8ce3A2h9S7F+EJoVrsFTi6tWgcBKhsuNuU0lJZCczq6?=
 =?us-ascii?Q?H7dCgdpQrH9wqgrf8qvfa3y6gXNOXTi0RcL3IFCeKGoOYFB46dAmLfJMKuIU?=
 =?us-ascii?Q?bVimt2VwP12qYciO5F1FwwDqp5TlXRVxMjOvWOUNW74Ppjo7Ry+2t+RZZISD?=
 =?us-ascii?Q?qnmhwAao3s2SPf70fY6tjthKGrQ1SuWil2segQufaUyh6sJv1iSbzGqrsuJm?=
 =?us-ascii?Q?6weM5opR14C9BJ5kKGkIXyDMHKe7CzyLmKdyPT9fCqhui20Xte6gUuEWaIok?=
 =?us-ascii?Q?+3RchK/iD333EqJVC4l9qdSMxNt8knk9BgGxRGiZ5GfmWPcq1aEtaGL0siE3?=
 =?us-ascii?Q?51cfFn1lBbnoc/TAQQmVp/pngbGlvO74QalygwWeqhmnFXjpJmomLgApmwhq?=
 =?us-ascii?Q?WsDhTKJjYDfvUti9PQRKOC8YI/nD435ylavxAo4lszVmGySl65KGkqeNVDn2?=
 =?us-ascii?Q?gYEO6n+iAJkL7LCor3TBHC/iH3DAIbUwcipCbmEranX7slZ1hFT/nrWULIQn?=
 =?us-ascii?Q?9foJAqUgd5m8g1qIJjpJIoQk1E7qQueV68j/wojbAFFjTVBkQnnk4xzMarNO?=
 =?us-ascii?Q?Hzlxy8YcFHwPXS8F6RcA2Mk6s/ayG1rqU2YfcmFT8HUkX0EvE0Ne3w7bgSa8?=
 =?us-ascii?Q?a9BkSFx6Lqi3vAs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:32:11.5625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4008834c-fe32-4280-95aa-08dd65e69d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006

Commit 05152a049444 ("iommu/amd: Add slab-cache for irq remapping tables")
introduces slab cache allocator. But slab cache allocator provides benefit
only when the allocation and deallocation of many identical objects is
frequent. The AMD IOMMU driver allocates Interrupt remapping table (IRT)
when device driver requests IRQ for the first time and never frees it.
Hence the slab allocator does not provide any benefit here.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 ----
 drivers/iommu/amd/init.c            | 21 +--------------------
 drivers/iommu/amd/iommu.c           | 26 ++++++++++++++------------
 3 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index dcc6fbfa62e2..a1e2b8317d11 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -313,7 +313,6 @@
  * AMD IOMMU hardware only support 512 IRTEs despite
  * the architectural limitation of 2048 entries.
  */
-#define DTE_INTTAB_ALIGNMENT    128
 #define DTE_INTTABLEN_VALUE     9ULL
 #define DTE_INTTABLEN           (DTE_INTTABLEN_VALUE << 1)
 #define DTE_INTTABLEN_MASK      (0xfULL << 1)
@@ -492,9 +491,6 @@ extern const struct iommu_ops amd_iommu_ops;
 /* IVRS indicates that pre-boot remapping was enabled */
 extern bool amdr_ivrs_remap_support;
 
-/* kmem_cache to get tables with 128 byte alignement */
-extern struct kmem_cache *amd_iommu_irq_cache;
-
 #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
 #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
 #define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index eaea9dc8af9d..0fbe92a0b48a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -12,7 +12,6 @@
 #include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
-#include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
@@ -2932,9 +2931,6 @@ static struct syscore_ops amd_iommu_syscore_ops = {
 
 static void __init free_iommu_resources(void)
 {
-	kmem_cache_destroy(amd_iommu_irq_cache);
-	amd_iommu_irq_cache = NULL;
-
 	free_iommu_all();
 	free_pci_segments();
 }
@@ -3033,7 +3029,7 @@ static void __init ivinfo_init(void *ivrs)
 static int __init early_amd_iommu_init(void)
 {
 	struct acpi_table_header *ivrs_base;
-	int remap_cache_sz, ret;
+	int ret;
 	acpi_status status;
 
 	if (!amd_iommu_detected)
@@ -3095,22 +3091,7 @@ static int __init early_amd_iommu_init(void)
 
 	if (amd_iommu_irq_remap) {
 		struct amd_iommu_pci_seg *pci_seg;
-		/*
-		 * Interrupt remapping enabled, create kmem_cache for the
-		 * remapping tables.
-		 */
 		ret = -ENOMEM;
-		if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
-			remap_cache_sz = MAX_IRQS_PER_TABLE * sizeof(u32);
-		else
-			remap_cache_sz = MAX_IRQS_PER_TABLE * (sizeof(u64) * 2);
-		amd_iommu_irq_cache = kmem_cache_create("irq_remap_cache",
-							remap_cache_sz,
-							DTE_INTTAB_ALIGNMENT,
-							0, NULL);
-		if (!amd_iommu_irq_cache)
-			goto out;
-
 		for_each_pci_segment(pci_seg) {
 			if (alloc_irq_lookup_table(pci_seg))
 				goto out;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd5116d8c3b2..0960b95656e6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -75,8 +75,6 @@ struct iommu_cmd {
  */
 DEFINE_IDA(pdom_ids);
 
-struct kmem_cache *amd_iommu_irq_cache;
-
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev);
 
@@ -3121,7 +3119,7 @@ static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
 	return table;
 }
 
-static struct irq_remap_table *__alloc_irq_table(void)
+static struct irq_remap_table *__alloc_irq_table(int nid, int order)
 {
 	struct irq_remap_table *table;
 
@@ -3129,19 +3127,13 @@ static struct irq_remap_table *__alloc_irq_table(void)
 	if (!table)
 		return NULL;
 
-	table->table = kmem_cache_alloc(amd_iommu_irq_cache, GFP_KERNEL);
+	table->table = iommu_alloc_pages_node(nid, GFP_KERNEL, order);
 	if (!table->table) {
 		kfree(table);
 		return NULL;
 	}
 	raw_spin_lock_init(&table->lock);
 
-	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
-		memset(table->table, 0,
-		       MAX_IRQS_PER_TABLE * sizeof(u32));
-	else
-		memset(table->table, 0,
-		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
 	return table;
 }
 
@@ -3173,6 +3165,14 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 	return 0;
 }
 
+static inline size_t get_irq_table_size(unsigned int max_irqs)
+{
+	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
+		return max_irqs * sizeof(u32);
+
+	return max_irqs * (sizeof(u64) * 2);
+}
+
 static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 					       u16 devid, struct pci_dev *pdev)
 {
@@ -3180,6 +3180,8 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	struct irq_remap_table *new_table = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	unsigned long flags;
+	int order = get_order(get_irq_table_size(MAX_IRQS_PER_TABLE));
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
 	spin_lock_irqsave(&iommu_table_lock, flags);
@@ -3198,7 +3200,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	/* Nothing there yet, allocate new irq remapping table */
-	new_table = __alloc_irq_table();
+	new_table = __alloc_irq_table(nid, order);
 	if (!new_table)
 		return NULL;
 
@@ -3233,7 +3235,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	if (new_table) {
-		kmem_cache_free(amd_iommu_irq_cache, new_table->table);
+		iommu_free_pages(new_table->table, order);
 		kfree(new_table);
 	}
 	return table;
-- 
2.34.1

