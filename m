Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005816;
	b=AYr1ArNQvkQnku0KUleHJgGLlkNARz+3Rz3iaAJfQ6iDRoGXv5ON6SKec/zaJ4R7Kbi1
	 6sTJa6qZ8YWPsHGhmIWgvcZSGSQ2rEhWo07/RvzTZV9ptJsyq95OCqKepfLtVkS4v1Egk
	 mMQTqBpXfUbQr7zTTWMUgYNBLPnoId3MofabjfyZsjWDxH31mYxpBECPnwSMZHcC3tlDf
	 e3ZCMWa6otN7LQ+aRhhtY6zdpGVS/UXhT9wmLubihA8vvudEbuqd0mOzgDYRxO6ex3Z/U
	 ZUQdHQIL0+fu6c3Jdz8VpirdPAtKnMwXdKrkwXUYHInGS4z7EKkkakR1twVJWLlFdrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005816;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=Xydf7D1Ug+18o9KjDGYgg5Q3bZN62iLYwR2p/Rz26AI=;
	b=jROoLr/lF+6nLviu4U+EOiEAJEjkVVreFbN62oMFkryQL+haXGAaw3bHW/WUNF67WX6/
	 9io8sdWYSOEtQg3i/MeUynVr7JSfK9yM2OhuNXSC8hEXxuxy0AE7zJXpNs3MAl1ff4FTm
	 RBqGeXl20PRNVrNlZbLUGVDkV8r+F2H0/19kcfPlp8aZ2B0EnKuln/HlTMcSAxYP0Gnx9
	 WxAYpTa9CcqIlZhD8V+BVs9h3yigu801Xd9oTBrWmyrIqc19mQGWlyvSLbTnOfLHuJO3h
	 jc7kTOez/qzjYHvGlxY5Tk8ITOQAvCYd5USiUClPRIeQp13tS7Et9xB3sBIYmX/nwdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="H/SzY1mw";
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103E606D808
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 22:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9103E606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=H/SzY1mw
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225653euoutp0270886fcb4bd4ce168ccb1ced95626ca1~llsgrE9pE0274902749euoutp02Q
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 22:56:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261106225653euoutp0270886fcb4bd4ce168ccb1ced95626ca1~llsgrE9pE0274902749euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005813;
	bh=Xydf7D1Ug+18o9KjDGYgg5Q3bZN62iLYwR2p/Rz26AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/SzY1mw3mA6Z56q3lZIMvfdcOBCrjc7dZDwRy01StWAF29fSNkLI3cm9/QjHG8/K
	 +44jfsOED7g7OjoBjFSu/K7Bt06FRI0BtX7WTeHmXIe0R3pvD3TWhEkAo+1fygM5bN
	 Ia4zVxYOK2nMvHb0NRTYr0NEst0n2+9TZA4BILts=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e~llsgXlFuR1955019550eucas1p2s;
	Fri,  6 Nov 2026 22:56:52 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225651eusmtip2930bd7ce74f96343191502d22feeb09d~llsfogufy2228922289eusmtip2U;
	Fri,  6 Nov 2026 22:56:51 +0000 (GMT)
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
Subject: [PATCH/RFC 5/7] dma-mapping: document that arch_dma_prep_coherent()
 must handle highmem
Date: Fri,  6 Nov 2026 23:56:25 +0100
Message-ID: <20261106225628.215319-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106225628.215319-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e
X-EPHeader: CA
X-CMS-RootMailID: 20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e
References: <20261106225628.215319-1-m.szyprowski@samsung.com>
	<CGME20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e@eucas1p2.samsung.com>

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
 include/linux/dma-map-ops.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b..0c90e205df15 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -371,6 +371,16 @@ static inline void arch_sync_dma_for_cpu_all(void)
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
+ */
 #ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
 void arch_dma_prep_coherent(struct page *page, size_t size);
 #else
-- 
2.43.0

