Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D723BD02;
	Fri, 17 Apr 2026 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419780; cv=none; b=i6te/LIlyFPsioJvahDK+c4y6sWaonI03KTlGSuUutoi9x8g8+QSM8l7t6DJLz8wOMRK9LSuXFk45d9NoAGl1oFa7sV/3tdX9AAanPS9ap3mkenLNJ9NmUH6xUA8vWspifS03T2kRY8m/Cx/g6ygqDbLL3EEqcaKAmi3NdZRU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419780; c=relaxed/simple;
	bh=59tfoMBqti+0Vm14vEl9sXO5vfXuwKWNjTQwMptc8Qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XWu/R9+t05xeVES7U0HtmviijnUOuUQGs4dREFHMvPSm5g1uwCb4ENzP3b4CUDMi/ZBo7gAzVScAAg98STKVvcD9MqTU61njPSEDR0AE9EZcU3c72xH6e3n8Y+DzUXwpkqbegDbRoM8+97Edd+aX7ae3jFK3jr8n3Kwkju9w7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcKWovGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcKWovGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98548C19425;
	Fri, 17 Apr 2026 09:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776419780;
	bh=59tfoMBqti+0Vm14vEl9sXO5vfXuwKWNjTQwMptc8Qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LcKWovGM1ODvjmxpvalDiphgTygEAncSvruAVkOp32BU1+9xs3vzt7oGmpuH2COTe
	 Bqw3NoRWjiK9e3LfzfYBcGP+zBS5AgBaSywvEDXSUSO1CgngE4LpVAZXsMkbQn1G/J
	 xxtMXomrMhyTt38pVfdNpYNjC6sir/oX6CDhgBloDwtM9d9fKPxpBW+zFGbheoYEOe
	 aZm2f8dj7g9y1XZfrfu8SG+EcTYIl3FMypfPXY1i0oO5HodJA/TeblrL5fuDeMKmdG
	 vv/j0V+gi38p0wBWH1iHDkdFDVMheOzm9aCTIoY1w6F7bWribM4N/CerdNkNZBJazk
	 kqTVQHraCtEDw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca,
	Mostafa Saleh <smostafa@google.com>
Subject: [RFC PATCH] dma-direct: select DMA address encoding from
 DMA_ATTR_CC_DECRYPTED
In-Reply-To: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
Date: Fri, 17 Apr 2026 15:26:13 +0530
Message-ID: <yq5abjfhap1e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>

Make the dma-direct helpers derive the DMA address encoding from
DMA_ATTR_CC_DECRYPTED instead of implicitly relying on
force_dma_unencrypted() inside phys_to_dma_direct()

Pass an explicit unencrypted/decrypted state into phys_to_dma_direct(),
make the alloc paths return DMA addresses that match the requested
buffer encryption state. Also only call dma_set_decrypted()
when DMA_ATTR_CC_DECRYPTED is actually set.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---

Missed doing this conversion in the pervious set. 

---
 kernel/dma/direct.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index bb2a32896a9e..70fc9ed9ad1a 100644
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
@@ -79,8 +81,6 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
 }
 
@@ -88,8 +88,6 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
 		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
@@ -177,7 +175,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 				  dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+				 !!(attrs & DMA_ATTR_CC_DECRYPTED));
 	return ret;
 }
 
@@ -193,9 +192,11 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
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
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), false);
 	return page;
 }
 
@@ -327,7 +328,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_encrypt_pages;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+				 !!(attrs & DMA_ATTR_CC_DECRYPTED));
 	return ret;
 
 out_encrypt_pages:
@@ -437,11 +439,12 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 
 	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
+	if ((attrs & DMA_ATTR_CC_DECRYPTED) && dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 setup_page:
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+				 !!(attrs & DMA_ATTR_CC_DECRYPTED));
 	return page;
 out_leak_pages:
 	return NULL;
@@ -451,8 +454,12 @@ void dma_direct_free_pages(struct device *dev, size_t size,
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

