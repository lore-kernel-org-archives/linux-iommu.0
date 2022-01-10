Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F91C433F5
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 18:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1928160E22;
	Mon, 10 Jan 2022 18:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zy8r--bg0p-W; Mon, 10 Jan 2022 18:46:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F347E6079D;
	Mon, 10 Jan 2022 18:46:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6E96C0030;
	Mon, 10 Jan 2022 18:46:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57568C001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 18:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F73D6079D
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 18:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YsvTGY0kAw7q for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 18:46:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 286C760E22
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=H3KF2prjYBSwrnfLvzejhzHVkMgjeD7cUDDGRAfx4vA=; b=IjTRj51FE8xpAGBh+cH4TWcHvJ
 MG2wJzSHRW7gAwyqyfkfXu/m/zYZ36/rsok84KGSDXK4tGnSckzORdQ1zgYiq/HVtAw5nYzZw8DUy
 IRCXKirqM7NrzeqsyuhAa06TJJ2jci8Dpi8KFiYL264JB4bqvtCDKhF+0zn4jDOmw786KKHjUS4TT
 lF4mgOAiHXJLtxCu9Z8/CyJZJgEj/Jscz5tM8SG6VLdqIKswqVG4UVAUeZLezohknH6ceuHht7+aU
 7ZENsFD1jIkWeFLbo2NQcrFAM34IBeBJD/xoGZSPnoSjAs3bK+BmnZkQm+W8iQk/zp+h5VlWiLttq
 8CQC5sBw==;
Received: from [2001:4bb8:18c:6af6:7014:844b:d20b:2d30] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n6zgC-00CqCn-Cb; Mon, 10 Jan 2022 18:46:04 +0000
Date: Mon, 10 Jan 2022 19:46:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for Linux 5.17
Message-ID: <Ydx+6rmjq2giOC/b@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17

for you to fetch changes up to f857acfc457ea63fa5b862d77f055665d863acfe:

  lib/scatterlist: cleanup macros into static inline functions (2021-12-22 09:21:43 +0100)

----------------------------------------------------------------
dma-mapping updates for Linux 5.17

 - refactor the dma-direct coherent allocator
 - turn an macro into an inline in scatterlist.h (Logan Gunthorpe)

----------------------------------------------------------------
Christoph Hellwig (11):
      dma-direct: factor out dma_set_{de,en}crypted helpers
      dma-direct: don't call dma_set_decrypted for remapped allocations
      dma-direct: always leak memory that can't be re-encrypted
      dma-direct: clean up the remapping checks in dma_direct_alloc
      dma-direct: factor out a helper for DMA_ATTR_NO_KERNEL_MAPPING allocations
      dma-direct: refactor the !coherent checks in dma_direct_alloc
      dma-direct: fail allocations that can't be made coherent
      dma-direct: warn if there is no pool for force unencrypted allocations
      dma-direct: drop two CONFIG_DMA_RESTRICTED_POOL conditionals
      dma-direct: factor the swiotlb code out of __dma_direct_alloc_pages
      dma-direct: add a dma_direct_use_pool helper

Logan Gunthorpe (1):
      lib/scatterlist: cleanup macros into static inline functions

 include/linux/scatterlist.h |  29 ++++--
 kernel/dma/direct.c         | 240 ++++++++++++++++++++++++++------------------
 2 files changed, 163 insertions(+), 106 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
