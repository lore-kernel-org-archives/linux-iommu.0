Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1343C2E1
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 12:49:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1200D2F4;
	Mon, 15 May 2023 05:50:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E17E3F67D;
	Mon, 15 May 2023 05:49:41 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	will@kernel.org,
	jgg@nvidia.com,
	digetx@gmail.com,
	thierry.reding@gmail.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH 4/4] iommu: Clean up force_aperture confusion
Date: Mon, 15 May 2023 13:49:32 +0100
Message-Id: <ed26ed3213bf07ab4977211702dc0898680524cd.1684154219.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1684154219.git.robin.murphy@arm.com>
References: <cover.1684154219.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was never entirely clear whether the force_aperture flag was supposed
to be a hardware capability or a software policy. So far things seem to
have leant towards the latter, given that the only drivers not setting
the flag are ones where the aperture is seemingly a whole virtual
address space such that accesses outside it wouldn't be possible, and
the one driver which definitely can't enforce it in hardware *does*
still set the flag.

On reflection, though, it makes little sense for drivers to dictate
usage policy to callers, and the interpretation that a driver setting
the flag might also translate addresses outside the given aperture but
has for some reason chosen not to is not actually a useful one. It seems
a lot more logical to treat the aperture as the absolute limit of what
can be translated, and the flag to indicate what would happen if a
device did try to access an address outside the aperture, i.e. whether
the access would fault or pass through untranslated. As such, reframe
the flag consistent with a hardware capability in the hope of clearing
up the misconception.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c    | 19 +++++++------------
 drivers/iommu/mtk_iommu_v1.c |  4 ++++
 drivers/iommu/sprd-iommu.c   |  1 +
 drivers/iommu/tegra-gart.c   |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a9f0b0bddbd..4693b021d54f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -548,24 +548,19 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
 
+	/*
+	 * If the IOMMU only offers a non-isolated GART-style translation
+	 * aperture, just let the device use dma-direct.
+	 */
+	if (!domain->geometry.force_aperture)
+		return -EINVAL;
+
 	iovad = &cookie->iovad;
 
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
 
-	/* Check the domain allows at least some access to the device... */
-	if (domain->geometry.force_aperture) {
-		if (base > domain->geometry.aperture_end ||
-		    limit < domain->geometry.aperture_start) {
-			pr_warn("specified DMA range outside IOMMU capability\n");
-			return -EFAULT;
-		}
-		/* ...then finally give it a kicking to make sure it fits */
-		base_pfn = max_t(unsigned long, base_pfn,
-				domain->geometry.aperture_start >> order);
-	}
-
 	/* start_pfn is always nonzero for an already-initialised domain */
 	mutex_lock(&cookie->mutex);
 	if (iovad->start_pfn) {
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 8a0a5e5d049f..3ca813919974 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -281,6 +281,10 @@ static struct iommu_domain *mtk_iommu_v1_domain_alloc(unsigned type)
 	if (!dom)
 		return NULL;
 
+	dom->domain.geometry.aperture_start = 0;
+	dom->domain.geometry.aperture_end = SZ_4G - 1;
+	dom->domain.geometry.force_aperture = true;
+
 	return &dom->domain;
 }
 
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 39e34fdeccda..eb684d8807ca 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -148,6 +148,7 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = SZ_256M - 1;
+	dom->domain.geometry.force_aperture = true;
 
 	return &dom->domain;
 }
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 0a121cbc17b8..c221af290798 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -160,7 +160,7 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 
 	domain->domain.geometry.aperture_start = gart->iovmm_base;
 	domain->domain.geometry.aperture_end = gart->iovmm_end - 1;
-	domain->domain.geometry.force_aperture = true;
+	domain->domain.geometry.force_aperture = false;
 
 	num_pages = (gart->iovmm_end - gart->iovmm_base) / GART_PAGE_SIZE;
 	domain->savedata = vcalloc(num_pages, sizeof(u32));
-- 
2.39.2.101.g768bb238c484.dirty

