Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48221CC6C
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585477; cv=none; b=inXXzGVK4HoHeow1C7p53z2rdrd8eHYoKfFPK+z6xEkRysLLwtfnEPL3kmILgDt+UdNaEqITWdIQB3RGHp5DNIPSgZ2ThkahY4GIN0G0HcXG7pnlDqjdtEgGEWDvIsgD/llKPsPan0+SSW8gPeapiSppQ6VDE9h61FYX8o/TAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585477; c=relaxed/simple;
	bh=u9/8JKWwZ2zM5aSESTwv+DYfmIeOC5CPjPusGfMUNw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WlQR2zEYi1AUX6kg+XtOGCt71GNCXcAQcYmCZedYdxnEx9LUtovuWYv0nBROjzbvkPYDsXx3KN4O+KI4N8CVP9sHvrUesJJqHZ6tQwoyYUNDXECe0RTelc8wybCRehPVxGZWKuQdTq9J7bxD3OpFKaD4X4AYhqPs7FZAQPB5ttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D4301516;
	Wed, 26 Feb 2025 07:58:10 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C34353F673;
	Wed, 26 Feb 2025 07:57:53 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	yf.wang@mediatek.com
Subject: [PATCH] iommu/dma: Remove redundant locking
Date: Wed, 26 Feb 2025 15:57:49 +0000
Message-Id: <a943d4c198e6a1fffe998337d577dc3aa7f660a9.1740585469.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.

iommu_dma_init_domain() is now only called under the group mutex, as it
should be given that that the default domain belongs to the group, so
the additional internal locking is no longer needed.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2a9fa0c8cc00..44afb0c5e80d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -86,7 +86,6 @@ struct iommu_dma_cookie {
 	struct iommu_domain		*fq_domain;
 	/* Options for dma-iommu use */
 	struct iommu_dma_options	options;
-	struct mutex			mutex;
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
@@ -397,7 +396,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 	if (!domain->iova_cookie)
 		return -ENOMEM;
 
-	mutex_init(&domain->iova_cookie->mutex);
 	return 0;
 }
 
@@ -698,23 +696,20 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 			 domain->geometry.aperture_start >> order);
 
 	/* start_pfn is always nonzero for an already-initialised domain */
-	mutex_lock(&cookie->mutex);
 	if (iovad->start_pfn) {
 		if (1UL << order != iovad->granule ||
 		    base_pfn != iovad->start_pfn) {
 			pr_warn("Incompatible range for DMA domain\n");
-			ret = -EFAULT;
-			goto done_unlock;
+			return -EFAULT;
 		}
 
-		ret = 0;
-		goto done_unlock;
+		return 0;
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 	ret = iova_domain_init_rcaches(iovad);
 	if (ret)
-		goto done_unlock;
+		return ret;
 
 	iommu_dma_init_options(&cookie->options, dev);
 
@@ -723,11 +718,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
 		domain->type = IOMMU_DOMAIN_DMA;
 
-	ret = iova_reserve_iommu_regions(dev, domain);
-
-done_unlock:
-	mutex_unlock(&cookie->mutex);
-	return ret;
+	return iova_reserve_iommu_regions(dev, domain);
 }
 
 /**
-- 
2.39.2.101.g768bb238c484.dirty

