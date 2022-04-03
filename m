Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46675C433F5
	for <iommu@archiver.kernel.org>; Sun,  3 Apr 2022 12:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C3BBF404D3;
	Sun,  3 Apr 2022 12:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tm5tOrBXdjis; Sun,  3 Apr 2022 12:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F85F400AF;
	Sun,  3 Apr 2022 12:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82766C002C;
	Sun,  3 Apr 2022 12:22:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30739C0012
 for <iommu@lists.linux-foundation.org>; Sun,  3 Apr 2022 12:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 154AE404B2
 for <iommu@lists.linux-foundation.org>; Sun,  3 Apr 2022 12:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWDuXQIXpf13 for <iommu@lists.linux-foundation.org>;
 Sun,  3 Apr 2022 12:22:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B89FC400AF
 for <iommu@lists.linux-foundation.org>; Sun,  3 Apr 2022 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=4wMs/Nqcp6JMJCOeAiciegLddg5+RH3CPGP7YX3Zovw=; b=t6VkHZfztk9JHbAjpDWnjswvr+
 DQlqofEaMbXC8+ef1pzLpiR2Kr9HLG34IUMXMqL4bet3X/B2Tp/SaT5m0masgDsl7+gOAEa6jvFlz
 vqp2lPMVvCl8akXqtYRUGbtpzQ4ewqKmQpPmRzekBODslOZPZye0SudGYy/rBLdBKM35YEb1VLSAS
 tEvmBK/8lbDrFum4vF6lNnrxcq5KKCkzcp1HjGW9S66Pe77ZTqOgnLRtJQcBOC6cKtSD4B5byyQu9
 BOQiN1b6wwt/JBU+1rGzed0KZbu+1nTNcpsnImor+RflbwQAgg8QXSNiiyTTwYpWJwzUEOFI09Kj+
 YuvjAM7g==;
Received: from [2001:4bb8:184:7553:31f9:976f:c3b1:7920] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nazFq-00BLsM-1L; Sun, 03 Apr 2022 12:22:50 +0000
Date: Sun, 3 Apr 2022 14:22:47 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] second round of dma-mapping updates for Linux 5.18
Message-ID: <YkmRl8McdwST4cII@infradead.org>
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

The following changes since commit 5efabdadcf4a5b9a37847ecc85ba71cf2eff0fcf:

  Merge tag 'devicetree-fixes-for-5.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2022-03-29 08:55:16 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-1

for you to fetch changes up to 4fe87e818ea492ade079cc01a31d088e445f8539:

  dma-mapping: move pgprot_decrypted out of dma_pgprot (2022-04-01 06:46:51 +0200)

----------------------------------------------------------------
second round of dma-mapping updates for 5.18

 - fix a regression in dma remap handling vs AMD memory encryption (me)
 - finally kill off the legacy PCI DMA API (Christophe JAILLET)

----------------------------------------------------------------
Christoph Hellwig (2):
      PCI/doc: cleanup references to the legacy PCI DMA API
      dma-mapping: move pgprot_decrypted out of dma_pgprot

Christophe JAILLET (1):
      PCI: Remove the deprecated "pci-dma-compat.h" API

 Documentation/PCI/pci.rst      |  14 ++---
 include/linux/pci-dma-compat.h | 129 -----------------------------------------
 include/linux/pci.h            |   3 +-
 kernel/dma/direct.c            |  10 +++-
 kernel/dma/mapping.c           |   2 -
 5 files changed, 16 insertions(+), 142 deletions(-)
 delete mode 100644 include/linux/pci-dma-compat.h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
