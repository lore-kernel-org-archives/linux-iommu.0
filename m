Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2CDC43332
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:20:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEFE20782
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ns6TQQWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEFE20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0A7162044C;
	Fri, 20 Mar 2020 16:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXCq+H2fqNCq; Fri, 20 Mar 2020 16:20:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 37144207EF;
	Fri, 20 Mar 2020 16:20:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE5CC1830;
	Fri, 20 Mar 2020 16:20:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64D42C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4F1E988374
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k5p0qdXGePmS for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 16:20:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8521D8832D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584721216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAZW6cFIVig3OQ6U+hazCtWFrY3hJC4RyMbwC1s1758=;
 b=Ns6TQQWQoLMokT9wM3Tk+ZDxsc1CLlat4+fW2s71q2DMbuCLcPT7c8iPWN/G6OJIkY3LkS
 3qPTaSEdVnKDrEdGaE8S+g8qPhc5UPNYDQTj5UVDn5JN7tuR7Kj4msU2KsU03B5piCQggI
 NdbC3AENGcQygmkj+mwtXuRzSIbxxws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ei1HOvX7N6KVKGzeiOefbA-1; Fri, 20 Mar 2020 12:20:14 -0400
X-MC-Unique: ei1HOvX7N6KVKGzeiOefbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0F88C8EE1;
 Fri, 20 Mar 2020 16:20:12 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 757FA60BFB;
 Fri, 20 Mar 2020 16:19:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v10 05/11] vfio/pci: Register an iommu fault handler
Date: Fri, 20 Mar 2020 17:19:05 +0100
Message-Id: <20200320161911.27494-6-eric.auger@redhat.com>
In-Reply-To: <20200320161911.27494-1-eric.auger@redhat.com>
References: <20200320161911.27494-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: marc.zyngier@arm.com, peter.maydell@linaro.org
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

Register an IOMMU fault handler which records faults in
the DMA FAULT region ring buffer. In a subsequent patch, we
will add the signaling of a specific eventfd to allow the
userspace to be notified whenever a new fault as shown up.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v8 -> v9:
- handler now takes an iommu_fault handle
- eventfd signaling moved to a subsequent patch
- check the fault type and return an error if != UNRECOV
- still the fault handler registration can fail. We need to
  reach an agreement about how to deal with the situation

v3 -> v4:
- move iommu_unregister_device_fault_handler to vfio_pci_release
---
 drivers/vfio/pci/vfio_pci.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 586b89debed5..69595c240baf 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -27,6 +27,7 @@
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
 #include <linux/nospec.h>
+#include <linux/circ_buf.h>
 
 #include "vfio_pci_private.h"
 
@@ -283,6 +284,38 @@ static const struct vfio_pci_regops vfio_pci_dma_fault_regops = {
 	.add_capability = vfio_pci_dma_fault_add_capability,
 };
 
+int vfio_pci_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
+{
+	struct vfio_pci_device *vdev = (struct vfio_pci_device *)data;
+	struct vfio_region_dma_fault *reg =
+		(struct vfio_region_dma_fault *)vdev->fault_pages;
+	struct iommu_fault *new =
+		(struct iommu_fault *)(vdev->fault_pages + reg->offset +
+			reg->head * reg->entry_size);
+	int head, tail, size;
+	int ret = 0;
+
+	if (fault->type != IOMMU_FAULT_DMA_UNRECOV)
+		return -ENOENT;
+
+	mutex_lock(&vdev->fault_queue_lock);
+
+	head = reg->head;
+	tail = reg->tail;
+	size = reg->nb_entries;
+
+	if (CIRC_SPACE(head, tail, size) < 1) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	*new = *fault;
+	reg->head = (head + 1) % size;
+unlock:
+	mutex_unlock(&vdev->fault_queue_lock);
+	return ret;
+}
+
 #define DMA_FAULT_RING_LENGTH 512
 
 static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
@@ -317,6 +350,13 @@ static int vfio_pci_init_dma_fault_region(struct vfio_pci_device *vdev)
 	header->entry_size = sizeof(struct iommu_fault);
 	header->nb_entries = DMA_FAULT_RING_LENGTH;
 	header->offset = sizeof(struct vfio_region_dma_fault);
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
@@ -542,6 +582,8 @@ static void vfio_pci_release(void *device_data)
 	if (!(--vdev->refcnt)) {
 		vfio_spapr_pci_eeh_release(vdev->pdev);
 		vfio_pci_disable(vdev);
+		/* TODO: Failure problematics */
+		iommu_unregister_device_fault_handler(&vdev->pdev->dev);
 	}
 
 	mutex_unlock(&vdev->reflck->lock);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
