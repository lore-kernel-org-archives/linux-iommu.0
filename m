Return-Path: <SRS0=VhCt=WE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE3BC433FF
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:01:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4324B217F4
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hfu9oWd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4324B217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3D6C8114E;
	Thu,  8 Aug 2019 16:00:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CC0AD1088
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:00:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6C51F829
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6rX4rzjkHGeK4NcYU1v//qZE74JXI8D/yo/ii/mnYy8=;
	b=Hfu9oWd7D7VEnMd8lwMF88eh50
	BrnWu/4N4gMfeeEotmC1C6Y+IfhfJTiB1IC70wAhR5mcLF5yinXgT7iJd4K7dstRQy5m09hks7OrJ
	zEZ0z/wwBb+A1O/IhjIHd2zh0vKOyma/ny+2FTKGh6YIwANnhvB0/I+c2fS/IjHEGss714co2qvBd
	lZzHBVxt2ueqjqs7M8VNPgT5WY92kbRli3ckVV8XUh0pvtHqWmcdLDRCdezLIkRi04cOZl/4nSQe/
	iChZdqMd8IckAsVP9tAkQsCeHzIuGvk+CU7UebYEbFUOa6jlcKLlmUy2IpoztFTi7nPeZYYTmrqvd
	dvG7o+HA==;
Received: from [195.167.85.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hvkqR-0006tx-U6; Thu, 08 Aug 2019 16:00:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 7/8] parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
Date: Thu,  8 Aug 2019 19:00:04 +0300
Message-Id: <20190808160005.10325-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

parisc is the only architecture that sets ARCH_NO_COHERENT_DMA_MMAP
when an MMU is enabled.  AFAIK this is because parisc CPUs use VIVT
caches, which means exporting normally cachable memory to userspace is
relatively dangrous due to cache aliasing.

But normally cachable memory is only allocated by dma_alloc_coherent
on parisc when using the sba_iommu or ccio_iommu drivers, so just
remove the .mmap implementation for them so that we don't have to set
ARCH_NO_COHERENT_DMA_MMAP, which I plan to get rid of.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/parisc/Kconfig        | 1 -
 drivers/parisc/ccio-dma.c  | 1 -
 drivers/parisc/sba_iommu.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 6d732e451071..e9dd88b7f81e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -52,7 +52,6 @@ config PARISC
 	select GENERIC_SCHED_CLOCK
 	select HAVE_UNSTABLE_SCHED_CLOCK if SMP
 	select GENERIC_CLOCKEVENTS
-	select ARCH_NO_COHERENT_DMA_MMAP
 	select CPU_NO_EFFICIENT_FFS
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 1d7125d29bee..ad290f79983b 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1024,7 +1024,6 @@ static const struct dma_map_ops ccio_ops = {
 	.unmap_page =		ccio_unmap_page,
 	.map_sg = 		ccio_map_sg,
 	.unmap_sg = 		ccio_unmap_sg,
-	.mmap =			dma_common_mmap,
 	.get_sgtable =		dma_common_get_sgtable,
 };
 
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index fa4df65b7e28..ed50502cc65a 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1084,7 +1084,6 @@ static const struct dma_map_ops sba_ops = {
 	.unmap_page =		sba_unmap_page,
 	.map_sg =		sba_map_sg,
 	.unmap_sg =		sba_unmap_sg,
-	.mmap =			dma_common_mmap,
 	.get_sgtable =		dma_common_get_sgtable,
 };
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
