Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E9AC43460
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BB661461
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 10:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BB661461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 478B9843B9;
	Fri,  7 May 2021 10:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27_QFsOZ4wSA; Fri,  7 May 2021 10:22:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F78C84428;
	Fri,  7 May 2021 10:22:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6832C0001;
	Fri,  7 May 2021 10:22:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3F2C000D
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 275A160AE6
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8I98nlEkkij for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 10:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7339260AE8
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 10:22:46 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc5z30FQ5zqTB9;
 Fri,  7 May 2021 18:19:27 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:34 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Yi Sun" <yi.y.sun@linux.intel.com>, Tian Kevin
 <kevin.tian@intel.com>
Subject: [RFC PATCH v4 04/13] iommu/io-pgtable-arm: Add and realize merge_page
 ops
Date: Fri, 7 May 2021 18:22:02 +0800
Message-ID: <20210507102211.8836-5-zhukeqian1@huawei.com>
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

If block(largepage) mappings are split during start dirty log, then
when stop dirty log, we need to recover them for better DMA performance.

This recovers block mappings and unmap the span of page mappings. BBML1
or BBML2 feature is required.

Merging page is designed to be only used by dirty log tracking, which
does not concurrently work with other pgtable ops that access underlying
page table, so race condition does not exist.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/io-pgtable-arm.c | 78 ++++++++++++++++++++++++++++++++++
 include/linux/io-pgtable.h     |  2 +
 2 files changed, 80 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 664a9548b199..b9f6e3370032 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -800,6 +800,83 @@ static size_t arm_lpae_split_block(struct io_pgtable_ops *ops,
 	return __arm_lpae_split_block(data, iova, size, lvl, ptep);
 }
 
+static size_t __arm_lpae_merge_page(struct arm_lpae_io_pgtable *data,
+				    unsigned long iova, phys_addr_t paddr,
+				    size_t size, int lvl, arm_lpae_iopte *ptep,
+				    arm_lpae_iopte prot)
+{
+	arm_lpae_iopte pte, *tablep;
+	struct io_pgtable *iop = &data->iop;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
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
+		if (iopte_leaf(pte, lvl, iop->fmt))
+			return size;
+
+		/* Race does not exist */
+		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_BBML1) {
+			prot |= ARM_LPAE_PTE_NT;
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+			io_pgtable_tlb_flush_walk(iop, iova, size,
+						  ARM_LPAE_GRANULE(data));
+
+			prot &= ~(ARM_LPAE_PTE_NT);
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+		} else {
+			__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
+		}
+
+		tablep = iopte_deref(pte, data);
+		__arm_lpae_free_pgtable(data, lvl + 1, tablep);
+		return size;
+	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
+		/* The size is too small, already merged */
+		return size;
+	}
+
+	/* Keep on walkin */
+	ptep = iopte_deref(pte, data);
+	return __arm_lpae_merge_page(data, iova, paddr, size, lvl + 1, ptep, prot);
+}
+
+static size_t arm_lpae_merge_page(struct io_pgtable_ops *ops, unsigned long iova,
+				  phys_addr_t paddr, size_t size, int iommu_prot)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	arm_lpae_iopte *ptep = data->pgd;
+	int lvl = data->start_level;
+	arm_lpae_iopte prot;
+	long iaext = (s64)iova >> cfg->ias;
+
+	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
+		return 0;
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || paddr >> cfg->oas))
+		return 0;
+
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return size;
+
+	/* If it is smallest granule, then nothing to do */
+	if (size == ARM_LPAE_BLOCK_SIZE(ARM_LPAE_MAX_LEVELS - 1, data))
+		return size;
+
+	prot = arm_lpae_prot_to_pte(data, iommu_prot);
+	return __arm_lpae_merge_page(data, iova, paddr, size, lvl, ptep, prot);
+}
+
 static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
 {
 	unsigned long granule, page_sizes;
@@ -879,6 +956,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.unmap		= arm_lpae_unmap,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 		.split_block	= arm_lpae_split_block,
+		.merge_page	= arm_lpae_merge_page,
 	};
 
 	return data;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index eba6c6ccbe49..e77576d946a2 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -169,6 +169,8 @@ struct io_pgtable_ops {
 				    unsigned long iova);
 	size_t (*split_block)(struct io_pgtable_ops *ops, unsigned long iova,
 			      size_t size);
+	size_t (*merge_page)(struct io_pgtable_ops *ops, unsigned long iova,
+			     phys_addr_t phys, size_t size, int prot);
 };
 
 /**
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
