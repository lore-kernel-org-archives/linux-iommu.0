Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C803381AFF;
	Mon, 20 Apr 2026 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665699; cv=none; b=ns20pfLdaPCSGjFuyRoCHE4qPGAuOkfKeECQOv10SDU8voA9aI55wbGW7PcDa41u05jqtY16ZYRyFO59N4HkYID78MMTKrupdNPZ/ZaCjNwSsTuo/2CtgNUyIqEguxX3dnD/SXfqK2TVxn0DU1l9l7liob5q37qBTh6/7Kb/9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665699; c=relaxed/simple;
	bh=u9Nxyxygf4qPGYAgMTCv2majmXN+k5vEhMk1b0dtxGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwTI0ADuY+oN5a4tjeNKK61SpxunSfYHvLMgO54FYCqxVWqsltXA8+Vi1Ofpaz+fRRd6Zjepyk5hS1a8UhYi+pgD10MmaRdnK5SvZoVA3cZmduwbgJ/OtMWH5TxajbyUTti0gmOYhHKHfQu/4NOrVTy7xzLLHp+SG8b0wiOrtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHaCmdY0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHaCmdY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B54C19425;
	Mon, 20 Apr 2026 06:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776665698;
	bh=u9Nxyxygf4qPGYAgMTCv2majmXN+k5vEhMk1b0dtxGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHaCmdY0X9mIkXDcuaXt//BQ77euBJRU0C/bo5VHZlfGSCRWOt35DzlF3eu+IrE1K
	 hfSGt1JTogoGsrqQv28cCvpCdPKsZO0VFQJ1ULGnYYG4YVflWAdlJnuK6IusbBm9kC
	 zSw0RO9c5UMyehAVqPOQ6D/XXV+7Pke0V+qJ8Sqjt/uRqOwfwW2gLHZ9LE40HqLK0i
	 troTFOa+zVz2c4QRdTdO7CRgzBdBXZI6hvjmnV++7Mz4J7pzaUSNYJCjDsQAhHQ/0u
	 0QkpFZX7qAXYfghEH2vL33XXfaXORsy4IlIs5heEd4HVxDB1Zb/Gi2qKrjEateR6iM
	 OEcTTozUXkKTw==
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
Subject: [PATCH v2 5/8] dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
Date: Mon, 20 Apr 2026 11:44:12 +0530
Message-ID: <20260420061415.3650870-6-aneesh.kumar@kernel.org>
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

