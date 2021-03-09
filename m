Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54CC433E9
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:22:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE1A65287
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE1A65287
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40CEC489E0;
	Tue,  9 Mar 2021 06:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSUwWKZ_jHbL; Tue,  9 Mar 2021 06:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD76649C90;
	Tue,  9 Mar 2021 06:22:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BC53C000A;
	Tue,  9 Mar 2021 06:22:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90234C0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 703A3835D3
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id otjxJlANCTZC for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 06:22:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 245C683563
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:31 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvlSp0bKmz17Hgx;
 Tue,  9 Mar 2021 14:20:42 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 14:22:19 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v2 3/6] vfio: Add a page fault handler
Date: Tue, 9 Mar 2021 14:22:04 +0800
Message-ID: <20210309062207.505-4-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210309062207.505-1-lushenming@huawei.com>
References: <20210309062207.505-1-lushenming@huawei.com>
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

VFIO manages the DMA mapping itself. To support IOPF for VFIO
devices, we add a VFIO page fault handler to serve the reported
page faults from the IOMMU driver. Besides, we can pre-map more
pages than requested at once to optimize for fewer page fault
handlings.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 drivers/vfio/vfio.c             |  35 +++++++
 drivers/vfio/vfio_iommu_type1.c | 167 ++++++++++++++++++++++++++++++++
 include/linux/vfio.h            |   5 +
 3 files changed, 207 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 38779e6fd80c..77b29bbd3027 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -2354,6 +2354,41 @@ struct iommu_domain *vfio_group_iommu_domain(struct vfio_group *group)
 }
 EXPORT_SYMBOL_GPL(vfio_group_iommu_domain);
 
+int vfio_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
+{
+	struct device *dev = (struct device *)data;
+	struct vfio_container *container;
+	struct vfio_group *group;
+	struct vfio_iommu_driver *driver;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	group = vfio_group_get_from_dev(dev);
+	if (!group)
+		return -ENODEV;
+
+	ret = vfio_group_add_container_user(group);
+	if (ret)
+		goto out;
+
+	container = group->container;
+	driver = container->iommu_driver;
+	if (likely(driver && driver->ops->dma_map_iopf))
+		ret = driver->ops->dma_map_iopf(container->iommu_data,
+						fault, dev);
+	else
+		ret = -ENOTTY;
+
+	vfio_group_try_dissolve_container(group);
+
+out:
+	vfio_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_iommu_dev_fault_handler);
+
 /**
  * Module/class support
  */
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 03ccc11057af..167d52c1468b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3330,6 +3330,172 @@ static void vfio_iommu_type1_notify(void *iommu_data,
 	wake_up_all(&iommu->vaddr_wait);
 }
 
+/*
+ * To optimize for fewer page fault handlings, try to
+ * pre-map more pages than requested.
+ */
+#define IOPF_PREMAP_LEN		512
+
+static void unpin_pages_iopf(struct vfio_dma *dma,
+			     unsigned long pfn, unsigned long npages)
+{
+	while (npages--)
+		put_pfn(pfn++, dma->prot);
+}
+
+/*
+ * Return 0 on success or a negative error code, the
+ * number of pages contiguously pinned is in @*pinned.
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
+	} else
+		*pfn_base = 0;
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
+	mmput(mm);
+	return ret;
+}
+
+static int vfio_iommu_type1_dma_map_iopf(void *iommu_data,
+					 struct iommu_fault *fault,
+					 struct device *dev)
+{
+	struct vfio_iommu *iommu = iommu_data;
+	dma_addr_t iova = ALIGN_DOWN(fault->prm.addr, PAGE_SIZE);
+	struct vfio_dma *dma;
+	int access_flags = 0;
+	size_t premap_len, map_len, mapped_len = 0;
+	unsigned long bit_offset, npages, i, vaddr, pfn;
+	struct vfio_batch batch;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+	struct iommu_page_response resp = {0};
+
+	mutex_lock(&iommu->lock);
+
+	dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
+	if (!dma)
+		goto out_invalid;
+
+	if (fault->prm.perm & IOMMU_FAULT_PERM_READ)
+		access_flags |= IOMMU_READ;
+	if (fault->prm.perm & IOMMU_FAULT_PERM_WRITE)
+		access_flags |= IOMMU_WRITE;
+	if ((dma->prot & access_flags) != access_flags)
+		goto out_invalid;
+
+	bit_offset = (iova - dma->iova) >> PAGE_SHIFT;
+	if (IOPF_MAPPED_BITMAP_GET(dma, bit_offset))
+		goto out_success;
+
+	premap_len = IOPF_PREMAP_LEN << PAGE_SHIFT;
+	npages = dma->size >> PAGE_SHIFT;
+	map_len = PAGE_SIZE;
+	for (i = bit_offset + 1; i < npages; i++) {
+		if (map_len >= premap_len || IOPF_MAPPED_BITMAP_GET(dma, i))
+			break;
+		map_len += PAGE_SIZE;
+	}
+	vaddr = iova - dma->iova + dma->vaddr;
+	vfio_batch_init(&batch);
+
+	while (map_len) {
+		int ret;
+
+		ret = pin_pages_iopf(dma, vaddr + mapped_len,
+				     map_len >> PAGE_SHIFT, &pfn,
+				     &npages, &batch);
+		if (!npages)
+			break;
+
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
+	}
+
+	vfio_batch_fini(&batch);
+
+	if (!mapped_len)
+		goto out_invalid;
+
+out_success:
+	status = IOMMU_PAGE_RESP_SUCCESS;
+
+out_invalid:
+	mutex_unlock(&iommu->lock);
+	resp.version		= IOMMU_PAGE_RESP_VERSION_1;
+	resp.grpid		= fault->prm.grpid;
+	resp.code		= status;
+	iommu_page_response(dev, &resp);
+	return 0;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -3345,6 +3511,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.dma_rw			= vfio_iommu_type1_dma_rw,
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
 	.notify			= vfio_iommu_type1_notify,
+	.dma_map_iopf		= vfio_iommu_type1_dma_map_iopf,
 };
 
 static int __init vfio_iommu_type1_init(void)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index b7e18bde5aa8..73af317a4343 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -99,6 +99,9 @@ struct vfio_iommu_driver_ops {
 						   struct iommu_group *group);
 	void		(*notify)(void *iommu_data,
 				  enum vfio_iommu_notify_type event);
+	int		(*dma_map_iopf)(void *iommu_data,
+					struct iommu_fault *fault,
+					struct device *dev);
 };
 
 extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
@@ -160,6 +163,8 @@ extern int vfio_unregister_notifier(struct device *dev,
 struct kvm;
 extern void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
 
+extern int vfio_iommu_dev_fault_handler(struct iommu_fault *fault, void *data);
+
 /*
  * Sub-module helpers
  */
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
