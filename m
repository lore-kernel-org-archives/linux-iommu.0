Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE914C34052
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1CF208C4
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1CF208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 646F986252;
	Tue, 18 Feb 2020 17:13:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUZviMpWanNd; Tue, 18 Feb 2020 17:13:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E5ED86354;
	Tue, 18 Feb 2020 17:13:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EE85C1D8E;
	Tue, 18 Feb 2020 17:13:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D5CC08A0
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B7EB4204C0
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JofRIMxJ8S4J for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by silver.osuosl.org (Postfix) with ESMTPS id EBBD620489
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:32 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id p125so20817655oif.10
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v0Vl76UEuxsk5yg9Po+ygPtGTaEk/mhPYQr81MGY08w=;
 b=tng2oLi15f0bF1wvxu7AlHmaRCR+78o8pI5enxWkmcm4anFIj2eLY3wL5SHR/jFNat
 NWlVJPl4c6kY67D1SYpjNjj4pzhOD23S5xjJgg4yr/33mU3c9OnKKxF0Dsb6u9NTxo25
 FOE1F1KtXdoUcW2whGoKCrj2qNW4RSc2si7zP57Kv/o5Yze1gam35EPLyBXKf9AGkm8i
 A8+A1GU+hp5dOypnIVm5b7HBMvz+qDqEexkb5jWM6YXE0ZeKlSZi6GPFwVsscRPD9yUQ
 KVjchJKNG1Mix8/ipumZ/dMiXhAbW6MPUXpDahQqNtcB+poipt6upNfk0W3932O6pLBq
 0ugA==
X-Gm-Message-State: APjAAAWv7tSAhUCS4q5w15nLlIe7UEA53iKGbCd6oGE7JhYVH/bhTWd5
 EXWGLHLmX9m/Y8WHISUUHw==
X-Google-Smtp-Source: APXvYqwUc3inMoCdecbdUuNsMDgvDcrJjhj8ChMk19cWCZkyZjwjeXollkDMysGYw5kJtCo1GqwvHQ==
X-Received: by 2002:a54:4791:: with SMTP id o17mr1818618oic.70.1582046011959; 
 Tue, 18 Feb 2020 09:13:31 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:31 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 05/11] EDAC: Remove Calxeda drivers
Date: Tue, 18 Feb 2020 11:13:15 -0600
Message-Id: <20200218171321.30990-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218171321.30990-1-robh@kernel.org>
References: <20200218171321.30990-1-robh@kernel.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-ide@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rrichter@marvell.com>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Do not apply yet.

 MAINTAINERS                     |   6 -
 drivers/edac/Kconfig            |  14 --
 drivers/edac/Makefile           |   3 -
 drivers/edac/highbank_l2_edac.c | 142 -----------------
 drivers/edac/highbank_mc_edac.c | 272 --------------------------------
 5 files changed, 437 deletions(-)
 delete mode 100644 drivers/edac/highbank_l2_edac.c
 delete mode 100644 drivers/edac/highbank_mc_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..4732bb268299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5964,12 +5964,6 @@ M:	Shravan Kumar Ramani <sramani@mellanox.com>
 S:	Supported
 F:	drivers/edac/bluefield_edac.c

-EDAC-CALXEDA
-M:	Robert Richter <rric@kernel.org>
-L:	linux-edac@vger.kernel.org
-S:	Maintained
-F:	drivers/edac/highbank*
-
 EDAC-CAVIUM OCTEON
 M:	Ralf Baechle <ralf@linux-mips.org>
 M:	Robert Richter <rrichter@marvell.com>
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index b3c99bb5fe77..f3ff75e5ed9b 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -334,20 +334,6 @@ config EDAC_CPC925
 	  a companion chip to the PowerPC 970 family of
 	  processors.

-config EDAC_HIGHBANK_MC
-	tristate "Highbank Memory Controller"
-	depends on ARCH_HIGHBANK
-	help
-	  Support for error detection and correction on the
-	  Calxeda Highbank memory controller.
-
-config EDAC_HIGHBANK_L2
-	tristate "Highbank L2 Cache"
-	depends on ARCH_HIGHBANK
-	help
-	  Support for error detection and correction on the
-	  Calxeda Highbank memory controller.
-
 config EDAC_OCTEON_PC
 	tristate "Cavium Octeon Primary Caches"
 	depends on CPU_CAVIUM_OCTEON
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index d77200c9680b..9a563db39bc3 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -69,9 +69,6 @@ obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
 obj-$(CONFIG_EDAC_AMD8111)		+= amd8111_edac.o
 obj-$(CONFIG_EDAC_AMD8131)		+= amd8131_edac.o

