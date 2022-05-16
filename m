Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3F6C433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 09:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BA6081AD1;
	Mon, 16 May 2022 09:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U31iZQhfN7HY; Mon, 16 May 2022 09:19:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1FCDF819B8;
	Mon, 16 May 2022 09:19:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA8C3C0039;
	Mon, 16 May 2022 09:19:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC2A6C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA2B14154A
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:19:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qPdJyGsjVpDR for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 09:19:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC499408B9
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QhmFm5x8eXWshJW5s2KSpUl/2VnAiPuQLb7xfj61KYo=; b=pTr671ML7JqfGzqWay29nNNcTI
 5pHHnwtL8rEqweyAYjfvsdmJbEv0rk0a8vzp7/0KkfLxn+NTGfhyhFl4814Mja5jh/0VAedMT/zEJ
 iBI52cy5ftLg7QVjPPuYMHPItj8w/C78ZrV7kWnX1Bu8s6y41kGPFnNAKzDIBDpq2UxpyNdDVZEv6
 T/wQQ4+85g6bekebGUlxB0XJrlRFEGtPQoJ0fMO91rp5vDA8lPgZf3baB9pivOyTEUqhqCA0mZX3N
 gZiWnpFvDlhiYPlYShMZJkoYBgMBYwW+WPB1xR6IeSvwZNGvteaNOnNzUhDtlIzCXyF0cNz66ytUF
 0C9NfWTQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <cyndis@kapsi.fi>)
 id 1nqWTe-0005fd-K6; Mon, 16 May 2022 11:53:18 +0300
From: cyndis@kapsi.fi
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
Subject: [PATCH v5 2/9] gpu: host1x: Add context bus
Date: Mon, 16 May 2022 11:52:51 +0300
Message-Id: <20220516085258.1227691-3-cyndis@kapsi.fi>
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

The context bus is a "dummy" bus that contains struct devices that
correspond to IOMMU contexts assigned through Host1x to processes.

Even when host1x itself is built as a module, the bus is registered
in built-in code so that the built-in ARM SMMU driver is able to
reference it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v4:
* Export bus as GPL
---
 drivers/gpu/Makefile               |  3 +--
 drivers/gpu/host1x/Kconfig         |  5 +++++
 drivers/gpu/host1x/Makefile        |  1 +
 drivers/gpu/host1x/context_bus.c   | 31 ++++++++++++++++++++++++++++++
 include/linux/host1x_context_bus.h | 15 +++++++++++++++
 5 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/host1x/context_bus.c
 create mode 100644 include/linux/host1x_context_bus.h

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..8997f0096545 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -2,7 +2,6 @@
 # drm/tegra depends on host1x, so if both drivers are built-in care must be
 # taken to initialize them in the correct order. Link order is the only way
 # to ensure this currently.
-obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
-obj-y			+= drm/ vga/
+obj-y			+= host1x/ drm/ vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
index 6815b4db17c1..1861a8180d3f 100644
--- a/drivers/gpu/host1x/Kconfig
+++ b/drivers/gpu/host1x/Kconfig
@@ -1,8 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config TEGRA_HOST1X_CONTEXT_BUS
+	bool
+
 config TEGRA_HOST1X
 	tristate "NVIDIA Tegra host1x driver"
 	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
 	select DMA_SHARED_BUFFER
+	select TEGRA_HOST1X_CONTEXT_BUS
 	select IOMMU_IOVA
 	help
 	  Driver for the NVIDIA Tegra host1x hardware.
diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index d2b6f7de0498..c891a3e33844 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -18,3 +18,4 @@ host1x-y = \
 	hw/host1x07.o
 
 obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
+obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
new file mode 100644
index 000000000000..b0d35b2bbe89
--- /dev/null
+++ b/drivers/gpu/host1x/context_bus.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, NVIDIA Corporation.
+ */
+
+#include <linux/device.h>
+#include <linux/of.h>
+
+struct bus_type host1x_context_device_bus_type = {
+	.name = "host1x-context",
+};
+EXPORT_SYMBOL_GPL(host1x_context_device_bus_type);
+
+static int __init host1x_context_device_bus_init(void)
+{
+	int err;
+
+	if (!of_machine_is_compatible("nvidia,tegra186") &&
+	    !of_machine_is_compatible("nvidia,tegra194") &&
+	    !of_machine_is_compatible("nvidia,tegra234"))
+		return 0;
+
+	err = bus_register(&host1x_context_device_bus_type);
+	if (err < 0) {
+		pr_err("bus type registration failed: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+postcore_initcall(host1x_context_device_bus_init);
diff --git a/include/linux/host1x_context_bus.h b/include/linux/host1x_context_bus.h
new file mode 100644
index 000000000000..72462737a6db
--- /dev/null
+++ b/include/linux/host1x_context_bus.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2021, NVIDIA Corporation. All rights reserved.
+ */
+
+#ifndef __LINUX_HOST1X_CONTEXT_BUS_H
+#define __LINUX_HOST1X_CONTEXT_BUS_H
+
+#include <linux/device.h>
+
+#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
+extern struct bus_type host1x_context_device_bus_type;
+#endif
+
+#endif
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
