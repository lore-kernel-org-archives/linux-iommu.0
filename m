Return-Path: <SRS0=maFY=IS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D582C433E2
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4289F61966
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4289F61966
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB32D4035C;
	Sat, 20 Mar 2021 16:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNG9z4dz9F33; Sat, 20 Mar 2021 16:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70F534035F;
	Sat, 20 Mar 2021 16:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2A2DC0010;
	Sat, 20 Mar 2021 16:05:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4722C0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5A08401C7
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6QOjtbFvq7i for <iommu@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 15:34:51 +0000 (UTC)
X-Greylist: delayed 00:15:11 by SQLgrey-1.8.0
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB157401CC
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:34:50 +0000 (UTC)
Date: Sat, 20 Mar 2021 15:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 s=protonmail3; t=1616254486;
 bh=JTyt7legjbFhec6GFumJoMePKi1InCF9VN17NylsqRE=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=Nb8kmdt4B3a51am5iZsJpAi7WUIS++kbEc3Orbn+Moy2/MVoFvBQs0QlSzJtNV/+t
 l1br16fPNrPDXQfIicmG5rjfeVPVxJSIwmj1xLwP56PEmfb/0xeJlrrbNIb2EYeV0w
 YLfJuziguX5bA1WE4EnOHthTE5Vc5Udx9aVsdGCLQftHjivuryzwgRxxjxJliDIyv2
 D/GVvFswygnOKcgx1HhJ4uLxMp5mr/+yH7W6dAT405Eo2qdHzLda2n9mGqYW9ACirX
 jRaqMxCQmpRxA5oDDUWNuxaL9z8cg2N6GKC3H4yiBCR0FcNofYMRByUPhxI84hqTbm
 K9/zpawux33ow==
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/3] iommu: dart: Add DART iommu driver
Message-ID: <20210320153419.61311-1-sven@svenpeter.dev>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 20 Mar 2021 16:05:05 +0000
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Mark Kettenis <mark.kettenis@xs4all.nl>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Apple's new SoCs use iommus for almost all peripherals. These Device
Address Resolution Tables must be setup before these peripherals can
act as DMA masters.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                      |   1 +
 drivers/iommu/Kconfig            |  13 +
 drivers/iommu/Makefile           |   1 +
 drivers/iommu/apple-dart-iommu.c | 653 +++++++++++++++++++++++++++++++
 4 files changed, 668 insertions(+)
 create mode 100644 drivers/iommu/apple-dart-iommu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f9a4f2de88b..7dcfce53dd04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1241,6 +1241,7 @@ M:	Sven Peter <sven@svenpeter.dev>
 L:	iommu@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
+F:	drivers/iommu/apple-dart-iommu.c

 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3c95c8524abe..810bcb3ed414 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -262,6 +262,19 @@ config SPAPR_TCE_IOMMU
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
 	  is not implemented as it is not necessary for VFIO.

+config IOMMU_APPLE_DART
+	tristate "Apple DART IOMMU Support"
+	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	select IOMMU_API
+	select IOMMU_IO_PGTABLE_APPLE_DART
+	help
+	  Support for Apple DART (Device Address Resolution Table) IOMMUs
+	  found in Apple ARM SoCs like the M1.
+	  This IOMMU is required for most peripherals using DMA to access
+	  the main memory.
+
+	  Say Y here if you are using an Apple SoC with a DART IOMMU.
+
 # ARM IOMMU support
 config ARM_SMMU
 	tristate "ARM Ltd. System MMU (SMMU) Support"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 61bd30cd8369..5f21f0dfec6a 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
