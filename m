Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26934C433DF
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 14:15:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50F3206DA
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 14:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EliOTm2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50F3206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D51D8795A;
	Mon,  3 Aug 2020 14:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SccSxELBTTWz; Mon,  3 Aug 2020 14:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E70BF8667B;
	Mon,  3 Aug 2020 14:15:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBF76C0050;
	Mon,  3 Aug 2020 14:15:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABA47C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 14:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A7A4A86365
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 14:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZR8wOGtrabsU for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 14:15:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A75798630A
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=tAS11sJpElMBs2Pfs6KLa4qx/lgKKhsfUzhtsaRTmoY=; b=EliOTm2U9G2AnO8zvDaIC4l0Yk
 s9QE3PYEN+MjTLkLvLN3iT78LpVL6fJkdOmsvYe8TpxcMT0A+QzEgi33wM+24VrVr2Xr1laEDhhIm
 SAibRNjK+KGNSalwfKqbXjblaK/DzDlVo4KklgJ10ACHz6KEt0R6Qx7FNsfCr/tKYfTxPl40G/+2q
 ZAH87xvPiPivlT5x63I6H1RDl0V3y2CXwL/PmeQLvTsI5o+b3AxxnIXZ+67ziGX1dk1ZtY5yawHml
 Ctr6ZdBvYORw91KD6xCoIGmpbu5WDSnCWrpg6AmISv4RPP6VpNBV54LUrVQs7xUWNbSyLE/c98c2D
 ZqT29rGw==;
Received: from 93-43-212-104.ip93.fastwebnet.it ([93.43.212.104]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2bFj-0003E4-Sh; Mon, 03 Aug 2020 14:15:48 +0000
Date: Mon, 3 Aug 2020 16:15:47 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for 5.9
Message-ID: <20200803141547.GA752173@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Note that this adds a select to drivers/iommu/Kconfig symbols which moves
to drivers/iommu/intel/Kconfig in the iommu tree. 

The following changes since commit d9765e41d8e9ea2251bf73735a2895c8bad546fc:

  dma-pool: do not allocate pool memory from CMA (2020-07-14 15:46:32 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9

for you to fetch changes up to 274b3f7bf34415eed106e479e4815e897ce5d763:

  dma-contiguous: cleanup dma_alloc_contiguous (2020-07-28 13:42:15 +0200)

----------------------------------------------------------------
dma-mapping updates for 5.9

 - make support for dma_ops optional
 - move more code out of line
 - add generic support for a dma_ops bypass mode
 - misc cleanups

----------------------------------------------------------------
Christoph Hellwig (7):
      dma-mapping: move the remaining DMA API calls out of line
      dma-mapping: inline the fast path dma-direct calls
      dma-mapping: make support for dma ops optional
      dma-mapping: add a dma_ops_bypass flag to struct device
      powerpc: use the generic dma_ops_bypass mode
      dma-debug: use named initializers for dir2name
      dma-contiguous: cleanup dma_alloc_contiguous

 arch/alpha/Kconfig                |   1 +
 arch/arm/Kconfig                  |   1 +
 arch/ia64/Kconfig                 |   1 +
 arch/mips/Kconfig                 |   1 +
 arch/parisc/Kconfig               |   1 +
 arch/powerpc/Kconfig              |   2 +
 arch/powerpc/include/asm/device.h |   5 -
 arch/powerpc/kernel/dma-iommu.c   |  90 ++------------
 arch/s390/Kconfig                 |   1 +
 arch/sparc/Kconfig                |   1 +
 arch/x86/Kconfig                  |   1 +
 drivers/infiniband/core/device.c  |   6 +-
 drivers/iommu/Kconfig             |   2 +
 drivers/macintosh/macio_asic.c    |   4 +-
 drivers/misc/mic/Kconfig          |   4 +
 drivers/vdpa/Kconfig              |   1 +
 drivers/xen/Kconfig               |   1 +
 include/linux/device.h            |  11 +-
 include/linux/dma-direct.h        | 104 ++++++++++++++++
 include/linux/dma-mapping.h       | 251 +++++---------------------------------
 kernel/dma/Kconfig                |  12 ++
 kernel/dma/Makefile               |   3 +-
 kernel/dma/contiguous.c           |  31 +++--
 kernel/dma/debug.c                |   8 +-
 kernel/dma/direct.c               |  74 -----------
 kernel/dma/mapping.c              | 214 ++++++++++++++++++++++++++++++--
 26 files changed, 415 insertions(+), 416 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
