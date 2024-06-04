Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4515F1428EF
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490528; cv=none; b=tHgSn8BMNsj/V2cL8VtklEm0n9Zmn2bhQS7TibUhzQpkPSEOpx0INsP74j47p4+1rPAfQyBZKFym4AwLgE72fiubWdPvpnSXoPd8GVvIQ8uhLvtn2S512ClnmIlZQblbok6s6hETX/XLBxJKJXahs6M7EkYLbroHRKJMFqfKsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490528; c=relaxed/simple;
	bh=IhCW5tPZwTtj5+YMsXpg5bHM6SkJlvgCSjrTIAYjZ5E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IuB4ENWTh2EN4niq1t5xmnXbJMHUxwMSysRAXLLZIqxeqTFv5AyqnYlK1kZaOYwrZQzhIF7/nlGiAguncT3nsaMc4bhmlLoEOrIXAtZdrKpu+qGqz7rzU6qyQrxs2o6vEvITqfTv6q9X1PSoQnnaqzJQeMi/honQ6F4au6lMrpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 757C86048992C;
	Tue,  4 Jun 2024 16:41:54 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: kunyu <kunyu@nfschina.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kunyu <kunyu@nfschina.com>
Subject: [PATCH] dma: direct: Optimize the code for the dma_direct_free function
Date: Tue,  4 Jun 2024 16:41:00 +0800
Message-Id: <20240604084100.51464-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The 'is_swiotlb-for-alloc' and 'dev_isdma_coherent' judgment functions
need to be called multiple times, so they are adjusted to variable
judgment, which can improve code conciseness.

Signed-off-by: kunyu <kunyu@nfschina.com>
---
 kernel/dma/direct.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..041e316ad4c0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -315,23 +315,24 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int page_order = get_order(size);
+	bool swiotlb_for_alloc = is_swiotlb_for_alloc(dev);
+	bool is_dma_coherent = dev_is_dma_coherent(dev);
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	    !force_dma_unencrypted(dev) && !swiotlb_for_alloc) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
 	}
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
-	    !dev_is_dma_coherent(dev) &&
-	    !is_swiotlb_for_alloc(dev)) {
+	    !is_dma_coherent && !swiotlb_for_alloc) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 		return;
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev)) {
+	    !is_dma_coherent) {
 		if (!dma_release_from_global_coherent(page_order, cpu_addr))
 			WARN_ON_ONCE(1);
 		return;
-- 
2.18.2

