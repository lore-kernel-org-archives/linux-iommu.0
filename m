From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC v2 3/8] iommu/dma: Allow MSI-only cookies
Date: Fri,  4 Nov 2016 11:24:01 +0000
Message-ID: <1478258646-3117-4-git-send-email-eric.auger@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy@arm.com>

IOMMU domain users such as VFIO face a similar problem to DMA API ops
with regard to mapping MSI messages in systems where the MSI write is
subject to IOMMU translation. With the relevant infrastructure now in
place for managed DMA domains, it's actually really simple for other
users to piggyback off that and reap the benefits without giving up
their own IOVA management, and without having to reinvent their own
wheel in the MSI layer.

Allow such users to opt into automatic MSI remapping by dedicating a
region of their IOVA space to a managed cookie.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v13 -> v14:
- restore reserve_iova for iova >= base + size

v1 -> v13 incorpration:
- compared to Robin's version
- add NULL last param to iommu_dma_init_domain
- set the msi_geometry aperture
- I removed
  if (base < U64_MAX - size)
     reserve_iova(iovad, iova_pfn(iovad, base + size), ULONG_MAX);
  don't get why we would reserve something out of the scope of the iova domain?
  what do I miss?
---
 drivers/iommu/dma-iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  9 +++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c5ab866..d45f9a0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -716,3 +716,42 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->address_lo += lower_32_bits(msi_page->iova);
 	}
 }
+
+/**
+ * iommu_get_dma_msi_region_cookie - Configure a domain for MSI remapping only
+ * @domain: IOMMU domain to prepare
+ * @base: Base address of IOVA region to use as the MSI remapping aperture
+ * @size: Size of the desired MSI aperture
+ *
+ * Users who manage their own IOVA allocation and do not want DMA API support,
+ * but would still like to take advantage of automatic MSI remapping, can use
+ * this to initialise their own domain appropriately.
+ */
+int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
+			       dma_addr_t base, u64 size)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iova_domain *iovad;
+	int ret;
+
+	if (domain->type == IOMMU_DOMAIN_DMA)
+		return -EINVAL;
+
+	ret = iommu_get_dma_cookie(domain);
+	if (ret)
+		return ret;
+
+	ret = iommu_dma_init_domain(domain, base, size, NULL);
+	if (ret) {
+		iommu_put_dma_cookie(domain);
+		return ret;
+	}
+
+	cookie = domain->iova_cookie;
+	iovad = &cookie->iovad;
+	if (base < U64_MAX - size)
+		reserve_iova(iovad, iova_pfn(iovad, base + size), ULONG_MAX);
+
+	return 0;
+}
+EXPORT_SYMBOL(iommu_get_dma_msi_region_cookie);
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 32c5890..05ab5b4 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -67,6 +67,9 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 /* The DMA API isn't _quite_ the whole story, though... */
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 
+int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
+				    dma_addr_t base, u64 size);
+
 #else
 
 struct iommu_domain;
@@ -90,6 +93,12 @@ static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 {
 }
 
+static inline int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
+						  dma_addr_t base, u64 size)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
1.9.1
