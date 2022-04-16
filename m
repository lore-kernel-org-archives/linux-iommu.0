Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308FFC433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 05:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4E54610E7;
	Sat, 16 Apr 2022 05:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GmGFpFKBKZfX; Sat, 16 Apr 2022 05:55:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E4696061B;
	Sat, 16 Apr 2022 05:55:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B2F3C002F;
	Sat, 16 Apr 2022 05:55:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEDDEC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 05:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C622940488
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 05:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3pFSqKJOMH1 for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 05:55:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D219A400E5
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 05:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=kMcem6muCtTXNqsopWLyZ9KtYeViiCS3WXyDPoUdWSs=; b=UKlTIjTIyzTCh5gDYG05jRSGgn
 nGNuUohCebuE+1FjaDUL3PE86I81XGyqL4uIQX+0zxNDAwNdzbMk9zcW4dz22UbApaF1uQEBvdQ8+
 XfHA+IOamd3OnsAFjqn5womNmuyT2PqmRkJs+F6aSJkEm5Ml+Ef12PONPH8N1hJOejCbcJRGHo2TC
 jKWbZyQ6HEcqn5A8SPABExyHuPhCw/pOy4rs4iQs/g63gs2gAxojoCa533N/cuIRyoJqNaWZIU9d8
 xxAolr+BVIwMA+4ac7B4unGQZInjnUB3/QUWn8ECY0aEXbBXAtZ/0bca4S0Fi7dTmm3ZbJnytUUob
 Ne760+PA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfbP0-00CJWX-FV; Sat, 16 Apr 2022 05:55:22 +0000
Date: Sat, 16 Apr 2022 07:55:18 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fixes for Linux 5.18
Message-ID: <YlpaRgHee1NPl2XB@infradead.org>
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

The following changes since commit 4fe87e818ea492ade079cc01a31d088e445f8539:

  dma-mapping: move pgprot_decrypted out of dma_pgprot (2022-04-01 06:46:51 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-2

for you to fetch changes up to 9e02977bfad006af328add9434c8bffa40e053bb:

  dma-direct: avoid redundant memory sync for swiotlb (2022-04-14 06:30:39 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.18

 - avoid a double memory copy for swiotlb (Chao Gao)

----------------------------------------------------------------
Chao Gao (1):
      dma-direct: avoid redundant memory sync for swiotlb

 kernel/dma/direct.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
