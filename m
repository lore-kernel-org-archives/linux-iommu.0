Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABE34A78E;
	Mon, 27 Apr 2026 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269362; cv=none; b=UnfOg2P0J8fozoriAqVfc5j9HSdDhUwe2eiBhYNE/SwH+GfA8QZiVmqBEUbzk9nhS2OaXVYn9isC7NZ9S2dfsl7QeCeDcK04Rrzs06nC+rhNm4FRbMYRWaHCbzozfvlXgAMtVa/fwT1iG0wncbNfJmN6g3a89g3JZ1TItWk5RMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269362; c=relaxed/simple;
	bh=Fnsr+GPTtXyrgyvCi2+InBaKMrtJkfUr3fNfh1lo0Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kL5VGJwDv0Tn2XMPZkT/QJlmgrMlLZ0AhIUJeRliZ2jwBpp++3bqkcZr4ZPKmD13owP0KxZ36qMYHBc2ldKhgkrrywnqEVhECN7gRozmRhMLZcsPlClVTuh91EZCn8rqWP7U1aSR2ize2ix6X45nRx6Dv9O3p9avqCSr+SCVqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogn9yO/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogn9yO/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CAFC19425;
	Mon, 27 Apr 2026 05:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269362;
	bh=Fnsr+GPTtXyrgyvCi2+InBaKMrtJkfUr3fNfh1lo0Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogn9yO/uhMSezYS7gKoB+sg2gd24X8EySsDh16adgVX2de23DkdDnFhEXDukXQYUx
	 OMoYjXjr2enJxtaYflfAbviarbcs3ez3LMRUvQn+2IUQ/doMgrTsPHPuqmhE9nwGY8
	 ZP/cuPInKKCB54NDiVo0ROUpdy7cnGpoZqwwn5JaV2LUgOd2EA4xs4pgWNrU1gHnWQ
	 cAPi/92x+rBc7cjvlPdLj2HhcDlCJDagkY3/+VrG5x9j0RPncPWMfkolaicWHLINOF
	 CHpPRwoy9uCb0TgUCRlCcVuxRiBNpHdE1miDvWMWshqmrd1rBfGE5dkWSjF1h48kil
	 LzPTyal0wCFVQ==
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
Subject: [PATCH v3 7/9] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
Date: Mon, 27 Apr 2026 11:25:07 +0530
Message-ID: <20260427055509.898190-8-aneesh.kumar@kernel.org>
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

Teach dma_direct_map_phys() to select the DMA address encoding based on
DMA_ATTR_CC_SHARED.

Use phys_to_dma_unencrypted() for decrypted mappings and
phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
but the source physical address is still encrypted, force the mapping
through swiotlb so the DMA address and backing memory attributes remain
consistent.

Update the arm64 and x86 CC-guest setup to not use swiotlb force option

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c      |  4 +---
 arch/x86/kernel/pci-dma.c |  4 +---
 kernel/dma/direct.c       |  4 +++-
 kernel/dma/direct.h       | 30 +++++++++++++-----------------
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 97987f850a33..acf67c7064db 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
 	unsigned int flags = SWIOTLB_VERBOSE;
 	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
 
-	if (is_realm_world()) {
+	if (is_realm_world())
 		swiotlb = true;
-		flags |= SWIOTLB_FORCE;
-	}
 
 	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
 		/*
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 6267363e0189..75cf8f6ae8cd 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -59,10 +59,8 @@ static void __init pci_swiotlb_detect(void)
 	 * bounce buffers as the hypervisor can't access arbitrary VM memory
 	 * that is not explicitly shared with it.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		x86_swiotlb_enable = true;
-		x86_swiotlb_flags |= SWIOTLB_FORCE;
-	}
 }
 #else
 static inline void __init pci_swiotlb_detect(void)
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a4aa7e1df2bb..7d51dd93513d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -691,8 +691,10 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
 	if (is_swiotlb_active(dev) &&
-	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev)))
+	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
+	     force_dma_unencrypted(dev)))
 		return swiotlb_max_mapping_size(dev);
+
 	return SIZE_MAX;
 }
 
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e05dc7649366..af035dc935ab 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -89,36 +89,32 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	dma_addr_t dma_addr;
 
 	if (is_swiotlb_force_bounce(dev)) {
-		if (!(attrs & DMA_ATTR_CC_SHARED)) {
-			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
-				return DMA_MAPPING_ERROR;
+		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+			return DMA_MAPPING_ERROR;
 
-			return swiotlb_map(dev, phys, size, dir, attrs);
-		}
-	} else if (attrs & DMA_ATTR_CC_SHARED) {
-		return DMA_MAPPING_ERROR;
+		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
 	if (attrs & DMA_ATTR_MMIO) {
 		dma_addr = phys;
 		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
 			goto err_overflow;
+		goto dma_mapped;
 	} else if (attrs & DMA_ATTR_CC_SHARED) {
 		dma_addr = phys_to_dma_unencrypted(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
-			goto err_overflow;
 	} else {
-		dma_addr = phys_to_dma(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
-		    dma_kmalloc_needs_bounce(dev, size, dir)) {
-			if (is_swiotlb_active(dev) &&
-			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
-				return swiotlb_map(dev, phys, size, dir, attrs);
+		dma_addr = phys_to_dma_encrypted(dev, phys);
+	}
 
-			goto err_overflow;
-		}
+	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
+	    dma_kmalloc_needs_bounce(dev, size, dir)) {
+		if (is_swiotlb_active(dev) &&
+		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		goto err_overflow;
 	}
 
+dma_mapped:
 	if (!dev_is_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
-- 
2.43.0

