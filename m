From: James Sewart <jamessewart@arista.com>
Subject: [PATCH 2/4] iommu/vt-d: Implement apply_resv_region for reserving
 IOVA ranges
Date: Mon, 4 Mar 2019 15:46:02 +0000
Message-ID: <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Used by iommu.c before creating identity mappings for reserved ranges to
ensure dma-map-ops won't ever remap these addresses.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..8e0a4e2ff77f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5299,6 +5299,19 @@ static void intel_iommu_put_resv_regions(struct =
device *dev,
 	}
 }
=20
+static void intel_iommu_apply_resv_region(struct device *dev,
+		struct iommu_domain *domain,
+		struct iommu_resv_region *region)
+{
+	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
+	unsigned long start, end;
+
+	start =3D IOVA_PFN(region->start);
+	end   =3D IOVA_PFN(region->start + region->length - 1);
+
+	WARN_ON_ONCE(reserve_iova(&dmar_domain->iovad, start, end) =3D=3D =
NULL);
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct =
intel_svm_dev *sdev)
 {
@@ -5392,6 +5405,7 @@ const struct iommu_ops intel_iommu_ops =3D {
 	.remove_device		=3D intel_iommu_remove_device,
 	.get_resv_regions	=3D intel_iommu_get_resv_regions,
 	.put_resv_regions	=3D intel_iommu_put_resv_regions,
+	.apply_resv_region	=3D intel_iommu_apply_resv_region,
 	.device_group		=3D pci_device_group,
 	.pgsize_bitmap		=3D INTEL_IOMMU_PGSIZES,
 };
--=20
2.17.1
