Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BA1FB5
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 07:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MNjuw99R4HgS/gXxR2rjHmB3r482Mpv9GRPW/CNskZA=; b=1jOsEuWgQSmtMaFWKT/scfSbVT
	lUFFM6ktVoaRkQFLyF2Dqnlavx3hi4StHJOm3DIiyzYMOpwbJ/WiD7wqWbLdQo8P/dysFa+u8qZ7/
	1MvcLDhfikHckihLkREpGhA4gg5GQtI2db0kGet+cg5T+sz0sQ/ewjGxM9k9gaU3BwTUUiMH+KfqD
	/s9h3kxBXjw459cZ0TTwSJpkRXO+OtKN2smJA1oX4s20l56bHONL4yKZUcHSqtuMVy0tWPTUh6Hu0
	Nv4I0pQkkr9AiEsRjrUIOEJtPb0FW/mnpre2CKXICO+75bn2r2Nmd+jrHN9UoGutp3RNYMgq/aOZW
	t6b7kSeg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUjAi-00B17L-2z; Wed, 22 Feb 2023 07:04:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH] swiotlb: mark swiotlb_memblock_alloc() as __init
Date: Tue, 21 Feb 2023 23:04:11 -0800
Message-Id: <20230222070411.6186-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

swiotlb_memblock_alloc() calls memblock_alloc(), which calls
(__init) memblock_alloc_try_nid(). However, swiotlb_membloc_alloc()
can be marked as __init since it is only called by swiotlb_init_remap(),
which is already marked as __init. This prevents a modpost build
warning/error:

WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)

This fixes the build warning/error seen on ARM64, PPC64, S390, i386,
and x86_64.

Fixes: 8d58aa484920 ("swiotlb: reduce the swiotlb buffer size on allocation failure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
---
 kernel/dma/swiotlb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -- a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -292,8 +292,9 @@ static void swiotlb_init_io_tlb_mem(stru
 	return;
 }
 
-static void *swiotlb_memblock_alloc(unsigned long nslabs, unsigned int flags,
-		int (*remap)(void *tlb, unsigned long nslabs))
+static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
+			unsigned int flags,
+			int (*remap)(void *tlb, unsigned long nslabs))
 {
 	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 	void *tlb;
