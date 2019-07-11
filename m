Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B27CC74A35
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 14:06:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F011B20872
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 14:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F011B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 986E350A1;
	Thu, 11 Jul 2019 14:05:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B3C155065
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 13:58:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4549C883
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 13:58:23 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E64E30820DD;
	Thu, 11 Jul 2019 13:58:22 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA0660A97;
	Thu, 11 Jul 2019 13:57:38 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
	alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
	robin.murphy@arm.com
Subject: [PATCH v9 06/11] vfio/pci: Allow to mmap the fault queue
Date: Thu, 11 Jul 2019 15:56:20 +0200
Message-Id: <20190711135625.20684-7-eric.auger@redhat.com>
In-Reply-To: <20190711135625.20684-1-eric.auger@redhat.com>
References: <20190711135625.20684-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 11 Jul 2019 13:58:22 +0000 (UTC)
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com, tina.zhang@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The DMA FAULT region contains the fault ring buffer.
There is benefit to let the userspace mmap this area.
Expose this mmappable area through a sparse mmap entry
and implement the mmap operation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v8 -> v9:
- remove unused index local variable in vfio_pci_fault_mmap
---
 drivers/vfio/pci/vfio_pci.c | 61 +++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index c6fdbd64bfb2..7d62dcdbdf0b 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -264,21 +264,75 @@ static void vfio_pci_dma_fault_release(struct vfio_pci_device *vdev,
 {
 }
 
+static int vfio_pci_dma_fault_mmap(struct vfio_pci_device *vdev,
+				   struct vfio_pci_region *region,
+				   struct vm_area_struct *vma)
+{
+	u64 phys_len, req_len, pgoff, req_start;
+	unsigned long long addr;
+	unsigned int ret;
+
+	phys_len = region->size;
+
+	req_len = vma->vm_end - vma->vm_start;
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	req_start = pgoff << PAGE_SHIFT;
+
+	/* only the second page of the producer fault region is mmappable */
+	if (req_start < PAGE_SIZE)
+		return -EINVAL;
+
+	if (req_start + req_len > phys_len)
+		return -EINVAL;
+
+	addr = virt_to_phys(vdev->fault_pages);
+	vma->vm_private_data = vdev;
+	vma->vm_pgoff = (addr >> PAGE_SHIFT) + pgoff;
+
+	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			      req_len, vma->vm_page_prot);
+	return ret;
+}
+
 static int vfio_pci_dma_fault_add_capability(struct vfio_pci_device *vdev,
 					     struct vfio_pci_region *region,
 					     struct vfio_info_cap *caps)
 {
+	struct vfio_region_info_cap_sparse_mmap *sparse = NULL;
 	struct vfio_region_info_cap_fault cap = {
 		.header.id = VFIO_REGION_INFO_CAP_DMA_FAULT,
 		.header.version = 1,
 		.version = 1,
 	};
-	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+	size_t size = sizeof(*sparse) + sizeof(*sparse->areas);
+	int ret;
+
+	ret = vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+	if (ret)
+		return ret;
+
+	sparse = kzalloc(size, GFP_KERNEL);
+	if (!sparse)
+		return -ENOMEM;
+
+	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+	sparse->nr_areas = 1;
+	sparse->areas[0].offset = PAGE_SIZE;
+	sparse->areas[0].size = region->size - PAGE_SIZE;
+
+	ret = vfio_info_add_capability(caps, &sparse->header, size);
+	if (ret)
+		kfree(sparse);
+
+	return ret;
 }
 
 static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
 	.rw		= vfio_pci_dma_fault_rw,
 	.release	= vfio_pci_dma_fault_release,
+	.mmap		= vfio_pci_dma_fault_mmap,
 	.add_capability = vfio_pci_dma_fault_add_capability,
 };
 
@@ -339,7 +393,8 @@ static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
 		VFIO_REGION_TYPE_NESTED,
 		VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT,
 		&vfio_pci_dma_fault_regops, size,
-		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
+		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE |
+		VFIO_REGION_INFO_FLAG_MMAP,
 		vdev->fault_pages);
 	if (ret)
 		goto out;
@@ -347,7 +402,7 @@ static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
 	header = (struct vfio_region_dma_fault *)vdev->fault_pages;
 	header->entry_size = sizeof(struct iommu_fault);
 	header->nb_entries = DMA_FAULT_RING_LENGTH;
-	header->offset = sizeof(struct vfio_region_dma_fault);
+	header->offset = PAGE_SIZE;
 
 	ret = iommu_register_device_fault_handler(&vdev->pdev->dev,
 					vfio_pci_iommu_dev_fault_handler,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
