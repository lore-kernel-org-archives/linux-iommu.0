Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84A9C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 22:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6869541742;
	Fri, 11 Feb 2022 22:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X_zIyaqGmZa1; Fri, 11 Feb 2022 22:35:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8688A41644;
	Fri, 11 Feb 2022 22:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68AF0C001A;
	Fri, 11 Feb 2022 22:35:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15DE8C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 22:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F417B41645
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 22:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2PIAtGa5IqK for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 22:35:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89C8D41644
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 22:35:00 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id q22so14340442ljh.7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TH2uNy6uW/Z12z/2GtQCMspceUF4ISNjvTtaipexx6A=;
 b=gy8HldiQEpZAmBdKqfecuc3gKK/lEN74tyRta728SwUWmULsdy0GC1gEK7ona/oGNy
 tV5ssGvhXNk94E2928Oy15ELuAeJnKC8LoA8qD1igCijNZQBbD7FOYHoZjEJwNDaLMVL
 deEFYL2fof6jnR0Mkgm/UKtJtHnfkCGen8zthyfxaxYuLwa/rx0XUGi00U8bnGdocqv3
 tnPCxB/h1UgdJwogITdlfmen26MAinPG0LWlWoDpfwtR6K4j7ppSlfgEx40pfppQOXel
 6bNoyhGYaiUbExAByrqN95oUsDW+7XDY9TjZty+e/NojxO0TZrFDXI353Z6ImrJBjUsY
 539w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TH2uNy6uW/Z12z/2GtQCMspceUF4ISNjvTtaipexx6A=;
 b=WPY8Xa0MBpjA3qOClFu5try/lPNL00Id1T3t00SBnmcLgoTQ3oxkOXKWOdsIaJdNTR
 HzWyV2jUlMQKA5eTlN7GWySN7QBTIIC7mcPKk5yub9tUw1PtZs4om79Ulmf5ogsjdNhH
 L/fLGINtdrIe56Hl5xp80z9ztB9GCLPqeAnfqTxhd0qOvRgNpKAUxMYJfUUPjjLZfGg0
 5pfJOQgHAEmYI3TJBnfVxh6VZF4TM5TGux27iglbsaKQVWoyrZFXy5z38uh/FClRnyeV
 9jMJZ6+cU1ZnjtVIcpGu2WfZa1B/OKWs2DMhEf0Gv6MEWfrOgTlSO65stg69XZMGvmTp
 nSow==
X-Gm-Message-State: AOAM531ej1L/w4zExs6CEX7HjzeolqR5pDRiZzMZXm1PUmGrDxUbnhEZ
 zH40iaFF/bprnoSLIegVonnBFg==
X-Google-Smtp-Source: ABdhPJxsE+HALt0vTPrRuJNxr2ZE651pwpGgmNPLikM59rW3n2qMZS1lxb3E0Le8RAOjIJQ+Y4xWrg==
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr2238743ljf.54.1644618898501; 
 Fri, 11 Feb 2022 14:34:58 -0800 (PST)
Received: from localhost.localdomain
 (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
 by smtp.gmail.com with ESMTPSA id x2sm3296300lji.27.2022.02.11.14.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Feb 2022 14:34:58 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 11/13 v2] ARM: ixp4xx: Drop custom DMA coherency and bouncing
Date: Fri, 11 Feb 2022 23:32:36 +0100
Message-Id: <20220211223238.648934-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211223238.648934-1-linus.walleij@linaro.org>
References: <20220211223238.648934-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Cc: Linus Walleij <linus.walleij@linaro.org>, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>
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

The new PCI driver does not need any of this stuff, so just
drop it.

Cc: iommu@lists.linux-foundation.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Pick up Christoph's Reviewed-by and add proper CC for iommu
- Resending with the rest
---
 arch/arm/Kconfig              |  5 ---
 arch/arm/mach-ixp4xx/common.c | 57 -----------------------------------
 kernel/dma/mapping.c          |  2 --
 3 files changed, 64 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3a95203236d2..ec0dbaf73a81 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -217,9 +217,6 @@ config ARCH_MAY_HAVE_PC_FDC
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
-config ARCH_HAS_DMA_SET_COHERENT_MASK
-	bool
-
 config GENERIC_ISA_DMA
 	bool
 
@@ -381,10 +378,8 @@ config ARCH_IOP32X
 config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	depends on MMU
-	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CPU_XSCALE
-	select DMABOUNCE if PCI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIO_IXP4XX
 	select GPIOLIB
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 4e51514ace6d..310e1602fbfc 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -30,7 +30,6 @@
 #include <linux/soc/ixp4xx/cpu.h>
 #include <linux/irqchip/irq-ixp4xx.h>
 #include <linux/platform_data/timer-ixp4xx.h>
-#include <linux/dma-map-ops.h>
 #include <mach/hardware.h>
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -330,59 +329,3 @@ void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
 		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
 	}
 }
-
-#ifdef CONFIG_PCI
-static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
-{
-	return (dma_addr + size) > SZ_64M;
-}
-
-static int ixp4xx_platform_notify_remove(struct device *dev)
-{
-	if (dev_is_pci(dev))
-		dmabounce_unregister_dev(dev);
-
-	return 0;
-}
-#endif
-
-/*
- * Setup DMA mask to 64MB on PCI devices and 4 GB on all other things.
- */
-static int ixp4xx_platform_notify(struct device *dev)
-{
-	dev->dma_mask = &dev->coherent_dma_mask;
-
-#ifdef CONFIG_PCI
-	if (dev_is_pci(dev)) {
-		dev->coherent_dma_mask = DMA_BIT_MASK(28); /* 64 MB */
-		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
-		return 0;
-	}
-#endif
-
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	return 0;
-}
-
-int dma_set_coherent_mask(struct device *dev, u64 mask)
-{
-	if (dev_is_pci(dev))
-		mask &= DMA_BIT_MASK(28); /* 64 MB */
-
-	if ((mask & DMA_BIT_MASK(28)) == DMA_BIT_MASK(28)) {
-		dev->coherent_dma_mask = mask;
-		return 0;
-	}
-
-	return -EIO;		/* device wanted sub-64MB mask */
-}
-EXPORT_SYMBOL(dma_set_coherent_mask);
-
-void __init ixp4xx_init_early(void)
-{
-	platform_notify = ixp4xx_platform_notify;
-#ifdef CONFIG_PCI
-	platform_notify_remove = ixp4xx_platform_notify_remove;
-#endif
-}
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9478eccd1c8e..559461a826ba 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -745,7 +745,6 @@ int dma_set_mask(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_set_mask);
 
-#ifndef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
 int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
 	/*
@@ -761,7 +760,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 	return 0;
 }
 EXPORT_SYMBOL(dma_set_coherent_mask);
-#endif
 
 size_t dma_max_mapping_size(struct device *dev)
 {
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
