Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C68C04AA8
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1622621707
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S9AAgr5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1622621707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C0484F5E;
	Tue, 30 Apr 2019 10:53:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C58ABF09
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6DC345F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3iOsMDc/eLLeJdIqAIhjTf5tbnEOPkeC/CTfINb+v8s=;
	b=S9AAgr5Ktas8/olr6azNlTcs4B
	Prm6OEH+dPlnM2AqezhlWA+RG3X5vo32Hx9ATmwl5rm/DZG3xyS/PctcZzthPIvp+fT133Mo8pQLX
	/jVzpiyCR5Das26rXa0lgp+HU3tkUXxW/BtZ/uAX6cFtLg6J30Nr6LdCZPKkHKx/ybeGPMoYUF/pD
	hcxbYUPxmGF345EzqJO9WnavyWtZD5KEVUsgW8SWYM3e+hqAmY5AexPmMN/+NsfEDKXjf96nssyxh
	Kwn7qaRGeTalVyf0Getj/N8S0zE/c7W7wd4hLfrZwNbBO0QTVK9Q4l/GFc9gzoV+B3WlvuoApXoj+
	3L7AHGnw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQNa-0007Md-S9; Tue, 30 Apr 2019 10:52:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 02/25] dma-mapping: add a Kconfig symbol to indicated
	arch_dma_prep_coherent presence
Date: Tue, 30 Apr 2019 06:51:51 -0400
Message-Id: <20190430105214.24628-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430105151.Pu12D6eHo6W6lUMZAa3p0-yHSXTwu8JAKBPFSqFCI_g@z>

Add a Kconfig symbol that indicates an architecture provides a
arch_dma_prep_coherent implementation, and provide a stub otherwise.

This will allow the generic dma-iommu code to use it while still
allowing to be built for cache coherent architectures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/Kconfig              | 1 +
 arch/csky/Kconfig               | 1 +
 include/linux/dma-noncoherent.h | 6 ++++++
 kernel/dma/Kconfig              | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e34b9eba5de..adda078d6df7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -13,6 +13,7 @@ config ARM64
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_DMA_MMAP_PGPROT
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 725a115759c9..2c3178848b7d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -1,6 +1,7 @@
 config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 69b36ed31a99..9741767e400f 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -72,6 +72,12 @@ static inline void arch_sync_dma_for_cpu_all(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
 
+#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
 void arch_dma_prep_coherent(struct page *page, size_t size);
+#else
+static inline void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+}
+#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
 
 #endif /* _LINUX_DMA_NONCOHERENT_H */
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 52b704e2b97a..83d711f8d665 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -38,6 +38,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	bool
 
+config ARCH_HAS_DMA_PREP_COHERENT
+	bool
+
 config ARCH_HAS_DMA_COHERENT_TO_PFN
 	bool
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