+obj-$(CONFIG_IOMMU_APPLE_DART) += apple-dart-iommu.o
diff --git a/drivers/iommu/apple-dart-iommu.c b/drivers/iommu/apple-dart-iommu.c
new file mode 100644
index 000000000000..a642dbc22281
--- /dev/null
+++ b/drivers/iommu/apple-dart-iommu.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple DART (Device Address Resolution Table) IOMMU driver
+ *
+ * Based on arm/arm-smmu/arm-ssmu.c and arm/arm-smmu-v3/arm-smmu-v3.c
+ *  Copyright (C) 2013 ARM Limited
+ *  Copyright (C) 2015 ARM Limited
+ *
+ * Copyright (C) 2021 The Asahi Linux Contributors
+ */
+
+#include <linux/dma-iommu.h>
+#include <linux/ratelimit.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/io-pgtable.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define DART_MAX_DEVICES 16
+#define DART_MAX_DOMAINS 16
+#define DART_MAX_TTBR 4
+
+#define DART_DOMAINS_ALL 0xffff
+
+#define DART_CONFIG 0x60
+#define DART_CONFIG_LOCK BIT(15)
+
+#define DART_ERROR 0x40
+#define DART_ERROR_DOMAIN_SHIFT 24
+#define DART_ERROR_DOMAIN_MASK 0xf
+#define DART_ERROR_CODE_MASK 0xffffff
+#define DART_ERROR_FLAG BIT(31)
+#define DART_ERROR_READ_FAULT BIT(4)
+#define DART_ERROR_WRITE_FAULT BIT(3)
+#define DART_ERROR_NO_PTE BIT(2)
+#define DART_ERROR_NO_PMD BIT(1)
+#define DART_ERROR_NO_PGD BIT(0)
+
+#define DART_DOMAIN_SELECT 0x34
+
+#define DART_DOMAIN_COMMAND 0x20
+#define DART_DOMAIN_COMMAND_BUSY BIT(2)
+#define DART_DOMAIN_COMMAND_INVALIDATE BIT(20)
+
+#define DART_DOMAIN_COMMAND_BUSY_TIMEOUT 100
+
+#define DART_DEVICE2DOMAIN_MAP 0x80
+
+#define DART_ERROR_ADDR_HI 0x54
+#define DART_ERROR_ADDR_LO 0x50
+
+#define DART_TCR(domain) (0x100 + 4 * (domain))
+#define DART_TCR_TRANSLATE_ENABLE BIT(7)
+#define DART_TCR_BYPASS_ENABLE BIT(8)
+
+#define DART_TTBR(domain, idx) (0x200 + 16 * (domain) + 4 * (idx))
+#define DART_TTBR_VALID BIT(31)
+#define DART_TTBR_SHIFT 12
+
+struct apple_dart_domain;
+
+struct apple_dart {
+	struct device *dev;
+	void __iomem *regs;
+
+	int irq;
+	struct clk_bulk_data *clks;
+	int num_clks;
+
+	struct iommu_device iommu;
+
+	struct apple_dart_domain *domains[DART_MAX_DOMAINS];
+
+	spinlock_t command_lock;
+	struct mutex domain_mutex;
+};
+
+struct apple_dart_domain {
+	struct apple_dart *dart;
+
+	int domain_idx;
+
+	struct io_pgtable_ops *pgtbl_ops;
+
+	struct iommu_domain domain;
+};
+
+struct apple_dart_master {
+	struct apple_dart *dart;
+	u32 sid;
+};
+
+static struct platform_driver apple_dart_driver;
+static const struct iommu_ops apple_dart_iommu_ops;
+
+static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct apple_dart_domain, domain);
+}
+
+static void apple_dart_hw_enable_translation(struct apple_dart *dart,
+					     u16 domain)
+{
+	writel(DART_TCR_TRANSLATE_ENABLE, dart->regs + DART_TCR(domain));
+}
+
+static void apple_dart_hw_disable_translation(struct apple_dart *dart,
+					      u16 domain)
+{
+	writel(0, dart->regs + DART_TCR(domain));
+}
+
+static void apple_dart_hw_set_pgd(struct apple_dart *dart, u16 domain, u16 idx,
+				  phys_addr_t paddr)
+{
+	writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
+	       dart->regs + DART_TTBR(domain, idx));
+}
+
+static void apple_dart_hw_clear_pgd(struct apple_dart *dart, u16 domain,
+				    u16 idx)
+{
+	writel(0, dart->regs + DART_TTBR(domain, idx));
+}
+
+static void apple_dart_hw_clear_all_pgds(struct apple_dart *dart, u16 domain)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i)
+		apple_dart_hw_clear_pgd(dart, domain, i);
+}
+
+static int apple_dart_hw_domain_command(struct apple_dart *dart,
+					u16 domain_bitmap, u32 command)
+{
+	unsigned long flags;
+	int ret;
+	u32 command_reg;
+
+	spin_lock_irqsave(&dart->command_lock, flags);
+	writel(domain_bitmap, dart->regs + DART_DOMAIN_SELECT);
+	writel(command, dart->regs + DART_DOMAIN_COMMAND);
+
+	ret = readl_poll_timeout(dart->regs + DART_DOMAIN_COMMAND, command_reg,
+				 !(command_reg & DART_DOMAIN_COMMAND_BUSY), 1,
+				 DART_DOMAIN_COMMAND_BUSY_TIMEOUT);
+	spin_unlock_irqrestore(&dart->command_lock, flags);
+
+	if (ret) {
+		dev_err(dart->dev,
+			"Timeout while waiting for busy flag to be cleared after issuing command %08x for domains %x\n",
+			command, domain_bitmap);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int apple_dart_hw_invalidate_tlb_global(struct apple_dart *dart)
+{
+	return apple_dart_hw_domain_command(dart, DART_DOMAINS_ALL,
+					    DART_DOMAIN_COMMAND_INVALIDATE);
+}
+
+static int apple_dart_hw_invalidate_tlb_domain(struct apple_dart *dart,
+					       u16 domain)
+{
+	return apple_dart_hw_domain_command(dart, 1 << domain,
+					    DART_DOMAIN_COMMAND_INVALIDATE);
+}
+
+static void apple_dart_hw_map_device_to_domain(struct apple_dart *dart,
+					       u8 device, u8 domain)
+{
+	u32 val;
+	unsigned int reg = device / 4;
+	unsigned int shift = 8 * (device % 4);
+	unsigned int mask = 0xff << shift;
+
+	val = readl(dart->regs + DART_DEVICE2DOMAIN_MAP + 4 * reg);
+	val &= ~mask;
+	val |= domain << shift;
+	writel(val, dart->regs + DART_DEVICE2DOMAIN_MAP + 4 * reg);
+}
+
+static int apple_hw_dart_reset(struct apple_dart *dart)
+{
+	int domain;
+	u32 config;
+
+	config = readl(dart->regs + DART_CONFIG);
+	if (config & DART_CONFIG_LOCK) {
+		dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
+			config);
+		return -EINVAL;
+	}
+
+	for (domain = 0; domain < DART_MAX_DOMAINS; ++domain) {
+		apple_dart_hw_disable_translation(dart, domain);
+		apple_dart_hw_clear_all_pgds(dart, domain);
+	}
+
+	/* restore identity device to domain map */
+	for (domain = 0; domain < DART_MAX_DOMAINS; ++domain)
+		apple_dart_hw_map_device_to_domain(dart, domain, domain);
+
+	return apple_dart_hw_invalidate_tlb_global(dart);
+}
+
+static void apple_dart_tlb_flush_all(void *cookie)
+{
+	struct apple_dart_domain *domain = cookie;
+
+	apple_dart_hw_invalidate_tlb_domain(domain->dart, domain->domain_idx);
+}
+
+static void apple_dart_tlb_flush_walk(unsigned long iova, size_t size,
+				      size_t granule, void *cookie)
+{
+	struct apple_dart_domain *domain = cookie;
+
+	apple_dart_hw_invalidate_tlb_domain(domain->dart, domain->domain_idx);
+}
+
+static const struct iommu_flush_ops apple_dart_tlb_ops = {
+	.tlb_flush_all = apple_dart_tlb_flush_all,
+	.tlb_flush_walk = apple_dart_tlb_flush_walk,
+	.tlb_add_page = NULL,
+};
+
+static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
+{
+	struct apple_dart_domain *dart_domain;
+
+	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
+	if (!dart_domain)
+		return NULL;
+
+	dart_domain->domain_idx = -1;
+	iommu_get_dma_cookie(&dart_domain->domain);
+
+	return &dart_domain->domain;
+}
+
+static void apple_dart_domain_free(struct iommu_domain *domain)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct apple_dart *dart = dart_domain->dart;
+
+	if (dart && dart_domain->domain_idx >= 0) {
+		mutex_lock(&dart->domain_mutex);
+		apple_dart_hw_clear_all_pgds(dart_domain->dart,
+					     dart_domain->domain_idx);
+		apple_dart_hw_disable_translation(dart_domain->dart,
+						  dart_domain->domain_idx);
+
+		apple_dart_hw_invalidate_tlb_domain(dart_domain->dart,
+						    dart_domain->domain_idx);
+
+		dart->domains[dart_domain->domain_idx] = NULL;
+
+		mutex_unlock(&dart->domain_mutex);
+	}
+
+	kfree(dart_domain);
+}
+
+static struct apple_dart *apple_dart_get_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct device *dev =
+		driver_find_device_by_fwnode(&apple_dart_driver.driver, fwnode);
+	put_device(dev);
+	return dev ? dev_get_drvdata(dev) : NULL;
+}
+
+static int apple_dart_finalise_domain(struct iommu_domain *domain,
+				      struct apple_dart_master *cfg)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct apple_dart *dart = dart_domain->dart;
+	struct io_pgtable_cfg pgtbl_cfg;
+	int i, ret;
+
+	mutex_lock(&dart->domain_mutex);
+
+	/* sanity check to ensure this domain isn't already initialized */
+	if (WARN_ON(dart_domain->domain_idx >= 0)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dart_domain->domain_idx = cfg->sid;
+
+	/* sanity check to ensure this index isn't already in use */
+	if (WARN_ON(dart->domains[dart_domain->domain_idx] != NULL)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	dart->domains[dart_domain->domain_idx] = dart_domain;
+
+	pgtbl_cfg = (struct io_pgtable_cfg){
+		.pgsize_bitmap = SZ_16K,
+		.ias = 32,
+		.oas = 36,
+		.coherent_walk = 1,
+		.tlb = &apple_dart_tlb_ops,
+		.iommu_dev = dart->dev,
+	};
+
+	dart_domain->pgtbl_ops =
+		alloc_io_pgtable_ops(ARM_APPLE_DART, &pgtbl_cfg, domain);
+	if (!dart_domain->pgtbl_ops) {
+		ret = -ENOMEM;
+		goto out_domain;
+	}
+
+	for (i = 0; i < 4; ++i) {
+		apple_dart_hw_set_pgd(dart, dart_domain->domain_idx, i,
+				      pgtbl_cfg.apple_dart_cfg.pgd[i]);
+	}
+
+	apple_dart_hw_enable_translation(dart, dart_domain->domain_idx);
+	apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+
+	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
+	domain->geometry.force_aperture = true;
+
+	ret = 0;
+
+out_domain:
+	if (ret)
+		dart->domains[dart_domain->domain_idx] = NULL;
+out:
+	mutex_unlock(&dart->domain_mutex);
+	return ret;
+}
+
+static int apple_dart_attach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	int ret;
+	struct apple_dart_master *cfg = dev_iommu_priv_get(dev);
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+
+	dart_domain->dart = cfg->dart;
+
+	ret = apple_dart_finalise_domain(domain, cfg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct iommu_device *apple_dart_probe_device(struct device *dev)
+{
+	struct apple_dart *dart = NULL;
+	struct apple_dart_master *cfg = NULL;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec || fwspec->ops != &apple_dart_iommu_ops)
+		return ERR_PTR(-ENODEV);
+
+	dart = apple_dart_get_by_fwnode(fwspec->iommu_fwnode);
+	if (!dart)
+		return ERR_PTR(-ENODEV);
+
+	cfg = kzalloc(offsetof(struct apple_dart_master, sid), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	cfg->dart = dart;
+	cfg->sid = fwspec->ids[0];
+	dev_iommu_priv_set(dev, cfg);
+
+	device_link_add(dev, dart->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+	return &dart->iommu;
+}
+
+static void apple_dart_release_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec || fwspec->ops != &apple_dart_iommu_ops)
+		return;
+
+	iommu_fwspec_free(dev);
+}
+
+static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	if (args->args_count != 1) {
+		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
+			args->args_count);
+		return -EINVAL;
+	}
+
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
+					   dma_addr_t iova)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
+
+	if (!ops)
+		return -ENODEV;
+
+	return ops->iova_to_phys(ops, iova);
+}
+
+static int apple_dart_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
+
+	if (!ops)
+		return -ENODEV;
+
+	return ops->map(ops, iova, paddr, size, prot, gfp);
+}
+
+static size_t apple_dart_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
+
+	if (!ops)
+		return 0;
+
+	return ops->unmap(ops, iova, size, gather);
+}
+
+static void apple_dart_iotlb_sync(struct iommu_domain *domain,
+				  struct iommu_iotlb_gather *gather)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct apple_dart *dart = dart_domain->dart;
+
+	if (!dart)
+		return;
+
+	apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+}
+
+static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct apple_dart *dart = dart_domain->dart;
+
+	if (!dart)
+		return;
+
+	apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+}
+
+static void apple_dart_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct apple_dart *dart = dart_domain->dart;
+
+	if (!dart)
+		return;
+
+	apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+}
+
+static struct iommu_group *apple_dart_device_group(struct device *dev)
+{
+	/* once we have PCI support this needs to use pci_device_group conditionally */
+	return generic_device_group(dev);
+}
+
+static const struct iommu_ops apple_dart_iommu_ops = {
+	.domain_alloc = apple_dart_domain_alloc,
+	.domain_free = apple_dart_domain_free,
+	.attach_dev = apple_dart_attach_dev,
+	.map = apple_dart_map,
+	.unmap = apple_dart_unmap,
+	.flush_iotlb_all = apple_dart_flush_iotlb_all,
+	.iotlb_sync = apple_dart_iotlb_sync,
+	.iotlb_sync_map = apple_dart_iotlb_sync_map,
+	.iova_to_phys = apple_dart_iova_to_phys,
+	.probe_device = apple_dart_probe_device,
+	.release_device = apple_dart_release_device,
+	.device_group = apple_dart_device_group,
+	.of_xlate = apple_dart_of_xlate,
+	.pgsize_bitmap = SZ_16K,
+};
+
+static irqreturn_t apple_dart_irq(int irq, void *dev)
+{
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	struct apple_dart *dart = dev;
+	const char *fault_name = NULL;
+	u32 error = readl(dart->regs + DART_ERROR);
+	u32 error_code = error & DART_ERROR_CODE_MASK;
+	u32 addr_hi = readl(dart->regs + DART_ERROR_ADDR_HI);
+	u32 addr_lo = readl(dart->regs + DART_ERROR_ADDR_LO);
+	u8 domain_idx =
+		(error >> DART_ERROR_DOMAIN_SHIFT) & DART_ERROR_DOMAIN_MASK;
+
+	if (!(error & DART_ERROR_FLAG))
+		return IRQ_NONE;
+
+	if (error_code & DART_ERROR_READ_FAULT)
+		fault_name = "READ FAULT";
+	else if (error_code & DART_ERROR_WRITE_FAULT)
+		fault_name = "WRITE FAULT";
+	else if (error_code & DART_ERROR_NO_PTE)
+		fault_name = "NO PTE FOR IOVA";
+	else if (error_code & DART_ERROR_NO_PMD)
+		fault_name = "NO PMD FOR IOVA";
+	else if (error_code & DART_ERROR_NO_PGD)
+		fault_name = "NO PGD FOR IOVA";
+
+	if (WARN_ON(fault_name == NULL))
+		fault_name = "unknown";
+
+	if (__ratelimit(&rs)) {
+		dev_err(dart->dev,
+			"Apple DART translation fault: error status %08x [domain:%d code:%x (%s)] at address 0x%08x%08x",
+			error, domain_idx, error_code, fault_name, addr_hi,
+			addr_lo);
+	}
+
+	writel(error, dart->regs + DART_ERROR);
+	return IRQ_HANDLED;
+}
+
+static int apple_dart_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct resource *res;
+	resource_size_t ioaddr;
+	struct apple_dart *dart;
+	struct device *dev = &pdev->dev;
+
+	dart = devm_kzalloc(dev, sizeof(*dart), GFP_KERNEL);
+	if (!dart)
+		return -ENOMEM;
+	dart->dev = dev;
+	spin_lock_init(&dart->command_lock);
+	mutex_init(&dart->domain_mutex);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (resource_size(res) < 0x4000) {
+		dev_err(dev, "MMIO region too small (%pr)\n", res);
+		return -EINVAL;
+	}
+	ioaddr = res->start;
+	dart->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dart->regs))
+		return PTR_ERR(dart->regs);
+
+	ret = devm_clk_bulk_get_all(dev, &dart->clks);
+	if (ret < 0)
+		return ret;
+	dart->num_clks = ret;
+
+	ret = clk_bulk_prepare_enable(dart->num_clks, dart->clks);
+	if (ret)
+		return ret;
+
+	ret = apple_hw_dart_reset(dart);
+	if (ret)
+		return ret;
+
+	dart->irq = platform_get_irq(pdev, 0);
+	if (dart->irq < 0)
+		return -ENODEV;
+
+	ret = devm_request_irq(dart->dev, dart->irq, apple_dart_irq,
+			       IRQF_SHARED, "apple-dart fault", dart);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, dart);
+
+	ret = iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s",
+				     dev_name(&pdev->dev));
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&dart->iommu, &apple_dart_iommu_ops);
+	iommu_device_set_fwnode(&dart->iommu, dev->fwnode);
+
+	ret = iommu_device_register(&dart->iommu);
+	if (ret)
+		return ret;
+
+	ret = bus_set_iommu(dev->bus, &apple_dart_iommu_ops);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int apple_dart_remove(struct platform_device *pdev)
+{
+	struct apple_dart *dart = platform_get_drvdata(pdev);
+
+	iommu_device_unregister(&dart->iommu);
+	iommu_device_sysfs_remove(&dart->iommu);
+
+	clk_bulk_disable(dart->num_clks, dart->clks);
+	clk_bulk_unprepare(dart->num_clks, dart->clks);
+
+	return 0;
+}
+
+static void apple_dart_shutdown(struct platform_device *pdev)
+{
+	apple_dart_remove(pdev);
+}
+
+static const struct of_device_id apple_dart_of_match[] = {
+	{ .compatible = "apple,t8103-dart", .data = NULL },
+	{},
+};
+MODULE_DEVICE_TABLE(of, apple_dart_of_match);
+
+static struct platform_driver apple_dart_driver = {
+	.driver	= {
+		.name			= "apple-dart",
+		.of_match_table		= apple_dart_of_match,
+	},
+	.probe	= apple_dart_probe,
+	.remove	= apple_dart_remove,
+	.shutdown = apple_dart_shutdown,
+};
+module_platform_driver(apple_dart_driver);
+
+MODULE_DESCRIPTION("IOMMU API for Apple's DART");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_LICENSE("GPL v2");
--
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
