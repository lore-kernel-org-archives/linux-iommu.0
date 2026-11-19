Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101336;
	b=5rQRL4Ek79CFHQMnQXFov7yu6C6c1pTope5pCAjQ+tyXim7uN80MRcDw7U9/EDQV5hEj
	 ou+oz++TuutKQSnpwrd6UTJzWhZXJT7BmHTxjJxBuYckwDE1olv/CSGIjbFUrrY/x+XIk
	 oEbuVv8zBlORROzuU1c9nHspkhFAUhWfmwIO2V0iZD+nIcrRSr/ObACWM2JPhVtVsm7nX
	 LUrsVjEhDBCSAFeMtjYYmR6Wk5PNjW+zpH6UAs+FqsW6+XT1coVgePMxndO6lr7Hv15Fa
	 TgsU4h8MkMCHeX1DLouiS04pSEj36KceMSt4FILdEwGIG41/mDjTgZbsEkbzHFg/dDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101336;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=a7hoW57Gyr9CSOcHzQjMhTzQYXncvMF6awqNiCCmApc=;
	b=fbfP9LntFdWW9DuXKBRdFiUEQvsvkj7vZVZE8QGzVlnV1ALEod+GpTsjdjgQ9Om3sky6
	 /4rE/3gE3ZE9/KUVCWBejmYsr/ntxyGPZhQsl+DMtl3g+B+ozT81CepXsDARevTgFgkc0
	 8TwN0xzahXdQFLzZrilS28DQGuwzU7foMO38tAUfHZK7U9O1MbGZ0usFhxnqkH470Kpc5
	 ajaM1zF95IjqejluEHhKycc0ZbztGOs3xAMSwvLM0or3agZTCUOA5+86CfLOBRU1e9+0q
	 MG3JP5w/teWqkYm+aFpiqctpRLhZMuAuYD1kK7526x+Mt6DjysaErTbaV32UDU1uXMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=XQ6NR+PF;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CB60A2630
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5CB60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=XQ6NR+PF
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151534euoutp01d0d7f974e31e17b7ef4cc8ee7b9d0c8c~peyc696cL2923629236euoutp01X
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151534euoutp01d0d7f974e31e17b7ef4cc8ee7b9d0c8c~peyc696cL2923629236euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101334;
	bh=a7hoW57Gyr9CSOcHzQjMhTzQYXncvMF6awqNiCCmApc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ6NR+PF6H3LD9K9eSc4Bd6f/LqwJI8O+ujaN0W58CUQtcaIBE6/FsM/7qOllRIgG
	 LyjsGe4/XxipSe+bSNCkJQ3dY+DBAGXug6CSLqNtK/wtREv8upTLSq/Wq6PZ2MkpcW
	 qqqBBruZhODRm8PxN11JORqNlrPi0Z1idq3FyMxM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261119151534eucas1p2cf9d1d672e5ff9edc51fab8965a4cac9~peyckz6wQ1566215662eucas1p26;
	Thu, 19 Nov 2026 15:15:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151533eusmtip177fe71b06e2e3a535d0a690846e3a047~peyb0Saan1821018210eusmtip1O;
	Thu, 19 Nov 2026 15:15:33 +0000 (GMT)
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
Subject: [PATCH v3 8/8] dma-direct: zero memory allocated with
 DMA_ATTR_NO_KERNEL_MAPPING
Date: Thu, 19 Nov 2026 16:15:16 +0100
Message-ID: <20261119151520.2383226-9-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119151520.2383226-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151534eucas1p2cf9d1d672e5ff9edc51fab8965a4cac9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151534eucas1p2cf9d1d672e5ff9edc51fab8965a4cac9
X-EPHeader: CA
X-CMS-RootMailID: 20261119151534eucas1p2cf9d1d672e5ff9edc51fab8965a4cac9
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151534eucas1p2cf9d1d672e5ff9edc51fab8965a4cac9@eucas1p2.samsung.com>

dma_direct_alloc_no_mapping() explicitly clears __GFP_ZERO before
allocating the pages, so buffers allocated with
DMA_ATTR_NO_KERNEL_MAPPING are handed out with stale contents of the
previously freed pages. Such buffers are typically passed to devices or
mapped to userspace, which may expose old kernel data.

The mask comes from the regular allocation path, which always zeroes the
buffer manually through its kernel mapping once it is set up. The
DMA_ATTR_NO_KERNEL_MAPPING path returns early with only a page cookie,
so it never reaches that memset(). This has been the case since the
attribute was first supported in the generic remap code in commit
e440e26a0251 ("dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING") and was
carried over when that handling was lifted into dma-direct.

All other dma_alloc_* paths always return zeroed memory, so do the same
here. Passing __GFP_ZERO to the page allocator is not sufficient, as
__dma_direct_alloc_pages() first tries dma_alloc_contiguous(), and CMA
ignores __GFP_ZERO.

Closes: https://sashiko.dev/#/bug/linux-c4421083-e44e-4373-a2c2-45649ea49c0b
Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/direct.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fea0dd36dd25..4bfb3e76cd76 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -6,6 +6,7 @@
  */
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/export.h>
+#include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
@@ -201,11 +202,16 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
 	struct page *page;
+	unsigned long i;
 
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
 	if (!page)
 		return NULL;
 
+	/* we always manually zero the allocated memory */
+	for (i = 0; i < size >> PAGE_SHIFT; i++)
+		clear_highpage(page + i);
+
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
 	/*
-- 
2.43.0

