Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D8C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:09:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30778207FB
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lz8YfiSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30778207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4F0D851FA;
	Wed, 30 Sep 2020 16:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E1hl0AE7h6d2; Wed, 30 Sep 2020 16:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 68A99861F0;
	Wed, 30 Sep 2020 16:09:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A121C0889;
	Wed, 30 Sep 2020 16:09:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5553AC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4AA14855B1
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Wg9WYTahUdH for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:09:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 350D58553C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Bg6UAf5GmAebEK7LE0iET3qIkeB8RGO2JOGQCLfw5AE=; b=Lz8YfiSsW36fA+/kt+aQbTMK4P
 K6o/6VxFcPIVfzsF7/V5PFlSQAKkt6d4r+ZOirMOoIRjFKB9lqo8WhU0Hng+I8LDD973uUBpOMAGx
 aQMwUwC3BRYimqDyMZM2dY6a4XbNBQdmmocZs4mVYjF2+pbn6XFHehXz/ZnTPH3K8iP34Z0nfywAt
 da+F4VpYkHW+B5fhZq6JvsQfEtHhrJ2CvaupP0jjgjLWxXMKo9+TGT6tRu2GfP8v6RZew9VPaEwJ1
 j5smZJMasHuQ4SPX2i8LZyAYwhy8CDbLI54uncAOeXzaWjMPyILN2qmiwmq12V7bm5fj2KLNxLCs4
 iB8QVggg==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNefP-0003CH-NZ; Wed, 30 Sep 2020 16:09:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, iommu@lists.linux-foundation.org
Subject: dma_alloc_pages / dma_alloc_noncoherent fixups
Date: Wed, 30 Sep 2020 18:09:09 +0200
Message-Id: <20200930160917.1234225-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

Hi all,

this series has a bunch of fixups for the noncoherent DMA allocator
rework that recently landed in linux-next.

I think the most important part is that the idea of vmap()ing
non-contiguous allocations in dma_alloc_noncoherent doesn't work very
well after all.  It means we can't just rely on virt_to_page to get
the page and just use remap_pfn_range or stuff it into other APIs,
but on the other hand it also isn't really generic enought for what
the media APIs seems to want.

So the first patch reverts that change, and the last patch suggests
a different lower level API which should allow the media code to do
all it wants.

I'd suggest all but the last patch for the current merge window, and
we should have a discussion on how well the last one suits the media
subsystem, and probably merge it together with any media changes to
use the required API.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
