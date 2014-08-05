From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 09/29] ARM: dma-mapping: provide stubs if no ARM_DMA_USE_IOMMU
 has been selected
Date: Tue, 05 Aug 2014 12:47:37 +0200
Message-ID: <1407235677-26324-10-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, linaro-mm-sig@lists.linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch provides stubs returing errors for all iommu related arm
dma-mapping functions, which are used when CONFIG_ARM_DMA_USE_IOMMU is
not set. This let drivers to use common code for iommu and non-iommu
cases without additional ifdefs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/include/asm/dma-iommu.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index ae3dac0..1e57569 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -9,6 +9,8 @@
 #include <linux/kmemcheck.h>
 #include <linux/kref.h>
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+
 struct dma_iommu_mapping {
 	/* iommu specific data */
 	struct iommu_domain	*domain;
@@ -38,5 +40,34 @@ int arm_iommu_create_default_mapping(struct device *dev, dma_addr_t base,
 
 void arm_iommu_release_default_mapping(struct device *dev);
 
+#else
+
+static inline struct dma_iommu_mapping *
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline void
+arm_iommu_release_mapping(struct dma_iommu_mapping *mapping) { }
+
+static inline int arm_iommu_attach_device(struct device *dev,
+					struct dma_iommu_mapping *mapping)
+{
+	return -ENOSYS;
+}
+
+static inline void arm_iommu_detach_device(struct device *dev) { }
+
+static inline int arm_iommu_create_default_mapping(struct device *dev,
+						dma_addr_t base, size_t size)
+{
+	return -ENOSYS;
+}
+
+static inline void arm_iommu_release_default_mapping(struct device *dev) { }
+
+#endif
+
 #endif /* __KERNEL__ */
 #endif
-- 
1.9.2
