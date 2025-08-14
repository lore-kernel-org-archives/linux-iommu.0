Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3A2ED179
	for <iommu@lists.linux.dev>; Thu, 14 Aug 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163816; cv=none; b=NEfHOJVq63JndiiFQ93L8ofJ9mBcDdzCRIkYGtaDrB3Ks8shQPWedv9d1vrPsxsBJZq/vFOvUxcr2uAC7sb/hgV4ak6xEf5Z58P5b2iKiB74askoFjSBLuA5BGtxqBUuzlrmmvnuffU28+dlebPvYk8UFXfMoBoIMIApt9IsKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163816; c=relaxed/simple;
	bh=umu6p1Xnjv7Eb71dtdWTGaIJkMemCtt+dX+UMOVtnDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7vZckzqMz6hoYt+fmgAAJGe+frvEXXGv8OuJ680qIZGCBfMWjvNalTpsvz8Sdmn38cgrxwYn5vW2iUZp8wRJlgAuRk+eLvvvOJkYkeQvYIGjq2hxXDlHt5Ww6ouZmAgacpkVW3zXn7J3+C0JUkPXzwyDxgfNvmQFfY3glpN9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c2fyv6dQyz2gKxY;
	Thu, 14 Aug 2025 17:27:19 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 52E1D140296;
	Thu, 14 Aug 2025 17:30:10 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 17:30:09 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<xiaqinxin@huawei.com>, <yangyicong@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH 2/2] iommu/io-pgtable: Add ARM SMMUv3 page table dump support
Date: Thu, 14 Aug 2025 17:30:05 +0800
Message-ID: <20250814093005.2040511-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250814093005.2040511-1-xiaqinxin@huawei.com>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

This patch implements the debug interface for dumping ARM SMMUv3
page table entries and protection information. The functionality
enables detailed inspection of IOMMU mappings for debugging and
validation purposes.

1. ARM SMMUv3 driver integration:
   - Implemented arm_smmu_dump_iova_prot() callback
   - Registered dump_iova_prot in iommu_domain_ops

2. ARM LPAE io-pgtable implementation:
   - Added arm_lpae_dump_iova_prot() to io_pgtable_ops
   - Defined protection bit descriptors (prot_bits)
   - Created io_pgtable_fmt_names for human-readable format strings
   - Implemented protection flag formatting in dump_prot()

3. Core io-pgtable interface extension:
   - Added dump_iova_prot callback to io_pgtable_ops

The implementation provides detailed output for each IOVA mapping:
<start> - <end>    lvl <level>  stage <format> <protection flags>
Example: 0xffff2000 - 0xffff3000 lvl 2 stage ARM_64_LPAE_S1 AF SH_NS

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  13 ++
 drivers/iommu/io-pgtable-arm.c              | 169 ++++++++++++++++++++
 include/linux/io-pgtable.h                  |   4 +
 3 files changed, 186 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5968043ac802..4128b3307753 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3411,6 +3411,16 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ops->iova_to_phys(ops, iova);
 }
 
+#ifdef CONFIG_IO_PTDUMP
+static size_t
+arm_smmu_dump_iova_prot(struct seq_file *s, struct iommu_domain *domain, dma_addr_t iova)
+{
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+
+	return ops->dump_iova_prot(s, ops, iova);
+}
+#endif
+
 static struct platform_driver arm_smmu_driver;
 
 static
@@ -3702,6 +3712,9 @@ static const struct iommu_ops arm_smmu_ops = {
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
+#ifdef CONFIG_IO_PTDUMP
+		.dump_iova_prot		= arm_smmu_dump_iova_prot,
+#endif
 		.free			= arm_smmu_domain_free_paging,
 	}
 };
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e8e2216c294..5deb03a85aa6 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -754,6 +754,172 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(d.pte, data) | iova;
 }
 
