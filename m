Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1D383C76;
	Mon, 20 Apr 2026 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665713; cv=none; b=jK3S5kuV7rhcsbrSvLXZlaLQuTK2M0+xuQX64L6W2zSzm5HUlDaQBNcGwedwFY6iVIEnrE2vk6AsHhEKaayROC15IQjzVVkg3CD8FESc/j5h4uH2cl/h1F3RPE1UEh2GtwSEBXmHz60AneeWRS17okKejYFHljMxKTxaU/mZSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665713; c=relaxed/simple;
	bh=i83T7lPEeSfxD2tPEEjjzZ7Urcsl8UtRe/aTW9tn7PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+/jG+Oayp5Ky8nOB9V66XrkHmaeH8vzZzHUXWHRI2ujuNKR5Q7SCN/mp7jN+ef1/YuB2czdBbBymt01SmHDdLCqCSY/HuMvf7rvkrf5hrkF33wjiAbHUoooUpubNEXUCYJvO61SRNgImz5rgwfJ+3STMi7jq2JjbEjy47/kOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfedlZDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfedlZDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4E7C19425;
	Mon, 20 Apr 2026 06:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776665712;
	bh=i83T7lPEeSfxD2tPEEjjzZ7Urcsl8UtRe/aTW9tn7PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfedlZDDoGMnGL2pu1vTNzYznOu1i6+iFKp/bvNw1LENQH6QARDZRkE2M6ueF5P0m
	 vlezf87FQCXbtPN/2QBxdWjcIJUjQA+Th5wJTEeGW2BfYzqmQE9QvTa+qj6s45j4Xo
	 0DbmjS04Rtyj0frEx7OiPiPiAMs8fIRuKIiet3j6Uy12y2AadHzL7rZ6H5Y6gGSFB8
	 YbYAYGQIMJajltlr/QzXiVVN9dCCmYIzJLwe3EOZAQEJ5AIW8H3cRFewO0JyAI8/7O
	 4HE355UTZKCQyZqax91Anu83oF5q2eEjlZp549Ew3x5bCAbc3bc/mNj8V3eOmr31XF
	 ax915gp4m76Jg==
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
Subject: [PATCH v2 8/8] dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED
Date: Mon, 20 Apr 2026 11:44:15 +0530
Message-ID: <20260420061415.3650870-9-aneesh.kumar@kernel.org>
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

Make the dma-direct helpers derive the DMA address encoding from
DMA_ATTR_CC_SHARED instead of implicitly relying on
force_dma_unencrypted() inside phys_to_dma_direct()

Pass an explicit unencrypted/decrypted state into phys_to_dma_direct(),
make the alloc paths return DMA addresses that match the requested
buffer encryption state. Also only call dma_set_decrypted()
DMA_ATTR_CC_SHARED is actually set.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 63a7b7bfff97..1239344f8585 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -24,11 +24,11 @@
 u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
-		phys_addr_t phys)
+		phys_addr_t phys, bool unencrypted)
 {
-	if (force_dma_unencrypted(dev))
+	if (unencrypted)
 		return phys_to_dma_unencrypted(dev, phys);
-	return phys_to_dma(dev, phys);
+	return phys_to_dma_encrypted(dev, phys);
 }
 
 static inline struct page *dma_direct_to_page(struct device *dev,
@@ -39,8 +39,9 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
+	bool require_decrypted = force_dma_unencrypted(dev);
 	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
-	u64 max_dma = phys_to_dma_direct(dev, phys);
+	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -69,7 +70,8 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+	bool require_decrypted = force_dma_unencrypted(dev);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -79,17 +81,18 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
-		return 0;
-	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
+	int ret;
+
+	ret = set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
+	if (ret)
+		pr_warn_ratelimited("leaking DMA memory that can't be decrypted\n");
+	return ret;
 }
 
 static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
 		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
@@ -177,7 +180,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 				  dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return ret;
 }
 
@@ -193,9 +197,11 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 	/* remove any dirty cache lines on the kernel alias */
 	if (!PageHighMem(page))
 		arch_dma_prep_coherent(page, size);
-
-	/* return the page pointer as the opaque cookie */
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	/*
+	 * return the page pointer as the opaque cookie.
+	 * Never used for unencrypted allocation
+	 */
+	*dma_handle = phys_to_dma_encrypted(dev, page_to_phys(page));
 	return page;
 }
 
@@ -337,7 +343,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_encrypt_pages;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return ret;
 
 out_encrypt_pages:
@@ -447,11 +454,12 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 
 	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 setup_page:
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return page;
 out_leak_pages:
 	return NULL;
@@ -461,8 +469,12 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		struct page *page, dma_addr_t dma_addr,
 		enum dma_data_direction dir)
 {
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	bool mark_mem_encrypted =  force_dma_unencrypted(dev);
 	void *vaddr = page_address(page);
-	bool mark_mem_encrypted = true;
 
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-- 
2.43.0

