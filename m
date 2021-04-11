Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730F9C43460
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 11:49:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9E761210
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 11:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9E761210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E83E0400E0;
	Sun, 11 Apr 2021 11:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJUMbzaxISpI; Sun, 11 Apr 2021 11:49:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96F0640297;
	Sun, 11 Apr 2021 11:49:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75F39C000C;
	Sun, 11 Apr 2021 11:49:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E324FC000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C24A140297
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HLusHouJWyO0 for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 11:49:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 753F3402E7
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618141782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWGzKMYndTaoxXICp38BRXxfjFIboliyTlISDDpbHt8=;
 b=BmbgXJXPfhgs8gjY45UMCWA+L1UTFTuDKwwkX1iEjVYy/mpL8W5DTqbTL+9ow+SmvStRrm
 gwLi5wHzfa0yFfZgjHhu1ZBvyrcdnR/gPnArOhmx+eQt3Pn9Bm9VBaRp0bg3FyYmu0rAt7
 HGHLOuwkn3OFU/mn9cRLN+HWNwGMD5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-_htAbm3AP_ORbX4iilw6Xw-1; Sun, 11 Apr 2021 07:49:38 -0400
X-MC-Unique: _htAbm3AP_ORbX4iilw6Xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F289D18397A0;
 Sun, 11 Apr 2021 11:49:35 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ADD25C3E4;
 Sun, 11 Apr 2021 11:49:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v13 12/13] vfio/pci: Register a DMA fault response region
Date: Sun, 11 Apr 2021 13:46:58 +0200
Message-Id: <20210411114659.15051-13-eric.auger@redhat.com>
In-Reply-To: <20210411114659.15051-1-eric.auger@redhat.com>
References: <20210411114659.15051-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 vivek.gautam@arm.com, vsethi@nvidia.com, zhangfei.gao@linaro.org,
 jiangkunkun@huawei.com
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

In preparation for vSVA, let's register a DMA fault response region,
where the userspace will push the page responses and increment the
head of the buffer. The kernel will pop those responses and inject them
on iommu side.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v11 -> v12:
- use DMA_FAULT_RESPONSE cap [Shameer]
- struct vfio_pci_device dma_fault_response_wq field introduced in
  this patch
- return 0 if the domain is NULL
- pass an int pointer to iommu_domain_get_attr
---
 drivers/vfio/pci/vfio_pci.c         | 125 ++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_private.h |   6 ++
 drivers/vfio/pci/vfio_pci_rdwr.c    |  39 +++++++++
 include/uapi/linux/vfio.h           |  32 +++++++
 4 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 72d7c667b64c..560b1a830726 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -316,9 +316,20 @@ static void vfio_pci_dma_fault_release(struct vfio_pci_device *vdev,
 	kfree(vdev->fault_pages);
 }
 
