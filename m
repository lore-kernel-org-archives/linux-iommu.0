Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF934C43462
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8795C61151
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8795C61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F7DA60E55;
	Fri,  9 Apr 2021 03:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GaUVpcxMUVfC; Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36E4260E51;
	Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D8E3C000B;
	Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C82FC000B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FF948487C
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGfwxS1qhKrf for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 03:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 984568487B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:47 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGkTL39vRznYwQ;
 Fri,  9 Apr 2021 11:41:58 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 11:44:38 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v3 4/8] vfio/type1: Pre-map more pages than requested in
 the IOPF handling
Date: Fri, 9 Apr 2021 11:44:16 +0800
Message-ID: <20210409034420.1799-5-lushenming@huawei.com>
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

To optimize for fewer page fault handlings, we can pre-map more pages
than requested at once.

Note that IOPF_PREMAP_LEN is just an arbitrary value for now, which we
could try further tuning.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 131 ++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1cb9d1f2717b..01e296c6dc9e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3217,6 +3217,91 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 	return -EINVAL;
 }
 
+/*
+ * To optimize for fewer page fault handlings, try to
+ * pre-map more pages than requested.
+ */
+#define IOPF_PREMAP_LEN		512
+
+/*
+ * Return 0 on success or a negative error code, the
+ * number of pages contiguously pinned is in @pinned.
+ */
+static int pin_pages_iopf(struct vfio_dma *dma, unsigned long vaddr,
+			  unsigned long npages, unsigned long *pfn_base,
+			  unsigned long *pinned, struct vfio_batch *batch)
+{
+	struct mm_struct *mm;
+	unsigned long pfn;
+	int ret = 0;
+	*pinned = 0;
+
+	mm = get_task_mm(dma->task);
+	if (!mm)
+		return -ENODEV;
+
+	if (batch->size) {
+		*pfn_base = page_to_pfn(batch->pages[batch->offset]);
+		pfn = *pfn_base;
+	} else {
+		*pfn_base = 0;
+	}
+
+	while (npages) {
+		if (!batch->size) {
+			unsigned long req_pages = min_t(unsigned long, npages,
+							batch->capacity);
+
+			ret = vaddr_get_pfns(mm, vaddr, req_pages, dma->prot,
+					     &pfn, batch->pages);
+			if (ret < 0)
+				goto out;
+
+			batch->size = ret;
+			batch->offset = 0;
+			ret = 0;
+
+			if (!*pfn_base)
+				*pfn_base = pfn;
+		}
+
+		while (true) {
+			if (pfn != *pfn_base + *pinned)
+				goto out;
+
+			(*pinned)++;
+			npages--;
+			vaddr += PAGE_SIZE;
+			batch->offset++;
+			batch->size--;
+
+			if (!batch->size)
+				break;
+
+			pfn = page_to_pfn(batch->pages[batch->offset]);
+		}
+
+		if (unlikely(disable_hugepages))
+			break;
+	}
+
+out:
+	if (batch->size == 1 && !batch->offset) {
+		put_pfn(pfn, dma->prot);
+		batch->size = 0;
+	}
+
+	mmput(mm);
+	return ret;
+}
+
+static void unpin_pages_iopf(struct vfio_dma *dma,
+			     unsigned long pfn, unsigned long npages)
+{
+	while (npages--)
+		put_pfn(pfn++, dma->prot);
+}
+
 /* VFIO I/O Page Fault handler */
 static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data)
 {
@@ -3225,9 +3310,11 @@ static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data)
 	struct vfio_iopf_group *iopf_group;
 	struct vfio_iommu *iommu;
 	struct vfio_dma *dma;
+	struct vfio_batch batch;
 	dma_addr_t iova = ALIGN_DOWN(fault->prm.addr, PAGE_SIZE);
 	int access_flags = 0;
-	unsigned long bit_offset, vaddr, pfn;
+	size_t premap_len, map_len, mapped_len = 0;
+	unsigned long bit_offset, vaddr, pfn, i, npages;
 	int ret;
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
 	struct iommu_page_response resp = {0};
@@ -3263,19 +3350,47 @@ static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data)
 	if (IOPF_MAPPED_BITMAP_GET(dma, bit_offset))
 		goto out_success;
 
+	premap_len = IOPF_PREMAP_LEN << PAGE_SHIFT;
+	npages = dma->size >> PAGE_SHIFT;
+	map_len = PAGE_SIZE;
+	for (i = bit_offset + 1; i < npages; i++) {
+		if (map_len >= premap_len || IOPF_MAPPED_BITMAP_GET(dma, i))
+			break;
+		map_len += PAGE_SIZE;
+	}
 	vaddr = iova - dma->iova + dma->vaddr;
+	vfio_batch_init(&batch);
 
-	if (vfio_pin_page_external(dma, vaddr, &pfn, false))
-		goto out_invalid;
+	while (map_len) {
+		ret = pin_pages_iopf(dma, vaddr + mapped_len,
+				     map_len >> PAGE_SHIFT, &pfn,
+				     &npages, &batch);
+		if (!npages)
+			break;
 
-	if (vfio_iommu_map(iommu, iova, pfn, 1, dma->prot)) {
-		put_pfn(pfn, dma->prot);
-		goto out_invalid;
+		if (vfio_iommu_map(iommu, iova + mapped_len, pfn,
+				   npages, dma->prot)) {
+			unpin_pages_iopf(dma, pfn, npages);
+			vfio_batch_unpin(&batch, dma);
+			break;
+		}
+
+		bitmap_set(dma->iopf_mapped_bitmap,
+			   bit_offset + (mapped_len >> PAGE_SHIFT), npages);
+
+		unpin_pages_iopf(dma, pfn, npages);
+
+		map_len -= npages << PAGE_SHIFT;
+		mapped_len += npages << PAGE_SHIFT;
+
+		if (ret)
+			break;
 	}
 
-	bitmap_set(dma->iopf_mapped_bitmap, bit_offset, 1);
+	vfio_batch_fini(&batch);
 
-	put_pfn(pfn, dma->prot);
+	if (!mapped_len)
+		goto out_invalid;
 
 out_success:
 	status = IOMMU_PAGE_RESP_SUCCESS;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
