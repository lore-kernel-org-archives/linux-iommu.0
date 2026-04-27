Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B134B1A3;
	Mon, 27 Apr 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269351; cv=none; b=ocsmzT6s6TVlL1hOXSRYVveFScocCU8EJmmeqD3j+2i4pmKBraYlwhqOqCkZMFsmSzn+h3tHCHJUz/J3aROrfiYxMjI3dDlIwhg7/RAd5b0cGeszdpGyVHyhxZG4u6AvzVyf5Q9XZonkx0eTEKLlOzuXPLPREq48mTYloHtcGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269351; c=relaxed/simple;
	bh=u9Nxyxygf4qPGYAgMTCv2majmXN+k5vEhMk1b0dtxGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLMALt8tG7vOrMtkvASNw9hqSNaaBdWwxkdiOT1As+5GeMWHDFQOKX8T7cWAQhvL3OwJ2Zpf9oKfZ/kKuuZVeHx2hKDk6w4oXQX1saTEyFD+0vEAU8vb/AjBum8KrXUGrBgIayE3mxEVDCVg5W1bldVkaUnrxGgcOwvZXLCwnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgBWSk74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgBWSk74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3CDC19425;
	Mon, 27 Apr 2026 05:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269351;
	bh=u9Nxyxygf4qPGYAgMTCv2majmXN+k5vEhMk1b0dtxGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgBWSk74gyOxSSSpWNz5R+kKDy5QL/8m9xtlDTKDuMVmkwGaCOkWivKXgwaLYgHbK
	 D3oV2TRq851n2uZRFG0q28PyddEilxmZbfpryBuvb0Zas8R969nP/8dx5IgDBhd1ev
	 X7JccXNKBKCJI2392tM9hHT/eNMC50/WP1NkazDbaM3xQISuYi6DtFLiP2IK4R6/a9
	 7Fpn6CwFvpcdIYTPMfMi8EIsxT/hoKoeaHepiS5iNxp1vbc56GpQBMpPAqRhzuocKK
	 sPBdJV8Im/Tj8TNWeA6voRZXPNWRSW+2kjsAgZBETzBbi7ey/CuOXthKP45bgXR9bN
	 fnXHZBiiRWpEA==
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
Subject: [PATCH v3 5/9] dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
Date: Mon, 27 Apr 2026 11:25:05 +0530
Message-ID: <20260427055509.898190-6-aneesh.kumar@kernel.org>
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

Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
do not need to adjust the page protection separately.

Update dma_pgprot() to apply pgprot_decrypted() when
DMA_ATTR_CC_SHARED is set and pgprot_encrypted() otherwise Convert
the dma-direct allocation and mmap paths to pass DMA_ATTR_CC_SHARED
instead of open-coding force_dma_unencrypted() handling around
dma_pgprot().

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  |  8 +++-----
 kernel/dma/mapping.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9373b9dcfb7b..a4aa7e1df2bb 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -298,9 +298,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
-			prot = pgprot_decrypted(prot);
-
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -603,9 +600,10 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
 	int ret = -ENXIO;
 
-	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 	if (force_dma_unencrypted(dev))
-		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e..44f715f3aa2d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -543,13 +543,21 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
  */
 pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
 {
+	pgprot_t dma_prot;
+
 	if (dev_is_dma_coherent(dev))
-		return prot;
+		dma_prot = prot;
 #ifdef CONFIG_ARCH_HAS_DMA_WRITE_COMBINE
-	if (attrs & DMA_ATTR_WRITE_COMBINE)
-		return pgprot_writecombine(prot);
+	else if (attrs & DMA_ATTR_WRITE_COMBINE)
+		dma_prot = pgprot_writecombine(prot);
 #endif
-	return pgprot_dmacoherent(prot);
+	else
+		dma_prot = pgprot_dmacoherent(prot);
+
+	if (attrs & DMA_ATTR_CC_SHARED)
+		return pgprot_decrypted(dma_prot);
+	else
+		return pgprot_encrypted(dma_prot);
 }
 #endif /* CONFIG_MMU */
 
-- 
2.43.0

