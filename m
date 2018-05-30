From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 1/2] ARM: dma-mapping: Implement
 arm_dma_iommu_detach_device()
Date: Wed, 30 May 2018 10:03:44 +0200
Message-ID: <20180530080345.2353-2-thierry.reding@gmail.com>
References: <20180530080345.2353-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180530080345.2353-1-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Skeggs <bskeggs@redhat.com>, Christoph Hellwig <hch@infradead.org>, Russell King <linux@armlinux.org.uk>
Cc: nouveau@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, Jordan Crouse <jcrouse@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding@nvidia.com>

Implement this function to enable drivers from detaching from any IOMMU
domains that architecture code might have attached them to so that they
can take exclusive control of the IOMMU via the IOMMU API.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- make API 32-bit ARM specific
- avoid extra local variable

Changes in v2:
- fix compilation

 arch/arm/include/asm/dma-mapping.h |  3 +++
 arch/arm/mm/dma-mapping-nommu.c    |  4 ++++
 arch/arm/mm/dma-mapping.c          | 16 ++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 8436f6ade57d..5960e9f3a9d0 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -103,6 +103,9 @@ extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 #define arch_teardown_dma_ops arch_teardown_dma_ops
 extern void arch_teardown_dma_ops(struct device *dev);
 
+#define arm_dma_iommu_detach_device arm_dma_iommu_detach_device
+extern void arm_dma_iommu_detach_device(struct device *dev);
+
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index f448a0663b10..eb781369377b 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -241,3 +241,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_teardown_dma_ops(struct device *dev)
 {
 }
+
+void arm_dma_iommu_detach_device(struct device *dev)
+{
+}
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index af27f1c22d93..6d8af08b3e7d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2400,3 +2400,19 @@ void arch_teardown_dma_ops(struct device *dev)
 
 	arm_teardown_iommu_dma_ops(dev);
 }
+
+void arm_dma_iommu_detach_device(struct device *dev)
+{
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+	if (!mapping)
+		return;
+
+	arm_iommu_release_mapping(mapping);
+	arm_iommu_detach_device(dev);
+
+	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
+#endif
+}
+EXPORT_SYMBOL(arm_dma_iommu_detach_device);
-- 
2.17.0
