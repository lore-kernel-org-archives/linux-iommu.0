Return-Path: <SRS0=KJF5=U5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF4C5B57E
	for <iommu@archiver.kernel.org>; Sun, 30 Jun 2019 16:48:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AC820665
	for <iommu@archiver.kernel.org>; Sun, 30 Jun 2019 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xrjm5qZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AC820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D93E7C51;
	Sun, 30 Jun 2019 16:48:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 019F1BBC
	for <iommu@lists.linux-foundation.org>;
	Sun, 30 Jun 2019 16:48:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5333CA8
	for <iommu@lists.linux-foundation.org>;
	Sun, 30 Jun 2019 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OOfEOtrG0Sb6Y0YzmxJZbpeIWttqDGl84dqQ7eJVwPg=;
	b=Xrjm5qZNG1e59Q/Wtor0r/mMS
	tqG2QGAng39Aw1YruOo7lmewixNBu6SxOymcCzjES7SrJVB4U+CCQV9UVMOqSceTYvVOeL0i9+PmB
	NeJkRYQTpjGcbc4OnwHn99jepPjWFvQ2anm5vbPMnTkKfTwaU5U/4jYErYBnmzG2fSw4KlJVNjI9v
	Qj2pjZZafiafco6GYuDmPvGya40WoQKC7MRJ/DZMahAAPJICw4ZLVSgIBZWM4meNnpi7huW0fD5qU
	i8RZWzQb8R7dVvSDpchsihU4Tzo+YQt7kidskBBBGZ2XyDfv06YrOGqhdTBqHhb2hxnGxdkQ56Tk+
	M6twGDX0A==;
Received: from [213.208.157.36] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hhczn-0004lL-Tx; Sun, 30 Jun 2019 16:48:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: paul.burton@mips.com
Subject: [PATCH] MIPS: only select ARCH_HAS_UNCACHED_SEGMENT for non-coherent
	platforms
Date: Sun, 30 Jun 2019 18:48:05 +0200
Message-Id: <20190630164805.12229-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
	linux@roeck-us.net
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

While mips might architecturally have the uncached segment all the time,
the infrastructure to use it is only need on platforms where DMA is
at least partially incoherent.  Only select it for those configuration
to fix a build failure as the arch_dma_prep_coherent symbol is also only
provided for non-coherent platforms.

Fixes: 2e96e04d25 ("MIPS: use the generic uncached segment support in dma-direct")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 61a390c2f2c1..caf480275a31 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -8,7 +8,6 @@ config MIPS
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-	select ARCH_HAS_UNCACHED_SEGMENT
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
@@ -1120,6 +1119,7 @@ config DMA_NONCOHERENT
 	bool
 	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_UNCACHED_SEGMENT
 	select NEED_DMA_MAP_STATE
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select DMA_NONCOHERENT_CACHE_SYNC
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
