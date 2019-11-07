Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157ABC43331
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 17:41:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD99218AE
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 17:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VEE70/Ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD99218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4EF0EDCF;
	Thu,  7 Nov 2019 17:40:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BCCE3DCA
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 17:40:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 20FF8712
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AcNJdWRFj0IiWBDJa9CJHpHPvlD1qpX53iQGww529G4=;
	b=VEE70/AbA2+/80RtKkwS8hzNgH
	0f/3J/BsSZ3aRwyDlxRdwuqsD5FF94BN++erCt7XDF1X8q3AHRFysxrvZJAJhD0rv9iTWKFDaAnWX
	1h1fQcVVwUS5gunbzqZ42JZjy8bCD5HrwTxW7vVMAKYX4DgJY5BpSx70Mo3j1MWwbyfi6qFMl091I
	RCm1pVnatmrIM+Q9KcbWp06hZjW9Ype5zpwVgWHyvDSxAzox7uiqAAwpt275DOYQsfbUTh2k5fO17
	cpKC7oNOXiKaF8wHv31ngSy4RUryhOiq8SEhUwfZbxncwQXtQ17K3mnBSxVzVf6aAjWr7AUHq9iyU
	Reb5jevQ==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSllz-0002ON-Cw; Thu, 07 Nov 2019 17:40:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/2] openrisc: use the generic in-place uncached DMA allocator
Date: Thu,  7 Nov 2019 18:40:35 +0100
Message-Id: <20191107174035.13783-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107174035.13783-1-hch@lst.de>
References: <20191107174035.13783-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	openrisc@lists.librecores.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Switch openrisc to use the dma-direct allocator and just provide the
hooks for setting memory uncached or cached.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/Kconfig      |  1 +
 arch/openrisc/kernel/dma.c | 51 +++++---------------------------------
 2 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index bf326f0edd2f..72469d2d2866 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,6 +7,7 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
index 4d5b8bd1d795..9a5b10164b08 100644
--- a/arch/openrisc/kernel/dma.c
+++ b/arch/openrisc/kernel/dma.c
@@ -11,8 +11,6 @@
  * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
  *
  * DMA mapping callbacks...
- * As alloc_coherent is the only DMA callback being used currently, that's
- * the only thing implemented properly.  The rest need looking into...
  */
 
 #include <linux/dma-noncoherent.h>
@@ -67,62 +65,25 @@ static const struct mm_walk_ops clear_nocache_walk_ops = {
 	.pte_entry		= page_clear_nocache,
 };
 
-/*
- * Alloc "coherent" memory, which for OpenRISC means simply uncached.
- *
- * This function effectively just calls __get_free_pages, sets the
- * cache-inhibit bit on those pages, and makes sure that the pages are
- * flushed out of the cache before they are used.
- *
- * If the NON_CONSISTENT attribute is set, then this function just
- * returns "normal", cachable memory.
- *
- * There are additional flags WEAK_ORDERING and WRITE_COMBINE to take
- * into consideration here, too.  All current known implementations of
- * the OR1K support only strongly ordered memory accesses, so that flag
- * is being ignored for now; uncached but write-combined memory is a
- * missing feature of the OR1K.
- */
-void *
-arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+int arch_dma_set_uncached(void *cpu_addr, size_t size)
 {
-	unsigned long va;
-	void *page;
-
-	page = alloc_pages_exact(size, gfp | __GFP_ZERO);
-	if (!page)
-		return NULL;
-
-	/* This gives us the real physical address of the first page. */
-	*dma_handle = __pa(page);
-
-	va = (unsigned long)page;
+	unsigned long va = (unsigned long)cpu_addr;
 
 	/*
 	 * We need to iterate through the pages, clearing the dcache for
 	 * them and setting the cache-inhibit bit.
 	 */
-	if (walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
-			NULL)) {
-		free_pages_exact(page, size);
-		return NULL;
-	}
-
-	return (void *)va;
+	return walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
+			NULL);
 }
 
-void
-arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
+void arch_dma_clear_uncached(void *cpu_addr, size_t size)
 {
-	unsigned long va = (unsigned long)vaddr;
+	unsigned long va = (unsigned long)cpu_addr;
 
 	/* walk_page_range shouldn't be able to fail here */
 	WARN_ON(walk_page_range(&init_mm, va, va + size,
 			&clear_nocache_walk_ops, NULL));
-
-	free_pages_exact(vaddr, size);
 }
 
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t addr, size_t size,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
