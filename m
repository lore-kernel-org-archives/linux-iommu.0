Return-Path: <SRS0=ipMx=7T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AFEC433DF
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 16:11:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1106220772
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 16:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nE5fDrqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1106220772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CA4DB20432;
	Sat,  6 Jun 2020 16:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PX1KESCPmF2G; Sat,  6 Jun 2020 16:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2571520012;
	Sat,  6 Jun 2020 16:11:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 155CCC088D;
	Sat,  6 Jun 2020 16:11:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC24C016E
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 16:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2EC0B87587
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 16:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KLOGgVfxYs0l for <iommu@lists.linux-foundation.org>;
 Sat,  6 Jun 2020 16:11:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ABD2587726
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Mm+5DhSxR2Kbdc/sLQObOdz1Pr0vn51n7mq4wVieKGw=; b=nE5fDrqkNkWTT6na+5H7yEMIpS
 GaU3WO7WZp/+z4VEPR/nLdOh3xstH3JgOKJfCaox9btWKqNbTIRoYsFXDgyRJAycd8kpBSUC7tdMH
 jvWfP7AZLQBzyRlFslkZT35tb5gunfuJpPcYQ2dI4LgCSPPmxvi1lRERWV2XcQzGYPlOrfR3CVTRp
 Ejy5W3NYIbgdh7MxzjDcJajl+yKch/xh/eTlSQ2kfd8m9Y1K8ojxXH5Wu7yvfu/Q5/Pbt2f9QcZGH
 3zb0oZuzRiNkF32hgwx0/yDPY1/1y/E42JRbP0VQqK9XBT/Jb7q3awxFi+dO8hZaBTuqgvmqoRGyn
 eNEoZceg==;
Received: from 213-225-38-56.nat.highway.a1.net ([213.225.38.56]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhbQ9-0004up-Gi; Sat, 06 Jun 2020 16:11:46 +0000
Date: Sat, 6 Jun 2020 18:09:32 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for 5.8, part 2
Message-ID: <20200606160932.GB3482728@infradead.org>
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

These were in a separate stable branch so that various media and drm
trees could pull the in for bug fixes, but looking at linux-next that
hasn't actually happened yet.  Still sending the APIs to you in the
hope that these bug fixes get picked up for 5.8 in one way or another.


The following changes since commit 24085f70a6e1b0cb647ec92623284641d8270637:

  Merge tag 'trace-v5.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2020-05-12 11:06:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-2

for you to fetch changes up to 48530d9fab0d3bf08827f9167be54acf66d4d457:

  iommu: add generic helper for mapping sgtable objects (2020-05-13 15:48:20 +0200)

----------------------------------------------------------------
dma-mapping updates for 5.8, part 2

 - add DMA mapping helpers for struct sg_table (Marek Szyprowski)

----------------------------------------------------------------
Marek Szyprowski (3):
      dma-mapping: add generic helpers for mapping sgtable objects
      scatterlist: add generic wrappers for iterating over sgtable objects
      iommu: add generic helper for mapping sgtable objects

 include/linux/dma-mapping.h | 80 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h       | 16 +++++++++
 include/linux/scatterlist.h | 50 ++++++++++++++++++++++++++--
 3 files changed, 143 insertions(+), 3 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
