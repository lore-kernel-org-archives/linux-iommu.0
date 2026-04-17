Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46823502AA;
	Fri, 17 Apr 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416393; cv=none; b=CUcfWRsrmqa8TPJIsRFmACri6jzfOyKb0tQaNymd6elU47DD07/+Z1ngQ9tt4EbyppKFMiBZLbI/uzJhY/4GcGmPWT8oK6vM/mT9+daKeGX2OadN1Mhcf5SJtzRsN+EDDYRGkJDPARUQ7vC8HSWZfrtxR4g8cTy0BQqWnmDe+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416393; c=relaxed/simple;
	bh=NPbjsIwD8g92JzX7wavhGqNdM/uKMVtRfW7D98XYiN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns3XYfRA3Kuo6A4x0hEwjKtMuz61dJG3ohaPDl7gLtL6nNWfTFdAePE3zLlhMnmh7KkW3N3GCquzl3rlrw4Q2X9jrGyn/50cfNVgC+8xDtEwe+puZJPj3ovIolNBKl8k79EYm3hTXIOvtCK0hGnxUPZD9x+qaa9rA7FWoMGtMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Epe/MGSF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Epe/MGSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0B8C2BCB4;
	Fri, 17 Apr 2026 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776416393;
	bh=NPbjsIwD8g92JzX7wavhGqNdM/uKMVtRfW7D98XYiN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Epe/MGSFe4LhtiLh5F3B0DyNUxwgoFjUeHAdnR/a0AoFxWN+qUWy3/H6QmDht6TZP
	 tszrpsItkyMs2DEF8uExjRyBo4rcFTWfYtNIJP9s6ZTgqw74cyMETg+jQhwa/5KaR+
	 iOQ7DQZCGZ8TrFc2T8JoISKW2SCfIuWkXHwDB+pyIy82Wa9SuS5viORnWFgfsb/VWr
	 V//1WojvoQJX5VSxF2j3zCt/9b9KVC1EIy6Xnv3vdaIvGYZjqLFeWqTzsYPwODmzWu
	 57gHWWOAB0JQ8tGpW/nnAvrcyqWZBHrGVGsIJtmMTeJP+TOgCfzuj5nDWvCbRIfIzK
	 1f1+GYdUG3S2w==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	m.szyprowski@samsung.com,
	will@kernel.org,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	catalin.marinas@arm.com,
	jiri@resnulli.us,
	jgg@ziepe.ca,
	aneesh.kumar@kernel.org,
	Mostafa Saleh <smostafa@google.com>
Subject: [RFC PATCH 2/7] dma-direct: use DMA_ATTR_CC_DECRYPTED in alloc/free paths
Date: Fri, 17 Apr 2026 14:28:55 +0530
Message-ID: <20260417085900.3062416-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate force_dma_unencrypted() into DMA_ATTR_CC_DECRYPTED in the
dma-direct allocation path and use the attribute to drive the related
decisions.

This updates dma_direct_alloc(), dma_direct_free(), and
dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index c2a43e4ef902..3932033f4d8c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -201,16 +201,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = true;
+	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
 	struct page *page;
 	void *ret;
 
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_DECRYPTED;
+		mark_mem_decrypt = true;
+	}
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_DECRYPTED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -244,7 +249,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || (attrs & DMA_ATTR_CC_DECRYPTED)) &&
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -318,11 +323,20 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-	bool mark_mem_encrypted = true;
+	bool mark_mem_encrypted = !!(attrs & DMA_ATTR_CC_DECRYPTED);
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_DECRYPTED;
+		mark_mem_encrypted = true;
+	}
+
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_DECRYPTED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -365,10 +379,14 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	unsigned long attrs = 0;
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_CC_DECRYPTED;
+
+	if ((attrs & DMA_ATTR_CC_DECRYPTED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	if (is_swiotlb_for_alloc(dev)) {
-- 
2.43.0