-obj-$(CONFIG_EDAC_HIGHBANK_MC)		+= highbank_mc_edac.o
-obj-$(CONFIG_EDAC_HIGHBANK_L2)		+= highbank_l2_edac.o
-
 obj-$(CONFIG_EDAC_OCTEON_PC)		+= octeon_edac-pc.o
 obj-$(CONFIG_EDAC_OCTEON_L2C)		+= octeon_edac-l2c.o
 obj-$(CONFIG_EDAC_OCTEON_LMC)		+= octeon_edac-lmc.o
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
deleted file mode 100644
index c4549cec788b..000000000000
--- a/drivers/edac/highbank_l2_edac.c
+++ /dev/null
@@ -1,142 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2011-2012 Calxeda, Inc.
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/edac.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/of_platform.h>
-
-#include "edac_module.h"
-
-#define SR_CLR_SB_ECC_INTR	0x0
-#define SR_CLR_DB_ECC_INTR	0x4
-
-struct hb_l2_drvdata {
-	void __iomem *base;
-	int sb_irq;
-	int db_irq;
-};
-
-static irqreturn_t highbank_l2_err_handler(int irq, void *dev_id)
-{
-	struct edac_device_ctl_info *dci = dev_id;
-	struct hb_l2_drvdata *drvdata = dci->pvt_info;
-
-	if (irq == drvdata->sb_irq) {
-		writel(1, drvdata->base + SR_CLR_SB_ECC_INTR);
-		edac_device_handle_ce(dci, 0, 0, dci->ctl_name);
-	}
-	if (irq == drvdata->db_irq) {
-		writel(1, drvdata->base + SR_CLR_DB_ECC_INTR);
-		edac_device_handle_ue(dci, 0, 0, dci->ctl_name);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static const struct of_device_id hb_l2_err_of_match[] = {
-	{ .compatible = "calxeda,hb-sregs-l2-ecc", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, hb_l2_err_of_match);
-
-static int highbank_l2_err_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *id;
-	struct edac_device_ctl_info *dci;
-	struct hb_l2_drvdata *drvdata;
-	struct resource *r;
-	int res = 0;
-
-	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), "cpu",
-		1, "L", 1, 2, NULL, 0, 0);
-	if (!dci)
-		return -ENOMEM;
-
-	drvdata = dci->pvt_info;
-	dci->dev = &pdev->dev;
-	platform_set_drvdata(pdev, dci);
-
-	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
-		return -ENOMEM;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		res = -ENODEV;
-		goto err;
-	}
-
-	if (!devm_request_mem_region(&pdev->dev, r->start,
-				     resource_size(r), dev_name(&pdev->dev))) {
-		dev_err(&pdev->dev, "Error while requesting mem region\n");
-		res = -EBUSY;
-		goto err;
-	}
-
-	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!drvdata->base) {
-		dev_err(&pdev->dev, "Unable to map regs\n");
-		res = -ENOMEM;
-		goto err;
-	}
-
-	id = of_match_device(hb_l2_err_of_match, &pdev->dev);
-	dci->mod_name = pdev->dev.driver->name;
-	dci->ctl_name = id ? id->compatible : "unknown";
-	dci->dev_name = dev_name(&pdev->dev);
-
-	if (edac_device_add_device(dci))
-		goto err;
-
-	drvdata->db_irq = platform_get_irq(pdev, 0);
-	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
-			       highbank_l2_err_handler,
-			       0, dev_name(&pdev->dev), dci);
-	if (res < 0)
-		goto err2;
-
-	drvdata->sb_irq = platform_get_irq(pdev, 1);
-	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
-			       highbank_l2_err_handler,
-			       0, dev_name(&pdev->dev), dci);
-	if (res < 0)
-		goto err2;
-
-	devres_close_group(&pdev->dev, NULL);
-	return 0;
-err2:
-	edac_device_del_device(&pdev->dev);
-err:
-	devres_release_group(&pdev->dev, NULL);
-	edac_device_free_ctl_info(dci);
-	return res;
-}
-
-static int highbank_l2_err_remove(struct platform_device *pdev)
-{
-	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
-
-	edac_device_del_device(&pdev->dev);
-	edac_device_free_ctl_info(dci);
-	return 0;
-}
-
-static struct platform_driver highbank_l2_edac_driver = {
-	.probe = highbank_l2_err_probe,
-	.remove = highbank_l2_err_remove,
-	.driver = {
-		.name = "hb_l2_edac",
-		.of_match_table = hb_l2_err_of_match,
-	},
-};
-
-module_platform_driver(highbank_l2_edac_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Calxeda, Inc.");
-MODULE_DESCRIPTION("EDAC Driver for Calxeda Highbank L2 Cache");
diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
deleted file mode 100644
index 61b76ec226af..000000000000
--- a/drivers/edac/highbank_mc_edac.c
+++ /dev/null
@@ -1,272 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2011-2012 Calxeda, Inc.
- */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/edac.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/of_platform.h>
-#include <linux/uaccess.h>
-
-#include "edac_module.h"
-
-/* DDR Ctrlr Error Registers */
-
-#define HB_DDR_ECC_ERR_BASE		0x128
-#define MW_DDR_ECC_ERR_BASE		0x1b4
-
-#define HB_DDR_ECC_OPT			0x00
-#define HB_DDR_ECC_U_ERR_ADDR		0x08
-#define HB_DDR_ECC_U_ERR_STAT		0x0c
-#define HB_DDR_ECC_U_ERR_DATAL		0x10
-#define HB_DDR_ECC_U_ERR_DATAH		0x14
-#define HB_DDR_ECC_C_ERR_ADDR		0x18
-#define HB_DDR_ECC_C_ERR_STAT		0x1c
-#define HB_DDR_ECC_C_ERR_DATAL		0x20
-#define HB_DDR_ECC_C_ERR_DATAH		0x24
-
-#define HB_DDR_ECC_OPT_MODE_MASK	0x3
-#define HB_DDR_ECC_OPT_FWC		0x100
-#define HB_DDR_ECC_OPT_XOR_SHIFT	16
-
-/* DDR Ctrlr Interrupt Registers */
-
-#define HB_DDR_ECC_INT_BASE		0x180
-#define MW_DDR_ECC_INT_BASE		0x218
-
-#define HB_DDR_ECC_INT_STATUS		0x00
-#define HB_DDR_ECC_INT_ACK		0x04
-
-#define HB_DDR_ECC_INT_STAT_CE		0x8
-#define HB_DDR_ECC_INT_STAT_DOUBLE_CE	0x10
-#define HB_DDR_ECC_INT_STAT_UE		0x20
-#define HB_DDR_ECC_INT_STAT_DOUBLE_UE	0x40
-
-struct hb_mc_drvdata {
-	void __iomem *mc_err_base;
-	void __iomem *mc_int_base;
-};
-
-static irqreturn_t highbank_mc_err_handler(int irq, void *dev_id)
-{
-	struct mem_ctl_info *mci = dev_id;
-	struct hb_mc_drvdata *drvdata = mci->pvt_info;
-	u32 status, err_addr;
-
-	/* Read the interrupt status register */
-	status = readl(drvdata->mc_int_base + HB_DDR_ECC_INT_STATUS);
-
-	if (status & HB_DDR_ECC_INT_STAT_UE) {
-		err_addr = readl(drvdata->mc_err_base + HB_DDR_ECC_U_ERR_ADDR);
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
-				     err_addr >> PAGE_SHIFT,
-				     err_addr & ~PAGE_MASK, 0,
-				     0, 0, -1,
-				     mci->ctl_name, "");
-	}
-	if (status & HB_DDR_ECC_INT_STAT_CE) {
-		u32 syndrome = readl(drvdata->mc_err_base + HB_DDR_ECC_C_ERR_STAT);
-		syndrome = (syndrome >> 8) & 0xff;
-		err_addr = readl(drvdata->mc_err_base + HB_DDR_ECC_C_ERR_ADDR);
-		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
-				     err_addr >> PAGE_SHIFT,
-				     err_addr & ~PAGE_MASK, syndrome,
-				     0, 0, -1,
-				     mci->ctl_name, "");
-	}
-
-	/* clear the error, clears the interrupt */
-	writel(status, drvdata->mc_int_base + HB_DDR_ECC_INT_ACK);
-	return IRQ_HANDLED;
-}
-
-static void highbank_mc_err_inject(struct mem_ctl_info *mci, u8 synd)
-{
-	struct hb_mc_drvdata *pdata = mci->pvt_info;
-	u32 reg;
-
-	reg = readl(pdata->mc_err_base + HB_DDR_ECC_OPT);
-	reg &= HB_DDR_ECC_OPT_MODE_MASK;
-	reg |= (synd << HB_DDR_ECC_OPT_XOR_SHIFT) | HB_DDR_ECC_OPT_FWC;
-	writel(reg, pdata->mc_err_base + HB_DDR_ECC_OPT);
-}
-
-#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
-
-static ssize_t highbank_mc_inject_ctrl(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct mem_ctl_info *mci = to_mci(dev);
-	u8 synd;
-
-	if (kstrtou8(buf, 16, &synd))
-		return -EINVAL;
-
-	highbank_mc_err_inject(mci, synd);
-
-	return count;
-}
-
-static DEVICE_ATTR(inject_ctrl, S_IWUSR, NULL, highbank_mc_inject_ctrl);
-
-static struct attribute *highbank_dev_attrs[] = {
-	&dev_attr_inject_ctrl.attr,
-	NULL
-};
-
-ATTRIBUTE_GROUPS(highbank_dev);
-
-struct hb_mc_settings {
-	int	err_offset;
-	int	int_offset;
-};
-
-static struct hb_mc_settings hb_settings = {
-	.err_offset = HB_DDR_ECC_ERR_BASE,
-	.int_offset = HB_DDR_ECC_INT_BASE,
-};
-
-static struct hb_mc_settings mw_settings = {
-	.err_offset = MW_DDR_ECC_ERR_BASE,
-	.int_offset = MW_DDR_ECC_INT_BASE,
-};
-
-static const struct of_device_id hb_ddr_ctrl_of_match[] = {
-	{ .compatible = "calxeda,hb-ddr-ctrl",		.data = &hb_settings },
-	{ .compatible = "calxeda,ecx-2000-ddr-ctrl",	.data = &mw_settings },
-	{},
-};
-MODULE_DEVICE_TABLE(of, hb_ddr_ctrl_of_match);
-
-static int highbank_mc_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *id;
-	const struct hb_mc_settings *settings;
-	struct edac_mc_layer layers[2];
-	struct mem_ctl_info *mci;
-	struct hb_mc_drvdata *drvdata;
-	struct dimm_info *dimm;
-	struct resource *r;
-	void __iomem *base;
-	u32 control;
-	int irq;
-	int res = 0;
-
-	id = of_match_device(hb_ddr_ctrl_of_match, &pdev->dev);
-	if (!id)
-		return -ENODEV;
-
-	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = 1;
-	layers[0].is_virt_csrow = true;
-	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = 1;
-	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
-			    sizeof(struct hb_mc_drvdata));
-	if (!mci)
-		return -ENOMEM;
-
-	mci->pdev = &pdev->dev;
-	drvdata = mci->pvt_info;
-	platform_set_drvdata(pdev, mci);
-
-	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
-		return -ENOMEM;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "Unable to get mem resource\n");
-		res = -ENODEV;
-		goto err;
-	}
-
-	if (!devm_request_mem_region(&pdev->dev, r->start,
-				     resource_size(r), dev_name(&pdev->dev))) {
-		dev_err(&pdev->dev, "Error while requesting mem region\n");
-		res = -EBUSY;
-		goto err;
-	}
-
-	base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!base) {
-		dev_err(&pdev->dev, "Unable to map regs\n");
-		res = -ENOMEM;
-		goto err;
-	}
-
-	settings = id->data;
-	drvdata->mc_err_base = base + settings->err_offset;
-	drvdata->mc_int_base = base + settings->int_offset;
-
-	control = readl(drvdata->mc_err_base + HB_DDR_ECC_OPT) & 0x3;
-	if (!control || (control == 0x2)) {
-		dev_err(&pdev->dev, "No ECC present, or ECC disabled\n");
-		res = -ENODEV;
-		goto err;
-	}
-
-	mci->mtype_cap = MEM_FLAG_DDR3;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->edac_cap = EDAC_FLAG_SECDED;
-	mci->mod_name = pdev->dev.driver->name;
-	mci->ctl_name = id->compatible;
-	mci->dev_name = dev_name(&pdev->dev);
-	mci->scrub_mode = SCRUB_SW_SRC;
-
-	/* Only a single 4GB DIMM is supported */
-	dimm = *mci->dimms;
-	dimm->nr_pages = (~0UL >> PAGE_SHIFT) + 1;
-	dimm->grain = 8;
-	dimm->dtype = DEV_X8;
-	dimm->mtype = MEM_DDR3;
-	dimm->edac_mode = EDAC_SECDED;
-
-	res = edac_mc_add_mc_with_groups(mci, highbank_dev_groups);
-	if (res < 0)
-		goto err;
-
-	irq = platform_get_irq(pdev, 0);
-	res = devm_request_irq(&pdev->dev, irq, highbank_mc_err_handler,
-			       0, dev_name(&pdev->dev), mci);
-	if (res < 0) {
-		dev_err(&pdev->dev, "Unable to request irq %d\n", irq);
-		goto err2;
-	}
-
-	devres_close_group(&pdev->dev, NULL);
-	return 0;
-err2:
-	edac_mc_del_mc(&pdev->dev);
-err:
-	devres_release_group(&pdev->dev, NULL);
-	edac_mc_free(mci);
-	return res;
-}
-
-static int highbank_mc_remove(struct platform_device *pdev)
-{
-	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
-
-	edac_mc_del_mc(&pdev->dev);
-	edac_mc_free(mci);
-	return 0;
-}
-
-static struct platform_driver highbank_mc_edac_driver = {
-	.probe = highbank_mc_probe,
-	.remove = highbank_mc_remove,
-	.driver = {
-		.name = "hb_mc_edac",
-		.of_match_table = hb_ddr_ctrl_of_match,
-	},
-};
-
-module_platform_driver(highbank_mc_edac_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Calxeda, Inc.");
-MODULE_DESCRIPTION("EDAC Driver for Calxeda Highbank");
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
