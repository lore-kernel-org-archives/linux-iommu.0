From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 10/11] arm: dma-mapping: Add additional parameters to
 arm_iommu_create_mapping
Date: Thu, 16 Jan 2014 13:44:22 +0100
Message-ID: <1389876263-25759-11-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>, Andreas Herrmann <herrmann.der.user@googlemail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Inki Dae <inki.dae@samsung.com>, iommu@lists.linux-foundation.org, Andreas Herrmann <andreas.herrmann@calxeda.com>, Hiroshi Doyu <hdoyu@nvidia.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

The new parameters are

  dma_addr_t grow_size

         Specifies the size by which the mapping will be extended in
         case that no sufficient space is left in the mapping to
         handle an iova allocation request. If a grow_size of 0 is
         specified the mapping is not extended.

  dma_addr_t max_size

         Specifies the maximum size for the entire mapping --
         including all extensions made over time. The mapping can only
         be extended if the entire size is less than or equal to
         max_size.

Adapt existing calls to arm_iommu_create_mapping in exynos_drm_iommu.c
and shmobile-iommu.c such that they do not make use of the extension
feature.

Adapt existing call to arm_iommu_create_mapping in arm-smmu.c such
that the extension feature will be used.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 arch/arm/include/asm/dma-iommu.h          |    4 ++--
 arch/arm/mm/dma-mapping.c                 |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |    4 ++--
 drivers/iommu/arm-smmu.c                  |    2 +-
 drivers/iommu/shmobile-iommu.c            |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index a8c56ac..50edacd 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -23,8 +23,8 @@ struct dma_iommu_mapping {
 };
 
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
-			 int order);
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base,  size_t size,
+			int order, dma_addr_t grow_size, dma_addr_t max_size);
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f61a570..ccea46a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1887,7 +1887,7 @@ struct dma_map_ops iommu_coherent_ops = {
  */
 struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
-			 int order)
+			int order, dma_addr_t grow_size, dma_addr_t max_size)
 {
 	unsigned int count = size >> (PAGE_SHIFT + order);
 	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.c b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
index fb8db03..c1cd18b 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
@@ -40,8 +40,8 @@ int drm_create_iommu_mapping(struct drm_device *drm_dev)
 		priv->da_space_order = EXYNOS_DEV_ADDR_ORDER;
 
 	mapping = arm_iommu_create_mapping(&platform_bus_type, priv->da_start,
-						priv->da_space_size,
-						priv->da_space_order);
+					priv->da_space_size,
+					priv->da_space_order, 0, 0);
 	if (IS_ERR(mapping))
 		return PTR_ERR(mapping);
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 68bbe45..31414e5 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2124,7 +2124,7 @@ static int arm_smmu_device_notifier(struct notifier_block *nb,
 			break;
 
 		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						0, SZ_128M, 0);
+						0, SZ_128M, 0, SZ_128M, SZ_2G);
 		if (IS_ERR(mapping)) {
 			ret = PTR_ERR(mapping);
 			dev_info(dev, "arm_iommu_create_mapping failed\n");
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index d572863..1ba3a01 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -343,7 +343,7 @@ static int shmobile_iommu_add_device(struct device *dev)
 	mapping = archdata->iommu_mapping;
 	if (!mapping) {
 		mapping = arm_iommu_create_mapping(&platform_bus_type, 0,
-						   L1_LEN << 20, 0);
+						L1_LEN << 20, 0, 0, 0);
 		if (IS_ERR(mapping))
 			return PTR_ERR(mapping);
 		archdata->iommu_mapping = mapping;
-- 
1.7.9.5
