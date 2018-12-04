From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 5/9] iommu/ipmmu-vmsa: Use helper functions to access dev->iommu_fwspec
Date: Tue,  4 Dec 2018 17:29:58 +0100
Message-ID: <20181204163002.15800-6-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/ipmmu-vmsa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ddf3a492e1d5..679f18bf0634 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -81,7 +81,9 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 
 static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 {
-	return dev->iommu_fwspec ? dev->iommu_fwspec->iommu_priv : NULL;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	return fwspec ? fwspec->iommu_priv : NULL;
 }
 
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
@@ -643,7 +645,7 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
@@ -692,7 +694,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
 
@@ -744,13 +746,15 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 static int ipmmu_init_platform_device(struct device *dev,
 				      struct of_phandle_args *args)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct platform_device *ipmmu_pdev;
 
 	ipmmu_pdev = of_find_device_by_node(args->np);
 	if (!ipmmu_pdev)
 		return -ENODEV;
 
-	dev->iommu_fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
+	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
+
 	return 0;
 }
 
-- 
2.17.1
