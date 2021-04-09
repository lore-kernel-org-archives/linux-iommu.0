Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08BC433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A9F61055
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A9F61055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C13BB848FA;
	Fri,  9 Apr 2021 03:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 977pFdSwMA-l; Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D63D8488C;
	Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F1AAC000A;
	Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 475DBC000B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA3538487B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SZ5NWvxXE8UQ for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 03:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B605A84881
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:47 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGkTL29g4znYts;
 Fri,  9 Apr 2021 11:41:58 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 11:44:36 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v3 3/8] vfio/type1: Add an MMU notifier to avoid pinning
Date: Fri, 9 Apr 2021 11:44:15 +0800
Message-ID: <20210409034420.1799-4-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210409034420.1799-1-lushenming@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Cc: Kevin Tian <kevin.tian@intel.com>, Christoph Hellwig <hch@infradead.org>,
 lushenming@huawei.com, wanghaibin.wang@huawei.com
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

To avoid pinning pages when they are mapped in IOMMU page tables, we
add an MMU notifier to tell the addresses which are no longer valid
and try to unmap them.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 112 +++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ab0ff60ee207..1cb9d1f2717b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -40,6 +40,7 @@
 #include <linux/notifier.h>
 #include <linux/dma-iommu.h>
 #include <linux/irqdomain.h>
+#include <linux/mmu_notifier.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -69,6 +70,7 @@ struct vfio_iommu {
 	struct mutex		lock;
 	struct rb_root		dma_list;
 	struct blocking_notifier_head notifier;
+	struct mmu_notifier	mn;
 	unsigned int		dma_avail;
 	unsigned int		vaddr_invalid_count;
 	uint64_t		pgsize_bitmap;
@@ -1204,6 +1206,72 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	return unlocked;
 }
 
+/* Unmap the IOPF mapped pages in the specified range. */
+static void vfio_unmap_partial_iopf(struct vfio_iommu *iommu,
+				    struct vfio_dma *dma,
+				    dma_addr_t start, dma_addr_t end)
+{
+	struct iommu_iotlb_gather *gathers;
+	struct vfio_domain *d;
+	int i, num_domains = 0;
+
+	list_for_each_entry(d, &iommu->domain_list, next)
+		num_domains++;
+
+	gathers = kzalloc(sizeof(*gathers) * num_domains, GFP_KERNEL);
+	if (gathers) {
+		for (i = 0; i < num_domains; i++)
+			iommu_iotlb_gather_init(&gathers[i]);
+	}
+
+	while (start < end) {
+		unsigned long bit_offset;
+		size_t len;
+
+		bit_offset = (start - dma->iova) >> PAGE_SHIFT;
+
+		for (len = 0; start + len < end; len += PAGE_SIZE) {
+			if (!IOPF_MAPPED_BITMAP_GET(dma,
+					bit_offset + (len >> PAGE_SHIFT)))
+				break;
+		}
+
+		if (len) {
+			i = 0;
+			list_for_each_entry(d, &iommu->domain_list, next) {
+				size_t unmapped;
+
+				if (gathers)
+					unmapped = iommu_unmap_fast(d->domain,
+								    start, len,
+								    &gathers[i++]);
+				else
+					unmapped = iommu_unmap(d->domain,
+							       start, len);
+
+				if (WARN_ON(unmapped != len))
+					goto out;
+			}
+
+			bitmap_clear(dma->iopf_mapped_bitmap,
+				     bit_offset, len >> PAGE_SHIFT);
+
+			cond_resched();
+		}
+
+		start += (len + PAGE_SIZE);
+	}
+
+out:
+	if (gathers) {
+		i = 0;
+		list_for_each_entry(d, &iommu->domain_list, next)
+			iommu_iotlb_sync(d->domain, &gathers[i++]);
+
+		kfree(gathers);
+	}
+}
+
 static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
 {
 	WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list));
@@ -3197,17 +3265,18 @@ static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data)
 
 	vaddr = iova - dma->iova + dma->vaddr;
 
-	if (vfio_pin_page_external(dma, vaddr, &pfn, true))
+	if (vfio_pin_page_external(dma, vaddr, &pfn, false))
 		goto out_invalid;
 
 	if (vfio_iommu_map(iommu, iova, pfn, 1, dma->prot)) {
-		if (put_pfn(pfn, dma->prot))
-			vfio_lock_acct(dma, -1, true);
+		put_pfn(pfn, dma->prot);
 		goto out_invalid;
 	}
 
 	bitmap_set(dma->iopf_mapped_bitmap, bit_offset, 1);
 
+	put_pfn(pfn, dma->prot);
+
 out_success:
 	status = IOMMU_PAGE_RESP_SUCCESS;
 
@@ -3220,6 +3289,43 @@ static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data)
 	return 0;
 }
 
+static void mn_invalidate_range(struct mmu_notifier *mn, struct mm_struct *mm,
+				unsigned long start, unsigned long end)
+{
+	struct vfio_iommu *iommu = container_of(mn, struct vfio_iommu, mn);
+	struct rb_node *n;
+	int ret;
+
+	mutex_lock(&iommu->lock);
+
+	ret = vfio_wait_all_valid(iommu);
+	if (WARN_ON(ret < 0))
+		return;
+
+	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
+		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
+		unsigned long start_n, end_n;
+
+		if (end <= dma->vaddr || start >= dma->vaddr + dma->size)
+			continue;
+
+		start_n = ALIGN_DOWN(max_t(unsigned long, start, dma->vaddr),
+				     PAGE_SIZE);
+		end_n = ALIGN(min_t(unsigned long, end, dma->vaddr + dma->size),
+			      PAGE_SIZE);
+
+		vfio_unmap_partial_iopf(iommu, dma,
+					start_n - dma->vaddr + dma->iova,
+					end_n - dma->vaddr + dma->iova);
+	}
+
+	mutex_unlock(&iommu->lock);
+}
+
+static const struct mmu_notifier_ops vfio_iommu_type1_mn_ops = {
+	.invalidate_range	= mn_invalidate_range,
+};
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
