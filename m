Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3242DC433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5E661A11
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5E661A11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 885B184A0B;
	Thu, 25 Mar 2021 13:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnTrii87ewA7; Thu, 25 Mar 2021 13:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C58884A0E;
	Thu, 25 Mar 2021 13:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A5E2C000D;
	Thu, 25 Mar 2021 13:03:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E38AEC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD61340F31
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gkFp525VipUj for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 13:03:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75EFC40F45
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:03:22 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id e18so2201818wrt.6
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eKTLVgXnpvjbazWRAvYU9QVKhpZ/RAu3/Gpz9BY4uVw=;
 b=KFeothr6D71F3V2OXxn/HRBCWxvrTBYpmNGhPi9V+JxZhJ6pWCxgAP1aaMrEhmZ07i
 6oScVl+zTvPEAN8yn1CbSk/xdcdGUQr+q02kWeBad3OFf3/tpMYiuVMJ9VlknYt1J5MS
 +97xz9GH00xHbJCW68FlbyFaxNoFm+EKzwRbmMotU7phTKMxQEL9JaVEuhc+3IFciyZ2
 vwwIAQ3ifi1NX6n3BRLudXPV7heZmfJheZHUMymDcjYBhXVr92M3wLpqwnE2TFj2g4Nv
 EV3dqewe9iIQOX0Q6W0fwGT5j+wVmgNMJ2N9712sviOpK6ZYGNUpzSjKOQXBfaLk5Kzd
 8LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eKTLVgXnpvjbazWRAvYU9QVKhpZ/RAu3/Gpz9BY4uVw=;
 b=fGre1ogfA5gDlA6ojKNx8M7si5tZWBiAa3PK3He4dYSQ+Y/gzd7EVJJOiTN6+R68s5
 vTQLPRxBHqnw3twpyHYbv2Gd8un6aFCU0jWQS0dZOovuObnt9oEt0+jh3kxCMiI+D1GL
 tG//H3wW7DZ3G1u6LKYTTnRdVR/N30tVQpolpdNUGXX6wzBtKV/Z0DGqywy1VSMZ9Leg
 9O2DR3ZzHOyjX8e8Jfb3Tu4ZIq1+sdnRJEl/9RxdBpzIUtCFIE57PtzdtFWRvdKyMkkP
 C1iPO6mVsMO4cyIPi/Lx2/IKMHVkDw7KXsHJN16DLBVpnUvGDY7Dlq+aPl0E9nqW3fCx
 Sdsg==
X-Gm-Message-State: AOAM533BOBB7Izg39U1UjJ+kO1UsY/QFOy5UajLoXsKOxs0ha9H5lCrK
 UmQcCOSh4EV7V0/ZUZo8/lA=
X-Google-Smtp-Source: ABdhPJx3GmEqYfvOBuvZb2Uk9r0KJU7t8FHVQTFIZtLY/uBVG5wGedbz/YmLbwu74t9njeQ0AJUQpg==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr8997953wrd.104.1616677400702; 
 Thu, 25 Mar 2021 06:03:20 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id u63sm6494706wmg.24.2021.03.25.06.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 06:03:19 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/9] memory: tegra: Move internal data structures into
 separate header
Date: Thu, 25 Mar 2021 14:03:24 +0100
Message-Id: <20210325130332.778208-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325130332.778208-1-thierry.reding@gmail.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
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

From: Thierry Reding <treding@nvidia.com>

From Tegra20 through Tegra210, either the GART or SMMU drivers need
access to the internals of the memory controller driver because they are
tightly coupled (in fact, the GART and SMMU are part of the memory
controller). On later chips, a separate hardware block implements the
SMMU functionality, so this is no longer needed. However, we still want
to reuse some of the existing infrastructure on later chips, so split
the memory controller internals into a separate header file to avoid
conflicts with the implementation on newer chips.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c      |  2 +-
 drivers/iommu/tegra-smmu.c      |  2 +-
 drivers/memory/tegra/mc.h       |  2 +-
 drivers/memory/tegra/tegra186.c | 12 ++++---
 include/soc/tegra/mc-internal.h | 62 +++++++++++++++++++++++++++++++++
 include/soc/tegra/mc.h          | 50 --------------------------
 6 files changed, 72 insertions(+), 58 deletions(-)
 create mode 100644 include/soc/tegra/mc-internal.h

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 6f130e51f072..716185234b2a 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -17,7 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 
-#include <soc/tegra/mc.h>
+#include <soc/tegra/mc-internal.h>
 
 #define GART_REG_BASE		0x24
 #define GART_CONFIG		(0x24 - GART_REG_BASE)
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 602aab98c079..fdb798c62596 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -17,7 +17,7 @@
 #include <linux/dma-mapping.h>
 
 #include <soc/tegra/ahb.h>
