Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A04EC433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 14:12:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A43F206C1
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 14:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g8x5ga3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A43F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DBBB3E9A;
	Wed, 14 Aug 2019 14:12:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3C024C5D
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 14:12:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E20B68A6
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 14:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wNAotc+YfObYMHP+Et0cYpre0RXPoOPUScnc71ZCCN0=;
	b=g8x5ga3zG8Qv34oZE7poH84sBC
	weQ4xKIdYW1uBiZvAi38+jHi7uhUVbCd7caX/PXGsYG499S5EPoqXtafuRTvX2gaYI8KdwtYWLrLV
	waRjmLUNjrpsPohrrzwMnLElKv6YbVQ0W61u8ItYI/Omt0nLuUSb+sgTNLxJkA2YLl9dC3XvUOjPy
	vzfa4HonzfPevyJ9+tBbnZuYyh4pXjURzJTSASFQliQ4Vce31WsWxc2APNcDX63BqUgTY6nyWwAO4
	QgIah0qTHyVyyNssaKO/MYA90fgTkMS9q67Fl7oEWs/8JEDUXXJwOoORd/gh7AimMiEavdBXyTZw3
	gq1tehMQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hxu0h-0004We-6a; Wed, 14 Aug 2019 14:12:19 +0000
Date: Wed, 14 Aug 2019 16:12:17 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma mapping fixes for 5.3-rc
Message-ID: <20190814141217.GA3792@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The following changes since commit 451577f3e3a9bf1861218641dbbf98e214e77851:

  Merge tag 'kbuild-fixes-v5.3-3' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2019-08-09 20:31:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-4

for you to fetch changes up to 33dcb37cef741294b481f4d889a465b8091f11bf:

  dma-mapping: fix page attributes for dma_mmap_* (2019-08-10 19:52:45 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.3-rc

 - fix the handling of the bus_dma_mask in dma_get_required_mask, which
   caused a regression in this merge window (Lucas Stach)
 - fix a regression in the handling of DMA_ATTR_NO_KERNEL_MAPPING (me)
 - fix dma_mmap_coherent to not cause page attribute mismatches on
   coherent architectures like x86 (me)

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
      dma-mapping: fix page attributes for dma_mmap_*

Lucas Stach (1):
      dma-direct: don't truncate dma_required_mask to bus addressing capabilities

 arch/arm/mm/dma-mapping.c        |  4 +---
 arch/arm64/mm/dma-mapping.c      |  4 +---
 arch/powerpc/Kconfig             |  1 -
 arch/powerpc/kernel/Makefile     |  3 +--
 arch/powerpc/kernel/dma-common.c | 17 -----------------
 drivers/iommu/dma-iommu.c        |  6 +++---
 include/linux/dma-noncoherent.h  | 13 +++++++++----
 kernel/dma/direct.c              | 10 +++++-----
 kernel/dma/mapping.c             | 19 ++++++++++++++++++-
 kernel/dma/remap.c               |  2 +-
 10 files changed, 39 insertions(+), 40 deletions(-)
 delete mode 100644 arch/powerpc/kernel/dma-common.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
