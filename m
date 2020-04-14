Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F8C3815B
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4227206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLXgT3OH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4227206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AFD7387E30;
	Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 43svVL4atlDJ; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7B5387E38;
	Tue, 14 Apr 2020 17:04:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5344C089E;
	Tue, 14 Apr 2020 17:04:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E455AC0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D3B9385D41
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id isuHXKMRZnvq for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3761485C52
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:24 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id a201so14546009wme.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S/58K7cBrS1YFykN7VmQq2KvNUeWsC8Kj3y4e3rsJUw=;
 b=uLXgT3OHXzr7WIP4auqQ0pUv8jB2Gu0FXs++D/iW1VZEOlUBZmMat/59hNvuKXUHVV
 cj4phAFkT9jzp8HztcrX5t+2TAb4qA0LjGQEUWnFH8gjmt+8YlIN8lTszPCjIHtMgaDl
 +RsNTiX9lWpFt0xvxuj1Y7/EnMK2Tgn3uAczFgsSbHnCwz9xf3C5PfaBTA7IAgjwJjMZ
 dR5jWTfHyCsIkCvhMYaacBFfAwrri6XZ9ck7gAnzv0Q56dBwvd8l8DQmZyHxVe0dbawr
 eOvgpmKohhfl5I9Lw9Cwarrb0fFLaC9G1aeQ5gdGvcNxYT/GGUj9hJxnnVNK9OriRqMh
 ARJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S/58K7cBrS1YFykN7VmQq2KvNUeWsC8Kj3y4e3rsJUw=;
 b=byPAKt6kIiBMXSmd7QH+CM4IbsojkH68Si4U8DRHu3EF6wiKnUPf5lS+J0EruKnEJf
 tJsNqD2n+ObvEKEqy0HxWgy3iGZ2zjwPh7L1XZKRY0fLPCA/gd1pa/KqmmGPqJrbYyYB
 73spYjvT7Vu3g5qiaGxVNiGSg8TLp0qJ4ubYUlhOSLuTuhkg9hP0NJCA2jtSNuBNybBx
 SGfjj3HxiwpuRnj+r+610+7R2A6zInuagS3BQxy4W01V6Wn1i7b6YG24wMhLQQYMddm/
 uuFYGSJmLncuMwdEo+dqvPXfvcIAQuT8RbsXDDKAns8vyCdzm1L2fytDpAGi9c9L204X
 Y4Ow==
X-Gm-Message-State: AGi0PubL1iDOKgs3UaVKR30ndM42oo4lWTPunr5aWs7x/Igil5EpmHmy
 mfGjf/TO4uvkQF7zFQnhj1+uFgfsqOONEw==
X-Google-Smtp-Source: APiQypI0vgAsGsElkb0YGq38HI94/U7rQoGenBTR1uCdMWwGoH/G4ZuBZFDfVeGMR2g5eqEKJcObhQ==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr784284wml.44.1586883861665;
 Tue, 14 Apr 2020 10:04:21 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:21 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 03/25] iommu: Add a page fault handler
Date: Tue, 14 Apr 2020 19:02:31 +0200
Message-Id: <20200414170252.714402-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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

Some systems allow devices to handle I/O Page Faults in the core mm. For
example systems implementing the PCI PRI extension or Arm SMMU stall
model. Infrastructure for reporting these recoverable page faults was
recently added to the IOMMU core. Add a page fault handler for host SVA.

IOMMU driver can now instantiate several fault workqueues and link them to
IOPF-capable devices. Drivers can choose between a single global
workqueue, one per IOMMU device, one per low-level fault queue, one per
domain, etc.

When it receives a fault event, supposedly in an IRQ handler, the IOMMU
driver reports the fault using iommu_report_device_fault(), which calls
the registered handler. The page fault handler then calls the mm fault
handler, and reports either success or failure with iommu_page_response().
When the handler succeeded, the IOMMU retries the access.

