Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FAEC433EF
	for <iommu@archiver.kernel.org>; Sun, 27 Feb 2022 18:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70D02408A4;
	Sun, 27 Feb 2022 18:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HLUfhSKoYLkQ; Sun, 27 Feb 2022 18:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 96FF14089A;
	Sun, 27 Feb 2022 18:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A747C0077;
	Sun, 27 Feb 2022 18:12:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B792EC001A
 for <iommu@lists.linux-foundation.org>; Sun, 27 Feb 2022 18:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A01A5408A0
 for <iommu@lists.linux-foundation.org>; Sun, 27 Feb 2022 18:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gOw6ufqoR7QH for <iommu@lists.linux-foundation.org>;
 Sun, 27 Feb 2022 18:12:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CAA14089A
 for <iommu@lists.linux-foundation.org>; Sun, 27 Feb 2022 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=VA6kacKbPKbiivcIZRmKZi1KNf7ZiEsud7xUBH92hHs=; b=xoVbEInD64+Y2TUVFpYcyxSQ2d
 HQ7q/UtZQ6eVgtNB/LbYL+/LUTO3meYnhi35iqza4tT1mr2Pc0JTsSaEl3rm9EL8bx77SdJb8ipdL
 Zvw4Aymq72oYjH0u5fM68AEeGdSMD7mX8JOrcOmOIWbyuoFSmjkea2pG4su1pVByjxQMcFc3zvDQN
 WegKyNcVDZbIlxNd8E8yFqdpmpF2DbUtOlTwvE4gWI5XHrMz05t4MfHSFapyHAd67680/LoKRxyb5
 Wdf3oKAnZwBieF6ZQdI6f8nYwkrY4LDc0Dbf+kAqiJKYZ/yXgdbVSaqt3kiAetpdU+J4RFU726d1v
 StFAcOeA==;
Received: from 91-118-163-82.static.upcbusiness.at ([91.118.163.82]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOO1e-009upo-4g; Sun, 27 Feb 2022 18:12:06 +0000
Date: Sun, 27 Feb 2022 19:12:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fix for Linux 5.17
Message-ID: <Yhu+8trQqqmYLid3@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Halil Pasic <pasic@linux.ibm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17-1

for you to fetch changes up to ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e:

  swiotlb: fix info leak with DMA_FROM_DEVICE (2022-02-14 10:22:28 +0100)

----------------------------------------------------------------
dma-mapping fix for Linux 5.17

 - fix a swiotlb info leak (Halil Pasic)

----------------------------------------------------------------
Halil Pasic (1):
      swiotlb: fix info leak with DMA_FROM_DEVICE

 Documentation/core-api/dma-attributes.rst | 8 ++++++++
 include/linux/dma-mapping.h               | 8 ++++++++
 kernel/dma/swiotlb.c                      | 3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
