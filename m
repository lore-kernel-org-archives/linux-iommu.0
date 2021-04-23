Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6EC43600
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA21461466
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA21461466
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CC5A843D1;
	Fri, 23 Apr 2021 11:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VRsZ_5kARD16; Fri, 23 Apr 2021 11:57:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B36ED843F5;
	Fri, 23 Apr 2021 11:56:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93340C000F;
	Fri, 23 Apr 2021 11:56:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1259C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3B36843E9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0Yh-Xr2TYx3 for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:56:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B19B5843B5
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 11:56:56 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 f195-20020a1c1fcc0000b029012eb88126d7so1066557wmf.3
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FsRbQGwgPPyTX9wed12qTQDvSstkWFdppnOjxRuHqVc=;
 b=ejY8PdllvGtau5SI84NlsFbQ/jOjJ60UTzOvs0UchL/+TFV03CkbyL8XNmfd/WRviN
 sRhV1ivb/6t70ipJzwGH3V2nwgvr2CC7e65EfkzCyG0Hd/t59p2UrA7/2X6oAiCYawVn
 osUbAydpApJ0S8TUhbVaV9JAPFB3T9Iv2eFi6NcuYwt9i4qFBrUBHaxcRtHf1YD8sh53
 ftWVMzYGg/42zGxpp8e+PeFOxEAFSJdB902bFsF4XH6MyC7wj3RiFQQSQfEvQZxqnort
 4HWeT9xiHnW4C0KFMeiyhR38PuYOylfhgT6e5JTFMsnvSVz4wKDW1kxw/rFG9cuOr51P
 gVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FsRbQGwgPPyTX9wed12qTQDvSstkWFdppnOjxRuHqVc=;
 b=gKG8uGxDiPy6fnHhExANgwgjPuhlt1HSq+a1Y5Zvv5l/l/t0IFpOIKJRGzXhUJastj
 Xd9XDFMgb74BFTRD5EldcrPuHkS1eqQ7yUl0MReqgiIgMg8Ts2CgZn3yTqIBKqD6gKrh
 q/4X1F6fLDb761LoactS3VS289PJmKiFc7FGxtj3XHhtNL6FNjRHEwGKwznHXq5/CifZ
 RXYSDatykvVc7Ot44OFtkQDClSbgLzAxixodyauisbvvI7NxIbcjS3W46ds5cRh3oW5t
 s5hXZQUNCGw3AiyA+D65mNJ/7ew9pg2J/FXK89uXC0txx90XSSTO24Vb8J/Ezdr7FZNM
 2Gag==
X-Gm-Message-State: AOAM531Re/Eo42lP65u7DS554dfhpE0O2teetXj0Ni+jgXSRYrSGe59k
 FifFaujmIcQRjIaoqYADa7RZ5Q==
X-Google-Smtp-Source: ABdhPJwFxm4cppgkEw1zzbXnamtX6GQwV4iOsj4o89kuGJEKVh1cwAkLGBz3rTZhiTvkNtcuHciiKA==
X-Received: by 2002:a05:600c:3796:: with SMTP id
 o22mr5082783wmr.139.1619179014941; 
 Fri, 23 Apr 2021 04:56:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 04:56:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v2 1/6] ACPI: arm64: Move DMA setup operations out of IORT
Date: Fri, 23 Apr 2021 13:38:32 +0200
Message-Id: <20210423113836.3974972-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, catalin.marinas@arm.com,
 sudeep.holla@arm.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, will@kernel.org, dwmw2@infradead.org,
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

Extract generic DMA setup code out of IORT, so it can be reused by VIOT.
Keep it in drivers/acpi/arm64 for now, since it could break x86
platforms that haven't run this code so far, if they have invalid
tables.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/arm64/Makefile |  1 +
 include/linux/acpi.h        |  3 +++
 include/linux/acpi_iort.h   |  6 ++---
 drivers/acpi/arm64/dma.c    | 50 ++++++++++++++++++++++++++++++++++
 drivers/acpi/arm64/iort.c   | 54 ++++++-------------------------------
 drivers/acpi/scan.c         |  2 +-
 6 files changed, 66 insertions(+), 50 deletions(-)
 create mode 100644 drivers/acpi/arm64/dma.c

diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 6ff50f4ed947..66acbe77f46e 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
+obj-y				+= dma.o
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c60745f657e9..7aaa9559cc19 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -259,9 +259,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 
 #ifdef CONFIG_ARM64
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
+void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
 #else
 static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
