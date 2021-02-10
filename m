Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F58C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224E260235
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224E260235
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E771387241;
	Wed, 10 Feb 2021 09:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMQ+bAihNEEo; Wed, 10 Feb 2021 09:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7AA7187228;
	Wed, 10 Feb 2021 09:57:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70803C0891;
	Wed, 10 Feb 2021 09:57:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 463FBC013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 333CC857CB
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dGix_rtCKgeG for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:57:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F02368558A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=u5NbTnnrhnYrB2dx6qOY6zq3bhU0+0dqdS2E83sSAIs=; b=p6Am/N5cpFrcuiblrl9z12UUVY
 LaiYLnWoy8KJpcRBRfAFpSS3mFvDuszHTIXNjLk4B4Ou06akDjwcIUzoTI8Lk8fuI7M5iIa+5DGRV
 QIltYK9P2Ge5r6T+jwumoHWnnrxWRlCCHaXQOXBhenzOaMBuRnNa5zzOhkSzgycbs+DFv7wG135M2
 a3jXw9mDEpnUOecRbg7eDJgSGXwYsOW89RpgbeiXhljN59Jf64JDnEOUkgW4+1PDIq051TzcENMO2
 SnK1akdm5bJb7JYJ1dvzIzxO8VXpyfy0GON387EO7R0xPprQ77T7dBhINiIGfqrAymVwcuSEbtOgy
 AiiGZejw==;
Received: from [2001:4bb8:184:7d04:5e70:671e:7b3:191] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l9mF2-008g56-UN; Wed, 10 Feb 2021 09:57:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/6] MIPS: remove CONFIG_DMA_MAYBE_COHERENT
Date: Wed, 10 Feb 2021 10:56:40 +0100
Message-Id: <20210210095641.23856-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210095641.23856-1-hch@lst.de>
References: <20210210095641.23856-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

CONFIG_DMA_MAYBE_COHERENT just guards two early init options now.  Just
enable them unconditionally for CONFIG_DMA_NONCOHERENT.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig        | 8 ++------
 arch/mips/kernel/setup.c | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0e86162df65541..1f1603a08a6d2d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -181,7 +181,7 @@ config MIPS_ALCHEMY
 	select CEVT_R4K
 	select CSRC_R4K
 	select IRQ_MIPS_CPU
-	select DMA_MAYBE_COHERENT	# Au1000,1500,1100 aren't, rest is
+	select DMA_NONCOHERENT		# Au1000,1500,1100 aren't, rest is
 	select MIPS_FIXUP_BIGPHYS_ADDR if PCI
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -546,7 +546,7 @@ config MIPS_MALTA
 	select CLKSRC_MIPS_GIC
 	select COMMON_CLK
 	select CSRC_R4K
-	select DMA_MAYBE_COHERENT
+	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PCI
@@ -1127,10 +1127,6 @@ config FW_CFE
 config ARCH_SUPPORTS_UPROBES
 	bool
 
-config DMA_MAYBE_COHERENT
-	select DMA_NONCOHERENT
-	bool
-
 config DMA_PERDEV_COHERENT
 	bool
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d6b2ba527f5b81..b25d07675b1ee1 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -805,7 +805,7 @@ static int __init debugfs_mips(void)
 arch_initcall(debugfs_mips);
 #endif
 
-#ifdef CONFIG_DMA_MAYBE_COHERENT
+#ifdef CONFIG_DMA_NONCOHERENT
 static int __init setcoherentio(char *str)
 {
 	dma_default_coherent = true;
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
