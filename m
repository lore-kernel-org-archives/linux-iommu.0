Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4638C400;
	Fri, 17 Apr 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416406; cv=none; b=PwpuZ79yYa1PeekWl1o9vk5mPpk3IXFI7a9KZ1z/3eUW1JLneI7i7pRVw6474Wrq9nGPMFb+pE74pIC0LOXI7XX0pVH4apbkLZtGvfCjLg4haV0+36n0IORppOyN603ZIb1Tfyenmj+ESOnnYmWpO3izLzGwg3SutOV+kfvfOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416406; c=relaxed/simple;
	bh=hkf8yDSIaDmjpcCJ9rrjqwE41gSx/WhkacTiUgjTgZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkfotjIpvnTskLzJ11G2nuzPwc2Il7ShKBUcqOn3VVpSq4ZVWMEOwukLJF73DF6f9FoEjI99BmkL4iA8noZn8yBhPQV2Vv8szKTiCpnaUGbqtSViQRvZxcpSd5u5Kef7FzRBMZRSAINI3RA8yGpvtH0CXrF75ZTRNmRE3W/FDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAf8Fq0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAf8Fq0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39952C19425;
	Fri, 17 Apr 2026 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776416405;
	bh=hkf8yDSIaDmjpcCJ9rrjqwE41gSx/WhkacTiUgjTgZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAf8Fq0Y0czYdglv3zUFt2NDwmrtGqB94RDN8musd7ZMvTTWQOQnZcSVyimhFMRfO
	 Ur8gD2dbPBbLe8r6E7fUM/n/FdSlPuM2JssWlx8r5Q4dEKOxZBVvpZkE3vMoyVRCrt
	 P1hkIVdR2e4XVoFXlmqKUCkKJ7uCaRQHrx5fQy3rl+Qi8Yzd49IwrH3HNLtw6Q9Hxe
	 JTUggQmaErONsKyHOmqFgY9memtbP9G/RWKunhCzPBTFiJ+dBpbKPmo+NDEilvym1/
	 7zWh5Zu5HGuAsirr01Eo+tXE3IKAqPi4uJJFkQ/k7RY2kOIVka4V5bR/l0WE/nUnah
	 RMZTcE37/EZ2A==
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
Subject: [RFC PATCH 5/7] dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_DECRYPTED
Date: Fri, 17 Apr 2026 14:28:58 +0530
Message-ID: <20260417085900.3062416-6-aneesh.kumar@kernel.org>
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

Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
do not need to adjust the page protection separately.

Update dma_pgprot() to apply pgprot_decrypted() when
DMA_ATTR_CC_DECRYPTED is set and pgprot_encrypted() otherwise Convert
the dma-direct allocation and mmap paths to pass DMA_ATTR_CC_DECRYPTED
instead of open-coding force_dma_unencrypted() handling around
dma_pgprot().

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  |  8 +++-----
 kernel/dma/mapping.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4a4147fffc5e..1d2c27bbf3de 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -288,9 +288,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
-			prot = pgprot_decrypted(prot);
-
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -580,9 +577,10 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
 	int ret = -ENXIO;
 
-	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 	if (force_dma_unencrypted(dev))
-		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+		attrs |= DMA_ATTR_CC_DECRYPTED;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 6d3dd0bd3a88..9f505df6ee0e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -534,13 +534,21 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
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
+	if (attrs & DMA_ATTR_CC_DECRYPTED)
+		return pgprot_decrypted(dma_prot);
+	else
+		return pgprot_encrypted(dma_prot);
 }
 #endif /* CONFIG_MMU */
 
-- 
2.43.0

