Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764968F44
	for <iommu@lists.linux.dev>; Sat, 30 Sep 2023 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3vVxJ+D//iP/ZGnGKLEESgiP70DXycjK8qgwox3ixOU=; b=t+KqkkbzG+EKYG1P+7XpreaPrM
	k4OjJtbSuKrkgmRW/k3rxCX12/ODC3sutOjhPafHz+LWkHZbJiWBo+o+/nmnmXgM1PP+J8od+D9UU
	9Iq6GHqCqXS/Sj+70rNIG8f+RPx3++d/rQJhrZjXXsJnV9OuCuXe8wWwgffs7+E10fM7765zXXern
	uHuEH1p8hiBT+MPKBjb20EssTVTKevxtuXVLcrRTa5H9qGykaRR7rHxYi5bLc+SdHx1+vj5J6+HAj
	919fibd8KmiowgZPVuJpT5pgnBJxescYnL+aXh4cDun2t4mvckjAGXUyMkVLFTx3o94/+ToscD0B1
	jnEv8AkA==;
Received: from [2001:4bb8:180:ac72:2f74:b3e8:163a:60ef] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qmdhD-009vSH-11;
	Sat, 30 Sep 2023 17:24:03 +0000
Date: Sat, 30 Sep 2023 19:23:58 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.6
Message-ID: <ZRhZrvxhAf78PgAt@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-09-30

for you to fetch changes up to 2d5780bbef8dbe6375d481cbea212606a80e4453:

  swiotlb: fix the check whether a device has used software IO TLB (2023-09-27 11:19:15 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.6

 - fix the narea calculation in swiotlb initialization (Ross Lagerwall)
 - fix the check whether a device has used swiotlb (Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (1):
      swiotlb: fix the check whether a device has used software IO TLB

Ross Lagerwall (1):
      swiotlb: use the calculated number of areas

 include/linux/swiotlb.h | 23 ++++++++++++++++-------
 kernel/dma/swiotlb.c    | 31 ++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 16 deletions(-)
