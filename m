Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C92ED848;
	Fri, 17 Apr 2026 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416414; cv=none; b=irR6sHJWwp3zh1VgoZ/C9LBbBC0VMn0FHESoxFwwXmOay1P2PAyVSZWhK4AepZLnVR6EA3RdD0yXix1i7DFmYcywpQvxXAXLUntGzp6Zlo8h4Z8tIa+W4xhfS6fecUEGxTFcO9q767+hbqgk3EDyncw8jvFu0DWDkvsawmG0V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416414; c=relaxed/simple;
	bh=biZe9ZTkJa9vfGKWLQ6grlTZUp7RS3uzG+uF8YGccLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV7a0SFlo9oXhnm8dE78lDmz/0jEVTmjecBC1hV2BotV7BW4wlA8XwhrY7Aqk52WrGLhdch6rE9Foh9snG4zXdR1kku+Fec1Kifu9TlvUbwHT2A9HUOFOj19pkZaAp4PAUBflf6zj4S+tSJbPKIOiOeliptls0s6bRRu2QrZHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH2taweh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH2taweh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7125AC19425;
	Fri, 17 Apr 2026 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776416413;
	bh=biZe9ZTkJa9vfGKWLQ6grlTZUp7RS3uzG+uF8YGccLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bH2tawehIYkPEOIMDsqRO8rygdoJiHo2pISV1vIDxeS2BRob4R/6PHPBd/tcA+oej
	 Fu4KsFix5QQGaXsn+07t5GFrr6zlB4ypmI0Ua/NOOlEu+HvPO36msTcFpmj41Hr7UO
	 90SQ0ZcW9cKPaDCDQwi18WT3n82K+lTJaYc8jSWLlC5V8PesQUoQUCihGauAIoZeCl
	 ETqJAtVyb+qpRFqeynN0hF4udVbADFpP9jL8MuorWAf30ILmrJXBrmMo7UmLM1uJ1H
	 DChWOlHKL2gilpMVR42dHFQofSueAJt87LOWifQDEDTGwIxzvvm1eH4fGLjcV0uk3X
	 k9wWCHC8NW2zw==
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
Subject: [RFC PATCH 7/7] dma-direct: set decrypted flag for remapped DMA allocations
Date: Fri, 17 Apr 2026 14:29:00 +0530
Message-ID: <20260417085900.3062416-8-aneesh.kumar@kernel.org>
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
index 1d2c27bbf3de..bb2a32896a9e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -204,6 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 {
 	bool remap = false, set_uncached = false;
 	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
+	bool allow_highmem = true;
 	struct page *page;
 	void *ret;
 
@@ -212,6 +213,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		mark_mem_decrypt = true;
 	}
 
+	if (attrs & DMA_ATTR_CC_DECRYPTED)
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
@@ -270,7 +280,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
 	if (!page)
 		return NULL;
 
@@ -298,7 +308,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
 
@@ -374,8 +390,16 @@ void dma_direct_free(struct device *dev, size_t size,
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

