Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796AF4E2367
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958907; cv=none; b=UqkWyHDd+TCNebYM6FA2HFn8WJwqYw4agYvdeVpWuSGrNNn6Elin5Wr5dIW0ovwDVbFj21E7+HF8bWqi7pI4C+dXTU3OC7lactxUBar7NChUJfU6IMvhda1eBxERaeOPlTIQ9NrDJAKzhetNHW8nDFoPKwwXSWAzPjwkS+3BqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958907; c=relaxed/simple;
	bh=I4RbcrBO3YWporH1Bxc0BpUPwkrIVtV3+V+ZxLrjfw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9JbK7OzJEraYOG41vi8oUbX+tZud2xK5vuUACsga4kbdYuniF1g07j0HJEB5ibUhl87NcXNRj/HeR96PtTejBh41vAXVGf+Uk7QBEX09Q7xJII1IYsfzL9w0crckdAgZgKi0x5ruZZMF1UEi3YEPotiS588kfIAM82SwmwnvK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LpN5/SnK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LpN5/SnK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636A12F;
	Fri,  2 Oct 2026 09:35:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2D5D3F86F;
	Fri,  2 Oct 2026 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790958904; bh=I4RbcrBO3YWporH1Bxc0BpUPwkrIVtV3+V+ZxLrjfw0=;
	h=From:To:Cc:Subject:Date:From;
	b=LpN5/SnKBoIRYnTXwoxH2s+xe9EbnIefcgFK8KLcqLvMNO/l7goJxPiYX2XbSPI+y
	 BPbZxDWvl/8RT+sLRi5rBy5BNfdAik7aFNlMIZX6tI3yUQmAyewPrvALPTlr+d95pb
	 7XqMwERQkiLFY1Kzpkm917LY0ZYSD58iZ4uTvt70=
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nicolinc@nvidia.com,
	jgg@nvidia.com
Subject: [PATCH] iommu/dma: Clean up redundant MSI cookie check
Date: Fri,  2 Oct 2026 17:34:58 +0100
Message-ID: <214eb3e383431f48b517c4bd2ba4f329579a442e.1790958898.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The has_msi_cookie() condition only mattered transiently as an artefact
of the cookie rework being done in parallel with the sw_msi rework. Once
combined, calls to iommu_dma_sw_msi() are themselves dispatched based on
domain->cookie_type, so checking again is clearly redundant.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1b8012123232..5d9d282540bc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2162,12 +2162,6 @@ void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
 	dev_clear_dma_iommu(dev);
 }
 
-static bool has_msi_cookie(const struct iommu_domain *domain)
-{
-	return domain && (domain->cookie_type == IOMMU_COOKIE_DMA_IOVA ||
-			  domain->cookie_type == IOMMU_COOKIE_DMA_MSI);
-}
-
 static size_t cookie_msi_granule(const struct iommu_domain *domain)
 {
 	switch (domain->cookie_type) {
@@ -2249,11 +2243,6 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
 
-	if (!has_msi_cookie(domain)) {
-		msi_desc_set_iommu_msi_iova(desc, 0, 0);
-		return 0;
-	}
-
 	iommu_group_mutex_assert(dev);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	if (!msi_page)
-- 
2.54.0.dirty

