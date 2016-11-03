From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC 7/8] iommu/vt-d: Implement add_reserved_regions callback
Date: Thu,  3 Nov 2016 21:39:37 +0000
Message-ID: <1478209178-3009-8-git-send-email-eric.auger@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

Implement the add_reserved_regions callback by registering
the [FEE0_0000h - FEF0_000h] 1MB range as a reserved region
(MSI address space).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 48 +++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a4407ea..fb64418 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5173,6 +5173,27 @@ static void intel_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(iommu->iommu_dev, dev);
 }
 
+static int intel_add_reserved_regions(struct iommu_domain *domain,
+				      struct device *device)
+{
+	struct iommu_reserved_region *region;
+	const dma_addr_t msi_base = 0xfee00000;
+	const size_t msi_length	= 0x00100000;
+
+	iommu_reserved_region_for_each(region, domain) {
+		if (region->start == msi_base && region->length == msi_length)
+			continue;
+	}
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->start  = msi_base;
+	region->length = msi_length;
+	list_add_tail(&region->list, &domain->reserved_regions);
+	return 0;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
@@ -5282,19 +5303,20 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
 static const struct iommu_ops intel_iommu_ops = {
-	.capable	= intel_iommu_capable,
-	.domain_alloc	= intel_iommu_domain_alloc,
-	.domain_free	= intel_iommu_domain_free,
-	.attach_dev	= intel_iommu_attach_device,
-	.detach_dev	= intel_iommu_detach_device,
-	.map		= intel_iommu_map,
-	.unmap		= intel_iommu_unmap,
-	.map_sg		= default_iommu_map_sg,
-	.iova_to_phys	= intel_iommu_iova_to_phys,
-	.add_device	= intel_iommu_add_device,
-	.remove_device	= intel_iommu_remove_device,
-	.device_group   = pci_device_group,
-	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
+	.capable		= intel_iommu_capable,
+	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_free		= intel_iommu_domain_free,
+	.attach_dev		= intel_iommu_attach_device,
+	.detach_dev		= intel_iommu_detach_device,
+	.map			= intel_iommu_map,
+	.unmap			= intel_iommu_unmap,
+	.map_sg			= default_iommu_map_sg,
+	.iova_to_phys		= intel_iommu_iova_to_phys,
+	.add_device		= intel_iommu_add_device,
+	.remove_device		= intel_iommu_remove_device,
+	.add_reserved_regions	= intel_iommu_add_reserved_regions,
+	.device_group		= pci_device_group,
+	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
-- 
1.9.1
