Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0CB168CB
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:19:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDAF4C15;
	Tue, 12 Sep 2023 09:19:39 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 545163F738;
	Tue, 12 Sep 2023 09:19:01 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	m.szyprowski@samsung.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: [PATCH 8/8] iommu: Improve map/unmap sanity checks
Date: Tue, 12 Sep 2023 17:18:44 +0100
Message-Id: <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1694525662.git.robin.murphy@arm.com>
References: <cover.1694525662.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current checks for the __IOMMU_DOMAIN_PAGING capability seem a
bit stifled, since it is quite likely now that a non-paging domain
won't have a pgsize_bitmap and/or mapping ops, and thus get caught
by the earlier condition anyway. Swap them around to test the more
fundamental condition first, then we can reasonably also upgrade
the other to a WARN_ON, since if a driver does ever expose a paging
domain without the means to actually page, it's clearly very broken.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c83f2e4c56f5..391bcae4d02d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2427,12 +2427,12 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
-		return -ENODEV;
-
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
+	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
+		return -ENODEV;
+
 	/* find out the minimum page size supported */
 	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
 
@@ -2510,10 +2510,10 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
-	if (unlikely(!ops->unmap_pages || domain->pgsize_bitmap == 0UL))
+	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return 0;
 
-	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+	if (WARN_ON(!ops->unmap_pages || domain->pgsize_bitmap == 0UL))
 		return 0;
 
 	/* find out the minimum page size supported */
-- 
2.39.2.101.g768bb238c484.dirty

