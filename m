Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54EAC10F14
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 12:22:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A113B2087F
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 12:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A113B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DB44AEF9;
	Mon,  8 Apr 2019 12:21:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 89649EEE
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 12:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 217AB623
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 12:21:58 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CF9C301BE68;
	Mon,  8 Apr 2019 12:21:57 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6928F2B9EF;
	Mon,  8 Apr 2019 12:21:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
	alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
	robin.murphy@arm.com
Subject: [PATCH v7 20/23] vfio-pci: Register an iommu fault handler
Date: Mon,  8 Apr 2019 14:19:08 +0200
Message-Id: <20190408121911.24103-21-eric.auger@redhat.com>
In-Reply-To: <20190408121911.24103-1-eric.auger@redhat.com>
References: <20190408121911.24103-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 08 Apr 2019 12:21:57 +0000 (UTC)
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
Message-ID: <20190408121908.SfdCDU3ftTUhNHUv7nyHkOvU3dOKKvID3LAdc5ZXZD0@z>

This patch registers a fault handler which records faults in
a circular buffer and then signals an eventfd. This buffer is
exposed within the fault region.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- move iommu_unregister_device_fault_handler to vfio_pci_release
---
 drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 01b1b4cb8349..cf12204486c3 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -29,6 +29,7 @@
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
 #include <linux/nospec.h>
+#include <linux/circ_buf.h>
 
 #include "vfio_pci_private.h"
 
@@ -295,6 +296,46 @@ static const struct vfio_pci_regops vfio_pci_fault_prod_regops = {
 	.add_capability = vfio_pci_fault_prod_add_capability,
 };
 
+int vfio_pci_iommu_dev_fault_handler(struct iommu_fault_event *evt, void *data)
+{
+	struct vfio_pci_device *vdev = (struct vfio_pci_device *) data;
+	struct vfio_region_fault_prod *prod_region =
+		(struct vfio_region_fault_prod *)vdev->fault_pages;
+	struct vfio_region_fault_cons *cons_region =
+		(struct vfio_region_fault_cons *)(vdev->fault_pages + 2 * PAGE_SIZE);
+	struct iommu_fault *new =
+		(struct iommu_fault *)(vdev->fault_pages + prod_region->offset +
+			prod_region->prod * prod_region->entry_size);
+	int prod, cons, size;
+
+	mutex_lock(&vdev->fault_queue_lock);
+
+	if (!vdev->fault_abi)
+		goto unlock;
+
+	prod = prod_region->prod;
+	cons = cons_region->cons;
+	size = prod_region->nb_entries;
+
+	if (CIRC_SPACE(prod, cons, size) < 1)
+		goto unlock;
+
+	*new = evt->fault;
+	prod = (prod + 1) % size;
+	prod_region->prod = prod;
+	mutex_unlock(&vdev->fault_queue_lock);
+
+	mutex_lock(&vdev->igate);
+	if (vdev->dma_fault_trigger)
+		eventfd_signal(vdev->dma_fault_trigger, 1);
+	mutex_unlock(&vdev->igate);
+	return 0;
+
+unlock:
+	mutex_unlock(&vdev->fault_queue_lock);
+	return -EINVAL;
+}
+
 static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
 {
 	struct vfio_region_fault_prod *header;
@@ -327,6 +368,13 @@ static int vfio_pci_init_fault_region(struct vfio_pci_device *vdev)
 	header = (struct vfio_region_fault_prod *)vdev->fault_pages;
 	header->version = -1;
 	header->offset = PAGE_SIZE;
+
+	ret = iommu_register_device_fault_handler(&vdev->pdev->dev,
+					vfio_pci_iommu_dev_fault_handler,
+					vdev);
+	if (ret)
+		goto out;
+
 	return 0;
 out:
 	kfree(vdev->fault_pages);
@@ -574,6 +622,7 @@ static void vfio_pci_release(void *device_data)
 	if (!(--vdev->refcnt)) {
 		vfio_spapr_pci_eeh_release(vdev->pdev);
 		vfio_pci_disable(vdev);
+		iommu_unregister_device_fault_handler(&vdev->pdev->dev);
 	}
 
 	mutex_unlock(&vdev->reflck->lock);
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 8e0a55682d3f..a9276926f008 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -122,6 +122,7 @@ struct vfio_pci_device {
 	int			ioeventfds_nr;
 	struct eventfd_ctx	*err_trigger;
 	struct eventfd_ctx	*req_trigger;
+	struct eventfd_ctx	*dma_fault_trigger;
 	struct mutex		fault_queue_lock;
 	int			fault_abi;
 	struct list_head	dummy_resources_list;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
