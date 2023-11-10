Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE7186B
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MnxFlr7v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rTDDJ39p2/9RhU5/XQUbQQVJgSZq+xnn1qxqWoHI9x4=; b=MnxFlr7vhkts8x9CK+vrb8uBHw
	yV3IBAU12521sMrM32umdbb2MX6cGbxP2MIRHt9JLRX803Yw07vA8QGC/BJn2/JhlZO7Tq6+jc0Uq
	17XPnN+a9KdNoDCMS8B2oq8COdhJbztc3YWslWvOk6baoEM6YUfjm49w5Kc2ZsuwhwS0vRYr11qR+
	KrGifuYDI+1nOEVbjumZfFxRdyqlzmsAsASoFmYi10CIqQvpSOwCEERwSyM6Kj1rNGnhLpX2rKUXE
	ISbmpp/piVpIkLlhibI8fVWpHAwlVsM/MAj3ranSOjoreBdWR04KXUceZYjzOflt9GvAzTmcVNQB1
	zakXh0vQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r1LUn-007zwi-1a;
	Fri, 10 Nov 2023 07:00:01 +0000
Date: Fri, 10 Nov 2023 07:59:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.7
Message-ID: <ZU3U759SwIC4Vv-F@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 8f6f76a6a29f36d2f3e4510d0bde5046672f6924:

  Merge tag 'mm-nonmm-stable-2023-11-02-14-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-11-02 20:53:31 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-11-10

for you to fetch changes up to 53c87e846e335e3c18044c397cc35178163d7827:

  swiotlb: fix out-of-bounds TLB allocations with CONFIG_SWIOTLB_DYNAMIC (2023-11-08 16:27:05 +0100)

----------------------------------------------------------------
ma-mapping fixes for Linux 6.7

 - don't leave pages decrypted for DMA in encrypted memory setups linger
   around on failure (Petr Tesarik)
 - fix an out of bounds access in the new dynamic swiotlb code (Petr Tesarik)
 - fix dma_addressing_limited for systems with weird physical memory layouts
   (Jia He)

----------------------------------------------------------------
Jia He (2):
      dma-mapping: move dma_addressing_limited() out of line
      dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover all system RAM

Petr Tesarik (2):
      swiotlb: do not free decrypted pages if dynamic
      swiotlb: fix out-of-bounds TLB allocations with CONFIG_SWIOTLB_DYNAMIC

 include/linux/dma-mapping.h | 19 +++++--------------
 kernel/dma/direct.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.h         |  1 +
 kernel/dma/mapping.c        | 22 ++++++++++++++++++++++
 kernel/dma/swiotlb.c        | 28 ++++++++++++++++++----------
 5 files changed, 86 insertions(+), 24 deletions(-)
