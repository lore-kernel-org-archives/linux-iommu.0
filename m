Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F004CC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:23:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EF064D99
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EF064D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC3032E0DF;
	Thu, 28 Jan 2021 15:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNd22Q9UdpuT; Thu, 28 Jan 2021 15:23:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AC0C721503;
	Thu, 28 Jan 2021 15:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92E57C0FA7;
	Thu, 28 Jan 2021 15:23:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF455C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CD7408688A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BGb8c79jqTVz for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 15:23:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7C29D84B08
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:23:12 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DRPG04vvbz7btD;
 Thu, 28 Jan 2021 23:16:56 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 23:17:59 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 07/11] iommu/arm-smmu-v3: Clear dirty log according to
 bitmap
Date: Thu, 28 Jan 2021 23:17:38 +0800
Message-ID: <20210128151742.18840-8-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210128151742.18840-1-zhukeqian1@huawei.com>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 lushenming@huawei.com, Kirti Wankhede <kwankhede@nvidia.com>,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: jiangkunkun <jiangkunkun@huawei.com>

After dirty log is retrieved, user should clear dirty log to re-enable
dirty log tracking for these dirtied pages. This adds a new interface
named clear_dirty_log and arm smmuv3 implements it, which clears the dirty
state (As we just enable HTTU for stage1, so set the AP[2] bit) of these
TTDs that are specified by the user provided bitmap.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++
 drivers/iommu/io-pgtable-arm.c              | 95 +++++++++++++++++++++
 drivers/iommu/iommu.c                       | 71 +++++++++++++++
 include/linux/io-pgtable.h                  |  4 +
 include/linux/iommu.h                       | 17 ++++
 5 files changed, 211 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 43d0536b429a..0c24503d29d3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2574,6 +2574,29 @@ static int arm_smmu_sync_dirty_log(struct iommu_domain *domain,
 			base_iova, bitmap_pgshift);
 }
 
+static int arm_smmu_clear_dirty_log(struct iommu_domain *domain,
+				    unsigned long iova, size_t size,
+				    unsigned long *bitmap,
+				    unsigned long base_iova,
+				    unsigned long bitmap_pgshift)
+{
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HTTU_HD)) {
+		dev_err(smmu->dev, "don't support HTTU_HD and clear dirty log\n");
+		return -EPERM;
+	}
+
+	if (!ops || !ops->clear_dirty_log) {
+		pr_err("don't support clear dirty log\n");
+		return -ENODEV;
+	}
+
+	return ops->clear_dirty_log(ops, iova, size, bitmap, base_iova,
+				    bitmap_pgshift);
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2676,6 +2699,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.split_block		= arm_smmu_split_block,
 	.merge_page		= arm_smmu_merge_page,
 	.sync_dirty_log		= arm_smmu_sync_dirty_log,
+	.clear_dirty_log	= arm_smmu_clear_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6cfe1ef3fedd..2256e37bcb3a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -966,6 +966,100 @@ static int arm_lpae_sync_dirty_log(struct io_pgtable_ops *ops,
 					 bitmap, base_iova, bitmap_pgshift);
 }
 
+static int __arm_lpae_clear_dirty_log(struct arm_lpae_io_pgtable *data,
+				      unsigned long iova, size_t size,
+				      int lvl, arm_lpae_iopte *ptep,
+				      unsigned long *bitmap,
+				      unsigned long base_iova,
+				      unsigned long bitmap_pgshift)
+{
+	arm_lpae_iopte pte;
+	struct io_pgtable *iop = &data->iop;
+	unsigned long offset;
+	size_t base, next_size;
+	int nbits, ret, i;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return -EINVAL;
+
+	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+		if (iopte_leaf(pte, lvl, iop->fmt)) {
+			if (pte & ARM_LPAE_PTE_AP_RDONLY)
+				return 0;
+
+			/* Ensure all corresponding bits are set */
+			nbits = size >> bitmap_pgshift;
+			offset = (iova - base_iova) >> bitmap_pgshift;
+			for (i = offset; i < offset + nbits; i++) {
+				if (!test_bit(i, bitmap))
+					return 0;
+			}
+
+			/* Race does not exist */
+			pte |= ARM_LPAE_PTE_AP_RDONLY;
+			__arm_lpae_set_pte(ptep, pte, &iop->cfg);
+			return 0;
+		} else {
+			/* To traverse next level */
+			next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
+			ptep = iopte_deref(pte, data);
+			for (base = 0; base < size; base += next_size) {
+				ret = __arm_lpae_clear_dirty_log(data,
+						iova + base, next_size, lvl + 1,
+						ptep, bitmap, base_iova,
+						bitmap_pgshift);
+				if (ret)
+					return ret;
+			}
+			return 0;
+		}
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		/* Though the size is too small, it is already clean */
+		if (pte & ARM_LPAE_PTE_AP_RDONLY)
+			return 0;
+
+		return -EINVAL;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_clear_dirty_log(data, iova, size, lvl + 1, ptep,
+			bitmap, base_iova, bitmap_pgshift);
+}
+
+static int arm_lpae_clear_dirty_log(struct io_pgtable_ops *ops,
+				    unsigned long iova, size_t size,
+				    unsigned long *bitmap,
+				    unsigned long base_iova,
+				    unsigned long bitmap_pgshift)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return -EINVAL;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext))
+		return -EINVAL;
+
+	if (data->iop.fmt != ARM_64_LPAE_S1 &&
+	    data->iop.fmt != ARM_32_LPAE_S1)
+		return -EINVAL;
+
+	return __arm_lpae_clear_dirty_log(data, iova, size, lvl, ptep,
+			bitmap, base_iova, bitmap_pgshift);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -1047,6 +1141,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.split_block	= arm_lpae_split_block,
 		.merge_page	= arm_lpae_merge_page,
 		.sync_dirty_log	= arm_lpae_sync_dirty_log,
