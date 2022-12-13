Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734D2563
	for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YMCKa70hO2og8rNvNG5HsTDbzJi+PBGe30FejVIjU1k=; b=VuhhdN/Na6Jt0sZxnXuAlweCx3
	TvLg4Kgb4B8iKQ3RQx2/BNI05WvHhG6uHhO3fDI0eFgckDkjLm5AFPVeIKhvveCkxMWFxX7H41YJW
	ZiK3Trv94cOgEalRhkff3e+8KNECKL13oFEF2IVEb2R8b7cm9mMkbp+8eYx9vmPY+ZkTt6yyDFfrb
	soQDus7gr2R/PtZG7cM2ZLMXfNzjcXVCHob1y3vOD5ZTFoHmk1rnGmKkCQRKlEO7Qr5G4Ho5EX7Ts
	xoSGCvBPEr4Dzr/HV8qGdiD5wtm9jMY7Qkfsad5D7aF/tVbiy3xQU+83FYLAzV/6mbkoBcdOtCfrU
	d708/dhA==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p58MX-002zdu-JM; Tue, 13 Dec 2022 16:42:38 +0000
Date: Tue, 13 Dec 2022 17:42:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.2
Message-ID: <Y5ire5HIAi/kc3cg@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.2-2022-12-13

for you to fetch changes up to ffcb754584603adf7039d7972564fbf6febdc542:

  dma-mapping: reject __GFP_COMP in dma_alloc_attrs (2022-11-21 09:37:20 +0100)

----------------------------------------------------------------
dma-mapping updates for Linux 2.6

 - reduce the swiotlb buffer size on allocation failure
   (Alexey Kardashevskiy)
 - clean up passing of bogus GFP flags to the dma-coherent allocator
   (Christoph Hellwig)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      swiotlb: reduce the swiotlb buffer size on allocation failure

Christoph Hellwig (7):
      media: videobuf-dma-contig: use dma_mmap_coherent
      RDMA/hfi1: don't pass bogus GFP_ flags to dma_alloc_coherent
      RDMA/qib: don't pass bogus GFP_ flags to dma_alloc_coherent
      cnic: don't pass bogus GFP_ flags to dma_alloc_coherent
      s390/ism: don't pass bogus GFP_ flags to dma_alloc_coherent
      ALSA: memalloc: don't pass bogus GFP_ flags to dma_alloc_*
      dma-mapping: reject __GFP_COMP in dma_alloc_attrs

 arch/arm/mm/dma-mapping.c                     | 17 --------
 drivers/infiniband/hw/hfi1/init.c             | 21 ++-------
 drivers/infiniband/hw/qib/qib_iba6120.c       |  2 +-
 drivers/infiniband/hw/qib/qib_init.c          | 21 ++-------
 drivers/iommu/dma-iommu.c                     |  3 --
 drivers/media/v4l2-core/videobuf-dma-contig.c | 22 ++++------
 drivers/net/ethernet/broadcom/cnic.c          |  6 +--
 drivers/s390/net/ism_drv.c                    |  3 +-
 kernel/dma/mapping.c                          |  8 ++++
 kernel/dma/swiotlb.c                          | 63 +++++++++++++++++----------
 sound/core/memalloc.c                         |  5 +--
 11 files changed, 69 insertions(+), 102 deletions(-)
