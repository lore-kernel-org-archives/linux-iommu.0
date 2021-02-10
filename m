Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E21C433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E19764E42
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 09:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E19764E42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66DD98723B;
	Wed, 10 Feb 2021 09:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oOV69mRfkwgC; Wed, 10 Feb 2021 09:57:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 025118722F;
	Wed, 10 Feb 2021 09:57:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F17B7C0891;
	Wed, 10 Feb 2021 09:57:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEBEEC0891
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ACEB38672F
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BLBn8zXjnyln for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:57:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E6E5A86730
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=YKTLEno4BoA1uPNMvgxx9dNuxXxSTmmhndwcXjQkrV4=; b=QvU3B3H4RDAcSNbKxreIM/Nr2Q
 rINm9XHMOmzWqNGXWuaWXlZi2agPamfUhuRvESci2niE2s7ucyAxICbMghzEP0uXllV/8TgR6QSuI
 OSQWGWlyQpRdyUFkCgsKZtkFr4CATjHpCbTxxW492l0tjxG917oQSXVrPh6uuMeA4XdU62HtaEh/C
 lH/IEpNVg3r5yyM7/PRpj6U8DSc57FZRY/joYX5ZmsZX+RNFsbnrERSHBJbaExBd9XZg3qCsKbeOd
 Oc2+Ow9eu063j8/76xXN7zKFH/SzMzUAIPzlskPSjJb28IwLsAIZ7GpjU0wMwRFNiMuggLn1wg946
 7hpObaoQ==;
Received: from [2001:4bb8:184:7d04:5e70:671e:7b3:191] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l9mF9-008g5d-Ea; Wed, 10 Feb 2021 09:57:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/6] MIPS: remove CONFIG_DMA_PERDEV_COHERENT
Date: Wed, 10 Feb 2021 10:56:41 +0100
Message-Id: <20210210095641.23856-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210210095641.23856-1-hch@lst.de>
References: <20210210095641.23856-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, Huacai Chen <chenhuacai@kernel.org>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
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

Just select DMA_NONCOHERENT and ARCH_HAS_SETUP_DMA_OPS from the
MIPS_GENERIC platform instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
---
 arch/mips/Kconfig              | 3 ++-
 arch/mips/mm/dma-noncoherent.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1f1603a08a6d2d..32a693d033adfd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -123,6 +123,7 @@ choice
 
 config MIPS_GENERIC_KERNEL
 	bool "Generic board-agnostic MIPS kernel"
+	select ARCH_HAS_SETUP_DMA_OPS
 	select MIPS_GENERIC
 	select BOOT_RAW
 	select BUILTIN_DTB
@@ -132,7 +133,7 @@ config MIPS_GENERIC_KERNEL
 	select CPU_MIPSR2_IRQ_EI
 	select CPU_MIPSR2_IRQ_VI
 	select CSRC_R4K
-	select DMA_PERDEV_COHERENT
+	select DMA_NONCOHERENT
 	select HAVE_PCI
 	select IRQ_MIPS_CPU
 	select MIPS_AUTO_PFN_OFFSET
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 90b562753eb892..212f3ce75a6bd3 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -135,7 +135,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 #endif
 
-#ifdef CONFIG_DMA_PERDEV_COHERENT
+#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		const struct iommu_ops *iommu, bool coherent)
 {
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
