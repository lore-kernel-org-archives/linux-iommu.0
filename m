Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A9C433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 11:39:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFEF22525
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 11:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFEF22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BEAA86DAF;
	Fri,  8 Jan 2021 11:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JjkL3qTaFlSE; Fri,  8 Jan 2021 11:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 090AF86DA6;
	Fri,  8 Jan 2021 11:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9A58C088B;
	Fri,  8 Jan 2021 11:39:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC8EC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 46888875B2
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7JS-aZlVUUH0 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 11:39:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E9E4C875A9
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:39:32 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id n10so7486767pgl.10
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 03:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VlwgV7b1F/P4akJValmrjyZfQkFPEpyYgB3GpAK0hVc=;
 b=C+Y8V82TxuAWBb4kPdLlg6ssY4c3Gs0rkqHMKGifS8D/ygLapaZIJW3ScIHWKHAEjf
 OJ0NvbYc7p1d0i5sJr41DlFimx+y4iI3wDhXX4zUx6mwUeoZVU29Reziy4lbtSP0/bH8
 O8SrnO44nE8h/L3mZjOzJE2Nk4jeNWfgWS6Ms8LXk6AzIYnKbjOFQLz49/KFat2uzmJu
 rd/kKzls5ZtVy7XcCy1c78APKK+AaatL5J1tD231eQuNwMWtp8zAfmY28U8sHTf1HHdn
 3g0xNik8s2/vROE1DAZA9noWVoR1OnSNBg2FXc1yr9Dmf2AvDv1CuMQ1Vz6JjVaXo+hs
 p84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VlwgV7b1F/P4akJValmrjyZfQkFPEpyYgB3GpAK0hVc=;
 b=c35h/Jy1/e8d+L2m1mkf1qkIwI3htOFQnDfI5b2IPJlFYB0syePFHcR5O+41TmviKT
 mgDtZbS76nDFolmznDKPuRBy+3iJOJ9mrXaHDcamDpZKkXPoPVWL8ojmqhaMBO+YKhCO
 /ZERR1hc2qUIrCn4QEujuxCX4fRrUyw1xz6nZbI2EIy9KWpJbiLAf/EW6z0zxY9//jaa
 dQMYH98Bop5J9QWJLGJu3VGXfKGzyzVHnVex1SZeFADhYnVHXwb2+qzPd3phv2q3Hv4l
 +nPb7qcb9u8ONMrML6NMDN6fpj/oXzNEhznxIkW8g0MextnKfXw/cPrApimQpk9oCfhD
 7c/A==
X-Gm-Message-State: AOAM530TwdUjmAm6uU+mJm/HqbOaz2zDRZ4u68ArEdESzk2kmd1GUQ6j
 G332dWEyQ0G90epnHNDobhI=
X-Google-Smtp-Source: ABdhPJwh2bm7ZayN5RxD5p1R2Gkeg2K8cZ4QDum4f4jDIw0tZOIYCE7VAOBtHaNrHRQSfmuGCl6v9Q==
X-Received: by 2002:a62:8414:0:b029:1ae:6a9a:48c7 with SMTP id
 k20-20020a6284140000b02901ae6a9a48c7mr6220686pfd.52.1610105972459; 
 Fri, 08 Jan 2021 03:39:32 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
 by smtp.gmail.com with ESMTPSA id gm18sm4589136pjb.55.2021.01.08.03.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 03:39:31 -0800 (PST)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH V2 2/2] iommu: add Unisoc iommu basic driver
Date: Fri,  8 Jan 2021 19:38:51 +0800
Message-Id: <20210108113851.354947-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108113851.354947-1-zhang.lyra@gmail.com>
References: <20210108113851.354947-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-kernel@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 Sheng Xu <sheng.xu@unisoc.com>, iommu@lists.linux-foundation.org,
 Kevin Tang <kevin.tang@unisoc.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch only adds display iommu support, the driver was tested with sprd
dpu.

