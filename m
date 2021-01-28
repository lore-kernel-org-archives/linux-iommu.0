Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C884CC433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:18:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F0464DED
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F0464DED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 06940868B4;
	Thu, 28 Jan 2021 15:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lf92nASNflr0; Thu, 28 Jan 2021 15:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 65B3C868A8;
	Thu, 28 Jan 2021 15:18:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52ED4C0FA7;
	Thu, 28 Jan 2021 15:18:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E37EC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A0F1868A9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Spb6HO0dkXOa for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 15:18:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 92243868A8
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:18:19 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DRPG06S7Dz7btQ;
 Thu, 28 Jan 2021 23:16:56 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 23:18:02 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 10/11] vfio/iommu_type1: Optimize dirty bitmap population
 based on iommu HWDBM
Date: Thu, 28 Jan 2021 23:17:41 +0800
Message-ID: <20210128151742.18840-11-zhukeqian1@huawei.com>
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

In the past if vfio_iommu is not of pinned_page_dirty_scope and
vfio_dma is iommu_mapped, we populate full dirty bitmap for this
vfio_dma. Now we can try to get dirty log from iommu before make
the lousy decision.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 97 ++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3b8522ebf955..1cd10f3e7ed4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -999,6 +999,25 @@ static bool vfio_group_supports_hwdbm(struct vfio_group *group)
 	return true;
 }
 
+static int vfio_iommu_dirty_log_clear(struct vfio_iommu *iommu,
+				      dma_addr_t start_iova, size_t size,
+				      unsigned long *bitmap_buffer,
+				      dma_addr_t base_iova, size_t pgsize)
+{
+	struct vfio_domain *d;
+	unsigned long pgshift = __ffs(pgsize);
+	int ret;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		ret = iommu_clear_dirty_log(d->domain, start_iova, size,
+					    bitmap_buffer, base_iova, pgshift);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 			      struct vfio_dma *dma, dma_addr_t base_iova,
 			      size_t pgsize)
@@ -1010,13 +1029,28 @@ static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 	unsigned long shift = bit_offset % BITS_PER_LONG;
 	unsigned long leftover;
 
+	if (iommu->pinned_page_dirty_scope || !dma->iommu_mapped)
+		goto bitmap_done;
+
+	/* try to get dirty log from IOMMU */
+	if (!iommu->num_non_hwdbm_groups) {
+		struct vfio_domain *d;
+
+		list_for_each_entry(d, &iommu->domain_list, next) {
+			if (iommu_sync_dirty_log(d->domain, dma->iova, dma->size,
+						dma->bitmap, dma->iova, pgshift))
+				return -EFAULT;
+		}
+		goto bitmap_done;
+	}
+
 	/*
 	 * mark all pages dirty if any IOMMU capable device is not able
 	 * to report dirty pages and all pages are pinned and mapped.
 	 */
-	if (!iommu->pinned_page_dirty_scope && dma->iommu_mapped)
-		bitmap_set(dma->bitmap, 0, nbits);
+	bitmap_set(dma->bitmap, 0, nbits);
 
+bitmap_done:
 	if (shift) {
 		bitmap_shift_left(dma->bitmap, dma->bitmap, shift,
 				  nbits + shift);
@@ -1078,6 +1112,18 @@ static int vfio_iova_dirty_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 		 */
 		bitmap_clear(dma->bitmap, 0, dma->size >> pgshift);
 		vfio_dma_populate_bitmap(dma, pgsize);
+
+		/* Clear iommu dirty log to re-enable dirty log tracking */
+		if (!iommu->pinned_page_dirty_scope &&
+		    dma->iommu_mapped && !iommu->num_non_hwdbm_groups) {
+			ret = vfio_iommu_dirty_log_clear(iommu,	dma->iova,
+					dma->size, dma->bitmap, dma->iova,
+					pgsize);
+			if (ret) {
+				pr_warn("dma dirty log clear failed!\n");
+				return ret;
+			}
+		}
 	}
 	return 0;
 }
@@ -2780,6 +2826,48 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
 			-EFAULT : 0;
 }
 
+static void vfio_dma_dirty_log_start(struct vfio_iommu *iommu,
+				     struct vfio_dma *dma)
+{
+	struct vfio_domain *d;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		/* Go through all domain anyway even if we fail */
+		iommu_split_block(d->domain, dma->iova, dma->size);
+	}
+}
+
+static void vfio_dma_dirty_log_stop(struct vfio_iommu *iommu,
+				    struct vfio_dma *dma)
+{
+	struct vfio_domain *d;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		/* Go through all domain anyway even if we fail */
+		iommu_merge_page(d->domain, dma->iova, dma->size,
+				 d->prot | dma->prot);
+	}
+}
+
+static void vfio_iommu_dirty_log_switch(struct vfio_iommu *iommu, bool start)
+{
+	struct rb_node *n;
+
+	/* Split and merge even if all iommu don't support HWDBM now */
+	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
+		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
+
+		if (!dma->iommu_mapped)
+			continue;
+
+		/* Go through all dma range anyway even if we fail */
+		if (start)
+			vfio_dma_dirty_log_start(iommu, dma);
+		else
+			vfio_dma_dirty_log_stop(iommu, dma);
+	}
+}
+
 static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 					unsigned long arg)
 {
@@ -2812,8 +2900,10 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
 		if (!iommu->dirty_page_tracking) {
 			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
-			if (!ret)
+			if (!ret) {
 				iommu->dirty_page_tracking = true;
+				vfio_iommu_dirty_log_switch(iommu, true);
+			}
 		}
 		mutex_unlock(&iommu->lock);
 		return ret;
@@ -2822,6 +2912,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 		if (iommu->dirty_page_tracking) {
 			iommu->dirty_page_tracking = false;
 			vfio_dma_bitmap_free_all(iommu);
+			vfio_iommu_dirty_log_switch(iommu, false);
 		}
 		mutex_unlock(&iommu->lock);
 		return 0;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
