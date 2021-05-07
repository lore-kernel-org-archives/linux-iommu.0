Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2CCC433B4
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D8B61468
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D8B61468
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65F1C8442A;
	Fri,  7 May 2021 10:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id moqRVO3vKGhM; Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D1C284421;
	Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 379A9C0022;
	Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77F6BC0022
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6332B843B9
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LRc5WfRNj2Pr for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 10:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EC96843A0
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:46 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc5z26gNgzqTB4;
 Fri,  7 May 2021 18:19:26 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:35 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Yi Sun" <yi.y.sun@linux.intel.com>, Tian Kevin
 <kevin.tian@intel.com>
Subject: [RFC PATCH v4 05/13] iommu/io-pgtable-arm: Add and realize
 sync_dirty_log ops
Date: Fri, 7 May 2021 18:22:03 +0800
Message-ID: <20210507102211.8836-6-zhukeqian1@huawei.com>
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

During dirty log tracking, user will try to retrieve dirty log from
iommu if it supports hardware dirty log. Scan leaf TTD and treat it
is dirty if it's writable. As we just set DBM bit for stage1 mapping,
so check whether AP[2] is not set.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 89 ++++++++++++++++++++++++++++++++++
 include/linux/io-pgtable.h     |  4 ++
 2 files changed, 93 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index b9f6e3370032..155d440099ab 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -877,6 +877,94 @@ static size_t arm_lpae_merge_page(struct io_pgtable_ops *ops, unsigned long iova
 	return __arm_lpae_merge_page(data, iova, paddr, size, lvl, ptep, prot);
 }
 
+static int __arm_lpae_sync_dirty_log(struct arm_lpae_io_pgtable *data,
+				     unsigned long iova, size_t size,
+				     int lvl, arm_lpae_iopte *ptep,
+				     unsigned long *bitmap,
+				     unsigned long base_iova,
+				     unsigned long bitmap_pgshift)
+{
+	arm_lpae_iopte pte;
+	struct io_pgtable *iop = &data->iop;
+	size_t base, next_size;
+	unsigned long offset;
+	int nbits, ret;
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
+			/* It is writable, set the bitmap */
+			nbits = size >> bitmap_pgshift;
+			offset = (iova - base_iova) >> bitmap_pgshift;
+			bitmap_set(bitmap, offset, nbits);
+			return 0;
+		}
+		/* Current level is table, traverse next level */
+		next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
+		ptep = iopte_deref(pte, data);
+		for (base = 0; base < size; base += next_size) {
+			ret = __arm_lpae_sync_dirty_log(data, iova + base,
+					next_size, lvl + 1, ptep, bitmap,
+					base_iova, bitmap_pgshift);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		if (pte & ARM_LPAE_PTE_AP_RDONLY)
+			return 0;
+
+		/* Though the size is too small, also set bitmap */
+		nbits = size >> bitmap_pgshift;
+		offset = (iova - base_iova) >> bitmap_pgshift;
+		bitmap_set(bitmap, offset, nbits);
+		return 0;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_sync_dirty_log(data, iova, size, lvl + 1, ptep,
+			bitmap, base_iova, bitmap_pgshift);
+}
+
+static int arm_lpae_sync_dirty_log(struct io_pgtable_ops *ops,
+				   unsigned long iova, size_t size,
+				   unsigned long *bitmap,
+				   unsigned long base_iova,
+				   unsigned long bitmap_pgshift)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
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
+	return __arm_lpae_sync_dirty_log(data, iova, size, lvl, ptep,
+					 bitmap, base_iova, bitmap_pgshift);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -957,6 +1045,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.split_block	= arm_lpae_split_block,
 		.merge_page	= arm_lpae_merge_page,
+		.sync_dirty_log	= arm_lpae_sync_dirty_log,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index e77576d946a2..329fa99d9d96 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -171,6 +171,10 @@ struct io_pgtable_ops {
 			      size_t size);
 	size_t (*merge_page)(struct io_pgtable_ops *ops, unsigned long iova,
 			     phys_addr_t phys, size_t size, int prot);
+	int (*sync_dirty_log)(struct io_pgtable_ops *ops,
+			      unsigned long iova, size_t size,
+			      unsigned long *bitmap, unsigned long base_iova,
+			      unsigned long bitmap_pgshift);
 };
 
 /**
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
