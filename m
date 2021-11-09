Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFAEC433EF
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 13:53:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25743611C4
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 13:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25743611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D85AA40290;
	Tue,  9 Nov 2021 13:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tPRqb5p5e82E; Tue,  9 Nov 2021 13:53:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A69154025E;
	Tue,  9 Nov 2021 13:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F102C0019;
	Tue,  9 Nov 2021 13:53:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD686C000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 13:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B44A480D4D
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 13:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M0TBSYZSCAFu for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:53:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DCB280D23
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=oIgGMHpAi8JRcxWTzCOubpqVxrGPO33+sqQ/r9/ZSe8=; b=vCCTlysMrpqzREWqr9l/8iS5z0
 3kcyk2eEQu9gz/0H+hXP44mhE6q9fECwsTorbB7hVYEXzHjlSt0X4ApmSj4vGgNtbFcbg3RQgmVSc
 A00nChZp2FuqdN6raezzrT1fi2XYX64BPYZkgNL3BN2/BMNemdShGLZN1dCEwOG97dsY2lMABFHJx
 DnBeKBC0bCF51EP5FbmjHbFAeNbYJh3H8eDdQima6di6+jnoeLO6m1yxVifpqrU4Ww2UL2bcfVXlH
 Nn+gpBp0x0zWY6gOrdNelsuoELp61EHW8AQMP+LLEiGz4iwr9gU1AeJvWeX6X9j0XJqw0MV2zBGyp
 We9htWkw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkRYr-0014Wx-0z; Tue, 09 Nov 2021 13:53:18 +0000
Date: Tue, 9 Nov 2021 14:53:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for Linux 5.16
Message-ID: <YYp9TAVLFsxqfVx7@infradead.org>
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

Just a small set of changes this time.  The request dma_direct_alloc
cleanups are still under review and haven't made the cut.

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.16

for you to fetch changes up to 9fbd8dc19aa57ec8fe92606043199919527cd9be:

  dma-mapping: use 'bitmap_zalloc()' when applicable (2021-10-27 08:20:09 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 5.16

 - convert sparc32 to the generic dma-direct code
 - use bitmap_zalloc (Christophe JAILLET)

----------------------------------------------------------------
Christoph Hellwig (3):
      sparc32: remove the call to dma_make_coherent in arch_dma_free
      sparc32: remove dma_make_coherent
      sparc32: use DMA_DIRECT_REMAP

Christophe JAILLET (1):
      dma-mapping: use 'bitmap_zalloc()' when applicable

 arch/sparc/Kconfig         |  3 +-
 arch/sparc/kernel/ioport.c | 76 +++++-----------------------------------------
 kernel/dma/coherent.c      |  5 ++-
 3 files changed, 12 insertions(+), 72 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
