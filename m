Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38080482EB;
	Fri,  2 Jan 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369052; cv=none; b=Am0DjB25gMHTOcgFKgi3SoAvSlREsN0rIIqmncufSSvB+S8D/AylHuS1Wx6L7Xya4NM+SxZrHPlfY2I9BD0sL1yqQbJy2jMgVFuhUoW710XJjzhZOfs5bJfJ6FrDmA1imGwH/FKpBaAHojQKTK8CyyWwLN650BUvvHGVlKHLOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369052; c=relaxed/simple;
	bh=aXybYEEAZBqHFW2+AotJSG257dcrGMIBjhJ+DdDD7Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhSfTkXu0BidQf1ovyffywhI0PFHatoZwmc9vbKM6A4j9NlCgHuw7NrJCeYUT68X4QqHBhRqNm62e008t2bJsBFCEXyayqurASnZ8Zn9fhbo5ybanR9JhknhudGxIUMODxuIAc0ccchKqrlNRDpeVIPRxNKg8fXm6h1oxPnyzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQQCzZKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQQCzZKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF79C116B1;
	Fri,  2 Jan 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767369051;
	bh=aXybYEEAZBqHFW2+AotJSG257dcrGMIBjhJ+DdDD7Xc=;
	h=From:To:Cc:Subject:Date:From;
	b=LQQCzZKGX+PK/TtsbzKxO8xdkW++2mdvYQC7ROcWUkDt38G11wUrfVpzfxNo0mIE0
	 qkt9mIr09+BOzlp0eJQsYaHxSsS+nE2YwjyB1nq5b/Eqz7ElHi26pPS/pXlrAdX2yN
	 5llz23JCAhp62kh0ibmFkX2UjMZBQ6mQJc1MBTUH0k7tnN9WhxCe/0/bUKgQQ47H2C
	 U94g3gpyucuuMFe7nS6McGuZZcl2FC6XoP09nvNXhDLAJR4/OLmdIkIA3qfL+LZHk/
	 LTujOxDiJgsMALlT6FrOKwnzExzNZGBRc7Nnp+5gVaoX+7qyP/3ZcuYaLTrdFiOTiL
	 6Zg9RRX1oAabQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2] dma-direct: set decrypted flag for remapped DMA allocations
Date: Fri,  2 Jan 2026 21:20:37 +0530
Message-ID: <20260102155037.2551524-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that are DMA non-coherent and require a remap were skipping
dma_set_decrypted(), leaving DMA buffers encrypted even when the device
requires unencrypted access. Move the call after the if (remap) branch
so that both the direct and remapped allocation paths correctly mark the
allocation as decrypted (or fail cleanly) before use.

Architectures such as arm64 cannot mark vmap addresses as decrypted, and
highmem pages necessarily require a vmap remap. As a result, such
allocations cannot be safely used for unencrypted DMA. Therefore, when
an unencrypted DMA buffer is requested, avoid allocating high PFNs from
__dma_direct_alloc_pages().

Other architectures (e.g. x86) do not have this limitation. However,
rather than making this architecture-specific, apply the restriction
only when the device requires unencrypted DMA access, for simplicity.

Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ffa267020a1e..faf1e41afde8 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -204,6 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
+	bool allow_highmem = true;
 	struct page *page;
 	void *ret;
 
@@ -250,8 +251,18 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
+
+	if (force_dma_unencrypted(dev))
+		/*
+		 * Unencrypted/shared DMA requires a linear-mapped buffer
+		 * address to look up the PFN and set architecture-required PFN
+		 * attributes. This is not possible with HighMem. Avoid HighMem
+		 * allocation.
+		 */
+		allow_highmem = false;
+
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
 	if (!page)
 		return NULL;
 
@@ -282,7 +293,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 	} else {
 		ret = page_address(page);
-		if (dma_set_decrypted(dev, ret, size))
+	}
+
+	if (force_dma_unencrypted(dev)) {
+		void *lm_addr;
+
+		lm_addr = page_address(page);
+		if (set_memory_decrypted((unsigned long)lm_addr, PFN_UP(size)))
 			goto out_leak_pages;
 	}
 
@@ -344,8 +361,16 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (dma_set_encrypted(dev, cpu_addr, size))
+	}
+
+	if (force_dma_unencrypted(dev)) {
+		void *lm_addr;
+
+		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
+		if (set_memory_encrypted((unsigned long)lm_addr, PFN_UP(size))) {
+			pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
 			return;
+		}
 	}
 
 	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
-- 
2.43.0