+static inline void
+acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
 #endif
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1a12baa58e40..f7f054833afd 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -34,7 +34,7 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
-void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *size);
+int iort_dma_get_ranges(struct device *dev, u64 *size);
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
@@ -48,8 +48,8 @@ static inline struct irq_domain *iort_get_device_domain(
 { return NULL; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 /* IOMMU interface */
-static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
-				  u64 *size) { }
+static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
+{ return -ENODEV; }
 static inline const struct iommu_ops *iort_iommu_configure_id(
 				      struct device *dev, const u32 *id_in)
 { return NULL; }
diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
new file mode 100644
index 000000000000..f16739ad3cc0
--- /dev/null
+++ b/drivers/acpi/arm64/dma.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
+#include <linux/device.h>
+#include <linux/dma-direct.h>
+
+void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
+{
+	int ret;
+	u64 end, mask;
+	u64 dmaaddr = 0, size = 0, offset = 0;
+
+	/*
+	 * If @dev is expected to be DMA-capable then the bus code that created
+	 * it should have initialised its dma_mask pointer by this point. For
+	 * now, we'll continue the legacy behaviour of coercing it to the
+	 * coherent mask if not, but we'll no longer do so quietly.
+	 */
+	if (!dev->dma_mask) {
+		dev_warn(dev, "DMA mask not set\n");
+		dev->dma_mask = &dev->coherent_dma_mask;
+	}
+
+	if (dev->coherent_dma_mask)
+		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+	else
+		size = 1ULL << 32;
+
+	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
+	if (ret == -ENODEV)
+		ret = iort_dma_get_ranges(dev, &size);
+	if (!ret) {
+		/*
+		 * Limit coherent and dma mask based on size retrieved from
+		 * firmware.
+		 */
+		end = dmaaddr + size - 1;
+		mask = DMA_BIT_MASK(ilog2(end) + 1);
+		dev->bus_dma_limit = end;
+		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
+		*dev->dma_mask = min(*dev->dma_mask, mask);
+	}
+
+	*dma_addr = dmaaddr;
+	*dma_size = size;
+
+	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
+
+	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
+}
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3912a1f6058e..a940be1cf2af 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1144,56 +1144,18 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
 }
 
 /**
- * iort_dma_setup() - Set-up device DMA parameters.
+ * iort_dma_get_ranges() - Look up DMA addressing limit for the device
+ * @dev: device to lookup
+ * @size: DMA range size result pointer
  *
- * @dev: device to configure
- * @dma_addr: device DMA address result pointer
- * @dma_size: DMA range size result pointer
+ * Return: 0 on success, an error otherwise.
  */
-void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
+int iort_dma_get_ranges(struct device *dev, u64 *size)
 {
-	u64 end, mask, dmaaddr = 0, size = 0, offset = 0;
-	int ret;
-
-	/*
-	 * If @dev is expected to be DMA-capable then the bus code that created
-	 * it should have initialised its dma_mask pointer by this point. For
-	 * now, we'll continue the legacy behaviour of coercing it to the
-	 * coherent mask if not, but we'll no longer do so quietly.
-	 */
-	if (!dev->dma_mask) {
-		dev_warn(dev, "DMA mask not set\n");
-		dev->dma_mask = &dev->coherent_dma_mask;
-	}
-
-	if (dev->coherent_dma_mask)
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+	if (dev_is_pci(dev))
+		return rc_dma_get_range(dev, size);
 	else
-		size = 1ULL << 32;
-
-	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
-	if (ret == -ENODEV)
-		ret = dev_is_pci(dev) ? rc_dma_get_range(dev, &size)
-				      : nc_dma_get_range(dev, &size);
-
-	if (!ret) {
-		/*
-		 * Limit coherent and dma mask based on size retrieved from
-		 * firmware.
-		 */
-		end = dmaaddr + size - 1;
-		mask = DMA_BIT_MASK(ilog2(end) + 1);
-		dev->bus_dma_limit = end;
-		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
-		*dev->dma_mask = min(*dev->dma_mask, mask);
-	}
-
-	*dma_addr = dmaaddr;
-	*dma_size = size;
-
-	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
-
-	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
+		return nc_dma_get_range(dev, size);
 }
 
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bc973fbd70b2..e166916eb9db 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1536,7 +1536,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 		return 0;
 	}
 
-	iort_dma_setup(dev, &dma_addr, &size);
+	acpi_arch_dma_setup(dev, &dma_addr, &size);
 
 	iommu = iort_iommu_configure_id(dev, input_id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
