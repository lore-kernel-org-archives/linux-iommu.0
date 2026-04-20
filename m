Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FFF38236B;
	Mon, 20 Apr 2026 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665708; cv=none; b=dUUYYLprBtCX1kIWTOtnYz06IWnTo9pbfyxiPdTZAhK5W85sAn4E2JMJHq6tsytgg1pG6LDTRPj/PssN1OGNyZ+58atTrAyOiFSmQMT32dsM3XPSXuhLnLUEOopAIqJ9iJwqPI0Y2sbxSfeWX1CpnZpgOo83UPNqGLhBfi7TGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665708; c=relaxed/simple;
	bh=BfBFs2nd1SxIKCxVd/f6c5GmBlgNuhGKhyywXCeZMnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iir1+KKythya8sc4mzHqZ3E+uzgjrMzJpXD5smSH/Of8CSzCHu7o5Xv6e7HBy3x3gCrZP22ivnNAY3aSHQKZy9DUEzzLbFF92RHrIgOwCSuYGtC5f/oNQsp8YEHmQ7hT+52IQi/SIkS5EClXbDgZ1fw2nArneYfEbFsvrQ48wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhLoV4Jr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhLoV4Jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE59DC19425;
	Mon, 20 Apr 2026 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776665707;
	bh=BfBFs2nd1SxIKCxVd/f6c5GmBlgNuhGKhyywXCeZMnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhLoV4JrMXQ4BLgaUm9/lbYWAqx9sQXKUKUI0Io5+WC6VTtrYR366B9R8FN3c7eV4
	 khfKcK7WJSSOI4Fn2mDsJHiwsqJR0kEa8ThwUkERxavIET0P68OEIZg7YcTTXVVFmU
	 FLRuFClVSOpImSmb6rXgXpXaLLKsviD3O3Tmuwei+B1Elc+yZoAi9DfiBfaEziRcEm
	 CzgYoa5mFPWOIa2xlThjFSfHr0W6mtrGImLehiO6tFYAuz3VIw9QtnkJ16fAw2PBN2
	 tNxtwaCtgbuQi9wg453+IVcsjXqhassTL27TSl9eK8N+qeN910rO5F8q5A2unWbnLY
	 KheziMFwvaPDQ==
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
Subject: [PATCH v2 7/8] dma-direct: set decrypted flag for remapped DMA allocations
Date: Mon, 20 Apr 2026 11:44:14 +0530
Message-ID: <20260420061415.3650870-8-aneesh.kumar@kernel.org>
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
 kernel/dma/direct.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a4aa7e1df2bb..63a7b7bfff97 100644
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