+		.clear_dirty_log = arm_lpae_clear_dirty_log,
 	};
 
 	return data;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 69f268069282..e2731a7afab2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2863,6 +2863,77 @@ int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_sync_dirty_log);
 
+static int __iommu_clear_dirty_log(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   unsigned long *bitmap,
+				   unsigned long base_iova,
+				   unsigned long bitmap_pgshift)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize;
+	int ret = 0;
+
+	if (!ops || !ops->clear_dirty_log) {
+		pr_err("don't support clear dirty log\n");
+		return -ENODEV;
+	}
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova, size);
+		ret = ops->clear_dirty_log(domain, iova, pgsize, bitmap,
+				base_iova, bitmap_pgshift);
+
+		if (ret)
+			break;
+
+		pr_debug("dirty_log_clear: iova 0x%lx pagesz 0x%zx\n", iova,
+			 pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+	iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+
+int iommu_clear_dirty_log(struct iommu_domain *domain,
+			  unsigned long iova, size_t size,
+			  unsigned long *bitmap, unsigned long base_iova,
+			  unsigned long bitmap_pgshift)
+{
+	unsigned long riova, rsize;
+	unsigned int min_pagesz;
+	bool flush = false;
+	int rs, re, start, end, ret = 0;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+
+	if (!IS_ALIGNED(iova | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx min_pagesz 0x%x\n",
+		       iova, min_pagesz);
+		return -EINVAL;
+	}
+
+	start = (iova - base_iova) >> bitmap_pgshift;
+	end = start + (size >> bitmap_pgshift);
+	bitmap_for_each_set_region(bitmap, rs, re, start, end) {
+		flush = true;
+		riova = iova + (rs << bitmap_pgshift);
+		rsize = (re - rs) << bitmap_pgshift;
+		ret = __iommu_clear_dirty_log(domain, riova, rsize, bitmap,
+					      base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+	}
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_clear_dirty_log);
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index f44551e4a454..e7134ee224c9 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -170,6 +170,10 @@ struct io_pgtable_ops {
 			      unsigned long iova, size_t size,
 			      unsigned long *bitmap, unsigned long base_iova,
 			      unsigned long bitmap_pgshift);
+	int (*clear_dirty_log)(struct io_pgtable_ops *ops,
+			       unsigned long iova, size_t size,
+			       unsigned long *bitmap, unsigned long base_iova,
+			       unsigned long bitmap_pgshift);
 };
 
 /**
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8069c8375e63..1cb6cd0cfc7b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,10 @@ struct iommu_ops {
 			      unsigned long iova, size_t size,
 			      unsigned long *bitmap, unsigned long base_iova,
 			      unsigned long bitmap_pgshift);
+	int (*clear_dirty_log)(struct iommu_domain *domain,
+			       unsigned long iova, size_t size,
+			       unsigned long *bitmap, unsigned long base_iova,
+			       unsigned long bitmap_pgshift);
 
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
@@ -525,6 +529,10 @@ extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
 				size_t size, unsigned long *bitmap,
 				unsigned long base_iova,
 				unsigned long bitmap_pgshift);
+extern int iommu_clear_dirty_log(struct iommu_domain *domain, unsigned long iova,
+				 size_t dma_size, unsigned long *bitmap,
+				 unsigned long base_iova,
+				 unsigned long bitmap_pgshift);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -940,6 +948,15 @@ static inline int iommu_sync_dirty_log(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_clear_dirty_log(struct iommu_domain *domain,
+					unsigned long iova, size_t size,
+					unsigned long *bitmap,
+					unsigned long base_iova,
+					unsigned long pgshift)
+{
+	return -EINVAL;
+}
+
 static inline int  iommu_device_register(struct iommu_device *iommu)
 {
 	return -ENODEV;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