-static int vfio_pci_dma_fault_mmap(struct vfio_pci_device *vdev,
-				   struct vfio_pci_region *region,
-				   struct vm_area_struct *vma)
+static void
+vfio_pci_dma_fault_response_release(struct vfio_pci_device *vdev,
+				    struct vfio_pci_region *region)
+{
+	if (vdev->dma_fault_response_wq)
+		destroy_workqueue(vdev->dma_fault_response_wq);
+	kfree(vdev->fault_response_pages);
+	vdev->fault_response_pages = NULL;
+}
+
+static int __vfio_pci_dma_fault_mmap(struct vfio_pci_device *vdev,
+				     struct vfio_pci_region *region,
+				     struct vm_area_struct *vma,
+				     u8 *pages)
 {
 	u64 phys_len, req_len, pgoff, req_start;
 	unsigned long long addr;
@@ -331,14 +342,14 @@ static int vfio_pci_dma_fault_mmap(struct vfio_pci_device *vdev,
 		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
 	req_start = pgoff << PAGE_SHIFT;
 
-	/* only the second page of the producer fault region is mmappable */
+	/* only the second page of the fault region is mmappable */
 	if (req_start < PAGE_SIZE)
 		return -EINVAL;
 
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
-	addr = virt_to_phys(vdev->fault_pages);
+	addr = virt_to_phys(pages);
 	vma->vm_private_data = vdev;
 	vma->vm_pgoff = (addr >> PAGE_SHIFT) + pgoff;
 
@@ -347,13 +358,29 @@ static int vfio_pci_dma_fault_mmap(struct vfio_pci_device *vdev,
 	return ret;
 }
 
-static int vfio_pci_dma_fault_add_capability(struct vfio_pci_device *vdev,
-					     struct vfio_pci_region *region,
-					     struct vfio_info_cap *caps)
+static int vfio_pci_dma_fault_mmap(struct vfio_pci_device *vdev,
+				   struct vfio_pci_region *region,
+				   struct vm_area_struct *vma)
+{
+	return __vfio_pci_dma_fault_mmap(vdev, region, vma, vdev->fault_pages);
+}
+
+static int
+vfio_pci_dma_fault_response_mmap(struct vfio_pci_device *vdev,
+				struct vfio_pci_region *region,
+				struct vm_area_struct *vma)
+{
+	return __vfio_pci_dma_fault_mmap(vdev, region, vma, vdev->fault_response_pages);
+}
+
+static int __vfio_pci_dma_fault_add_capability(struct vfio_pci_device *vdev,
+					       struct vfio_pci_region *region,
+					       struct vfio_info_cap *caps,
+					       u32 cap_id)
 {
 	struct vfio_region_info_cap_sparse_mmap *sparse = NULL;
 	struct vfio_region_info_cap_fault cap = {
-		.header.id = VFIO_REGION_INFO_CAP_DMA_FAULT,
+		.header.id = cap_id,
 		.header.version = 1,
 		.version = 1,
 	};
@@ -381,6 +408,23 @@ static int vfio_pci_dma_fault_add_capability(struct vfio_pci_device *vdev,
 	return ret;
 }
 
+static int vfio_pci_dma_fault_add_capability(struct vfio_pci_device *vdev,
+					     struct vfio_pci_region *region,
+					     struct vfio_info_cap *caps)
+{
+	return __vfio_pci_dma_fault_add_capability(vdev, region, caps,
+						   VFIO_REGION_INFO_CAP_DMA_FAULT);
+}
+
+static int
+vfio_pci_dma_fault_response_add_capability(struct vfio_pci_device *vdev,
+					   struct vfio_pci_region *region,
+					   struct vfio_info_cap *caps)
+{
+	return __vfio_pci_dma_fault_add_capability(vdev, region, caps,
+						   VFIO_REGION_INFO_CAP_DMA_FAULT_RESPONSE);
+}
+
 static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
 	.rw		= vfio_pci_dma_fault_rw,
 	.release	= vfio_pci_dma_fault_release,
@@ -388,6 +432,13 @@ static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
 	.add_capability = vfio_pci_dma_fault_add_capability,
 };
 
+static const struct vfio_pci_regops vfio_pci_dma_fault_response_regops = {
+	.rw		= vfio_pci_dma_fault_response_rw,
+	.release	= vfio_pci_dma_fault_response_release,
+	.mmap		= vfio_pci_dma_fault_response_mmap,
+	.add_capability = vfio_pci_dma_fault_response_add_capability,
+};
+
 static int
 vfio_pci_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
 {
@@ -501,6 +552,57 @@ static int vfio_pci_dma_fault_init(struct vfio_pci_device *vdev)
 	return ret;
 }
 
+#define DMA_FAULT_RESPONSE_RING_LENGTH 512
+
+static int vfio_pci_dma_fault_response_init(struct vfio_pci_device *vdev)
+{
+	struct vfio_region_dma_fault_response *header;
+	struct iommu_domain *domain;
+	int nested, ret;
+	size_t size;
+
+	domain = iommu_get_domain_for_dev(&vdev->pdev->dev);
+	if (!domain)
+		return 0;
+
+	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_NESTING, &nested);
+	if (ret || !nested)
+		return ret;
+
+	mutex_init(&vdev->fault_response_queue_lock);
+
+	/*
+	 * We provision 1 page for the header and space for
+	 * DMA_FAULT_RING_LENGTH fault records in the ring buffer.
+	 */
+	size = ALIGN(sizeof(struct iommu_page_response) *
+		     DMA_FAULT_RESPONSE_RING_LENGTH, PAGE_SIZE) + PAGE_SIZE;
+
+	vdev->fault_response_pages = kzalloc(size, GFP_KERNEL);
+	if (!vdev->fault_response_pages)
+		return -ENOMEM;
+
+	ret = vfio_pci_register_dev_region(vdev,
+		VFIO_REGION_TYPE_NESTED,
+		VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT_RESPONSE,
+		&vfio_pci_dma_fault_response_regops, size,
+		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE |
+		VFIO_REGION_INFO_FLAG_MMAP,
+		vdev->fault_response_pages);
+	if (ret)
+		goto out;
+
+	header = (struct vfio_region_dma_fault_response *)vdev->fault_response_pages;
+	header->entry_size = sizeof(struct iommu_page_response);
+	header->nb_entries = DMA_FAULT_RESPONSE_RING_LENGTH;
+	header->offset = PAGE_SIZE;
+
+	return 0;
+out:
+	vdev->fault_response_pages = NULL;
+	return ret;
+}
+
 static int vfio_pci_enable(struct vfio_pci_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -603,6 +705,10 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 	if (ret)
 		goto disable_exit;
 
+	ret = vfio_pci_dma_fault_response_init(vdev);
+	if (ret)
+		goto disable_exit;
+
 	vfio_pci_probe_mmaps(vdev);
 
 	return 0;
@@ -2228,6 +2334,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
 	mutex_init(&vdev->vma_lock);
 	INIT_LIST_HEAD(&vdev->vma_list);
+	INIT_LIST_HEAD(&vdev->dummy_resources_list);
 	init_rwsem(&vdev->memory_lock);
 
 	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index e2a999107bcb..f7b1e7fb86e5 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -144,7 +144,10 @@ struct vfio_pci_device {
 	struct eventfd_ctx	*err_trigger;
 	struct eventfd_ctx	*req_trigger;
 	u8			*fault_pages;
+	u8			*fault_response_pages;
+	struct workqueue_struct *dma_fault_response_wq;
 	struct mutex		fault_queue_lock;
+	struct mutex		fault_response_queue_lock;
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
 	struct list_head	ioeventfds_list;
@@ -189,6 +192,9 @@ extern long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
 extern size_t vfio_pci_dma_fault_rw(struct vfio_pci_device *vdev,
 				    char __user *buf, size_t count,
 				    loff_t *ppos, bool iswrite);
+extern size_t vfio_pci_dma_fault_response_rw(struct vfio_pci_device *vdev,
+					     char __user *buf, size_t count,
+					     loff_t *ppos, bool iswrite);
 
 extern int vfio_pci_init_perm_bits(void);
 extern void vfio_pci_uninit_perm_bits(void);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 164120607469..efde0793360b 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -400,6 +400,45 @@ size_t vfio_pci_dma_fault_rw(struct vfio_pci_device *vdev, char __user *buf,
 	return ret;
 }
 
+size_t vfio_pci_dma_fault_response_rw(struct vfio_pci_device *vdev, char __user *buf,
+				      size_t count, loff_t *ppos, bool iswrite)
+{
+	unsigned int i = VFIO_PCI_OFFSET_TO_INDEX(*ppos) - VFIO_PCI_NUM_REGIONS;
+	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	void *base = vdev->region[i].data;
+	int ret = -EFAULT;
+
+	if (pos >= vdev->region[i].size)
+		return -EINVAL;
+
+	count = min(count, (size_t)(vdev->region[i].size - pos));
+
+	if (iswrite) {
+		struct vfio_region_dma_fault_response *header =
+			(struct vfio_region_dma_fault_response *)base;
+		uint32_t  new_head;
+
+		if (pos != 0 || count != 4)
+			return -EINVAL;
+
+		if (copy_from_user((void *)&new_head, buf, count))
+			return -EFAULT;
+
+		if (new_head >= header->nb_entries)
+			return -EINVAL;
+
+		mutex_lock(&vdev->fault_response_queue_lock);
+		header->head = new_head;
+		mutex_unlock(&vdev->fault_response_queue_lock);
+	} else {
+		if (copy_to_user(buf, base + pos, count))
+			return -EFAULT;
+	}
+	*ppos += count;
+	ret = count;
+	return ret;
+}
+
 static void vfio_pci_ioeventfd_do_write(struct vfio_pci_ioeventfd *ioeventfd,
 					bool test_mem)
 {
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ad7c275b4074..bf7c62b47ce2 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -352,6 +352,7 @@ struct vfio_region_info_cap_type {
 
 /* sub-types for VFIO_REGION_TYPE_NESTED */
 #define VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT	(1)
+#define VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT_RESPONSE	(2)
 
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
@@ -1030,6 +1031,17 @@ struct vfio_region_info_cap_fault {
 	__u32 version;
 };
 
+/*
+ * Capability exposed by the DMA fault response region
+ * @version: ABI version
+ */
+#define VFIO_REGION_INFO_CAP_DMA_FAULT_RESPONSE	7
+
+struct vfio_region_info_cap_fault_response {
+	struct vfio_info_cap_header header;
+	__u32 version;
+};
+
 /*
  * DMA Fault Region Layout
  * @tail: index relative to the start of the ring buffer at which the
@@ -1050,6 +1062,26 @@ struct vfio_region_dma_fault {
 	__u32   head;
 };
 
+/*
+ * DMA Fault Response Region Layout
+ * @head: index relative to the start of the ring buffer at which the
+ *        producer (userspace) insert responses into the buffer
+ * @entry_size: fault ring buffer entry size in bytes
+ * @nb_entries: max capacity of the fault ring buffer
+ * @offset: ring buffer offset relative to the start of the region
+ * @tail: index relative to the start of the ring buffer at which the
+ *        consumer (kernel) finds the next item in the buffer
+ */
+struct vfio_region_dma_fault_response {
+	/* Write-Only */
+	__u32   head;
+	/* Read-Only */
+	__u32   entry_size;
+	__u32	nb_entries;
+	__u32	offset;
+	__u32   tail;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
