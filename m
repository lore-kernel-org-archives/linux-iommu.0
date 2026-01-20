Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488E378D78;
	Tue, 20 Jan 2026 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891416; cv=none; b=adYNe71b0nP9t4JP6GnHzO46bvbnxjvi7dZVatcfWI7uUozx7fFpgX3n5gy8yTtHDfGH/I+5QYN4NG76bwyvrrYlYgs/PJKRLyKaw5T5VGSZN5iIrLZ+VIJE7gYeqLEhdrbW09o2CgJbxCc1gX3eGLiswSQM2BISDPtbAFaRCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891416; c=relaxed/simple;
	bh=yEgHIyLIqk6gAe5l/q4brOThH126ghMwe3bBSnRu4Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9Ea8Kug4Q7G1JQ44Xm5qc8C/QBor1Gy6oXgeEoElTthjQbmoK/QY56Vuug9s17ZBpbMdZSOYAez9SuayX+bnwUw3gsbqH164SoPnDOX+6PSvnhFNvLRFKsDRhp5aK+KYPDn4PcHpAKmQVO8LngUx/sZx5tfp/DiQElTiE1AdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLfpU0pM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLfpU0pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAEDC19425;
	Tue, 20 Jan 2026 06:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768891415;
	bh=yEgHIyLIqk6gAe5l/q4brOThH126ghMwe3bBSnRu4Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLfpU0pMTuw2e7OskzBkgYJ4fzQ1VTrVPTN9/k1uX3/9B0e/VRiWRLMJobn/fthgV
	 4xGFg5lqGGVQ0Gi5ywtpj8KUTCWID2Uxi/bbhzr0OsL0lFue/AXxDbgKoi9DLlS0Td
	 ao0kpw9UMomsCTMAvHENZDx4m/eI/7RIsKMKVcN+zyOlVFkr/jTBYPGxK9uBouRvmD
	 AU3TW1iZMlTYcDShFOSUzWhwHfoJKQteodsHR+p/NCEBABPHA99/Qq8ZGTjO5JXG+4
	 IdwpXG0qrWfuA/M3T3iQtMsKEl7d80X22dtTCUzlla2atVWP6/pFhVdHZX4F18Tb/B
	 Vet29NJcX0SFQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	will@kernel.org,
	robin.murphy@arm.com,
	suzuki.poulose@arm.com,
	jgg@ziepe.ca,
	steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH 2/2] dma-direct: Make phys_to_dma() pick encrypted vs unencrypted per device
Date: Tue, 20 Jan 2026 12:12:55 +0530
Message-ID: <20260120064255.179425-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120064255.179425-1-aneesh.kumar@kernel.org>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems that apply an address encryption tag/mask to DMA addresses, the
choice of encrypted vs unencrypted DMA address is device-dependent (e.g.
TDISP trusted devices vs non-trusted devices).

Teach phys_to_dma() to make this choice based on
force_dma_unencrypted(dev), and convert dma-direct users to call
phys_to_dma() directly. With this in place, drop phys_to_dma_direct() as
redundant.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/dma-direct.h | 18 +++++++++++-------
 kernel/dma/direct.c        | 20 ++++++--------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index c249912456f9..e2e3a08373a1 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -90,17 +90,21 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
 {
 	return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
 }
-/*
- * If memory encryption is supported, phys_to_dma will set the memory encryption
- * bit in the DMA address, and dma_to_phys will clear it.
- * phys_to_dma_unencrypted is for use on special unencrypted memory like swiotlb
- * buffers.
- */
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+
+static inline dma_addr_t phys_to_dma_encrypted(struct device *dev,
+					       phys_addr_t paddr)
 {
 	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
 }
 
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+
+	if (force_dma_unencrypted(dev))
+		return phys_to_dma_unencrypted(dev, paddr);
+	return phys_to_dma_encrypted(dev, paddr);
+}
+
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	phys_addr_t paddr;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a5639e9415f5..59d7d9e15e17 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -23,14 +23,6 @@
  */
 u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
-static inline dma_addr_t phys_to_dma_direct(struct device *dev,
-		phys_addr_t phys)
-{
-	if (force_dma_unencrypted(dev))
-		return phys_to_dma_unencrypted(dev, phys);
-	return phys_to_dma(dev, phys);
-}
-
 static inline struct page *dma_direct_to_page(struct device *dev,
 		dma_addr_t dma_addr)
 {
@@ -40,7 +32,7 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 u64 dma_direct_get_required_mask(struct device *dev)
 {
 	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
-	u64 max_dma = phys_to_dma_direct(dev, phys);
+	u64 max_dma = phys_to_dma(dev, phys);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -69,7 +61,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -178,7 +170,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
 }
 
@@ -196,7 +188,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 
 	/* return the page pointer as the opaque cookie */
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return page;
 }
 
@@ -311,7 +303,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_encrypt_pages;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
 
 out_encrypt_pages:
@@ -392,7 +384,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return page;
 out_leak_pages:
 	return NULL;
-- 
2.43.0

