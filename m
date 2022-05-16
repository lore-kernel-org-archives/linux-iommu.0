Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B85C433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 09:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 131C440AF7;
	Mon, 16 May 2022 09:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id USU3Uwi5G12j; Mon, 16 May 2022 09:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 97E8840AF1;
	Mon, 16 May 2022 09:20:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AA35C0039;
	Mon, 16 May 2022 09:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2B8DC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D080A40AF1
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XBRVibcrxdxR for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:20:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6F4D40396
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FPpZYcd65p9L5JcibP3JDILC9+us9sfPI6bsJC4UG0s=; b=P+m3VmW/aH6+j8jcxIK/JATwsA
 4lPJaxv8vsDM7PeRcScxr/vyz/5LffJiujlLV3okqXvkmqgIM3fcnXtaUqxITuatLJsYfING/rQQl
 3W8CVcJIgiuShlw+Ctz36e8gJVGhkmuU1tJ48BFlz1nsmTukL7tlEsnoVVvmDwu7DRSl+Owi9vYbq
 vUTUqnn6G1gnXyYpdTMHHdsQSqykDtfFfyvDiJ77LmN4VzjGLDfNp0FAJz7NX7RgoTv3z9WuTlyBF
 ObFXXeofahECAqsY7Ol0CK0Y7bRpd/oK/dQ3Tr40lHm0LFbjexdaPyhVePTHPIkbFl7iW7lDqJfoR
 2E2FpSlw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <cyndis@kapsi.fi>)
 id 1nqWTe-0005fd-NK; Mon, 16 May 2022 11:53:18 +0300
From: cyndis@kapsi.fi
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
Subject: [PATCH v5 3/9] gpu: host1x: Add context device management code
Date: Mon, 16 May 2022 11:52:52 +0300
Message-Id: <20220516085258.1227691-4-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516085258.1227691-1-cyndis@kapsi.fi>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Mikko Perttunen <mperttunen@nvidia.com>

