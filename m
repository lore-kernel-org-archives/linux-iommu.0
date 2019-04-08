Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915A0C10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 12:22:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEE62087F
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 12:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEE62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A897EF2;
	Mon,  8 Apr 2019 12:22:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 47A1CEED
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 12:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CCE77623
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 12:22:04 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D26E3065493;
	Mon,  8 Apr 2019 12:22:04 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D3A2D63B80;
	Mon,  8 Apr 2019 12:21:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
	alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
	robin.murphy@arm.com
Subject: [PATCH v7 21/23] vfio_pci: Allow to mmap the fault queue
Date: Mon,  8 Apr 2019 14:19:09 +0200
Message-Id: <20190408121911.24103-22-eric.auger@redhat.com>
In-Reply-To: <20190408121911.24103-1-eric.auger@redhat.com>
References: <20190408121911.24103-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 08 Apr 2019 12:22:04 +0000 (UTC)
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, vincent.stehle@arm.com,
	ashok.raj@intel.com, marc.zyngier@arm.com, christoffer.dall@arm.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408121909.YdqT2soqof57A5s0uaBywQ_gxkThtjYFXBAXF5HGV9c@z>

The Producer Fault region contains the fault queue in the second page.
There is benefit to let the userspace mmap this area. So let's expose
this mmappable area through a sparse mmap entry and implement the mmap
operation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c | 61 +++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cf12204486c3..8c895ece4750 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -274,15 +274,70 @@ static const struct vfio_pci_fault_abi fault_abi_versions[] = {
 
 #define NR_FAULT_ABIS ARRAY_SIZE(fault_abi_versions)
 
+static int vfio_pci_fault_mmap(struct vfio_pci_device *vdev,
+			       struct vfio_pci_region *region,
+			       struct vm_area_struct *vma)
+{
+	u64 phys_len, req_len, pgoff, req_start;
+	unsigned long long addr;
+	unsigned int index, ret;
+
+	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
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
 static int vfio_pci_fault_prod_add_capability(struct vfio_pci_device *vdev,
 		struct vfio_pci_region *region, struct vfio_info_cap *caps)
 {
+	struct vfio_region_info_cap_sparse_mmap *sparse = NULL;
 	struct vfio_region_info_cap_fault cap = {
 		.header.id = VFIO_REGION_INFO_CAP_PRODUCER_FAULT,
 		.header.version = 1,
 		.version = NR_FAULT_ABIS,
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
+	sparse->areas[0].size = PAGE_SIZE;
+
+	ret = vfio_info_add_capability(caps, &sparse->header, size);
+	if (ret)
+		kfree(sparse);
+
+	return ret;
 }
 
 static const struct vfio_pci_regops vfio_pci_fault_cons_regops = {
@@ -293,6 +348,7 @@ static const struct vfio_pci_regops vfio_pci_fault_cons_regops = {
 static const struct vfio_pci_regops vfio_pci_fault_prod_regops = {
 	.rw		= vfio_pci_fault_prod_rw,
 	.release	= vfio_pci_fault_release,
+	.mmap		= vfio_pci_fault_mmap,
 	.add_capability = vfio_pci_fault_prod_add_capability,
 };
 
@@ -351,7 +407,8 @@ static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
 		VFIO_REGION_TYPE_NESTED,
 		VFIO_REGION_SUBTYPE_NESTED_FAULT_PROD,
 		&vfio_pci_fault_prod_regops, 2 * PAGE_SIZE,
-		VFIO_REGION_INFO_FLAG_READ, vdev->fault_pages);
+		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_MMAP,
+		vdev->fault_pages);
 	if (ret)
 		goto out;
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