-#include <soc/tegra/mc.h>
+#include <soc/tegra/mc-internal.h>
 
 struct tegra_smmu_group {
 	struct list_head list;
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 1ee34f0da4f7..116bf68325b7 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/types.h>
 
-#include <soc/tegra/mc.h>
+#include <soc/tegra/mc-internal.h>
 
 #define MC_INTSTATUS					0x00
 #define MC_INTMASK					0x04
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index e25c954dde2e..aa676c45650b 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -9,6 +9,8 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+#include <soc/tegra/mc.h>
+
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
 #include <dt-bindings/memory/tegra186-mc.h>
 #endif
@@ -31,14 +33,14 @@ struct tegra186_mc_soc {
 	unsigned int num_clients;
 };
 
-struct tegra186_mc {
+struct tegra_mc {
 	struct device *dev;
 	void __iomem *regs;
 
 	const struct tegra186_mc_soc *soc;
 };
 
-static void tegra186_mc_program_sid(struct tegra186_mc *mc)
+static void tegra186_mc_program_sid(struct tegra_mc *mc)
 {
 	unsigned int i;
 
@@ -1523,8 +1525,8 @@ static const struct tegra186_mc_soc tegra194_mc_soc = {
 
 static int tegra186_mc_probe(struct platform_device *pdev)
 {
-	struct tegra186_mc *mc;
 	struct resource *res;
+	struct tegra_mc *mc;
 	int err;
 
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
@@ -1552,7 +1554,7 @@ static int tegra186_mc_probe(struct platform_device *pdev)
 
 static int tegra186_mc_remove(struct platform_device *pdev)
 {
-	struct tegra186_mc *mc = platform_get_drvdata(pdev);
+	struct tegra_mc *mc = platform_get_drvdata(pdev);
 
 	of_platform_depopulate(mc->dev);
 
@@ -1577,7 +1579,7 @@ static int __maybe_unused tegra186_mc_suspend(struct device *dev)
 
 static int __maybe_unused tegra186_mc_resume(struct device *dev)
 {
-	struct tegra186_mc *mc = dev_get_drvdata(dev);
+	struct tegra_mc *mc = dev_get_drvdata(dev);
 
 	tegra186_mc_program_sid(mc);
 
diff --git a/include/soc/tegra/mc-internal.h b/include/soc/tegra/mc-internal.h
new file mode 100644
index 000000000000..4f327695d58c
--- /dev/null
+++ b/include/soc/tegra/mc-internal.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2014 NVIDIA Corporation
+ * Copyright (C) 2021 NVIDIA Corporation
+ */
+
+#ifndef __SOC_TEGRA_MC_INTERNAL_H__
+#define __SOC_TEGRA_MC_INTERNAL_H__
+
+#include <soc/tegra/mc.h>
+
+struct tegra_mc_soc {
+	const struct tegra_mc_client *clients;
+	unsigned int num_clients;
+
+	const unsigned long *emem_regs;
+	unsigned int num_emem_regs;
+
+	unsigned int num_address_bits;
+	unsigned int atom_size;
+
+	u8 client_id_mask;
+
+	const struct tegra_smmu_soc *smmu;
+
+	u32 intmask;
+
+	const struct tegra_mc_reset_ops *reset_ops;
+	const struct tegra_mc_reset *resets;
+	unsigned int num_resets;
+
+	const struct tegra_mc_icc_ops *icc_ops;
+
+	int (*init)(struct tegra_mc *mc);
+};
+
+struct tegra_mc {
+	struct device *dev;
+	struct tegra_smmu *smmu;
+	struct gart_device *gart;
+	void __iomem *regs;
+	struct clk *clk;
+	int irq;
+
+	const struct tegra_mc_soc *soc;
+	unsigned long tick;
+
+	struct tegra_mc_timing *timings;
+	unsigned int num_timings;
+
+	struct reset_controller_dev reset;
+
+	struct icc_provider provider;
+
+	spinlock_t lock;
+
+	struct {
+		struct dentry *root;
+	} debugfs;
+};
+
+#endif /* __SOC_TEGRA_MC_INTERNAL_H__ */
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index d2fbe6a8b25b..7be8441c6e9e 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -155,56 +155,6 @@ struct tegra_mc_icc_ops {
 						void *data);
 };
 
-struct tegra_mc_soc {
-	const struct tegra_mc_client *clients;
-	unsigned int num_clients;
-
-	const unsigned long *emem_regs;
-	unsigned int num_emem_regs;
-
-	unsigned int num_address_bits;
-	unsigned int atom_size;
-
-	u8 client_id_mask;
-
-	const struct tegra_smmu_soc *smmu;
-
-	u32 intmask;
-
-	const struct tegra_mc_reset_ops *reset_ops;
-	const struct tegra_mc_reset *resets;
-	unsigned int num_resets;
-
-	const struct tegra_mc_icc_ops *icc_ops;
-
-	int (*init)(struct tegra_mc *mc);
-};
-
-struct tegra_mc {
-	struct device *dev;
-	struct tegra_smmu *smmu;
-	struct gart_device *gart;
-	void __iomem *regs;
-	struct clk *clk;
-	int irq;
-
-	const struct tegra_mc_soc *soc;
-	unsigned long tick;
-
-	struct tegra_mc_timing *timings;
-	unsigned int num_timings;
-
-	struct reset_controller_dev reset;
-
-	struct icc_provider provider;
-
-	spinlock_t lock;
-
-	struct {
-		struct dentry *root;
-	} debugfs;
-};
-
 int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
