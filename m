From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 06/10] iommu/vt-d: Pass pasid table to context mapping
Date: Mon, 16 Jul 2018 14:49:49 +0800
Message-ID: <1531723793-14607-7-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

So that the pasid related info, such as the pasid table and the
maximum of pasid could be used during setting up scalable mode
context.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 62e9579..add7e3e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1918,6 +1918,7 @@ static void domain_exit(struct dmar_domain *domain)
 
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
+				      struct pasid_table *table,
 				      u8 bus, u8 devfn)
 {
 	u16 did = domain->iommu_did[iommu->seq_id];
@@ -2040,6 +2041,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 struct domain_context_mapping_data {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
+	struct pasid_table *table;
 };
 
 static int domain_context_mapping_cb(struct pci_dev *pdev,
@@ -2048,25 +2050,31 @@ static int domain_context_mapping_cb(struct pci_dev *pdev,
 	struct domain_context_mapping_data *data = opaque;
 
 	return domain_context_mapping_one(data->domain, data->iommu,
-					  PCI_BUS_NUM(alias), alias & 0xff);
+					  data->table, PCI_BUS_NUM(alias),
+					  alias & 0xff);
 }
 
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
+	struct domain_context_mapping_data data;
+	struct pasid_table *table;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
-	struct domain_context_mapping_data data;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
 
+	table = intel_pasid_get_table(dev);
+
 	if (!dev_is_pci(dev))
-		return domain_context_mapping_one(domain, iommu, bus, devfn);
+		return domain_context_mapping_one(domain, iommu, table,
+						  bus, devfn);
 
 	data.domain = domain;
 	data.iommu = iommu;
+	data.table = table;
 
 	return pci_for_each_dma_alias(to_pci_dev(dev),
 				      &domain_context_mapping_cb, &data);
-- 
2.7.4
