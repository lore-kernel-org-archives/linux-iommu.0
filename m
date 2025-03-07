Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3520C48B
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341563; cv=fail; b=tIyfstaGarSUMi1Fec0Xv7eyQE/rfLi/iiOVIFQpxC1WvE+M6rW73HPFLHyPs7kf57OruQqiGvf1tO47/yTgUlgkyBkZQ8leF6LdAnLj3JKIY2qQWyjStCuWgkshlJMHrOmmVr1cPBNi36NKXziZlOJ5JmsvaoShUkTDy/wcB9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341563; c=relaxed/simple;
	bh=Ky9h83Byt5kaI8q5k4xrLIa0RSkuqwD0hF7XXqcX3yM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6S9mspDb2wfTOKDaghJ1dOAtg6FCNeLWfbfYQ0JHPEm1OcgC629gjx0JcJ873qgZWSVKOKvcf6mRQ9nfLaSiKz/d5gHd7nNzmPPZDxtXvTkrjYDplxF1EaoNfB8X7309mkgnQHDxIouqfqFQzFV9J6QXLzvenCYAmhjaqxAf2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oTYKM7HJ; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oTYKM7HJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AW+TKIxP0ISllc1M0oXVkACyc6xC7JY8kfvogx83CcFFCfsn02X0Qd2dkvnId/AGZudg44ZTrLxCQ2KD6QsQ4NbrOhSskFvpmYzwHbfaRzc32sdYmU1YReF/DkKfzGAxpQyew1a7nF5nevzLErKq5IzbM0Prbm5NYVra4b4XQ7txbyg39jmmiBRiYhwX/RQ7IcikeMGUbuGzrgjFUD6bp7XkN5s/WWDQXaMBXR4W1jliZQshYJENIddNuvgOBXH8ZVQvQveFAJ5Ewbz32tQxjNpAQeI5SOqlFyys2Q5ltBGy/DcQLHGfVm/ETZT6knb7fsP5dC0NuKhj1ecFWnUKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lz6jjvhT+8uxMa9tBNjZSomQTh4wXdfRF3bkQgr5/I=;
 b=OqM6JkUFPJBBvd0PerE53C39hiqrXyLx2wbfu+Q+yZ4xPlQA4dWsGf51c6C3JvsapDj5dx/SzWl/50Y5ffP57FQpYvfwFLGDnhposB53fnulVCgZAYSH/l6nEf1DrYyqn4kSQUt0xtAzqiu8SUfD8x8I2z1+/WJFr2qCTuNRJGAsmoQhWbznb6uTMAfuFvCWbpbEAel7C23Lyb/DIjVJbG5AG2v1iX6G1OCjIWdKykRSigsk4EKTMe8+bq1AzWxRvwZAhecGPTtMWyF72OTMUEfj79S+8rRTnFDmBiFiSpRkRGgho5YQoQFHrK479XX9xgWWOTJi5oi3wfhaRxyYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lz6jjvhT+8uxMa9tBNjZSomQTh4wXdfRF3bkQgr5/I=;
 b=oTYKM7HJ68HREKiSRNogk+B15M0zGGfLv5j5GfG2h7oRXbjLBDejXy9vCwUBYhzzztqdxonse90HJ/76YiPQoksDWohzqm2I82Le4r6oPplbeh2RzbofFobvxEqahz0jX42lXuWuJi80cj2BU6k4+U1Gz4iG6sgU5PCwK7ccMjU=
Received: from SJ0PR13CA0093.namprd13.prod.outlook.com (2603:10b6:a03:2c5::8)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 09:59:17 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::53) by SJ0PR13CA0093.outlook.office365.com
 (2603:10b6:a03:2c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Fri,
 7 Mar 2025 09:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 09:59:17 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 03:59:13 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH 2/4] iommu/amd: Replace slab cache allocator with page allocator
