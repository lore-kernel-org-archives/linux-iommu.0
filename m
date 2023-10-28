Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165A621
	for <iommu@lists.linux.dev>; Sat, 28 Oct 2023 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cLOfh4GW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=fXN5QmDxRcC9PlWGir13GkiD3PUEUiOPSu3HdRVFd6c=; b=cLOfh4GW1bLPZcygMnf+MkOebK
	NJ54b86vclK2VBNyqW9MzYvrgxrZ8q6v6lghitLHvpYBF0Qo7EnZ8XWH6sxh3xaF4BGNP1yzDW4/4
	ns1MHGSjJ8xvSP9+rYWEEA17io5vOVw7i1reA4ft7bNkDQI0EZ9/Ya5lVtmz8CCC/glvUseqRlTN6
	Qv7t6LVKY34eO3qku476a2UKDOUHo9LR/ZNclFISKFeKUq97cwpahZPsKz9lMYHgqxGGg2PfYDn3H
	3AvQ7iF46UDKLUlprYRiMhwiPO1F2zKrjXQs1vbP0tVuzOxskqcv0rdeSRHOnZbFXk/4N7v908ZUY
	qfqpW/5A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qwlg8-000cnM-20;
	Sat, 28 Oct 2023 15:56:50 +0000
Date: Sat, 28 Oct 2023 17:56:41 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.6
Message-ID: <ZT0vORvO7dAaHPvj@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 4f82870119a46b0d04d91ef4697ac4977a255a9d:

  Merge tag 'mm-hotfixes-stable-2023-10-24-09-40' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-10-24 09:52:16 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-10-28

for you to fetch changes up to d5090484b021794271280ab64d20253883b7f6fd:

  swiotlb: do not try to allocate a TLB bigger than MAX_ORDER pages (2023-10-25 16:26:20 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.6

 - reduce the initialy dynamic swiotlb size to remove an annoying but
   harmless warning from the page allocator (Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (1):
      swiotlb: do not try to allocate a TLB bigger than MAX_ORDER pages

 kernel/dma/swiotlb.c | 5 +++++
 1 file changed, 5 insertions(+)
