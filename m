Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DD9C07E9C
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:19:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F359B6115C
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F359B6115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4B8C607DB;
	Mon, 12 Jul 2021 06:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7nIFBZIp5gmI; Mon, 12 Jul 2021 06:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 982316058D;
	Mon, 12 Jul 2021 06:19:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74931C0010;
	Mon, 12 Jul 2021 06:19:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB40C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F148F4040E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6TQiv43v3PI for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 06:19:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 167E34040C
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=beM8fTJDPaLnKCeeGRk85GXcYvQNxhia1GMUUJGaUo8=; b=o2m4AAjPPOwEANBCECmW+IDLQl
 SCrxeIXMJkPAWxGKoQyPE70bdBKQSCgOmWgN+J+2z2C4uenkIrHK+Q83i4EmI5CQl40G1ULfC4Gpb
 mkjxKHO7+/C0hS3oWTqoKT6gSDjZPh1abW0pQvLE+2RuAw0HWddRWHZVc1c8vxGtnBltpXK2U671e
 CQwkjrxAwl+C6LUTMG5tR+NIjMa84o2lwVGH0/qoztBh2mloJD1mqMyrLRablFbBGeJdJOVqoDByD
 flvW0aCcJ3xtq7srGwc/1O20Gnol6iCihR5ual04IxxLfH95hYVP6MtMCiTySMvL1PO93JPVqg82t
 /UWUkW3Q==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2pGP-00Gx15-41; Mon, 12 Jul 2021 06:18:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Brian Cain <bcain@codeaurora.org>
Subject: [PATCH 1/7] dma-direct: add support for dma_coherent_default_memory
Date: Mon, 12 Jul 2021 08:16:58 +0200
Message-Id: <20210712061704.4162464-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hexagon@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
 Dillon Min <dillon.minfei@gmail.com>, linux-kernel@vger.kernel.org,
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

Add an option to allocate uncached memory for dma_alloc_coherent from
the global dma_coherent_default_memory.  This will allow to move
arm-nommu (and eventually other platforms) to use generic code for
allocating uncached memory from a pre-populated pool.

Note that this is a different pool from the one that platforms that
can remap at runtime use for GFP_ATOMIC allocations for now, although
there might be opportunities to eventually end up with a common codebase
for the two use cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
---
 kernel/dma/Kconfig  |  4 ++++
 kernel/dma/direct.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 77b405508743..725cfd51762b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -93,6 +93,10 @@ config DMA_COHERENT_POOL
 	select GENERIC_ALLOCATOR
 	bool
 
+config DMA_GLOBAL_POOL
+	select DMA_DECLARE_COHERENT
+	bool
+
 config DMA_REMAP
 	bool
 	depends on MMU
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f737e3347059..d1d0258ed6d0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -156,9 +156,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
 	    !dev_is_dma_coherent(dev))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev))
+		return dma_alloc_from_global_coherent(dev, size, dma_handle);
+
 	/*
 	 * Remapping or decrypting memory may block. If either is required and
 	 * we can't block, allocate the memory from the atomic pools.
@@ -255,11 +260,19 @@ void dma_direct_free(struct device *dev, size_t size,
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
 	    !dev_is_dma_coherent(dev)) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 		return;
 	}
 
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev)) {
+		if (!dma_release_from_global_coherent(page_order, cpu_addr))
+			WARN_ON_ONCE(1);
+		return;
+	}
+
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
@@ -462,6 +475,8 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
+	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
+		return ret;
 
 	if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
 		return -ENXIO;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
