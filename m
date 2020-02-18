Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F9C3404C
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC490208C4
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC490208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8FDEC85BCD;
	Tue, 18 Feb 2020 17:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mh3orzIt0coA; Tue, 18 Feb 2020 17:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 14EEA8598A;
	Tue, 18 Feb 2020 17:13:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FAE9C08A0;
	Tue, 18 Feb 2020 17:13:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0366C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DA741204B1
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2sqg-tGZdAvb for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 1169E20489
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:26 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id j16so20269874otl.1
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4LxZR/H/qWaW6PLZe7czUDlSa5Ov9S/K1kfsaVdcFug=;
 b=mNxiiCitbLKCOy7lXWboOBdR/GVqeOedkPYpHXeNn4G4+xYglajLnGudkcTgb47Wfs
 zmcMo8QOaXZGQ05CWW6wfbFfeCqQu9Ve3fSl0WtSVFzZV48T/u3j0Kvt2lPtPE2tpT7d
 1MMT4ZiMfgOwLfD1u0bAxe8pJvxgi/W7eD2A2Y9C37xWaDwp7GH/74F9CAzueIIdccjm
 vQz3ix+lT9a4dAr+PpbQaVAiEpGrc8auSgjJ5eiiJIgNLZXSLFJSUgqgLlSvjIT1LUs9
 PJ8H8mubFbt3Q6Hy27ID7wy9eXYK47iQN91lPzsqds0me/NB3MQw7L1mR7lLAxZiZKPT
 rteg==
X-Gm-Message-State: APjAAAVPkFjm/LnOk3FGUu6Ac78ipnIFjyTN6YGP2wK0549RGMZHGUbT
 XnZsTJGldZaxKKJ3qhTUAg==
X-Google-Smtp-Source: APXvYqzcQiA7Kz1hw5DSMbv4x/r+JIz0TrIbtjHbvB5jqm2ONigiZ49RPglyPaLbn09y6q4zITnNIw==
X-Received: by 2002:a05:6830:1f0c:: with SMTP id
 u12mr16226750otg.253.1582046005180; 
 Tue, 18 Feb 2020 09:13:25 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:24 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 01/11] vfio: Remove Calxeda XGMAC reset driver
Date: Tue, 18 Feb 2020 11:13:11 -0600
Message-Id: <20200218171321.30990-2-robh@kernel.org>
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

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Do not apply yet.

 drivers/vfio/platform/reset/Kconfig           |  8 --
 drivers/vfio/platform/reset/Makefile          |  2 -
 .../reset/vfio_platform_calxedaxgmac.c        | 74 -------------------
 3 files changed, 84 deletions(-)
 delete mode 100644 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c

diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
index 1edbe9ee7356..3668d1d92909 100644
--- a/drivers/vfio/platform/reset/Kconfig
+++ b/drivers/vfio/platform/reset/Kconfig
@@ -1,12 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config VFIO_PLATFORM_CALXEDAXGMAC_RESET
-	tristate "VFIO support for calxeda xgmac reset"
-	depends on VFIO_PLATFORM
-	help
-	  Enables the VFIO platform driver to handle reset for Calxeda xgmac
-
-	  If you don't know what to do here, say N.
-
 config VFIO_PLATFORM_AMDXGBE_RESET
 	tristate "VFIO support for AMD XGBE reset"
 	depends on VFIO_PLATFORM
diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
index 7294c5ea122e..be7960ce5dbc 100644
--- a/drivers/vfio/platform/reset/Makefile
+++ b/drivers/vfio/platform/reset/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-vfio-platform-calxedaxgmac-y := vfio_platform_calxedaxgmac.o
 vfio-platform-amdxgbe-y := vfio_platform_amdxgbe.o

-obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
 obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
 obj-$(CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET) += vfio_platform_bcmflexrm.o
diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
deleted file mode 100644
index 09a9453b75c5..000000000000
--- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * VFIO platform driver specialized for Calxeda xgmac reset
- * reset code is inherited from calxeda xgmac native driver
- *
- * Copyright 2010-2011 Calxeda, Inc.
- * Copyright (c) 2015 Linaro Ltd.
- *              www.linaro.org
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include "../vfio_platform_private.h"
-
-#define DRIVER_VERSION  "0.1"
-#define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
-#define DRIVER_DESC     "Reset support for Calxeda xgmac vfio platform device"
-
-/* XGMAC Register definitions */
-#define XGMAC_CONTROL           0x00000000      /* MAC Configuration */
-
-/* DMA Control and Status Registers */
-#define XGMAC_DMA_CONTROL       0x00000f18      /* Ctrl (Operational Mode) */
-#define XGMAC_DMA_INTR_ENA      0x00000f1c      /* Interrupt Enable */
-
-/* DMA Control registe defines */
-#define DMA_CONTROL_ST          0x00002000      /* Start/Stop Transmission */
-#define DMA_CONTROL_SR          0x00000002      /* Start/Stop Receive */
-
-/* Common MAC defines */
-#define MAC_ENABLE_TX           0x00000008      /* Transmitter Enable */
-#define MAC_ENABLE_RX           0x00000004      /* Receiver Enable */
-
-static inline void xgmac_mac_disable(void __iomem *ioaddr)
-{
-	u32 value = readl(ioaddr + XGMAC_DMA_CONTROL);
-
-	value &= ~(DMA_CONTROL_ST | DMA_CONTROL_SR);
-	writel(value, ioaddr + XGMAC_DMA_CONTROL);
-
-	value = readl(ioaddr + XGMAC_CONTROL);
-	value &= ~(MAC_ENABLE_TX | MAC_ENABLE_RX);
-	writel(value, ioaddr + XGMAC_CONTROL);
-}
-
-static int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
-{
-	struct vfio_platform_region *reg = &vdev->regions[0];
-
-	if (!reg->ioaddr) {
-		reg->ioaddr =
-			ioremap(reg->addr, reg->size);
-		if (!reg->ioaddr)
-			return -ENOMEM;
-	}
-
-	/* disable IRQ */
-	writel(0, reg->ioaddr + XGMAC_DMA_INTR_ENA);
-
-	/* Disable the MAC core */
-	xgmac_mac_disable(reg->ioaddr);
-
-	return 0;
-}
-
-module_vfio_reset_handler("calxeda,hb-xgmac", vfio_platform_calxedaxgmac_reset);
-
-MODULE_VERSION(DRIVER_VERSION);
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
