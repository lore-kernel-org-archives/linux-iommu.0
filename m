Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0739C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 12:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8ACC240AAE;
	Fri, 18 Feb 2022 12:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vg8oY7dBn0gD; Fri, 18 Feb 2022 12:12:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1022E40297;
	Fri, 18 Feb 2022 12:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CECD5C0021;
	Fri, 18 Feb 2022 12:12:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 719F4C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56D33403A2
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kc63XugNXSL0 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 12:12:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F975405CB
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A0ES94RB8ss0IE5g/Imh4fw5K6SE/rzur7MuY1WTuvE=; b=vtczx+b9uHmxAJfzit9FlIrEX7
 wlQ3II06qVnJhbCuexXqp0AO8xMqszCUCFVevcuxouVxSHFdNNNVhXRJC+9CkfMJfK2Wl5hLSGpwP
 4e+7yI7Nt5WeSCEpo1OIyCMhqdTimmfIdPAlK/ZO8OWLlhveCws+g5+krO9K7EV4tbKYosFtrR27t
 PHMTaipD5gw8P17EVZQgqxrgPxHmEcRZ9AspZ/f8H6LC0FfzgMm/UTP5GkZPe5KEgcJFjwkgpFofy
 0kRJBvAX2Laa1qID70nUeAvHxU3IHfrh41PLOSMFeTKxPVkcM1EdETGuL2qnhYNvl/ZzW2BPMXVtx
 u8ESujqw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <mperttunen@nvidia.com>)
 id 1nL1fq-0006eP-0w; Fri, 18 Feb 2022 13:43:42 +0200
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Subject: [PATCH v3 3/9] gpu: host1x: Add context device management code
Date: Fri, 18 Feb 2022 13:39:46 +0200
Message-Id: <20220218113952.3077606-4-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220218113952.3077606-1-mperttunen@nvidia.com>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Mikko Perttunen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mikko Perttunen <mperttunen@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add code to register context devices from device tree, allocate them
out and manage their refcounts.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
* Directly set DMA mask instead of inheriting from Host1x.
* Use iommu-map instead of custom DT property.
---
 drivers/gpu/host1x/Makefile  |   1 +
 drivers/gpu/host1x/context.c | 174 +++++++++++++++++++++++++++++++++++
 drivers/gpu/host1x/context.h |  27 ++++++
 drivers/gpu/host1x/dev.c     |  12 ++-
 drivers/gpu/host1x/dev.h     |   2 +
 include/linux/host1x.h       |  17 ++++
 6 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/host1x/context.c
 create mode 100644 drivers/gpu/host1x/context.h

diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index c891a3e33844..8a65e13d113a 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -10,6 +10,7 @@ host1x-y = \
 	debug.o \
 	mipi.o \
 	fence.o \
+	context.o \
 	hw/host1x01.o \
 	hw/host1x02.o \
 	hw/host1x04.o \
diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
new file mode 100644
index 000000000000..987c08a1e2f2
--- /dev/null
+++ b/drivers/gpu/host1x/context.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, NVIDIA Corporation.
+ */
+
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pid.h>
+#include <linux/slab.h>
+
+#include "context.h"
+#include "dev.h"
+
+/*
+ * Due to an issue with T194 NVENC, only 38 bits can be used.
+ * Anyway, 256GiB of IOVA ought to be enough for anyone.
+ */
+static dma_addr_t context_device_dma_mask = DMA_BIT_MASK(38);
+
+int host1x_context_list_init(struct host1x *host1x)
+{
+	struct host1x_context_list *cdl = &host1x->context_list;
+	struct host1x_context *ctx;
+	struct device_node *node;
+	int index;
+	int err;
+
+	node = of_get_child_by_name(host1x->dev->of_node, "memory-contexts");
+	if (!node)
+		return 0;
+
+	cdl->devs = NULL;
+	cdl->len = 0;
+	mutex_init(&cdl->lock);
+
+	err = of_property_count_u32_elems(node, "iommu-map");
+	if (err < 0) {
+		err = 0;
+		goto put_node;
+	}
+
+	cdl->devs = kcalloc(err, sizeof(*cdl->devs), GFP_KERNEL);
+	if (!cdl->devs) {
+		err = -ENOMEM;
+		goto put_node;
+	}
+	cdl->len = err / 4;
+
+	for (index = 0; index < cdl->len; index++) {
+		struct iommu_fwspec *fwspec;
+
+		ctx = &cdl->devs[index];
+
+		ctx->host = host1x;
+
+		device_initialize(&ctx->dev);
+
+		ctx->dev.dma_mask = &context_device_dma_mask;
+		ctx->dev.coherent_dma_mask = context_device_dma_mask;
+		dev_set_name(&ctx->dev, "host1x-ctx.%d", index);
+		ctx->dev.bus = &host1x_context_device_bus_type;
+		ctx->dev.parent = host1x->dev;
+
+		dma_set_max_seg_size(&ctx->dev, UINT_MAX);
+
+		err = device_add(&ctx->dev);
+		if (err) {
+			dev_err(host1x->dev, "could not add context device %d: %d\n", index, err);
+			goto del_devices;
+		}
+
+		err = of_dma_configure_id(&ctx->dev, node, true, &index);
+		if (err) {
+			dev_err(host1x->dev, "IOMMU configuration failed for context device %d: %d\n",
+				index, err);
+			device_del(&ctx->dev);
+			goto del_devices;
+		}
+
+		fwspec = dev_iommu_fwspec_get(&ctx->dev);
+		if (!fwspec) {
+			dev_err(host1x->dev, "Context device %d has no IOMMU!\n", index);
+			device_del(&ctx->dev);
+			goto del_devices;
+		}
+
+		ctx->stream_id = fwspec->ids[0] & 0xffff;
+	}
+
+	of_node_put(node);
+
+	return 0;
+
+del_devices:
+	while (--index >= 0)
+		device_del(&cdl->devs[index].dev);
+
+	kfree(cdl->devs);
+	cdl->len = 0;
+
+put_node:
+	of_node_put(node);
+
+	return err;
+}
+
+void host1x_context_list_free(struct host1x_context_list *cdl)
+{
+	int i;
+
+	for (i = 0; i < cdl->len; i++)
+		device_del(&cdl->devs[i].dev);
+
+	kfree(cdl->devs);
+	cdl->len = 0;
+}
+
+struct host1x_context *host1x_context_alloc(struct host1x *host1x,
+					    struct pid *pid)
+{
+	struct host1x_context_list *cdl = &host1x->context_list;
+	struct host1x_context *free = NULL;
+	int i;
+
+	if (!cdl->len)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mutex_lock(&cdl->lock);
+
+	for (i = 0; i < cdl->len; i++) {
+		struct host1x_context *cd = &cdl->devs[i];
+
+		if (cd->owner == pid) {
+			refcount_inc(&cd->ref);
+			mutex_unlock(&cdl->lock);
+			return cd;
+		} else if (!cd->owner && !free) {
+			free = cd;
+		}
+	}
+
+	if (!free) {
+		mutex_unlock(&cdl->lock);
+		return ERR_PTR(-EBUSY);
+	}
+
+	refcount_set(&free->ref, 1);
+	free->owner = get_pid(pid);
+
+	mutex_unlock(&cdl->lock);
+
+	return free;
+}
+EXPORT_SYMBOL(host1x_context_alloc);
+
+void host1x_context_get(struct host1x_context *cd)
+{
+	refcount_inc(&cd->ref);
+}
+EXPORT_SYMBOL(host1x_context_get);
+
+void host1x_context_put(struct host1x_context *cd)
+{
+	struct host1x_context_list *cdl = &cd->host->context_list;
+
+	if (refcount_dec_and_mutex_lock(&cd->ref, &cdl->lock)) {
+		put_pid(cd->owner);
+		cd->owner = NULL;
+		mutex_unlock(&cdl->lock);
+	}
+}
+EXPORT_SYMBOL(host1x_context_put);
diff --git a/drivers/gpu/host1x/context.h b/drivers/gpu/host1x/context.h
new file mode 100644
index 000000000000..268ecdf6b1bb
--- /dev/null
+++ b/drivers/gpu/host1x/context.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Host1x context devices
+ *
+ * Copyright (c) 2020, NVIDIA Corporation.
+ */
+
+#ifndef __HOST1X_CONTEXT_H
+#define __HOST1X_CONTEXT_H
+
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+
+struct host1x;
+
+extern struct bus_type host1x_context_device_bus_type;
+
+struct host1x_context_list {
+	struct mutex lock;
+	struct host1x_context *devs;
+	unsigned int len;
+};
+
+int host1x_context_list_init(struct host1x *host1x);
+void host1x_context_list_free(struct host1x_context_list *cdl);
+
+#endif
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 6994f8c0e02e..40f64efd5865 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -28,6 +28,7 @@
 
 #include "bus.h"
 #include "channel.h"
