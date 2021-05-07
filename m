Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5924C433B4
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F026145E
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F026145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D40B484406;
	Fri,  7 May 2021 10:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RrLdpp-okPDo; Fri,  7 May 2021 10:22:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97314843E0;
	Fri,  7 May 2021 10:22:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDFDC0022;
	Fri,  7 May 2021 10:22:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86A73C000D
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7438C843B9
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id auD9yoQ4Qi5w for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 10:22:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D20B843A4
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:42 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fc5zk3NqczCqys;
 Fri,  7 May 2021 18:20:02 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:33 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Yi Sun" <yi.y.sun@linux.intel.com>, Tian Kevin
 <kevin.tian@intel.com>
Subject: [RFC PATCH v4 03/13] iommu/io-pgtable-arm: Add and realize
 split_block ops
Date: Fri, 7 May 2021 18:22:01 +0800
Message-ID: <20210507102211.8836-4-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210507102211.8836-1-zhukeqian1@huawei.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

From: Kunkun Jiang <jiangkunkun@huawei.com>

Block(largepage) mapping is not a proper granule for dirty log tracking.
Take an extreme example, if DMA writes one byte, under 1G mapping, the
dirty amount reported is 1G, but under 4K mapping, the dirty amount is
just 4K.

This splits block descriptor to an span of page descriptors. BBML1 or
BBML2 feature is required.

Spliting block is designed to be only used by dirty log tracking, which
does not concurrently work with other pgtable ops that access underlying
page table, so race condition does not exist.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 122 +++++++++++++++++++++++++++++++++
 include/linux/io-pgtable.h     |   2 +
 2 files changed, 124 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 94d790b8ed27..664a9548b199 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -79,6 +79,8 @@
 #define ARM_LPAE_PTE_SH_IS		(((arm_lpae_iopte)3) << 8)
 #define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
 #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
+/* Block descriptor bits */
+#define ARM_LPAE_PTE_NT			(((arm_lpae_iopte)1) << 16)
 
 #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
 /* Ignore the contiguous bit for block splitting */
@@ -679,6 +681,125 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 	return iopte_to_paddr(pte, data) | iova;
 }
 
+static size_t __arm_lpae_split_block(struct arm_lpae_io_pgtable *data,
+				     unsigned long iova, size_t size, int lvl,
+				     arm_lpae_iopte *ptep);
+
+static size_t arm_lpae_do_split_blk(struct arm_lpae_io_pgtable *data,
+				    unsigned long iova, size_t size,
+				    arm_lpae_iopte blk_pte, int lvl,
+				    arm_lpae_iopte *ptep)
+{
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte pte, *tablep;
+	phys_addr_t blk_paddr;
+	size_t tablesz = ARM_LPAE_GRANULE(data);
+	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int i;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
+	tablep = __arm_lpae_alloc_pages(tablesz, GFP_ATOMIC, cfg);
+	if (!tablep)
+		return 0;
+
+	blk_paddr = iopte_to_paddr(blk_pte, data);
+	pte = iopte_prot(blk_pte);
+	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz)
+		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, &tablep[i]);
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_BBML1) {
+		/* Race does not exist */
+		blk_pte |= ARM_LPAE_PTE_NT;
+		__arm_lpae_set_pte(ptep, blk_pte, cfg);
+		io_pgtable_tlb_flush_walk(&data->iop, iova, size, size);
+	}
+	/* Race does not exist */
+	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
+
+	/* Have splited it into page? */
+	if (lvl == (ARM_LPAE_MAX_LEVELS - 1))
+		return size;
+
+	/* Go back to lvl - 1 */
+	ptep -= ARM_LPAE_LVL_IDX(iova, lvl - 1, data);
+	return __arm_lpae_split_block(data, iova, size, lvl - 1, ptep);
+}
+
+static size_t __arm_lpae_split_block(struct arm_lpae_io_pgtable *data,
+				     unsigned long iova, size_t size, int lvl,
+				     arm_lpae_iopte *ptep)
+{
+	arm_lpae_iopte pte;
+	struct io_pgtable *iop = &data->iop;
+	size_t base, next_size, total_size;
+
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
+	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
+	pte = READ_ONCE(*ptep);
+	if (WARN_ON(!pte))
+		return 0;
+
+	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
+		if (iopte_leaf(pte, lvl, iop->fmt)) {
+			if (lvl == (ARM_LPAE_MAX_LEVELS - 1) ||
+			    (pte & ARM_LPAE_PTE_AP_RDONLY))
+				return size;
+
+			/* We find a writable block, split it. */
+			return arm_lpae_do_split_blk(data, iova, size, pte,
+					lvl + 1, ptep);
+		} else {
+			/* If it is the last table level, then nothing to do */
+			if (lvl == (ARM_LPAE_MAX_LEVELS - 2))
+				return size;
+
+			total_size = 0;
+			next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
+			ptep = iopte_deref(pte, data);
+			for (base = 0; base < size; base += next_size)
+				total_size += __arm_lpae_split_block(data,
+						iova + base, next_size, lvl + 1,
+						ptep);
+			return total_size;
+		}
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		WARN(1, "Can't split behind a block.\n");
+		return 0;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_split_block(data, iova, size, lvl + 1, ptep);
+}
+
+static size_t arm_lpae_split_block(struct io_pgtable_ops *ops,
+				   unsigned long iova, size_t size)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return 0;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext))
+		return 0;
+
+	/* If it is smallest granule, then nothing to do */
+	if (size == ARM_LPAE_BLOCK_SIZE(ARM_LPAE_MAX_LEVELS - 1, data))
+		return size;
+
+	return __arm_lpae_split_block(data, iova, size, lvl, ptep);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -757,6 +878,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map		= arm_lpae_map,
 		.unmap		= arm_lpae_unmap,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.split_block	= arm_lpae_split_block,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 92274705b772..eba6c6ccbe49 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -167,6 +167,8 @@ struct io_pgtable_ops {
 			size_t size, struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	size_t (*split_block)(struct io_pgtable_ops *ops, unsigned long iova,
+			      size_t size);
 };
 
 /**
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
