Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196B2C34031
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 21:15:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D458924125
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 21:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpQz5E6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D458924125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9E10D85B4A;
	Tue, 18 Feb 2020 21:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NvL98C9u0vZX; Tue, 18 Feb 2020 21:15:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31FAA85ADC;
	Tue, 18 Feb 2020 21:15:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 189C0C08A0;
	Tue, 18 Feb 2020 21:15:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69F05C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 21:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6696A85B4A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 21:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Z14P8xRtsiy for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 21:15:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DDAF485ADC
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 21:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=YDNpfjFJzeSvSEEYP1Omf0hCUn2a1ROqATNsqQ7lTVk=; b=rpQz5E6qJ4lt2sGkm4aZKuH9H8
 TEu6LIuhR0NWAZb0cdbQhciRfVqBPxFQKKQG1btjdMx1LJ2iL8ikrd4CWajT8yBZisocYc9YaReKC
 7o6v5wB5Phuz7MnWqaE81vXhLMJuGOIPx/FP+jMZE9tTQo8yCmSQJXjEBpmK7BsPTnmDRHtBUaEOa
 1BnrkMYxk5S3tZQPHxrOqZVKNjbyPbTpZQVC3n8D2575M2dAdpyZ4bpgCfZhxtN/w2RmC7oWoXJGv
 BriB3w6IDDu0yIqje7dwBCeRb5qrKeIkUMBdy26jZh/LCRv3gfe/I4PCPB+U4OEXBUw6REwlvAi8b
 L/WSAseQ==;
Received: from [199.255.44.128] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4ACv-0000gY-Lf; Tue, 18 Feb 2020 21:15:05 +0000
Date: Tue, 18 Feb 2020 13:15:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for 5.6
Message-ID: <20200218211500.GA41556@infradead.org>
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

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.6

for you to fetch changes up to 75467ee48a5e04cf3ae3cb39aea6adee73aeff91:

  dma-direct: improve DMA mask overflow reporting (2020-02-05 18:53:41 +0100)

----------------------------------------------------------------
dma-mapping fixes for 5.6

 - give command line cma= precedence over the CONFIG_ option
   (Nicolas Saenz Julienne)
 - always allow 32-bit DMA, even for weirdly placed ZONE_DMA
 - improve the debug printks when memory is not addressable, to help
   find problems with swiotlb initialization

----------------------------------------------------------------
Christoph Hellwig (3):
      dma-direct: relax addressability checks in dma_direct_supported
      dma-direct: improve swiotlb error reporting
      dma-direct: improve DMA mask overflow reporting

Nicolas Saenz Julienne (1):
      dma-contiguous: CMA: give precedence to cmdline

 include/linux/swiotlb.h | 11 +++------
 kernel/dma/contiguous.c |  9 +++++++-
 kernel/dma/direct.c     | 61 ++++++++++++++++++++-----------------------------
 kernel/dma/swiotlb.c    | 42 +++++++++++++++++++---------------
 4 files changed, 59 insertions(+), 64 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
