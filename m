Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED9C83000
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2C6206E2
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wJeF5Q7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2C6206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4925686F87;
	Tue, 28 Apr 2020 12:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9usM1MphEWI; Tue, 28 Apr 2020 12:05:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1868E87221;
	Tue, 28 Apr 2020 12:05:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E925CC0865;
	Tue, 28 Apr 2020 12:05:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B127BC0863
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A116888045
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Z3o9GQgrYlJ for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 11:40:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4780A88058
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588074021; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=EyRVot7qp3Cdnv4TORCR9Eswn96fUUZzNYySheEGPnQ=;
 b=wJeF5Q7qmuqnPQlHMXIeuomJO7W/3+EEQ/D4CulerL+TG6O5Kj3KgPtG4WzE6NIZduZoO1S5
 hkzu4jNS/KgkDBg7PXDnTZsRb/DSH5RniXU0+6zt9g0N+1Prax/dB7YR0WOz6ybEJzEilVzN
 ueVqJcOcNxBxTEJRl0qainl1S6Y=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8160f.7f2b76e55dc0-smtp-out-n04;
 Tue, 28 Apr 2020 11:39:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B4403C43637; Tue, 28 Apr 2020 11:39:58 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 00DACC44793;
 Tue, 28 Apr 2020 11:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00DACC44793
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
 jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Subject: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Tue, 28 Apr 2020 17:09:18 +0530
Message-Id: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
X-Mailman-Approved-At: Tue, 28 Apr 2020 12:05:44 +0000
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 alex.bennee@linaro.org, vatsa@codeaurora.org, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

For better security, its desirable that a guest VM's memory is
not accessible to any entity that executes outside the context of
guest VM. In case of virtio, backend drivers execute outside the
context of guest VM and in general will need access to complete
guest VM memory.  One option to restrict the access provided to
backend driver is to make use of a bounce buffer. The bounce
buffer is accessible to both backend and frontend drivers. All IO
buffers that are in private space of guest VM are bounced to be
accessible to backend.

This patch proposes a new memory pool to be used for this bounce
purpose, rather than the default swiotlb memory pool. That will
avoid any conflicts that may arise in situations where a VM needs
to use swiotlb pool for driving any pass-through devices (in
which case swiotlb memory needs not be shared with another VM) as
well as virtio devices (which will require swiotlb memory to be
shared with backend VM). As a possible extension to this patch,
we can provide an option for virtio to make use of default
swiotlb memory pool itself, where no such conflicts may exist in
a given deployment.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 drivers/virtio/Makefile        |   2 +-
 drivers/virtio/virtio.c        |   2 +
 drivers/virtio/virtio_bounce.c | 150 +++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h         |   4 ++
 4 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_bounce.c

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 29a1386e..3fd3515 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_bounce.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32..bc2f779 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -329,6 +329,7 @@ int register_virtio_device(struct virtio_device *dev)
 
 	dev->index = err;
 	dev_set_name(&dev->dev, "virtio%u", dev->index);