Add code to register context devices from device tree, allocate them
out and manage their refcounts.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
* Directly set DMA mask instead of inheriting from Host1x.
* Use iommu-map instead of custom DT property.
v4:
* Use u64 instead of dma_addr_t for DMA mask
* Use unsigned ints for indexes and adjust error handling flow
* Parse iommu-map property at top level host1x DT node
* Use separate DMA mask per device
* Export symbols as GPL
v5:
* Rename host1x_context to host1x_memory_context
---
 drivers/gpu/host1x/Makefile  |   1 +
 drivers/gpu/host1x/context.c | 160 +++++++++++++++++++++++++++++++++++
 drivers/gpu/host1x/context.h |  27 ++++++
 drivers/gpu/host1x/dev.c     |  12 ++-
 drivers/gpu/host1x/dev.h     |   2 +
 include/linux/host1x.h       |  18 ++++
 6 files changed, 219 insertions(+), 1 deletion(-)
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
index 000000000000..d7d95b69a72a
--- /dev/null
+++ b/drivers/gpu/host1x/context.c
@@ -0,0 +1,160 @@
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
+int host1x_memory_context_list_init(struct host1x *host1x)
+{
+	struct host1x_memory_context_list *cdl = &host1x->context_list;
+	struct device_node *node = host1x->dev->of_node;
+	struct host1x_memory_context *ctx;
+	unsigned int i;
+	int err;
+
+	cdl->devs = NULL;
+	cdl->len = 0;
+	mutex_init(&cdl->lock);
+
+	err = of_property_count_u32_elems(node, "iommu-map");
+	if (err < 0)
+		return 0;
+
+	cdl->devs = kcalloc(err, sizeof(*cdl->devs), GFP_KERNEL);
+	if (!cdl->devs)
+		return -ENOMEM;
+	cdl->len = err / 4;
+
+	for (i = 0; i < cdl->len; i++) {
+		struct iommu_fwspec *fwspec;
+
+		ctx = &cdl->devs[i];
+
+		ctx->host = host1x;
+
+		device_initialize(&ctx->dev);
+
+		/*
+		 * Due to an issue with T194 NVENC, only 38 bits can be used.
+		 * Anyway, 256GiB of IOVA ought to be enough for anyone.
+		 */
+		ctx->dma_mask = DMA_BIT_MASK(38);
+		ctx->dev.dma_mask = &ctx->dma_mask;
+		ctx->dev.coherent_dma_mask = ctx->dma_mask;
+		dev_set_name(&ctx->dev, "host1x-ctx.%d", i);
+		ctx->dev.bus = &host1x_context_device_bus_type;
+		ctx->dev.parent = host1x->dev;
+
+		dma_set_max_seg_size(&ctx->dev, UINT_MAX);
+
+		err = device_add(&ctx->dev);
+		if (err) {
+			dev_err(host1x->dev, "could not add context device %d: %d\n", i, err);
+			goto del_devices;
+		}
+
+		err = of_dma_configure_id(&ctx->dev, node, true, &i);
+		if (err) {
+			dev_err(host1x->dev, "IOMMU configuration failed for context device %d: %d\n",
+				i, err);
+			device_del(&ctx->dev);
+			goto del_devices;
+		}
+
+		fwspec = dev_iommu_fwspec_get(&ctx->dev);
+		if (!fwspec) {
+			dev_err(host1x->dev, "Context device %d has no IOMMU!\n", i);
+			device_del(&ctx->dev);
+			goto del_devices;
+		}
+
+		ctx->stream_id = fwspec->ids[0] & 0xffff;
+	}
+
+	return 0;
+
+del_devices:
+	while (i--)
+		device_del(&cdl->devs[i].dev);
+
+	kfree(cdl->devs);
+	cdl->len = 0;
+
+	return err;
+}
+
+void host1x_memory_context_list_free(struct host1x_memory_context_list *cdl)
+{
+	unsigned int i;
+
+	for (i = 0; i < cdl->len; i++)
+		device_del(&cdl->devs[i].dev);
+
+	kfree(cdl->devs);
+	cdl->len = 0;
+}
+
+struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
+							  struct pid *pid)
+{
+	struct host1x_memory_context_list *cdl = &host1x->context_list;
+	struct host1x_memory_context *free = NULL;
+	int i;
+
+	if (!cdl->len)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mutex_lock(&cdl->lock);
+
+	for (i = 0; i < cdl->len; i++) {
+		struct host1x_memory_context *cd = &cdl->devs[i];
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
+EXPORT_SYMBOL_GPL(host1x_memory_context_alloc);
+
+void host1x_memory_context_get(struct host1x_memory_context *cd)
+{
+	refcount_inc(&cd->ref);
+}
+EXPORT_SYMBOL_GPL(host1x_memory_context_get);
+
+void host1x_memory_context_put(struct host1x_memory_context *cd)
+{
+	struct host1x_memory_context_list *cdl = &cd->host->context_list;
+
+	if (refcount_dec_and_mutex_lock(&cd->ref, &cdl->lock)) {
+		put_pid(cd->owner);
+		cd->owner = NULL;
+		mutex_unlock(&cdl->lock);
+	}
+}
+EXPORT_SYMBOL_GPL(host1x_memory_context_put);
diff --git a/drivers/gpu/host1x/context.h b/drivers/gpu/host1x/context.h
new file mode 100644
index 000000000000..db8ff0a1f4f3
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
+struct host1x_memory_context_list {
+	struct mutex lock;
+	struct host1x_memory_context *devs;
+	unsigned int len;
+};
+
+int host1x_memory_context_list_init(struct host1x *host1x);
+void host1x_memory_context_list_free(struct host1x_memory_context_list *cdl);
+
+#endif
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 80c685ab3e30..89cc79a48eab 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -28,6 +28,7 @@
 
 #include "bus.h"
 #include "channel.h"
+#include "context.h"
 #include "debug.h"
 #include "dev.h"
 #include "intr.h"
@@ -503,10 +504,16 @@ static int host1x_probe(struct platform_device *pdev)
 		goto iommu_exit;
 	}
 
+	err = host1x_memory_context_list_init(host);
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
@@ -550,6 +557,8 @@ static int host1x_probe(struct platform_device *pdev)
 	host1x_intr_deinit(host);
 deinit_syncpt:
 	host1x_syncpt_deinit(host);
+free_contexts:
+	host1x_memory_context_list_free(&host->context_list);
 free_channels:
 	host1x_channel_list_free(&host->channel_list);
 iommu_exit:
@@ -571,6 +580,7 @@ static int host1x_remove(struct platform_device *pdev)
 
 	host1x_intr_deinit(host);
 	host1x_syncpt_deinit(host);
+	host1x_memory_context_list_free(&host->context_list);
 	host1x_channel_list_free(&host->channel_list);
 	host1x_iommu_exit(host);
 	host1x_bo_cache_destroy(&host->cache);
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index ca4b082f0cd4..7552a4554534 100644
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
+	struct host1x_memory_context_list context_list;
 
 	struct dentry *debugfs;
 
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index e8dc5bc41f79..75cf996b0087 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -440,4 +440,22 @@ int tegra_mipi_disable(struct tegra_mipi_device *device);
 int tegra_mipi_start_calibration(struct tegra_mipi_device *device);
 int tegra_mipi_finish_calibration(struct tegra_mipi_device *device);
 
+/* host1x memory contexts */
+
+struct host1x_memory_context {
+	struct host1x *host;
+
+	refcount_t ref;
+	struct pid *owner;
+
+	struct device dev;
+	u64 dma_mask;
+	u32 stream_id;
+};
+
+struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
+							  struct pid *pid);
+void host1x_memory_context_get(struct host1x_memory_context *cd);
+void host1x_memory_context_put(struct host1x_memory_context *cd);
+
 #endif
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
