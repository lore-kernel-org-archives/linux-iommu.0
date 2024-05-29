Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB3E21A19
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998061; cv=none; b=fVzfo75vSfwmlYTdv7NQwscwGNDGMmYMiDNpKm+IwivhE2fqYaVaOWD/FTtK3S55X69uL95qiFdl3/yPaZlSIvKZ5z4XbwghD/7ZQtHn0CU5fYMOhcOoQf28G3gs32cHli5z1c4EMdxY07KWgux+migVSbPonEAF7biGKcAcQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998061; c=relaxed/simple;
	bh=c6dqKVeQyxgbzfBnYTmLHRwbpXQUgnveDT5DlgxVB50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLlEA5gU6WrIT/Vva8z5UoO24lMUgVb2Nz3Vfidq1GsYppuhRwrN5y04OOXsp1TTzQR5RI8F1z3jMx8VqnLucGsNOaSVktxqiJm2X0vzEX9XXXWVZUeGWdybeauPuy5KBnTWQjfpuH74ABGIDSEBSKKegTFPLRg+iS6n01+Sjic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB0FA339;
	Wed, 29 May 2024 08:54:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99F1A3F792;
	Wed, 29 May 2024 08:54:18 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	will@kernel.org,
	linux-kernel@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v2] iommu/dma: Fix domain init
Date: Wed, 29 May 2024 16:54:09 +0100
Message-Id: <159193e80b6a7701c61b32d6119ac68989d457bd.1716997607.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite carefully rewording the kerneldoc to describe the new direct
interaction with dma_range_map, it seems I managed to confuse myself in
removing the redundant force_aperture check and ended up making the code
not do that at all. This led to dma_range_maps inadvertently being able
to set iovad->start_pfn = 0, and all the nonsensical chaos which ensues
from there. Restore the correct behaviour of constraining base_pfn to
the domain aperture regardless of dma_range_map, and not trying to apply
dma_range_map constraints to the basic IOVA domain since they will be
properly handled with reserved regions later.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: ad4750b07d34 ("iommu/dma: Make limit checks self-contained")
Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Since I've now got round to rebasing on -rc1, I figured I may as well
send a v2 with updated tags to avoid any confusion.

 drivers/iommu/dma-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f731e4b2a417..43520e7275cc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -686,15 +686,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 
 	/* Check the domain allows at least some access to the device... */
 	if (map) {
-		dma_addr_t base = dma_range_map_min(map);
-		if (base > domain->geometry.aperture_end ||
+		if (dma_range_map_min(map) > domain->geometry.aperture_end ||
 		    dma_range_map_max(map) < domain->geometry.aperture_start) {
 			pr_warn("specified DMA range outside IOMMU capability\n");
 			return -EFAULT;
 		}
-		/* ...then finally give it a kicking to make sure it fits */
-		base_pfn = max(base, domain->geometry.aperture_start) >> order;
 	}
+	/* ...then finally give it a kicking to make sure it fits */
+	base_pfn = max_t(unsigned long, base_pfn,
+			 domain->geometry.aperture_start >> order);
 
 	/* start_pfn is always nonzero for an already-initialised domain */
 	mutex_lock(&cookie->mutex);
-- 
2.39.2.101.g768bb238c484.dirty