+#ifdef CONFIG_IO_PTDUMP
+#include <linux/seq_file.h>
+
+struct io_ptdump_prot_bits {
+	uint64_t mask;
+	uint64_t val;
+	const char *set;
+	const char *clear;
+};
+
+static const struct io_ptdump_prot_bits prot_bits[] = {
+	{
+		.mask   = ARM_LPAE_PTE_VALID,
+		.val    = ARM_LPAE_PTE_VALID,
+		.set    = "V",
+		.clear  = " ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_XN,
+		.val    = ARM_LPAE_PTE_XN,
+		.set    = "XN",
+		.clear  = "  ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_DBM,
+		.val    = ARM_LPAE_PTE_DBM,
+		.set    = "DBM",
+		.clear  = "   ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_AF,
+		.val    = ARM_LPAE_PTE_AF,
+		.set    = "AF",
+		.clear  = "  ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_SH_NS,
+		.val    = ARM_LPAE_PTE_SH_NS,
+		.set    = "SH_NS",
+		.clear  = "     ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_SH_OS,
+		.val    = ARM_LPAE_PTE_SH_OS,
+		.set    = "SH_OS",
+		.clear  = "     ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_SH_IS,
+		.val    = ARM_LPAE_PTE_SH_IS,
+		.set    = "SH_IS",
+		.clear  = "     ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_NS,
+		.val    = ARM_LPAE_PTE_NS,
+		.set    = "NS",
+		.clear  = "  ",
+	},
+	{
+		.mask   = ARM_LPAE_PTE_NSTABLE,
+		.val    = ARM_LPAE_PTE_NSTABLE,
+		.set    = "NST",
+		.clear  = "   ",
+	},
+};
+
+const char *io_pgtable_fmt_names[] = {
+	"ARM_32_LPAE_S1",
+	"ARM_32_LPAE_S2",
+	"ARM_64_LPAE_S1",
+	"ARM_64_LPAE_S2",
+	"ARM_V7S",
+	"ARM_MALI_LPAE",
+	"AMD_IOMMU_V1",
+	"AMD_IOMMU_V2",
+	"APPLE_DART",
+	"APPLE_DART2",
+};
+
+struct io_ptdump_prot {
+	int lvl;
+	int stage;
+	char *attr;
+	size_t size;
+};
+
+static void dump_prot(struct seq_file *s, arm_lpae_iopte pte)
+{
+	int capacity = 64;
+	const char *attr;
+	int length = 0;
+
+	char *prot = kzalloc(capacity * sizeof(char), GFP_KERNEL);
+
+	if (!prot)
+		return;
+
+	/* Traverse all predefined permission bits */
+	for (size_t i = 0; i < ARRAY_SIZE(prot_bits); i++) {
+		if ((pte & prot_bits[i].mask) == prot_bits[i].val)
+			attr = prot_bits[i].set;
+		else
+			attr = prot_bits[i].clear;
+
+		size_t attr_len = strlen(attr);
+
+		/* Check and extend the buffer */
+		while (length + attr_len > capacity) {
+			capacity *= 2;
+
+			char *temp = krealloc(prot, capacity * sizeof(char), GFP_KERNEL);
+
+			if (!temp) {
+				kfree(prot);
+				return;
+			}
+
+			prot = temp;
+		}
+
+		length += snprintf(prot + length, capacity - length, "%s ", attr);
+
+		/* Security check: prevents abnormal buffer expansion */
+		if (length > PAGE_SIZE) {
+			pr_err("len = %zu, attr = %s, i =%d\n", length, attr, i);
+			kfree(prot);
+			return;
+		}
+	}
+
+	seq_printf(s, "%s", prot);
+	kfree(prot);
+}
+
+static size_t arm_lpae_dump_iova_prot(struct seq_file *s, struct io_pgtable_ops *ops,
+								   unsigned long iova)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct iova_to_phys_data d;
+	int ret;
+
+	struct io_pgtable_walk_data walk_data = {
+		.data = &d,
+		.visit = visit_iova_to_phys,
+		.addr = iova,
+		.end = iova + 1,
+	};
+
+	/* Only the mapped iova will be output */
+	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
+	if (ret)
+		return ARM_LPAE_GRANULE(data);
+
+	seq_printf(s, "%lx - %lx    lvl %d  stage %s ",
+			   iova, iova + ARM_LPAE_BLOCK_SIZE(d.lvl, data),
+			   d.lvl, io_pgtable_fmt_names[data->iop.fmt]);
+
+	/* TODO: The dump prot is incomplete and will be supplemented later... */
+	dump_prot(s, d.pte);
+	seq_puts(s, "\n");
+
+	return ARM_LPAE_BLOCK_SIZE(d.lvl, data);
+}
+#endif
+
 static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 			      arm_lpae_iopte *ptep, size_t size)
 {
@@ -950,6 +1116,9 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+#ifdef CONFIG_IO_PTDUMP
+		.dump_iova_prot = arm_lpae_dump_iova_prot,
+#endif
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 138fbd89b1e6..307c68f0038c 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -217,6 +217,10 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+#ifdef CONFIG_IO_PTDUMP
+	size_t (*dump_iova_prot)(struct seq_file *s, struct io_pgtable_ops *ops,
+			      unsigned long iova);
+#endif
 	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
-- 
2.33.0

