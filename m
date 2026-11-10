Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304131;
	b=rQ2cNYWBpstZAiQbYNVWyO2Q3mAeabrPuIzFnwsAHGdLfYp7e+niwF30P6vjRGCT1TK4
	 OZFLeqihfhrrEUk2w0bqxWcB7DdkiWSzIaug7s18Sqz6WI55a/XMxJpPycb18/XUSpYZp
	 7KqFPJVnx6/PqNX7VHjCKlUd9rILzdCN8vSUztoxJZClSDQNlrmaYwisp6PIrUenMqwSQ
	 ZV9B6v5JU7bpVZwxw9Uc8GrRIR4ZNvOAkRplTMQ60zRpHEqD7hoSmKfpTTFbUVrBl1P9+
	 WDlH/qUyAS3eT4g1eojFEcAKMgWaYwqv/LX3FrKdOuwIfSLNFuYKX2uVltw9Zn+ABrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304131;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=3WfehI9fQijRo2A/YkZKLEEsknJgbPS4DyEKhXbP7KQ=;
	b=rFKrby10gU+ZzD8w4QYcfO2hhfUNtV5hJWBdSG1gQbZF8wrNTHOJSj1LDgdDeewSP0Or
	 jQY5atPJZpRwOuzhKin6YCjNwVLZaigDVaLuKhSybXAWhV8CK0BQbcGxelGa73aQfshBE
	 0LFy5781BjQuoS7InwncF+doZxtr0cXaWdkPeFzsv2p6kMawrobUMMoF18grNObsdlxPS
	 eX0bq1ua3FlWhpyqsvkPeP2Q5kxPuqMkgYtb3GibrJEOZL2NwkQNmop4097zhTUWvZCl/
	 2UhPQ6fUCOF5ZC168fA+sdrvAx/3cc31vFOV7i+4lCptOkQJCTtk2e7F+UVAWIv0eCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=t5H7erzo;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E08606A321
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64E08606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=t5H7erzo
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094847euoutp01d9638d1f915948f8e66ef8dde6fae07c~mphjn62q-1176611766euoutp01F
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:48:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261110094847euoutp01d9638d1f915948f8e66ef8dde6fae07c~mphjn62q-1176611766euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304127;
	bh=3WfehI9fQijRo2A/YkZKLEEsknJgbPS4DyEKhXbP7KQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=t5H7erzotTjNcdaOkmaz3M4aA0Bqymkk4HSUDa58RSqUxDGN6OQYsxVyl1jgVDKGD
	 bLjcVFp9RRWjiC9Fcd+zIkUM6TTLjMXbv3wVY4MDaONJLRjuve1I7MrmM00BC+kuY9
	 Ah8MaNnhV/y3AztJNjfW33hOf5Z0Whnj6YtDNxQA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51~mphjEO8nd1080110801eucas1p1W;
	Tue, 10 Nov 2026 09:48:46 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094846eusmtip14801004a391e04a621db015af3a4d45a~mphiUYlbM3235732357eusmtip1b;
	Tue, 10 Nov 2026 09:48:46 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 0/7] dma-mapping: DMA_ATTR_NO_KERNEL_MAPPING related
 fixes
Date: Tue, 10 Nov 2026 10:48:20 +0100
Message-ID: <20261110094830.2081847-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51
X-EPHeader: CA
X-CMS-RootMailID: 20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51
References: <CGME20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51@eucas1p1.samsung.com>

Hi All,

arch_dma_prep_coherent() is called by the generic DMA code on pages
which may be located in highmem: dma_direct_alloc() forces the remap
path for a highmem page returned from CMA and calls this hook on it
before creating the uncached mapping. However, the hook has never been
documented and some implementations assume that the page has a kernel
linear mapping. This issue affects MIPS, xtensa and PowerPC. It gets
fixed by patches #2-#4.

xtensa also only invalidates the cache, which discards the zeroes
written by the dma_direct_alloc(). Patch #1 switches it to a
writeback+invalidate.

Patch #5 documents that arch_dma_prep_coherent() must write back dirty
lines and must accept highmem pages. With that in place, patch #6 drops
the PageHighMem() check in dma_direct_alloc_no_mapping(), which so far
skipped cache maintenance for highmem CMA pages allocated with
DMA_ATTR_NO_KERNEL_MAPPING.

Patch #7 makes dma_direct_alloc_no_mapping() always return zeroed
memory, like all other dma_alloc_* paths. Passing __GFP_ZERO is not
enough there, because CMA ignores.

The analysis and the patchset was prepared with the help of an LLM. The
code compiles fine, but it has not been runtime tested on any of the
affected architectures yet. Testing on real hardware would be
appreciated. I've reviewed the resulting changes.

I plan to merge this via my dma-mapping tree, so I would like to get
acks from xtensa, MIPS and PowerPC arch maintainers.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Changelog:
v2:
- fixed minor issues in comments and patch descriptions pointed by sashiko
- dropped RFC annotation

v1: https://lore.kernel.org/all/20261106225628.215319-1-m.szyprowski@samsung.com/


Patch summary:

Marek Szyprowski (7):
  xtensa: write back dirty lines in arch_dma_prep_coherent()
  xtensa: handle highmem pages in arch_dma_prep_coherent()
  MIPS: mm: handle highmem pages in arch_dma_prep_coherent()
  powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
  dma-mapping: document that arch_dma_prep_coherent() must handle
    highmem
  dma-direct: do not skip cache maintenance for highmem pages in
    no-mapping allocations
  dma-direct: zero memory allocated with DMA_ATTR_NO_KERNEL_MAPPING

 arch/mips/mm/dma-noncoherent.c    | 10 +++++-----
 arch/powerpc/mm/dma-noncoherent.c |  4 +---
 arch/xtensa/kernel/pci-dma.c      | 12 +++++++++++-
 include/linux/dma-map-ops.h       | 11 +++++++++++
 kernel/dma/direct.c               |  9 +++++++--
 5 files changed, 35 insertions(+), 11 deletions(-)

-- 
2.43.0

