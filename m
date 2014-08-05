From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 08/29] ARM: dma-mapping: add helpers for managing default
 per-device dma mappings
Date: Tue, 05 Aug 2014 12:47:36 +0200
Message-ID: <1407235677-26324-9-git-send-email-m.szyprowski@samsung.com>
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

This patch adds 2 helpers: arm_iommu_create_default_mapping and
arm_iommu_release_default_mapping for managing default iommu-based
dma-mapping address space, created for exlusive use only by the given
device. Those helpers are convenient for setting up iommu-based
dma-mapping for most typical devices in the system.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/include/asm/dma-iommu.h |  5 +++++
 arch/arm/mm/dma-mapping.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 8e3fcb9..ae3dac0 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -33,5 +33,10 @@ int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
 
+int arm_iommu_create_default_mapping(struct device *dev, dma_addr_t base,
+				     size_t size);
+
+void arm_iommu_release_default_mapping(struct device *dev);
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8161102..233a8cf 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2106,4 +2106,35 @@ void arm_iommu_detach_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
+int arm_iommu_create_default_mapping(struct device *dev, dma_addr_t base,
+				     size_t size)
+{
+	struct dma_iommu_mapping *mapping;
+	int ret;
+
+	mapping = arm_iommu_create_mapping(dev->bus, base, size);
+	if (IS_ERR(mapping))
+		return PTR_ERR(mapping);
+
+	ret = arm_iommu_attach_device(dev, mapping);
+	if (ret) {
+		arm_iommu_release_mapping(mapping);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arm_iommu_create_default_mapping);
+
+void arm_iommu_release_default_mapping(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	if (!mapping)
+		return;
+
+	arm_iommu_detach_device(dev);
+	arm_iommu_release_mapping(mapping);
+}
+EXPORT_SYMBOL_GPL(arm_iommu_release_default_mapping);
+
 #endif
-- 
1.9.2
