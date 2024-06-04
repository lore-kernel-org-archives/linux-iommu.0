Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B813D602
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466122; cv=none; b=P5n6BgltvLNuvd5AfX2iVAcY6tDCjH0x8H37YwtqdiNsUkwWl72y+V/y7rC1q9VtQGjjD9jDx5B+Zpk82Fr7yEW8Y8+08Qlfk/+z7igBjh7VtCzIPufqvSSPXjKkdYCug6MdyKaG6OA3mebqwWE6Ianm4Ob44OQDkjwBJhCLVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466122; c=relaxed/simple;
	bh=KoW/D18MopXUFdHXQ6Q/PnnQkxmmhncr645BE4UuUac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqAqX5qHgaK4IrGCi0KBpQg4ielZjaLQ9woFE8CQRt8d6DGOY1kemkN5R2e4gq9DfMSj9DxkDuJux+uAkSowQTRcQFc1PaJmHIwuhW9DTHRaL9mnhFA298gDRiW55M2o3yNvg4tIE4FxzTMgrwKR9+napTPR6UqIj+KSRsS1u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbRCiTnj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbRCiTnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466120; x=1749002120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoW/D18MopXUFdHXQ6Q/PnnQkxmmhncr645BE4UuUac=;
  b=IbRCiTnjIkJgYsl3ggnJAIAFrsP5PygSsgp2qySkEFJpO/Ai2c41lhOO
   NlPgrCrKqNImHi2eFwfcUc+wU3oFaNBopMVKxxShIPco3N00T+hmeQRyt
   VJPHgIB2guqDmtbdh+kqgOaZtvbEWGMwjt7g28kIYlXgjI4o5Bhk5sC1A
   pw6qCXyWA2fGHjN8wqO00XTimwopQfy9s2AutmW3TPpqjo+pSUAiqZIdR
   QKPkLM74g3qQl/dreNHlM/iPu85KSjEtrLX/ZSHncvnsBUoQxZpUbgYR2
   NilyPTHA1VjhqoXkZtt3LdGdwaFmj/eu4WFwUjq1wGY+Gfa7ugYWDeTsz
   w==;
X-CSE-ConnectionGUID: Ikyz2EWKTr6TmwlL8swYkQ==
X-CSE-MsgGUID: UFWZlPc5Q0aXARumgxYiTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385136"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385136"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:55:20 -0700
X-CSE-ConnectionGUID: 8KCAZo9aTm+WGTPkIQjPMQ==
X-CSE-MsgGUID: Clo85EuxT/qX1MmOM+MbzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37662033"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:55:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 17/22] ARM: dma-mapping: Pass device to arm_iommu_create_mapping()
Date: Tue,  4 Jun 2024 09:51:29 +0800
Message-Id: <20240604015134.164206-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

All users of ARM IOMMU mappings create them for a particular device, so
change the interface to accept the device rather than forcing a vague
indirection through a bus type. This prepares for making a similar
change to iommu_domain_alloc() itself.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/arm/include/asm/dma-iommu.h         | 2 +-
 arch/arm/mm/dma-mapping.c                | 8 ++++----
 drivers/gpu/drm/exynos/exynos_drm_dma.c  | 2 +-
 drivers/iommu/ipmmu-vmsa.c               | 3 +--
 drivers/iommu/mtk_iommu_v1.c             | 3 +--
 drivers/media/platform/ti/omap3isp/isp.c | 2 +-
 6 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 82ec1ccf1fee..2ce4c5683e6d 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -24,7 +24,7 @@ struct dma_iommu_mapping {
 };
 
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(const struct bus_type *bus, dma_addr_t base, u64 size);
+arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size);
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5adf1769eee4..52f9c56cc3cb 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1532,7 +1532,7 @@ static const struct dma_map_ops iommu_ops = {
 
 /**
  * arm_iommu_create_mapping
- * @bus: pointer to the bus holding the client device (for IOMMU calls)
+ * @dev: pointer to the client device (for IOMMU calls)
  * @base: start address of the valid IO address space
  * @size: maximum size of the valid IO address space
  *
@@ -1544,7 +1544,7 @@ static const struct dma_map_ops iommu_ops = {
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(const struct bus_type *bus, dma_addr_t base, u64 size)
+arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 {
 	unsigned int bits = size >> PAGE_SHIFT;
 	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
@@ -1585,7 +1585,7 @@ arm_iommu_create_mapping(const struct bus_type *bus, dma_addr_t base, u64 size)
 
 	spin_lock_init(&mapping->lock);
 
-	mapping->domain = iommu_domain_alloc(bus);
+	mapping->domain = iommu_domain_alloc(dev->bus);
 	if (!mapping->domain)
 		goto err4;
 
@@ -1718,7 +1718,7 @@ static void arm_setup_iommu_dma_ops(struct device *dev)
 		dma_base = dma_range_map_min(dev->dma_range_map);
 		size = dma_range_map_max(dev->dma_range_map) - dma_base;
 	}
-	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
+	mapping = arm_iommu_create_mapping(dev, dma_base, size);
 	if (IS_ERR(mapping)) {
 		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
 				size, dev_name(dev));
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index e2c7373f20c6..6a6761935224 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -110,7 +110,7 @@ int exynos_drm_register_dma(struct drm_device *drm, struct device *dev,
 		void *mapping = NULL;
 
 		if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
-			mapping = arm_iommu_create_mapping(&platform_bus_type,
+			mapping = arm_iommu_create_mapping(dev,
 				EXYNOS_DEV_ADDR_START, EXYNOS_DEV_ADDR_SIZE);
 		else if (IS_ENABLED(CONFIG_IOMMU_DMA))
 			mapping = iommu_get_domain_for_dev(priv->dma_dev);
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index b657cc09605f..ff55b8c30712 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -804,8 +804,7 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 	if (!mmu->mapping) {
 		struct dma_iommu_mapping *mapping;
 
-		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						   SZ_1G, SZ_2G);
+		mapping = arm_iommu_create_mapping(dev, SZ_1G, SZ_2G);
 		if (IS_ERR(mapping)) {
 			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
 			ret = PTR_ERR(mapping);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index d6e4002200bd..da61df27582d 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -439,8 +439,7 @@ static int mtk_iommu_v1_create_mapping(struct device *dev,
 	mtk_mapping = data->mapping;
 	if (!mtk_mapping) {
 		/* MTK iommu support 4GB iova address space. */
-		mtk_mapping = arm_iommu_create_mapping(&platform_bus_type,
-						0, 1ULL << 32);
+		mtk_mapping = arm_iommu_create_mapping(dev, 0, 1ULL << 32);
 		if (IS_ERR(mtk_mapping))
 			return PTR_ERR(mtk_mapping);
 
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index 1cda23244c7b..91101ba88ef0 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -1965,7 +1965,7 @@ static int isp_attach_iommu(struct isp_device *isp)
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
 	 * VAs. This will allocate a corresponding IOMMU domain.
 	 */
-	mapping = arm_iommu_create_mapping(&platform_bus_type, SZ_1G, SZ_2G);
+	mapping = arm_iommu_create_mapping(isp->dev, SZ_1G, SZ_2G);
 	if (IS_ERR(mapping)) {
 		dev_err(isp->dev, "failed to create ARM IOMMU mapping\n");
 		return PTR_ERR(mapping);
-- 
2.34.1

