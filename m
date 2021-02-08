Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEEAC43381
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 16:41:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393A164E9C
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 16:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393A164E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1591E85F3A;
	Mon,  8 Feb 2021 16:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i169GXhkWReC; Mon,  8 Feb 2021 16:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8AB9385B3B;
	Mon,  8 Feb 2021 16:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 862CEC0891;
	Mon,  8 Feb 2021 16:41:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBEB9C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A946D2094C
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TIQlfcUzMzk for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 16:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by silver.osuosl.org (Postfix) with ESMTPS id F08812079D
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+Iq5LNuGONIJSlt2BCZxMPi1D1idJLDj40Ss+nIJ16Y=; b=vYDvRV1ydBQnebpPZS+UoEsR0y
 mHQqvb0tbudnfraBwOtXq0AhHzRK5y+nt3OQh3TgsZUjYl3Ks1YrBi6Dqo8g+MuaB+BzUToFVsels
 XUsC6QdXfhcnKH1KmJ+kQnZVybxzTJyYkA1zKqdPo4PXQdYvzeUTZ5IJWNpsRTFs4eBRBE1q7zzUp
 vdIOP6s4topbq2Rnrleb9fVeiZWRG6Fj5PgVfneBuGQW7EEjIsldgl9CsAOAKpAUQW5Lm6bEyW5bU
 6JE3ptXRzr7yZbrUhigxv/0cHQ9V6s9w+Wsm+3l1oB13ZA+apfY9ZVo7/3bfUAp6CV0HimKTBVE/b
 MQtHR/8w==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <mperttunen@nvidia.com>)
 id 1l99as-0000Cr-MW; Mon, 08 Feb 2021 18:40:58 +0200
From: Mikko Perttunen <mperttunen@nvidia.com>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
 robin.murphy@arm.com
Subject: [RFC PATCH 2/8] gpu: host1x: Add context bus
Date: Mon,  8 Feb 2021 18:38:42 +0200
Message-Id: <20210208163848.2504291-3-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208163848.2504291-1-mperttunen@nvidia.com>
References: <20210208163848.2504291-1-mperttunen@nvidia.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 84.249.134.236
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The context bus is a "dummy" bus that contains struct devices that
correspond to IOMMU contexts assigned through Host1x to processes.

Even when host1x itself is built as a module, the bus is registered
in built-in code so that the built-in ARM SMMU driver is able to
reference it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
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
index 6dab94adf25e..8546dde3acc8 100644
--- a/drivers/gpu/host1x/Kconfig
+++ b/drivers/gpu/host1x/Kconfig
@@ -1,7 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config TEGRA_HOST1X_CONTEXT_BUS
+	bool
+
 config TEGRA_HOST1X
 	tristate "NVIDIA Tegra host1x driver"
 	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
+	select TEGRA_HOST1X_CONTEXT_BUS
 	select IOMMU_IOVA
 	help
 	  Driver for the NVIDIA Tegra host1x hardware.
diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index a48af2cefae1..d9fea2885658 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -19,3 +19,4 @@ host1x-y = \
 	hw/host1x07.o
 
 obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
+obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
new file mode 100644
index 000000000000..2625914f3c7d
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
+EXPORT_SYMBOL(host1x_context_device_bus_type);
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
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