The iommu support for others would be added once finished tests with those
devices, such as Image codec(jpeg) processor, a few signal processors,
including VSP(video), GSP(graphic), ISP(image), and camera CPP, etc.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/Kconfig      |  12 +
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/sprd-iommu.c | 546 +++++++++++++++++++++++++++++++++++++
 3 files changed, 559 insertions(+)
 create mode 100644 drivers/iommu/sprd-iommu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 192ef8f61310..3f8dcf070442 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -408,4 +408,16 @@ config VIRTIO_IOMMU
 
 	  Say Y here if you intend to run this kernel as a guest.
 
+config SPRD_IOMMU
+	tristate "Unisoc IOMMU Support"
+	depends on ARCH_SPRD
+	select IOMMU_API
+	help
+	  Support for IOMMU on Unisoc's SoCs on which multi-media subsystems
+	  need IOMMU, such as DPU, Image codec(jpeg) processor, and a few
+	  signal processors, including VSP(video), GSP(graphic), ISP(image), and
+	  CPP, etc.
+
+	  Say Y here if you want multi-media functions.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 61bd30cd8369..5925b6af2123 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
+obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
new file mode 100644
index 000000000000..a112b4d3cc23
--- /dev/null
+++ b/drivers/iommu/sprd-iommu.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Unisoc IOMMU driver
+ *
+ * Copyright (C) 2020 Unisoc, Inc.
+ * Author: Chunyan Zhang <chunyan.zhang@unisoc.com>
+ */
+
+#include <linux/device.h>
+#include <linux/dma-iommu.h>
+#include <linux/errno.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+
+/* SPRD IOMMU page is 4K size alignment */
+#define SPRD_IOMMU_PAGE_SHIFT	12
+#define SPRD_IOMMU_PAGE_SIZE	SZ_4K
+
+#define SPRD_IOMMU_REG_OFFSET	0x800
+#define SPRD_EX_CFG		(SPRD_IOMMU_REG_OFFSET + 0x0)
+#define SPRD_IOMMU_VAOR_BYPASS	BIT(4)
+#define SPRD_IOMMU_GATE_EN	BIT(1)
+#define SPRD_IOMMU_EN		BIT(0)
+#define SPRD_EX_UPDATE		(SPRD_IOMMU_REG_OFFSET + 0x4)
+#define SPRD_EX_FIRST_VPN	(SPRD_IOMMU_REG_OFFSET + 0x8)
+#define SPRD_EX_VPN_RANGE	(SPRD_IOMMU_REG_OFFSET + 0xc)
+#define SPRD_EX_FIRST_PPN	(SPRD_IOMMU_REG_OFFSET + 0x10)
+#define SPRD_EX_DEFAULT_PPN	(SPRD_IOMMU_REG_OFFSET + 0x14)
+
+#define SPRD_IOMMU_VERSION	(SPRD_IOMMU_REG_OFFSET + 0x0)
+#define SPRD_VERSION_MASK	GENMASK(15, 8)
+#define SPRD_VERSION_SHIFT	8
+#define SPRD_VAU_CFG		(SPRD_IOMMU_REG_OFFSET + 0x4)
+#define SPRD_VAU_UPDATE		(SPRD_IOMMU_REG_OFFSET + 0x8)
+#define SPRD_VAU_AUTH_CFG	(SPRD_IOMMU_REG_OFFSET + 0xc)
+#define SPRD_VAU_FIRST_PPN	(SPRD_IOMMU_REG_OFFSET + 0x10)
+#define SPRD_VAU_DEFAULT_PPN_RD	(SPRD_IOMMU_REG_OFFSET + 0x14)
+#define SPRD_VAU_DEFAULT_PPN_WR	(SPRD_IOMMU_REG_OFFSET + 0x18)
+#define SPRD_VAU_FIRST_VPN	(SPRD_IOMMU_REG_OFFSET + 0x1c)
+#define SPRD_VAU_VPN_RANGE	(SPRD_IOMMU_REG_OFFSET + 0x20)
+
+enum sprd_iommu_version {
+	SPRD_IOMMU_EX,
+	SPRD_IOMMU_VAU,
+};
+
+/*
+ * struct sprd_iommu_match_data - sprd iommu configurations which serves
+ *				  for different master devices
+ *
+ * @iova_start:	the first address that can be mapped
+ * @iova_size:	the largest address range that can be mapped
+ *
+ * iova_start and iova_size are designed for debug purpose, that says different
+ * masters use different ranges of virtual address.
+ */
+struct sprd_iommu_match_data {
+	unsigned long iova_start;
+	unsigned long iova_size;
+};
+
+/*
+ * struct sprd_iommu_device - high-level sprd iommu device representation,
+ * including hardware information and configuration, also driver data, etc
+ *
+ * @mdata:	hardware configuration and information
+ * @ver:	sprd iommu device version
+ * @prot_page:	protect page base address, data would be written to here
+ *		while translation fault
+ * @base:	mapped base address for accessing registers
+ * @dev:	pointer to basic device structure
+ * @iommu:	IOMMU core representation
+ * @group:	IOMMU group
+ */
+struct sprd_iommu_device {
+	const struct sprd_iommu_match_data *mdata;
+	enum sprd_iommu_version ver;
+	phys_addr_t		prot_page;
+	void __iomem		*base;
+	struct device		*dev;
+	struct iommu_device	iommu;
+	struct iommu_group	*group;
+};
+
+struct sprd_iommu_domain {
+	spinlock_t		pgtlock; /* lock for page table */
+	struct iommu_domain	domain;
+	u32			*pgt_va; /* page table virtual address base */
+	struct sprd_iommu_device	*sdev;
+};
+
+static const struct iommu_ops sprd_iommu_ops;
+
+static struct sprd_iommu_domain *to_sprd_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct sprd_iommu_domain, domain);
+}
+
+static inline void
+iommu_writel(struct sprd_iommu_device *sdev, unsigned int reg, u32 val)
+{
+	writel_relaxed(val, sdev->base + reg);
+}
+
+static inline u32
+iommu_readl(struct sprd_iommu_device *sdev, unsigned int reg)
+{
+	return readl_relaxed(sdev->base + reg);
+}
+
+static inline void
+iommu_update_bits(struct sprd_iommu_device *sdev, unsigned int reg,
+		  u32 mask, u32 shift, u32 val)
+{
+	u32 t = iommu_readl(sdev, reg);
+
+	t = (t & (~(mask << shift))) | ((val & mask) << shift);
+	iommu_writel(sdev, reg, t);
+}
+
+static inline int
+set_version(struct sprd_iommu_device *sdev)
+{
+	sdev->ver = (iommu_readl(sdev, SPRD_IOMMU_VERSION) &
+		     SPRD_VERSION_MASK) >> SPRD_VERSION_SHIFT;
+
+	if (sdev->ver != SPRD_IOMMU_EX &&
+	    sdev->ver != SPRD_IOMMU_VAU)
+		return -EINVAL;
+
+	return 0;
+}
+
+static dma_addr_t sprd_iommu_dma_addr(void *va)
+{
+	return (dma_addr_t)virt_to_phys(va);
+}
+
+static unsigned long
+sprd_iommu_pgt_size(const struct sprd_iommu_match_data *mdata)
+{
+	return (mdata->iova_size >> SPRD_IOMMU_PAGE_SHIFT) * 4;
+}
+
+static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
+{
+	struct sprd_iommu_domain *dom;
+
+	if (domain_type != IOMMU_DOMAIN_DMA && domain_type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
+	if (!dom)
+		return NULL;
+
+	if (iommu_get_dma_cookie(&dom->domain)) {
+		kfree(dom);
+		return NULL;
+	}
+
+	spin_lock_init(&dom->pgtlock);
+
+	return &dom->domain;
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	struct sprd_iommu_device *sdev = dom->sdev;
+	size_t pgt_size = (size_t)sprd_iommu_pgt_size(sdev->mdata);
+
+	dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va,
+			  sprd_iommu_dma_addr(dom->pgt_va));
+	kfree(dom);
+}
+
+static void sprd_iommu_first_vpn(struct sprd_iommu_device *sdev)
+{
+	u32 val = (u32)sdev->mdata->iova_start;
+	unsigned int reg;
+
+	if (sdev->ver == SPRD_IOMMU_EX)
+		reg = SPRD_EX_FIRST_VPN;
+	else
+		reg = SPRD_VAU_FIRST_VPN;
+
+	val = val >> SPRD_IOMMU_PAGE_SHIFT;
+
+	iommu_writel(sdev, reg, val);
+}
+
+static void sprd_iommu_vpn_range(struct sprd_iommu_device *sdev)
+{
+	u32 val = (u32)sdev->mdata->iova_size;
+	unsigned int reg;
+
+	if (sdev->ver == SPRD_IOMMU_EX)
+		reg = SPRD_EX_VPN_RANGE;
+	else
+		reg = SPRD_VAU_VPN_RANGE;
+
+	val = (val >> SPRD_IOMMU_PAGE_SHIFT) - 1;
+
+	iommu_writel(sdev, reg, val);
+}
+
+static void sprd_iommu_first_ppn(struct sprd_iommu_domain *dom)
+{
+	u32 val = sprd_iommu_dma_addr(dom->pgt_va) >> SPRD_IOMMU_PAGE_SHIFT;
+	struct sprd_iommu_device *sdev = dom->sdev;
+	unsigned int reg;
+
+	if (sdev->ver == SPRD_IOMMU_EX)
+		reg = SPRD_EX_FIRST_PPN;
+	else
+		reg = SPRD_VAU_FIRST_PPN;
+
+	iommu_writel(sdev, reg, val);
+}
+
+static void sprd_iommu_default_ppn(struct sprd_iommu_device *sdev)
+{
+	u32 val = (u32)sdev->prot_page >> SPRD_IOMMU_PAGE_SHIFT;
+
+	if (sdev->ver == SPRD_IOMMU_EX) {
+		iommu_writel(sdev, SPRD_EX_DEFAULT_PPN, val);
+	} else if (sdev->ver == SPRD_IOMMU_VAU) {
+		iommu_writel(sdev, SPRD_VAU_DEFAULT_PPN_RD, val);
+		iommu_writel(sdev, SPRD_VAU_DEFAULT_PPN_WR, val);
+	}
+}
+
+static void sprd_iommu_hw_cfg(struct sprd_iommu_device *sdev)
+{
+	unsigned int reg_cfg, reg_update;
+
+	if (sdev->ver == SPRD_IOMMU_EX) {
+		reg_cfg = SPRD_EX_CFG;
+		reg_update = SPRD_EX_UPDATE;
+	} else {
+		reg_cfg = SPRD_VAU_CFG;
+		reg_update = SPRD_VAU_UPDATE;
+	}
+
+	/* enable mmu, clk gate, vaor bypass */
+	iommu_writel(sdev, reg_cfg, SPRD_IOMMU_EN | SPRD_IOMMU_GATE_EN |
+		     SPRD_IOMMU_VAOR_BYPASS);
+
+	/* clear iommu TLB buffer after page table updated */
+	iommu_writel(sdev, reg_update, 0xffffffff);
+}
+
+static int sprd_iommu_attach_device(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	size_t pgt_size = (size_t)sprd_iommu_pgt_size(sdev->mdata);
+
+	dom->pgt_va = (u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, get_order(pgt_size));
+	if (!dom->pgt_va) {
+		dev_err(sdev->dev, "Fail to alloc pages.\n");
+		return -ENOMEM;
+	}
+
+	dom->domain.geometry.aperture_start = sdev->mdata->iova_start;
+	dom->domain.geometry.aperture_end = sdev->mdata->iova_start +
+					    sdev->mdata->iova_size - 1;
+	dom->sdev = sdev;
+
+	sprd_iommu_first_ppn(dom);
+	sprd_iommu_first_vpn(sdev);
+	sprd_iommu_vpn_range(sdev);
+	sprd_iommu_default_ppn(sdev);
+	sprd_iommu_hw_cfg(sdev);
+
+	return 0;
+}
+
+static void sprd_iommu_detach_device(struct iommu_domain *domain,
+					     struct device *dev)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	dom->sdev = NULL;
+}
+
+static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	const struct sprd_iommu_match_data *mdata;
+	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
+	unsigned long flags;
+	unsigned int i;
+	u32 *pgt_base_iova;
+	u32 pabase = (u32)paddr;
+	int map_size = 0;
+
+	if (!dom->sdev) {
+		pr_err("No sprd_iommu_device attached to the domain\n");
+		return -EINVAL;
+	}
+
+	mdata = dom->sdev->mdata;
+	if ((iova + size) > (mdata->iova_start + mdata->iova_size) ||
+	    iova < mdata->iova_start) {
+		dev_err(dom->sdev->dev, "(iova(0x%lx) + sixe(0x%lx)) are not in the range!\n",
+			iova, size);
+		return -EINVAL;
+	}
+
+	pgt_base_iova = dom->pgt_va +
+		((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	for (i = 0; i < page_num; i++) {
+		pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
+		pabase += SPRD_IOMMU_PAGE_SIZE;
+		map_size += SPRD_IOMMU_PAGE_SIZE;
+	}
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	return map_size == size ? 0 : -EEXIST;
+}
+
+static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
+			size_t size, struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	const struct sprd_iommu_match_data *mdata = dom->sdev->mdata;
+	unsigned long flags;
+	u32 *pgt_base_iova;
+	unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
+
+	if ((iova + size) > (mdata->iova_start + mdata->iova_size) ||
+	    iova < mdata->iova_start)
+		return -EINVAL;
+
+	pgt_base_iova = dom->pgt_va +
+		((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT);
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	memset(pgt_base_iova, 0, page_num * sizeof(u32));
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	return 0;
+}
+
+static void sprd_iommu_sync_map(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	unsigned int reg;
+
+	if (dom->sdev->ver == SPRD_IOMMU_EX)
+		reg = SPRD_EX_UPDATE;
+	else
+		reg = SPRD_VAU_UPDATE;
+
+	iommu_writel(dom->sdev, reg, 0xffffffff);
+}
+
+static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
+					   dma_addr_t iova)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+	const struct sprd_iommu_match_data *mdata = dom->sdev->mdata;
+	unsigned long flags;
+	phys_addr_t pa;
+	unsigned long start = mdata->iova_start;
+	unsigned long end = mdata->iova_start + mdata->iova_size - 1;
+
+	if (iova < start || iova > end)
+		pr_err("iova (0x%llx) exceed the vpn range[0x%lx-0x%lx]!\n",
+		       iova, start, end);
+
+	spin_lock_irqsave(&dom->pgtlock, flags);
+	pa = *(dom->pgt_va + ((iova - mdata->iova_start) >> SPRD_IOMMU_PAGE_SHIFT));
+	pa = pa << SPRD_IOMMU_PAGE_SHIFT;
+	spin_unlock_irqrestore(&dom->pgtlock, flags);
+
+	return pa;
+}
+
+static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct sprd_iommu_device *sdev;
+
+	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
+		return ERR_PTR(-ENODEV);
+
+	sdev = dev_iommu_priv_get(dev);
+
+	return &sdev->iommu;
+}
+
+static void sprd_iommu_release_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
+		return;
+
+	iommu_fwspec_free(dev);
+}
+
+static struct iommu_group *sprd_iommu_device_group(struct device *dev)
+{
+	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
+
+	if (!sdev)
+		return ERR_PTR(-ENODEV);
+
+	/* All the client devices are in the same iommu-group */
+	if (!sdev->group) {
+		sdev->group = iommu_group_alloc();
+		if (IS_ERR(sdev->group))
+			dev_err(dev, "Failed to allocate IOMMU group\n");
+	}
+
+	return sdev->group;
+}
+
+static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	struct platform_device *pdev;
+
+	if (!dev_iommu_priv_get(dev)) {
+		pdev = of_find_device_by_node(args->np);
+		if (WARN_ON(!pdev))
+			return -EINVAL;
+
+		dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
+	}
+
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+
+static const struct iommu_ops sprd_iommu_ops = {
+	.domain_alloc	= sprd_iommu_domain_alloc,
+	.domain_free	= sprd_iommu_domain_free,
+	.attach_dev	= sprd_iommu_attach_device,
+	.detach_dev	= sprd_iommu_detach_device,
+	.map		= sprd_iommu_map,
+	.unmap		= sprd_iommu_unmap,
+	.iotlb_sync_map = sprd_iommu_sync_map,
+	.iova_to_phys	= sprd_iommu_iova_to_phys,
+	.probe_device	= sprd_iommu_probe_device,
+	.release_device	= sprd_iommu_release_device,
+	.device_group	= sprd_iommu_device_group,
+	.of_xlate	= sprd_iommu_of_xlate,
+	.pgsize_bitmap	= ~0UL << SPRD_IOMMU_PAGE_SHIFT,
+};
+
+static const struct sprd_iommu_match_data sprd_iommu_disp = {
+	.iova_start = 0x30000000,
+	.iova_size = 0x10000000,
+};
+
+static const struct of_device_id sprd_iommu_of_match[] = {
+	{ .compatible = "sprd,iommu-disp",
+	  .data = &sprd_iommu_disp },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sprd_iommu_of_match);
+
+static int sprd_iommu_probe(struct platform_device *pdev)
+{
+	struct sprd_iommu_device *sdev;
+	struct device *dev = &pdev->dev;
+	void *p;
+	int ret;
+
+	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	sdev->base = devm_platform_ioremap_resource(pdev, 0);
+
+	sdev->mdata = device_get_match_data(dev);
+
+	if (set_version(sdev)) {
+		dev_err(dev, "iommu version(0x%x) is invalid.\n", sdev->ver);
+		return -EINVAL;
+	}
+
+	p = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	sdev->prot_page = virt_to_phys(p);
+	sdev->dev = dev;
+
+	platform_set_drvdata(pdev, sdev);
+
+	ret = iommu_device_sysfs_add(&sdev->iommu, &pdev->dev, NULL,
+				     dev_name(&pdev->dev));
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&sdev->iommu, &sprd_iommu_ops);
+	iommu_device_set_fwnode(&sdev->iommu, &pdev->dev.of_node->fwnode);
+
+	ret = iommu_device_register(&sdev->iommu);
+	if (ret)
+		return ret;
+
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type,  &sprd_iommu_ops);
+
+	return 0;
+}
+
+static int sprd_iommu_remove(struct platform_device *pdev)
+{
+	struct sprd_iommu_device *sdev = platform_get_drvdata(pdev);
+
+	if (sdev->group)
+		iommu_group_put(sdev->group);
+
+	bus_set_iommu(&platform_bus_type, NULL);
+
+	platform_set_drvdata(pdev, NULL);
+	iommu_device_sysfs_remove(&sdev->iommu);
+	iommu_device_unregister(&sdev->iommu);
+
+	return 0;
+}
+
+static struct platform_driver sprd_iommu_driver = {
+	.driver	= {
+		.name		= "sprd-iommu",
+		.of_match_table	= sprd_iommu_of_match,
+
+	},
+	.probe	= sprd_iommu_probe,
+	.remove	= sprd_iommu_remove,
+};
+module_platform_driver(sprd_iommu_driver);
+
+MODULE_DESCRIPTION("IOMMU driver for Unisoc SoCs");
+MODULE_ALIAS("platform:sprd-iommu");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