+#include "context.h"
 #include "debug.h"
 #include "dev.h"
 #include "intr.h"
@@ -502,10 +503,16 @@ static int host1x_probe(struct platform_device *pdev)
 		goto iommu_exit;
 	}
 
+	err = host1x_context_list_init(host);
+	if (err) {
+		dev_err(&pdev->dev, "failed to initialize context list\n");
+		goto free_channels;
+	}
+
 	err = host1x_syncpt_init(host);
 	if (err) {
 		dev_err(&pdev->dev, "failed to initialize syncpts\n");
-		goto free_channels;
+		goto free_contexts;
 	}
 
 	err = host1x_intr_init(host, syncpt_irq);
@@ -549,6 +556,8 @@ static int host1x_probe(struct platform_device *pdev)
 	host1x_intr_deinit(host);
 deinit_syncpt:
 	host1x_syncpt_deinit(host);
+free_contexts:
+	host1x_context_list_free(&host->context_list);
 free_channels:
 	host1x_channel_list_free(&host->channel_list);
 iommu_exit:
@@ -568,6 +577,7 @@ static int host1x_remove(struct platform_device *pdev)
 
 	host1x_intr_deinit(host);
 	host1x_syncpt_deinit(host);
+	host1x_context_list_free(&host->context_list);
 	host1x_iommu_exit(host);
 	host1x_bo_cache_destroy(&host->cache);
 
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index ca4b082f0cd4..92f4804d8b70 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -14,6 +14,7 @@
 
 #include "cdma.h"
 #include "channel.h"
+#include "context.h"
 #include "intr.h"
 #include "job.h"
 #include "syncpt.h"
@@ -141,6 +142,7 @@ struct host1x {
 	struct mutex syncpt_mutex;
 
 	struct host1x_channel_list channel_list;
+	struct host1x_context_list context_list;
 
 	struct dentry *debugfs;
 
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e8dc5bc41f79..9d9f1711472b 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -440,4 +440,21 @@ int tegra_mipi_disable(struct tegra_mipi_device *device);
 int tegra_mipi_start_calibration(struct tegra_mipi_device *device);
 int tegra_mipi_finish_calibration(struct tegra_mipi_device *device);
 
+/* host1x context devices */
+
+struct host1x_context {
+	struct host1x *host;
+
+	refcount_t ref;
+	struct pid *owner;
+
+	struct device dev;
+	u32 stream_id;
+};
+
+struct host1x_context *host1x_context_alloc(struct host1x *host1x,
+					    struct pid *pid);
+void host1x_context_get(struct host1x_context *cd);
+void host1x_context_put(struct host1x_context *cd);
+
 #endif
-- 
2.35.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
