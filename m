Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F928C433E0
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 07:49:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D17208C7
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 07:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aAeel0Tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D17208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 135D92048D;
	Sat, 27 Jun 2020 07:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f8qHwOBM3lUb; Sat, 27 Jun 2020 07:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A915420468;
	Sat, 27 Jun 2020 07:49:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85806C088C;
	Sat, 27 Jun 2020 07:49:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFED1C016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 07:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D997585BF7
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 07:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dAZgrqWd6N4L for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 07:49:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E5F9985BBD
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=VISRGRVX3KTYFQ5h7gP2VwYP1BiwOz4Oy4J0zolFtuE=; b=aAeel0Tk4D0FgLHXHU22f2R1z0
 kItD/+v4kQfOgGNPMUZJCFliF5C8/S9d9XdqLvIMK8u68LEys7hOBBn57WWaNTD1g4ytQdZTkUrQM
 BPhPjU/XbeRkVc7VwWi44UdY7CgAvlQyPMogGuYIYwPSHyH2llS1DY3QVwWTjFZa5Kzx+lQOnGCF8
 XLi07T7Do/BzvkUQXhtRsqA79TThw6jyxzvwE7Pfpm+NeieVls7UOkphIG7/kucx8TDLm/xZEPD5O
 9FJPKRm8mzRLtIopZt5eLzAL+3B/yjYjRvR1sCyZmz6FokT11nvdRshlpce94T1QLmtteOAJajd07
 STxBmgkw==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jp5aC-0007Xl-DJ; Sat, 27 Jun 2020 07:49:05 +0000
Date: Sat, 27 Jun 2020 09:49:02 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fixes for 5.8
Message-ID: <20200627074902.GA2447682@infradead.org>
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

The following changes since commit dbed452a078d56bc7f1abecc3edd6a75e8e4484e:

  dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL (2020-06-15 08:35:30 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-4

for you to fetch changes up to 8e36baf97b252cdcafa53589e8227cbb1e85f0b0:

  dma-remap: align the size in dma_common_*_remap() (2020-06-23 14:14:41 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.8:

 - fix dma coherent mmap in nommu (me)
 - more AMD SEV fallout (David Rientjes, me)
 - fix alignment in dma_common_*_remap (Eric Auger)

----------------------------------------------------------------
Christoph Hellwig (3):
      dma-direct: re-enable mmap for !CONFIG_MMU
      dma-direct: mark __dma_direct_alloc_pages static
      dma-mapping: DMA_COHERENT_POOL should select GENERIC_ALLOCATOR

David Rientjes (4):
      dma-direct: always align allocation size in dma_direct_alloc_pages()
      dma-direct: re-encrypt memory if dma_direct_alloc_pages() fails
      dma-direct: check return value when encrypting or decrypting memory
      dma-direct: add missing set_memory_decrypted() for coherent mapping

Eric Auger (1):
      dma-remap: align the size in dma_common_*_remap()

 include/linux/dma-direct.h |  2 --
 kernel/dma/Kconfig         |  3 ++-
 kernel/dma/direct.c        | 59 ++++++++++++++++++++++++++--------------------
 kernel/dma/remap.c         |  5 ++--
 4 files changed, 39 insertions(+), 30 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
