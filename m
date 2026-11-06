Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005813;
	b=IvWIcKEBg4Y1cfzOIW5c2z6RdnizRFnYOgUeKMf5lVV/tOAvkcDMSKNJpp+7j5KpLIdk
	 Z8YH1qD41mnBrA0aTgMZmYgqhvrI5rB/BcgjOZ4UB7efjNnT7saCfvHQqzcsNGeSsWmGD
	 6+xsS35Oo2QONQ5JEGLYV72pZjic+VDbavmbJmQWMHXSHgLnTOKbVbhcP0iQREnZGRpRd
	 eRPdjC3gD/bGePmoKI03cS+VPKuzHUeGYFL6huQko02ecy+/9RdFoP9fZ6oSkWKBRE7jF
	 uWZO4H1ZKuYUoJ8/wfsv8fPe0DzdTZ8kE25Rhmzsu12Qz0+e6zlNPRNU0mJQ7v/Ffsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005813;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=6ox8H2SB0a9cHlZt4WIpVZ59gqLnArKdF1x3visfTJw=;
	b=mQkr3aFLBZJWEpg9qxXz2TQt4Uisz48n8nPIyexBFFUECdg+IhHSt7l525tVY/u+ugs0
	 b7kg8nPdqPOwSpGZBYyaXUDVaeH1CnV1x/4na4wyaZurw+pyQx3wc5RY7HrnhsI98J775
	 kpc+HcJFfk2PLCs00V0WyLr5+qiVDX/9irxcynYVuT42TEyYWUM3xRTMRXgUHF2RKSGyM
	 JGC8HhrnYTQGaJwX5Kbf/j748uGhi2+7P//0Z6n3L6dMMgfRYg0h0FscQ19JUe6XVeZZp
	 Lls2M/I4TB4dlUc1bSe0uhkMzFoEzUB1ovCcO9yBocUhlrF3svInDacb5Q3ihZml+5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IZM7+FZh;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271F606A32E
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 22:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7271F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IZM7+FZh
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225649euoutp025daf9d3edc29527088b134f250820ec7~llsdVcodQ0400204002euoutp02B
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 22:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261106225649euoutp025daf9d3edc29527088b134f250820ec7~llsdVcodQ0400204002euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005809;
	bh=6ox8H2SB0a9cHlZt4WIpVZ59gqLnArKdF1x3visfTJw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IZM7+FZh8nsiweFEbAr0S3ZBsmbv8xwZ4jOUX8inhKF5v/yJTgP1akoT3Aj2jFMgx
	 Eji0XU5WCYKJhcEaNstqcJZVqsMW7E+w40TXJDosvfiUQrIZcYvoTDcOhrVrErgUpK
	 ik4cCX3X6Kl32h0Urj/VJsYCneZ/8WsyAvpX56IE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc~llscO712W1955019550eucas1p2p;
	Fri,  6 Nov 2026 22:56:48 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225647eusmtip2ed800cd9a277538d08247abe06f701a8~llsbgLFSy2228922289eusmtip2P;
	Fri,  6 Nov 2026 22:56:47 +0000 (GMT)
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
Subject: [PATCH/RFC 0/7] dma-mapping: DMA_ATTR_NO_KERNEL_MAPPING related
 fixes
Date: Fri,  6 Nov 2026 23:56:20 +0100
Message-ID: <20261106225628.215319-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc
X-EPHeader: CA
X-CMS-RootMailID: 20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc
References: <CGME20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc@eucas1p2.samsung.com>

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

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


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
 include/linux/dma-map-ops.h       | 10 ++++++++++
 kernel/dma/direct.c               |  9 +++++++--
 5 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.43.0

