Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447BC8300B
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:03:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA0220838
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aE/6AvmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA0220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A5E2887E0B;
	Thu, 30 Apr 2020 10:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yp9YzlN3gWpk; Thu, 30 Apr 2020 10:03:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8FB3F87E08;
	Thu, 30 Apr 2020 10:03:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77AACC088E;
	Thu, 30 Apr 2020 10:03:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 712B1C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6064C885D3
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIqke--M+dRl for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 10:03:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 49DDD88684
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:03:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588240994; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GzOQaZhkTsXQ0ZLc1DIGFBouSnKM6Gu0ASksSMRWSZg=;
 b=aE/6AvmJQKInO6XxsyYYop5InW8yc/fu9xHyNINNiU0YE0nlYzStR/yz+j4bbFnMQUjlHXgm
 UR8W5nuPzvIE3JiZg3QR6oiFvyoZ/BeK14rit5kNbQfZfyuNUwiqC0oyFPGE4zlbz6yS/Ot8
 60GCeI35fEDKecYwxfNYkyqUbF0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaaa261.7ff7ec8e6880-smtp-out-n05;
 Thu, 30 Apr 2020 10:03:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 1C448C44791; Thu, 30 Apr 2020 10:03:12 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 91D13C432C2;
 Thu, 30 Apr 2020 10:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91D13C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
 jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Subject: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Date: Thu, 30 Apr 2020 15:32:56 +0530
Message-Id: <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
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

Some hypervisors may not support MMIO transport i.e trap config
space access and have it be handled by backend driver. They may
allow other ways to interact with backend such as message-queue
or doorbell API. This patch allows for hypervisor specific
methods for config space IO.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
 include/linux/virtio.h       |  14 +++++
 2 files changed, 94 insertions(+), 51 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97d5725..69bfa35 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -100,7 +100,35 @@ struct virtio_mmio_vq_info {
 	struct list_head node;
 };
 
+#ifdef CONFIG_VIRTIO_MMIO_OPS
 
+static struct virtio_mmio_ops *mmio_ops;
+
+#define virtio_readb(a)		mmio_ops->mmio_readl((a))
+#define virtio_readw(a)		mmio_ops->mmio_readl((a))
+#define virtio_readl(a)		mmio_ops->mmio_readl((a))
+#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
+#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
+#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))
+
+int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
+{
+	pr_info("Registered %s as mmio ops\n", ops->name);
+	mmio_ops = ops;
+
+	return 0;
+}
+
+#else	/* CONFIG_VIRTIO_MMIO_OPS */
+
+#define virtio_readb(a)		readb((a))
+#define virtio_readw(a)		readw((a))
+#define virtio_readl(a)		readl((a))
+#define virtio_writeb(val, a)	writeb((val), (a))
+#define virtio_writew(val, a)	writew((val), (a))
+#define virtio_writel(val, a)	writel((val), (a))
+
+#endif	/* CONFIG_VIRTIO_MMIO_OPS */
 
 /* Configuration interface */
 
@@ -109,12 +137,12 @@ static u64 vm_get_features(struct virtio_device *vdev)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	u64 features;
 
-	writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
-	features = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
+	virtio_writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
+	features = virtio_readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
 	features <<= 32;
 
