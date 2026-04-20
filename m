Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B522A1B2;
	Mon, 20 Apr 2026 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665684; cv=none; b=IM1NBDlDUjdbj4sjcf1xQr3U9xyuXia/t3Q1KaQ4o5ptu//UB2Mj7D0Hs1wXIyspKoEkOlEVnQ0ll6kvTsYeba9YZ0evjC9iT1arjmo7KwjpqHzoiKweRK9mBdqwTK8CZZ1NO/LsNN0QXboFrsgFsTTMXcKkdfeznxU7zQhDzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665684; c=relaxed/simple;
	bh=4MW7wMvDoqITfLwkJTW6/lwo+jU4h0pFXHWOV1R6rJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+2TfB+3lIdpK6A7AJWYsE9EYWtatpHZaMy333WdlVb6IAMc+O7ESJhLIN1kH4n65yY3vK1rhm25GDjLJC6aq3M7FLO28RRiosf2uqoxkygKIeOoGPa+T3zEhsKXNIbccAkdOVUDZ6ndV+8Rf3atkA/qGTYr3FOnERzjGEQudSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjE2dnF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjE2dnF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B5C2BCC4;
	Mon, 20 Apr 2026 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776665684;
	bh=4MW7wMvDoqITfLwkJTW6/lwo+jU4h0pFXHWOV1R6rJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjE2dnF3sAsFXcwd8DpByrXLECm539bexUJC00SBThyK7smra0q1SQJMWnjOPiPPB
	 kZtj53HHDPEhHGCY04zeEvcIHH+15vsiM4XclujQHg5QOi29Lxfkw1nG2xItVYLeJQ
	 JYIrYpEoRTMiXPNuqHtnwr4zJI8MND7z8u74zCPsKy+i0+8kp2BImH7UvnhFEuljfl
	 MCEmBn84IgTjyiNAy1Cn7jLl4aqLuzD6M+vbOaE9nrDIpCT4uvfQFALDAcwWFdYdi4
	 Du26eETgUi21cxpuvncS1FHek+WjybHOUZIYTtHhbC/k6nEAV1aGTTOO2nnKshpxzd
	 VJ10shyOP3dCA==
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
Subject: [PATCH v2 2/8] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
Date: Mon, 20 Apr 2026 11:44:09 +0530
Message-ID: <20260420061415.3650870-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
dma-direct allocation path and use the attribute to drive the related
decisions.

This updates dma_direct_alloc(), dma_direct_free(), and
dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b958f150718a..0c2e1f8436ce 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -201,16 +201,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = true;
+	bool mark_mem_decrypt = false;
 	struct page *page;
 	void *ret;
 
+	/*
+	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
+	 * attribute. The direct allocator uses it internally after it has
+	 * decided that the backing pages must be shared/decrypted, so the
+	 * rest of the allocation path can consistently select DMA addresses,
+	 * choose compatible pools and restore encryption on free.
+	 */
+	if (attrs & DMA_ATTR_CC_SHARED)
+		return NULL;
+
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_decrypt = true;
+	}
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -244,7 +259,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -318,11 +333,20 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-	bool mark_mem_encrypted = true;
+	bool mark_mem_encrypted = false;
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_encrypted = true;
+	}
+
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -365,10 +389,14 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	unsigned long attrs = 0;
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	if (is_swiotlb_for_alloc(dev)) {
-- 
2.43.0