The iopf_param pointer could be embedded into iommu_fault_param. But
putting iopf_param into the iommu_param structure allows us not to care
about ordering between calls to iopf_queue_add_device() and
iommu_register_device_fault_handler().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: Fix 'busy' refcount
---
 drivers/iommu/Kconfig      |   4 +
 drivers/iommu/Makefile     |   1 +
 include/linux/iommu.h      |  60 +++++
 drivers/iommu/io-pgfault.c | 452 +++++++++++++++++++++++++++++++++++++
 4 files changed, 517 insertions(+)
 create mode 100644 drivers/iommu/io-pgfault.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e81842f59b037..bf620bf48da03 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -109,6 +109,10 @@ config IOMMU_SVA
 	select IOMMU_API
 	select MMU_NOTIFIER
 
+config IOMMU_PAGE_FAULT
+	bool
+	select IOMMU_API
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 40c800dd4e3ef..bf5cb4ee84093 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
+obj-$(CONFIG_IOMMU_PAGE_FAULT) += io-pgfault.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 167e468dd3510..5a3d092c2568a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -343,12 +343,21 @@ struct iommu_fault_param {
 	struct mutex lock;
 };
 
+/**
+ * iopf_queue_flush_t - Flush low-level page fault queue
+ *
+ * Report all faults currently pending in the low-level page fault queue
+ */
+struct iopf_queue;
+typedef int (*iopf_queue_flush_t)(void *cookie, struct device *dev, int pasid);
+
 /**
  * struct dev_iommu - Collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
  * @sva_param:	 IOMMU parameter for SVA
  * @sva_lock:	 protects @sva_param
+ * @iopf_param:	 I/O Page Fault queue and data
  * @fwspec:	 IOMMU fwspec data
  * @priv:	 IOMMU Driver private data
  *
@@ -360,6 +369,7 @@ struct dev_iommu {
 	struct iommu_fault_param	*fault_param;
 	struct iommu_sva_param		*sva_param;
 	struct mutex			sva_lock;
+	struct iopf_device_param	*iopf_param;
 	struct iommu_fwspec		*fwspec;
 	void				*priv;
 };
@@ -1071,4 +1081,54 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
+#ifdef CONFIG_IOMMU_PAGE_FAULT
+extern int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
+
+extern int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
+extern int iopf_queue_remove_device(struct iopf_queue *queue,
+				    struct device *dev);
+extern int iopf_queue_flush_dev(struct device *dev, int pasid);
+extern struct iopf_queue *
+iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie);
+extern void iopf_queue_free(struct iopf_queue *queue);
+extern int iopf_queue_discard_partial(struct iopf_queue *queue);
+#else /* CONFIG_IOMMU_PAGE_FAULT */
+static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_add_device(struct iopf_queue *queue,
+					struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_remove_device(struct iopf_queue *queue,
+					   struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int iopf_queue_flush_dev(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
+
+static inline struct iopf_queue *
+iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie)
+{
+	return NULL;
+}
+
+static inline void iopf_queue_free(struct iopf_queue *queue)
+{
+}
+
+static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_IOMMU_PAGE_FAULT */
+
 #endif /* __LINUX_IOMMU_H */
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
new file mode 100644
index 0000000000000..5bba8e6a13be2
--- /dev/null
+++ b/drivers/iommu/io-pgfault.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle device page faults
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ */
+
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+/**
+ * struct iopf_queue - IO Page Fault queue
+ * @wq: the fault workqueue
+ * @flush: low-level flush callback
+ * @flush_arg: flush() argument
+ * @devices: devices attached to this queue
+ * @lock: protects the device list
+ */
+struct iopf_queue {
+	struct workqueue_struct		*wq;
+	iopf_queue_flush_t		flush;
+	void				*flush_arg;
+	struct list_head		devices;
+	struct mutex			lock;
+};
+
+/**
+ * struct iopf_device_param - IO Page Fault data attached to a device
+ * @dev: the device that owns this param
+ * @queue: IOPF queue
+ * @queue_list: index into queue->devices
+ * @partial: faults that are part of a Page Request Group for which the last
+ *           request hasn't been submitted yet.
+ * @busy: the param is being used
+ * @wq_head: signal a change to @busy
+ */
+struct iopf_device_param {
+	struct device			*dev;
+	struct iopf_queue		*queue;
+	struct list_head		queue_list;
+	struct list_head		partial;
+	unsigned long			busy;
+	wait_queue_head_t		wq_head;
+};
+
+struct iopf_fault {
+	struct iommu_fault		fault;
+	struct list_head		head;
+};
+
+struct iopf_group {
+	struct iopf_fault		last_fault;
+	struct list_head		faults;
+	struct work_struct		work;
+	struct device			*dev;
+};
+
+static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
+			       enum iommu_page_response_code status)
+{
+	struct iommu_page_response resp = {
+		.version		= IOMMU_PAGE_RESP_VERSION_1,
+		.pasid			= iopf->fault.prm.pasid,
+		.grpid			= iopf->fault.prm.grpid,
+		.code			= status,
+	};
+
+	if (iopf->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
+		resp.flags = IOMMU_PAGE_RESP_PASID_VALID;
+
+	return iommu_page_response(dev, &resp);
+}
+
+static enum iommu_page_response_code
+iopf_handle_single(struct iopf_fault *iopf)
+{
+	/* TODO */
+	return -ENODEV;
+}
+
+static void iopf_handle_group(struct work_struct *work)
+{
+	struct iopf_group *group;
+	struct iopf_fault *iopf, *next;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
+
+	group = container_of(work, struct iopf_group, work);
+
+	list_for_each_entry_safe(iopf, next, &group->faults, head) {
+		/*
+		 * For the moment, errors are sticky: don't handle subsequent
+		 * faults in the group if there is an error.
+		 */
+		if (status == IOMMU_PAGE_RESP_SUCCESS)
+			status = iopf_handle_single(iopf);
+
+		if (!(iopf->fault.prm.flags &
+		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
+			kfree(iopf);
+	}
+
+	iopf_complete_group(group->dev, &group->last_fault, status);
+	kfree(group);
+}
+
+/**
+ * iommu_queue_iopf - IO Page Fault handler
+ * @evt: fault event
+ * @cookie: struct device, passed to iommu_register_device_fault_handler.
+ *
+ * Add a fault to the device workqueue, to be handled by mm.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+{
+	int ret;
+	struct iopf_group *group;
+	struct iopf_fault *iopf, *next;
+	struct iopf_device_param *iopf_param;
+
+	struct device *dev = cookie;
+	struct dev_iommu *param = dev->iommu;
+
+	lockdep_assert_held(&param->lock);
+
+	if (fault->type != IOMMU_FAULT_PAGE_REQ)
+		/* Not a recoverable page fault */
+		return -EOPNOTSUPP;
+
+	/*
+	 * As long as we're holding param->lock, the queue can't be unlinked
+	 * from the device and therefore cannot disappear.
+	 */
+	iopf_param = param->iopf_param;
+	if (!iopf_param)
+		return -ENODEV;
+
+	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
+		iopf = kzalloc(sizeof(*iopf), GFP_KERNEL);
+		if (!iopf)
+			return -ENOMEM;
+
+		iopf->fault = *fault;
+
+		/* Non-last request of a group. Postpone until the last one */
+		list_add(&iopf->head, &iopf_param->partial);
+
+		return 0;
+	}
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group) {
+		/*
+		 * The caller will send a response to the hardware. But we do
+		 * need to clean up before leaving, otherwise partial faults
+		 * will be stuck.
+		 */
+		ret = -ENOMEM;
+		goto cleanup_partial;
+	}
+
+	group->dev = dev;
+	group->last_fault.fault = *fault;
+	INIT_LIST_HEAD(&group->faults);
+	list_add(&group->last_fault.head, &group->faults);
+	INIT_WORK(&group->work, iopf_handle_group);
+
+	/* See if we have partial faults for this group */
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, head) {
+		if (iopf->fault.prm.grpid == fault->prm.grpid)
+			/* Insert *before* the last fault */
+			list_move(&iopf->head, &group->faults);
+	}
+
+	queue_work(iopf_param->queue->wq, &group->work);
+	return 0;
+
+cleanup_partial:
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, head) {
+		if (iopf->fault.prm.grpid == fault->prm.grpid) {
+			list_del(&iopf->head);
+			kfree(iopf);
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_queue_iopf);
+
+/**
+ * iopf_queue_flush_dev - Ensure that all queued faults have been processed
+ * @dev: the endpoint whose faults need to be flushed.
+ * @pasid: the PASID affected by this flush
+ *
+ * Users must call this function when releasing a PASID, to ensure that all
+ * pending faults for this PASID have been handled, and won't hit the address
+ * space of the next process that uses this PASID.
+ *
+ * This function can also be called before shutting down the device, in which
+ * case @pasid should be IOMMU_PASID_INVALID.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_flush_dev(struct device *dev, int pasid)
+{
+	int ret = 0;
+	struct iopf_queue *queue;
+	struct iopf_device_param *iopf_param;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return -ENODEV;
+
+	/*
+	 * It is incredibly easy to find ourselves in a deadlock situation if
+	 * we're not careful, because we're taking the opposite path as
+	 * iommu_queue_iopf:
+	 *
+	 *   iopf_queue_flush_dev()   |  PRI queue handler
+	 *    lock(&param->lock)      |   iommu_queue_iopf()
+	 *     queue->flush()         |    lock(&param->lock)
+	 *      wait PRI queue empty  |
+	 *
+	 * So we can't hold the device param lock while flushing. Take a
+	 * reference to the device param instead, to prevent the queue from
+	 * going away.
+	 */
+	mutex_lock(&param->lock);
+	iopf_param = param->iopf_param;
+	if (iopf_param) {
+		queue = param->iopf_param->queue;
+		iopf_param->busy++;
+	} else {
+		ret = -ENODEV;
+	}
+	mutex_unlock(&param->lock);
+	if (ret)
+		return ret;
+
+	/*
+	 * When removing a PASID, the device driver tells the device to stop
+	 * using it, and flush any pending fault to the IOMMU. In this flush
+	 * callback, the IOMMU driver makes sure that there are no such faults
+	 * left in the low-level queue.
+	 */
+	queue->flush(queue->flush_arg, dev, pasid);
+
+	flush_workqueue(queue->wq);
+
+	mutex_lock(&param->lock);
+	iopf_param->busy--;
+	wake_up(&iopf_param->wq_head);
+	mutex_unlock(&param->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
+
+/**
+ * iopf_queue_discard_partial - Remove all pending partial fault
+ * @queue: the queue whose partial faults need to be discarded
+ *
+ * When the hardware queue overflows, last page faults in a group may have been
+ * lost and the IOMMU driver calls this to discard all partial faults. The
+ * driver shouldn't be adding new faults to this queue concurrently.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_discard_partial(struct iopf_queue *queue)
+{
+	struct iopf_fault *iopf, *next;
+	struct iopf_device_param *iopf_param;
+
+	if (!queue)
+		return -EINVAL;
+
+	mutex_lock(&queue->lock);
+	list_for_each_entry(iopf_param, &queue->devices, queue_list) {
+		list_for_each_entry_safe(iopf, next, &iopf_param->partial, head)
+			kfree(iopf);
+	}
+	mutex_unlock(&queue->lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_discard_partial);
+
+/**
+ * iopf_queue_add_device - Add producer to the fault queue
+ * @queue: IOPF queue
+ * @dev: device to add
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
+{
+	int ret = -EINVAL;
+	struct iopf_device_param *iopf_param;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return -ENODEV;
+
+	iopf_param = kzalloc(sizeof(*iopf_param), GFP_KERNEL);
+	if (!iopf_param)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&iopf_param->partial);
+	iopf_param->queue = queue;
+	iopf_param->dev = dev;
+	init_waitqueue_head(&iopf_param->wq_head);
+
+	mutex_lock(&queue->lock);
+	mutex_lock(&param->lock);
+	if (!param->iopf_param) {
+		list_add(&iopf_param->queue_list, &queue->devices);
+		param->iopf_param = iopf_param;
+		ret = 0;
+	}
+	mutex_unlock(&param->lock);
+	mutex_unlock(&queue->lock);
+
+	if (ret)
+		kfree(iopf_param);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_add_device);
+
+/**
+ * iopf_queue_remove_device - Remove producer from fault queue
+ * @queue: IOPF queue
+ * @dev: device to remove
+ *
+ * Caller makes sure that no more faults are reported for this device.
+ *
+ * Return: 0 on success and <0 on error.
+ */
+int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
+{
+	bool busy;
+	int ret = 0;
+	struct iopf_fault *iopf, *next;
+	struct iopf_device_param *iopf_param;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param || !queue)
+		return -EINVAL;
+
+	do {
+		mutex_lock(&queue->lock);
+		mutex_lock(&param->lock);
+		iopf_param = param->iopf_param;
+		if (iopf_param && iopf_param->queue == queue) {
+			busy = iopf_param->busy;
+			if (!busy) {
+				list_del(&iopf_param->queue_list);
+				param->iopf_param = NULL;
+			}
+		} else {
+			ret = -EINVAL;
+		}
+		mutex_unlock(&param->lock);
+		mutex_unlock(&queue->lock);
+		if (ret)
+			return ret;
+
+		/*
+		 * If there is an ongoing flush, wait for it to complete and
+		 * then retry. iopf_param isn't going away since we're the only
+		 * thread that can free it.
+		 */
+		if (busy)
+			wait_event(iopf_param->wq_head, !iopf_param->busy);
+	} while (busy);
+
+	/* Just in case some faults are still stuck */
+	list_for_each_entry_safe(iopf, next, &iopf_param->partial, head)
+		kfree(iopf);
+
+	kfree(iopf_param);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_remove_device);
+
+/**
+ * iopf_queue_alloc - Allocate and initialize a fault queue
+ * @name: a unique string identifying the queue (for workqueue)
+ * @flush: a callback that flushes the low-level queue
+ * @cookie: driver-private data passed to the flush callback
+ *
+ * The callback is called before the workqueue is flushed. The IOMMU driver must
+ * commit all faults that are pending in its low-level queues at the time of the
+ * call, into the IOPF queue (with iommu_report_device_fault). The callback
+ * takes a device pointer as argument, hinting what endpoint is causing the
+ * flush. When the device is NULL, all faults should be committed.
+ *
+ * Return: the queue on success and NULL on error.
+ */
+struct iopf_queue *
+iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie)
+{
+	struct iopf_queue *queue;
+
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue)
+		return NULL;
+
+	/*
+	 * The WQ is unordered because the low-level handler enqueues faults by
+	 * group. PRI requests within a group have to be ordered, but once
+	 * that's dealt with, the high-level function can handle groups out of
+	 * order.
+	 */
+	queue->wq = alloc_workqueue("iopf_queue/%s", WQ_UNBOUND, 0, name);
+	if (!queue->wq) {
+		kfree(queue);
+		return NULL;
+	}
+
+	queue->flush = flush;
+	queue->flush_arg = cookie;
+	INIT_LIST_HEAD(&queue->devices);
+	mutex_init(&queue->lock);
+
+	return queue;
+}
+EXPORT_SYMBOL_GPL(iopf_queue_alloc);
+
+/**
+ * iopf_queue_free - Free IOPF queue
+ * @queue: queue to free
+ *
+ * Counterpart to iopf_queue_alloc(). The driver must not be queuing faults or
+ * adding/removing devices on this queue anymore.
+ */
+void iopf_queue_free(struct iopf_queue *queue)
+{
+	struct iopf_device_param *iopf_param, *next;
+
+	if (!queue)
+		return;
+
+	list_for_each_entry_safe(iopf_param, next, &queue->devices, queue_list)
+		iopf_queue_remove_device(queue, iopf_param->dev);
+
+	destroy_workqueue(queue->wq);
+	kfree(queue);
+}
+EXPORT_SYMBOL_GPL(iopf_queue_free);
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