Date: Fri, 7 Mar 2025 15:28:20 +0530
Message-ID: <20250307095822.2274-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307095822.2274-1-sarunkod@amd.com>
References: <20250307095822.2274-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 548d3141-eafa-448a-1aed-08dd5d5eb962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7eN3o9Pg0tvIlgA3AJsTAeOXAKrCdJtVKInSg+HOZM7Hv3Q8qwAdKvyw3RM?=
 =?us-ascii?Q?EDZiRIVjll1P16qAM4mQCXS/evLBy1fbLSa2SVb7bWyv9PumScwpcXy3PNLP?=
 =?us-ascii?Q?G5V0Ygtr66PHaIneRu6Q5Shw85uL8RP6IKiO/L+jFNE1BW90OiMcqLRC9FNH?=
 =?us-ascii?Q?+wpubbVEQl63Q8lm66nSFcty4kGQGad2SX+b+w/TARMgEvOIOXZYmnRQ/z++?=
 =?us-ascii?Q?SlvBiHP5xEMt9m9Y5XPQiqZDeQUF84WLcrpqfGsd1l/Qbd7iENf19QJ1BtCx?=
 =?us-ascii?Q?XUKg7ezNq0qqu5tqA6OL0JBuRxUg3AqP/lbtqzKl3W4cF4FH+AH9eApdc9dv?=
 =?us-ascii?Q?gv1pXlBoIhB65U+BFztgF7g7penjpU5ykN03JJR/RqSTy4bnOTwFwKAk3FOU?=
 =?us-ascii?Q?u+XvaqORfUoEEUartInlKn2QgT/djR0jsYVZW2RIBw8HjV7I4EP0k0YJ/TKU?=
 =?us-ascii?Q?VirmCTn2CQH8Vm82H20HOBSrKLnvTIU4Jxpw/lImz+pPCYbkRVOkBOGR+JZm?=
 =?us-ascii?Q?6Z4uHt4kV1+3LccuuQ48CmmnH/5AAUU91+r4Jz+zFK06OUqRZm6xRGk1Sabb?=
 =?us-ascii?Q?UO7F1RnZPzl8yk6ILRDGdd+ADhGAAzUnYu8eze2aOATFhoiyMMDaOw8uo3sk?=
 =?us-ascii?Q?/Niu2Zir9BlP0LRXXj8kMrdfNRTFC4bpW5cCCP6yOg1Go+wNpdNc86FyYBFk?=
 =?us-ascii?Q?Vlg9FN+RvP+rxzxHZMitVNETJsLo6J7nsOiT9RZwYLBz86KC6oCztjo56gAi?=
 =?us-ascii?Q?BoY6rQX+0gqSBldWt0oIATOwKm0sWxTHU/OpvzyAKA88lgHs52dM8TLsGnmU?=
 =?us-ascii?Q?37lLju40KjeKp96Qqbgkx9OglbP3zOyuisXn3Ppib+uUE5YqTIzkXCb3A136?=
 =?us-ascii?Q?9Vxpfu69hXDvfb17SBG+Z0Q548qrN9vz83Aykefz6t+7ZZBS7ODNugerSd0T?=
 =?us-ascii?Q?JHekuaVi3NIRmAVOQH0BE12x+FN3/lolEHeiKVBv9QaZK3Gb4IxKvbll8c9v?=
 =?us-ascii?Q?GslXSAyWlO0WqqZGcpUukt14zE3OnBcVtBb2y3/sKFojxr+prMDKT+C/O69e?=
 =?us-ascii?Q?VzC1reUOUREFRrXdcisA0lnLEVXIlOtMcSjMRBcZk388UKO75BjN9WZpskK4?=
 =?us-ascii?Q?PdC27jVs9Nkot3pPKAXvarJH7yJ8uLl/FcbRr8UpLLtJaYBBmFJg3fgeez/8?=
 =?us-ascii?Q?U7Yvq9TX3WzpJxqn2uA3uikAhgBwTBCu3MUjXg9a06msZz3OTaMYiknUx/eY?=
 =?us-ascii?Q?V2mOF44jyjPGj6k5T0yB1ysk4Q2gQXDuzjEyC0F74DsELBuDNS7Ky+hFCnA1?=
 =?us-ascii?Q?FwpaG2WZuowu3nP9lH2CyrcRmJ6/aPMqM5x3RpE9KoR2X+a+12pkjpajC5xR?=
 =?us-ascii?Q?8f6gXNZUg+ZpndmRvIIGD7+NaneNpZAh1tOMZWBaiz6FSf9e08vwNdHhqxZ4?=
 =?us-ascii?Q?97jmpjSYlTX+YyKBCX795787O6QQFPZAPm2ZgEL00lu+7WGysOfuJxTUf5YM?=
 =?us-ascii?Q?bG66+TSzkxf5KW8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:59:17.3439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 548d3141-eafa-448a-1aed-08dd5d5eb962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255

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