+	virtio_bounce_set_dma_ops(dev);
 
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
@@ -431,6 +432,7 @@ EXPORT_SYMBOL_GPL(virtio_device_restore);
 
 static int virtio_init(void)
 {
+	virtio_map_bounce_buffer();
 	if (bus_register(&virtio_bus) != 0)
 		panic("virtio bus registration failed");
 	return 0;
diff --git a/drivers/virtio/virtio_bounce.c b/drivers/virtio/virtio_bounce.c
new file mode 100644
index 0000000..3de8e0e
--- /dev/null
+++ b/drivers/virtio/virtio_bounce.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Virtio DMA ops to bounce buffers
+ *
+ *  Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ *
+ * This module allows bouncing of IO buffers to a region which will be
+ * accessible to backend drivers.
+ */
+
+#include <linux/virtio.h>
+#include <linux/io.h>
+#include <linux/swiotlb.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+static phys_addr_t bounce_buf_paddr;
+static void *bounce_buf_vaddr;
+static size_t bounce_buf_size;
+struct swiotlb_pool *virtio_pool;
+
+#define VIRTIO_MAX_BOUNCE_SIZE	(16*4096)
+
+static void *virtio_alloc_coherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp_flags, unsigned long attrs)
+{
+	phys_addr_t addr;
+
+	if (!virtio_pool)
+		return NULL;
+
+	addr = swiotlb_alloc(virtio_pool, size, bounce_buf_paddr, ULONG_MAX);
+	if (addr == DMA_MAPPING_ERROR)
+		return NULL;
+
+	*dma_handle = (addr - bounce_buf_paddr);
+
+	return bounce_buf_vaddr + (addr - bounce_buf_paddr);
+}
+
+static void virtio_free_coherent(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_handle, unsigned long attrs)
+{
+	phys_addr_t addr = (dma_handle + bounce_buf_paddr);
+
+	swiotlb_free(virtio_pool, addr, size);
+}
+
+static dma_addr_t virtio_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	void *ptr = page_address(page) + offset;
+	phys_addr_t paddr = virt_to_phys(ptr);
+	dma_addr_t handle;
+
+	if (!virtio_pool)
+		return DMA_MAPPING_ERROR;
+
+	handle = _swiotlb_tbl_map_single(virtio_pool, dev, bounce_buf_paddr,
+					 paddr, size, size, dir, attrs);
+	if (handle == (phys_addr_t)DMA_MAPPING_ERROR)
+		return DMA_MAPPING_ERROR;
+
+	return handle - bounce_buf_paddr;
+}
+
+static void virtio_unmap_page(struct device *dev, dma_addr_t dev_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	phys_addr_t addr = dev_addr + bounce_buf_paddr;
+
+	_swiotlb_tbl_unmap_single(virtio_pool, dev, addr, size,
+					size, dir, attrs);
+}
+
+size_t virtio_max_mapping_size(struct device *dev)
+{
+	return VIRTIO_MAX_BOUNCE_SIZE;
+}
+
+static const struct dma_map_ops virtio_dma_ops = {
+	.alloc			= virtio_alloc_coherent,
+	.free			= virtio_free_coherent,
+	.map_page		= virtio_map_page,
+	.unmap_page		= virtio_unmap_page,
+	.max_mapping_size	= virtio_max_mapping_size,
+};
+
+void virtio_bounce_set_dma_ops(struct virtio_device *vdev)
+{
+	if (!bounce_buf_paddr)
+		return;
+
+	set_dma_ops(vdev->dev.parent, &virtio_dma_ops);
+}
+
+int virtio_map_bounce_buffer(void)
+{
+	int ret;
+
+	if (!bounce_buf_paddr)
+		return 0;
+
+	/*
+	 * Map region as 'cacheable' memory. This will reduce access latency for
+	 * backend.
+	 */
+	bounce_buf_vaddr = memremap(bounce_buf_paddr,
+				bounce_buf_size, MEMREMAP_WB);
+	if (!bounce_buf_vaddr)
+		return -ENOMEM;
+
+	memset(bounce_buf_vaddr, 0, bounce_buf_size);
+	virtio_pool = swiotlb_register_pool("virtio_swiotlb", bounce_buf_paddr,
+				bounce_buf_vaddr, bounce_buf_size);
+	if (IS_ERR(virtio_pool)) {
+		ret = PTR_ERR(virtio_pool);
+		virtio_pool = NULL;
+		memunmap(bounce_buf_vaddr);
+		return ret;
+	}
+
+	return 0;
+}
+
+int virtio_register_bounce_buffer(phys_addr_t base, size_t size)
+{
+	if (bounce_buf_paddr || !base || size < PAGE_SIZE)
+		return -EINVAL;
+
+	bounce_buf_paddr = base;
+	bounce_buf_size = size;
+
+	return 0;
+}
+
+static int __init virtio_bounce_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (!of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	return virtio_register_bounce_buffer(rmem->base, rmem->size);
+}
+
+RESERVEDMEM_OF_DECLARE(virtio, "virtio_bounce_pool", virtio_bounce_setup);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a493eac..c4970c5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -134,12 +134,16 @@ void virtio_config_changed(struct virtio_device *dev);
 void virtio_config_disable(struct virtio_device *dev);
 void virtio_config_enable(struct virtio_device *dev);
 int virtio_finalize_features(struct virtio_device *dev);
+int virtio_register_bounce_buffer(phys_addr_t base, size_t size);
+
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
 size_t virtio_max_dma_size(struct virtio_device *vdev);
+extern int virtio_map_bounce_buffer(void);
+extern void virtio_bounce_set_dma_ops(struct virtio_device *dev);
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
