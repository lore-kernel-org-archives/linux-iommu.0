From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v6 06/07] iommu/ipmmu-vmsa: ARM and ARM64 archdata access
Date: Thu, 20 Oct 2016 08:36:33 +0900
Message-ID: <20161019233633.10506.3943.sendpatchset@little-apple>
References: <20161019233533.10506.16810.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161019233533.10506.16810.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Not all architectures have an iommu member in their archdata, so
use #ifdefs support build wit COMPILE_TEST on any architecture.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---

 Changes since V5:
 - None

 Changes since V4:
 - None

 Changes since V3:
 - New patch

 drivers/iommu/ipmmu-vmsa.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

--- 0012/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-09-20 21:59:21.690607110 +0900
@@ -70,6 +70,25 @@ static struct ipmmu_vmsa_domain *to_vmsa
 	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
 }
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+static struct ipmmu_vmsa_archdata *to_archdata(struct device *dev)
+{
+	return dev->archdata.iommu;
+}
+static void set_archdata(struct device *dev, struct ipmmu_vmsa_archdata *p)
+{
+	dev->archdata.iommu = p;
+}
+#else
+static struct ipmmu_vmsa_archdata *to_archdata(struct device *dev)
+{
+	return NULL;
+}
+static void set_archdata(struct device *dev, struct ipmmu_vmsa_archdata *p)
+{
+}
+#endif
+
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
 
 /* -----------------------------------------------------------------------------
@@ -539,7 +558,7 @@ static void ipmmu_domain_free(struct iom
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
 	struct ipmmu_vmsa_device *mmu = archdata->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
@@ -581,7 +600,7 @@ static int ipmmu_attach_device(struct io
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned int i;
 
@@ -701,7 +720,7 @@ static int ipmmu_init_platform_device(st
 	archdata->mmu = mmu;
 	archdata->utlbs = utlbs;
 	archdata->num_utlbs = num_utlbs;
-	dev->archdata.iommu = archdata;
+	set_archdata(dev, archdata);
 	return 0;
 
 error:
@@ -713,12 +732,11 @@ error:
 
 static int ipmmu_add_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata;
 	struct ipmmu_vmsa_device *mmu = NULL;
 	struct iommu_group *group;
 	int ret;
 
-	if (dev->archdata.iommu) {
+	if (to_archdata(dev)) {
 		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
 			 dev_name(dev));
 		return -EINVAL;
@@ -754,8 +772,7 @@ static int ipmmu_add_device(struct devic
 	 * - Make the mapping size configurable ? We currently use a 2GB mapping
 	 *   at a 1GB offset to ensure that NULL VAs will fault.
 	 */
-	archdata = dev->archdata.iommu;
-	mmu = archdata->mmu;
+	mmu = to_archdata(dev)->mmu;
 	if (!mmu->mapping) {
 		struct dma_iommu_mapping *mapping;
 
@@ -783,7 +800,7 @@ error:
 	if (mmu)
 		arm_iommu_release_mapping(mmu->mapping);
 
-	dev->archdata.iommu = NULL;
+	set_archdata(dev, NULL);
 
 	if (!IS_ERR_OR_NULL(group))
 		iommu_group_remove_device(dev);
@@ -793,7 +810,7 @@ error:
 
 static void ipmmu_remove_device(struct device *dev)
 {
-	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_archdata *archdata = to_archdata(dev);
 
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
@@ -801,7 +818,7 @@ static void ipmmu_remove_device(struct d
 	kfree(archdata->utlbs);
 	kfree(archdata);
 
-	dev->archdata.iommu = NULL;
+	set_archdata(dev, NULL);
 }
 
 static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
