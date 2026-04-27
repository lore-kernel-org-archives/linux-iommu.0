Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33D34A78E;
	Mon, 27 Apr 2026 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269368; cv=none; b=i3RmZNVqs0INQALEZ5+mqA2sE+bjbGRKraAOj4t7VkXxbZjN+MhAGHa0oHeY45XiHdBD3Q2BkINvdFqDoELTmMwshsmV1iN4TnFFKEJvjoX8fDEgheM9YV+JzW+8CIXwH8n6+YbpCdIFOjQhN4yYHQfitqssj3QCJseJIXu+6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269368; c=relaxed/simple;
	bh=xibEEWJCVBE55hyDt+ak85NFqZSAoVj9pQeBEuJT7FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTBH+GUlu71DDKykqqthlxJfw2s7lbX3fRsmiJ7TcG5dUtc8BufxJZ/SgtMA6URZoXOAVeg7JsnIxmnco/2uXL+2vSDlesIPHkMVTbKpoxhfOatcX3NHNWwpKC9M6pPZvvGNExk0ZY44dfxYWhYKicHTKE8jbLVEqEpp+f3UHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqGEbJT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqGEbJT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28528C4AF09;
	Mon, 27 Apr 2026 05:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269368;
	bh=xibEEWJCVBE55hyDt+ak85NFqZSAoVj9pQeBEuJT7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cqGEbJT2Ailt2fLq4r0iKM4nCVjZvyI2lWsi3HXZ9NsNNXBr/XM/dWyzhumZscGj9
	 3eS8CU2psPojfrrb6njvxsrWMhrOGg2RQ76qUOZ+7sealDcHIuTmgZx0uiS7oqUmcw
	 Cta5U+gg8FKGVlUs8W7UR0xSi7wp34nmnb/OfEmny+Og19K2jwadVyo6p3k9YrBtKp
	 26UyXurrM5HvM/jobmG244ueIm1oR88zPG1w0KSkGO9laePERTPYFC1DiqYWf1nI4B
	 E6Nq38BPpilUiCnJvd+BGoDfXIRb8SWSDrwpJTZLZZ+FKJj+bBVbO9GZTWqWxqCNqC
	 s7//ankUcDKzQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 8/9] dma-direct: set decrypted flag for remapped DMA allocations
Date: Mon, 27 Apr 2026 11:25:08 +0530
Message-ID: <20260427055509.898190-9-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427055509.898190-1-aneesh.kumar@kernel.org>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
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

Fix dma_direct_alloc() and dma_direct_free() to apply set_memory_*() to
the linear-map alias of the backing pages instead of the remapped CPU
address. Also disallow highmem pages for DMA_ATTR_CC_SHARED, because
highmem buffers do not provide a usable linear-map address.

Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 7d51dd93513d..f874be2d85c2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -204,6 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 {
 	bool remap = false, set_uncached = false;
 	bool mark_mem_decrypt = false;
+	bool allow_highmem = true;
 	struct page *page;
 	void *ret;
 
@@ -222,6 +223,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		mark_mem_decrypt = true;
 	}
 
+	if (attrs & DMA_ATTR_CC_SHARED)
+		/*
+		 * Unencrypted/shared DMA requires a linear-mapped buffer
+		 * address to look up the PFN and set architecture-required PFN
+		 * attributes. This is not possible with HighMem. Avoid HighMem
+		 * allocation.
+		 */
+		allow_highmem = false;
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
@@ -280,7 +290,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
 	if (!page)
 		return NULL;
 
@@ -308,7 +318,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 	} else {
 		ret = page_address(page);
-		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))
+	}
+
+	if (mark_mem_decrypt) {
+		void *lm_addr;
+
+		lm_addr = page_address(page);
+		if (set_memory_decrypted((unsigned long)lm_addr, PFN_UP(size)))
 			goto out_leak_pages;
 	}
 
@@ -384,8 +400,16 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
+	}
+
+	if (mark_mem_encrypted) {
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

