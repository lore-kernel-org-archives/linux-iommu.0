Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101335;
	b=sn4y6aMSEtuh682ZFnsr4e8QAaw7SCl0wzJl63mQP6JRF1nHCd3/LbvwWMJ4QbdBHp05
	 a2ZJe++gwv+B5JHGjX31UQJqYca4PrRb01yWcajmDw0U/tAtKC2LKqM1wvsMWtpsdJZg9
	 O0j+6mj7t89JrJC/yE5MgTKozJ/XzVRqQrPPC5CrH/zBtWm/ISGgEuK+tjmwszL5L1wCz
	 4s9k4WWcm/B6AH4eau7DSkN9cFInQQTUXGhAsneAMabl7lDFG03pd7ObJB+AoAc5BR5Zr
	 SWBc9401tqzValETcmoLccYZTny9VlUokPWgow++rcyLvN4xV0P1Dq9m8rrRJ4lnOZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101335;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=ax4MvHJyHLXrr5GwS+hGV9/dsrsTvA8fGhdsCAVYF24=;
	b=CCR6C8n1bHU8W6RYHX6FlZkNdzBJ34JPOsG4lo1soiaZsRK3wqrkfrOFN0YzxXjJcp5J
	 bvZSjCrZ3crMyuPzaYScK2hTwtZlKb+/kamdQ2gsEzTpct3sraJUHexYnCeNUQJBc5Fsy
	 OrttfHQgtRP917Oe8f9Ostmh69K2Yub87N/qNVWyzrV9FlNoOoypfOQk1EOu4wXNkssBx
	 agU2B2vDPw/nJFNBEtfIe9zgxsCjsSfv1dYM6iaj4zZGZQLGKMbXVZ/PEqjM54bzmkKgq
	 +ZbQ18NMmrIzIYH6k/eRLPwNzecYHyWZduKuIrEpGRl4FUA5cHkxKNSQFiQHmDRUo+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VLZvUaM1;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0260A2615
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3A0260A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VLZvUaM1
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151533euoutp0182f03fc2d58902276cf8ecf4cd9d64e6~peybvoW_L2923629236euoutp01V
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:15:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151533euoutp0182f03fc2d58902276cf8ecf4cd9d64e6~peybvoW_L2923629236euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101333;
	bh=ax4MvHJyHLXrr5GwS+hGV9/dsrsTvA8fGhdsCAVYF24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLZvUaM13HP47U/Mu7cGknArwSWhmYxrLHbn13/RxK3w5RIrr6P+0x9dAbL+qTYO5
	 cthHT5ZH9acsPLxmJFyGwYan23fQMYeyzmNPzJgUUEKTlCuxUwXVSOjUQKvKnkEnny
	 UKhhNHhD61vyHTYMFiw+UTYnyA5jYqM163Ip43KA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c~peya4iPL63051430514eucas1p1_;
	Thu, 19 Nov 2026 15:15:32 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151531eusmtip145daf13e958c69886e733e79cb8fb7ec~peyaIqQwf2051120511eusmtip1m;
	Thu, 19 Nov 2026 15:15:31 +0000 (GMT)
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
Subject: [PATCH v3 6/8] dma-mapping: document that arch_dma_prep_coherent()
 must handle highmem
Date: Thu, 19 Nov 2026 16:15:14 +0100
Message-ID: <20261119151520.2383226-7-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c
X-EPHeader: CA
X-CMS-RootMailID: 20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c@eucas1p1.samsung.com>

arch_dma_prep_coherent() has no documentation, and several
implementations assumed that the page passed to it always has a kernel
linear mapping and used page_address() on it. That is not the case:
dma_direct_alloc() and atomic_pool_expand() can get a highmem page from
CMA and pass it to arch_dma_prep_coherent() before remapping it, and
dma-iommu allocates the pages for non-contiguous buffers with
__GFP_HIGHMEM.

Add a kernel-doc comment describing what the hook has to do and stating
explicitly that it must accept highmem pages without a permanent kernel
mapping.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/dma-map-ops.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b..ee4ac12bf2ad 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -371,6 +371,17 @@ static inline void arch_sync_dma_for_cpu_all(void)
 }
 #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
 
+/**
+ * arch_dma_prep_coherent - prepare memory for use as a coherent DMA buffer
+ * @page: first page of the physically contiguous buffer
+ * @size: size of the buffer in bytes
+ *
+ * Called before the buffer is accessed through an uncached alias or handed
+ * to a non-coherent device. The implementation must write back any dirty
+ * data cache lines covering the buffer, so no dirty line can be evicted
+ * later on top of data written through the uncached alias or by the device.
+ * Must accept highmem pages without a permanent kernel mapping.
+ */
 #ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
 void arch_dma_prep_coherent(struct page *page, size_t size);
 #else
-- 
2.43.0