-	writel(0, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
-	features |= readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
+	virtio_writel(0, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
+	features |= virtio_readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
 
 	return features;
 }
@@ -133,12 +161,12 @@ static int vm_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	writel(1, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
-	writel((u32)(vdev->features >> 32),
+	virtio_writel(1, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
+	virtio_writel((u32)(vdev->features >> 32),
 			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
 
-	writel(0, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
-	writel((u32)vdev->features,
+	virtio_writel(0, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
+	virtio_writel((u32)vdev->features,
 			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
 
 	return 0;
@@ -158,25 +186,25 @@ static void vm_get(struct virtio_device *vdev, unsigned offset,
 		int i;
 
 		for (i = 0; i < len; i++)
-			ptr[i] = readb(base + offset + i);
+			ptr[i] = virtio_readb(base + offset + i);
 		return;
 	}
 
 	switch (len) {
 	case 1:
-		b = readb(base + offset);
+		b = virtio_readb(base + offset);
 		memcpy(buf, &b, sizeof b);
 		break;
 	case 2:
-		w = cpu_to_le16(readw(base + offset));
+		w = cpu_to_le16(virtio_readw(base + offset));
 		memcpy(buf, &w, sizeof w);
 		break;
 	case 4:
-		l = cpu_to_le32(readl(base + offset));
+		l = cpu_to_le32(virtio_readl(base + offset));
 		memcpy(buf, &l, sizeof l);
 		break;
 	case 8:
-		l = cpu_to_le32(readl(base + offset));
+		l = cpu_to_le32(virtio_readl(base + offset));
 		memcpy(buf, &l, sizeof l);
 		l = cpu_to_le32(ioread32(base + offset + sizeof l));
 		memcpy(buf + sizeof l, &l, sizeof l);
@@ -200,7 +228,7 @@ static void vm_set(struct virtio_device *vdev, unsigned offset,
 		int i;
 
 		for (i = 0; i < len; i++)
-			writeb(ptr[i], base + offset + i);
+			virtio_writeb(ptr[i], base + offset + i);
 
 		return;
 	}
@@ -208,21 +236,21 @@ static void vm_set(struct virtio_device *vdev, unsigned offset,
 	switch (len) {
 	case 1:
 		memcpy(&b, buf, sizeof b);
-		writeb(b, base + offset);
+		virtio_writeb(b, base + offset);
 		break;
 	case 2:
 		memcpy(&w, buf, sizeof w);
-		writew(le16_to_cpu(w), base + offset);
+		virtio_writew(le16_to_cpu(w), base + offset);
 		break;
 	case 4:
 		memcpy(&l, buf, sizeof l);
-		writel(le32_to_cpu(l), base + offset);
+		virtio_writel(le32_to_cpu(l), base + offset);
 		break;
 	case 8:
 		memcpy(&l, buf, sizeof l);
-		writel(le32_to_cpu(l), base + offset);
+		virtio_writel(le32_to_cpu(l), base + offset);
 		memcpy(&l, buf + sizeof l, sizeof l);
-		writel(le32_to_cpu(l), base + offset + sizeof l);
+		virtio_writel(le32_to_cpu(l), base + offset + sizeof l);
 		break;
 	default:
 		BUG();
@@ -236,14 +264,14 @@ static u32 vm_generation(struct virtio_device *vdev)
 	if (vm_dev->version == 1)
 		return 0;
 	else
-		return readl(vm_dev->base + VIRTIO_MMIO_CONFIG_GENERATION);
+		return virtio_readl(vm_dev->base + VIRTIO_MMIO_CONFIG_GENERATION);
 }
 
 static u8 vm_get_status(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 
-	return readl(vm_dev->base + VIRTIO_MMIO_STATUS) & 0xff;
+	return virtio_readl(vm_dev->base + VIRTIO_MMIO_STATUS) & 0xff;
 }
 
 static void vm_set_status(struct virtio_device *vdev, u8 status)
@@ -253,7 +281,7 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
 
-	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
+	virtio_writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
 }
 
 static void vm_reset(struct virtio_device *vdev)
@@ -261,7 +289,7 @@ static void vm_reset(struct virtio_device *vdev)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 
 	/* 0 status means a reset. */
-	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+	virtio_writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
 }
 
 
@@ -275,7 +303,7 @@ static bool vm_notify(struct virtqueue *vq)
 
 	/* We write the queue's selector into the notification register to
 	 * signal the other end */
-	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	virtio_writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
 	return true;
 }
 
@@ -289,8 +317,8 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	irqreturn_t ret = IRQ_NONE;
 
 	/* Read and acknowledge interrupts */
-	status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
-	writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
+	status = virtio_readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
+	virtio_writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
 
 	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
 		virtio_config_changed(&vm_dev->vdev);
@@ -321,12 +349,12 @@ static void vm_del_vq(struct virtqueue *vq)
 	spin_unlock_irqrestore(&vm_dev->lock, flags);
 
 	/* Select and deactivate the queue */
-	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
+	virtio_writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 	if (vm_dev->version == 1) {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
-		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
+		virtio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+		WARN_ON(virtio_readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
 
 	vring_del_virtqueue(vq);
@@ -360,10 +388,10 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 		return NULL;
 
 	/* Select the queue we're interested in */
-	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
+	virtio_writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 
 	/* Queue shouldn't already be set up. */
-	if (readl(vm_dev->base + (vm_dev->version == 1 ?
+	if (virtio_readl(vm_dev->base + (vm_dev->version == 1 ?
 			VIRTIO_MMIO_QUEUE_PFN : VIRTIO_MMIO_QUEUE_READY))) {
 		err = -ENOENT;
 		goto error_available;
@@ -376,7 +404,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 		goto error_kmalloc;
 	}
 
-	num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
+	num = virtio_readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
 	if (num == 0) {
 		err = -ENOENT;
 		goto error_new_virtqueue;
@@ -391,7 +419,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	}
 
 	/* Activate the queue */
-	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
+	virtio_writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (vm_dev->version == 1) {
 		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
 
@@ -408,27 +436,27 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 			goto error_bad_pfn;
 		}
 
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
-		writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
+		virtio_writel(q_pfn, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
 		u64 addr;
 
 		addr = virtqueue_get_desc_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
-		writel((u32)(addr >> 32),
+		virtio_writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
+		virtio_writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
 
 		addr = virtqueue_get_avail_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
-		writel((u32)(addr >> 32),
+		virtio_writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
+		virtio_writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
 
 		addr = virtqueue_get_used_addr(vq);
-		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
-		writel((u32)(addr >> 32),
+		virtio_writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
+		virtio_writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
 
-		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+		virtio_writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
 	}
 
 	vq->priv = info;
@@ -444,10 +472,10 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	vring_del_virtqueue(vq);
 error_new_virtqueue:
 	if (vm_dev->version == 1) {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
-		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
-		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
+		virtio_writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
+		WARN_ON(virtio_readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
 	kfree(info);
 error_kmalloc:
@@ -514,6 +542,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.bus_name	= vm_bus_name,
 };
 
+static const struct virtio_mmio_ops virtio_mmio_default_ops;
 
 static void virtio_mmio_release_dev(struct device *_d)
 {
@@ -550,21 +579,21 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		return PTR_ERR(vm_dev->base);
 
 	/* Check magic value */
-	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
+	magic = virtio_readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
 		return -ENODEV;
 	}
 
 	/* Check device version */
-	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
+	vm_dev->version = virtio_readl(vm_dev->base + VIRTIO_MMIO_VERSION);
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
 		return -ENXIO;
 	}
 
-	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
+	vm_dev->vdev.id.device = virtio_readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
 	if (vm_dev->vdev.id.device == 0) {
 		/*
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
@@ -572,10 +601,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		 */
 		return -ENODEV;
 	}
-	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
+	vm_dev->vdev.id.vendor = virtio_readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
 	if (vm_dev->version == 1) {
-		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+		virtio_writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 
 		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 		/*
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a493eac..652ccfb 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -119,6 +119,20 @@ struct virtio_device {
 	void *priv;
 };
 
+#define MAX_MMIO_NAME_SIZE 32
+
+struct virtio_mmio_ops {
+	char name[MAX_MMIO_NAME_SIZE];
+	u8 (*mmio_readb)(const volatile void __iomem *addr);
+	u16 (*mmio_readw)(const volatile void __iomem *addr);
+	u32 (*mmio_readl)(const volatile void __iomem *addr);
+	void (*mmio_writeb)(u8 val, volatile void __iomem *addr);
+	void (*mmio_writew)(u16 val, volatile void __iomem *addr);
+	void (*mmio_writel)(u32 val, volatile void __iomem *addr);
+};
+
+extern int register_virtio_mmio_ops(struct virtio_mmio_ops *ops);
+
 static inline struct virtio_device *dev_to_virtio(struct device *_dev)
 {
 	return container_of(_dev, struct virtio_device, dev);
-- 
2.7.4


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
