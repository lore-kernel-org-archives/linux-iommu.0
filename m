From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 01/10] iommu/ipmmu-vmsa: Refactor micro-TLB lookup
Date: Thu, 15 May 2014 12:40:42 +0200
Message-ID: <1400150451-13469-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Cache the micro-TLB number in archdata allocated in the .add_device
handler instead of looking it up when the deviced is attached and
detached. This simplifies the .attach_dev and .detach_dev operations and
prepares for DT support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 92 ++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index a8a940a..49e00f7 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -44,6 +44,11 @@ struct ipmmu_vmsa_domain {
 	pgd_t *pgd;
 };
 
+struct ipmmu_vmsa_archdata {
+	struct ipmmu_vmsa_device *mmu;
+	unsigned int utlb;
+};
+
 static DEFINE_SPINLOCK(ipmmu_devices_lock);
 static LIST_HEAD(ipmmu_devices);
 
@@ -265,14 +270,19 @@ static void ipmmu_tlb_invalidate(struct ipmmu_vmsa_domain *domain)
  * Enable MMU translation for the microTLB.
  */
 static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
-			      const struct ipmmu_vmsa_master *master)
+			      unsigned int utlb)
 {
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
 
+	/*
+	 * TODO: Reference-count the microTLB as several bus masters can be
+	 * connected to the same microTLB.
+	 */
+
 	/* TODO: What should we set the ASID to ? */
-	ipmmu_write(mmu, IMUASID(master->utlb), 0);
+	ipmmu_write(mmu, IMUASID(utlb), 0);
 	/* TODO: Do we need to flush the microTLB ? */
-	ipmmu_write(mmu, IMUCTR(master->utlb),
+	ipmmu_write(mmu, IMUCTR(utlb),
 		    IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
 		    IMUCTR_MMUEN);
 }
@@ -281,11 +291,11 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
  * Disable MMU translation for the microTLB.
  */
 static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
-			       const struct ipmmu_vmsa_master *master)
+			       unsigned int utlb)
 {
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
 
-	ipmmu_write(mmu, IMUCTR(master->utlb), 0);
+	ipmmu_write(mmu, IMUCTR(utlb), 0);
 }
 
 static void ipmmu_flush_pgtable(struct ipmmu_vmsa_device *mmu, void *addr,
@@ -674,21 +684,6 @@ static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
  * IOMMU Operations
  */
 
-static const struct ipmmu_vmsa_master *
-ipmmu_find_master(struct ipmmu_vmsa_device *ipmmu, struct device *dev)
-{
-	const struct ipmmu_vmsa_master *master = ipmmu->pdata->masters;
-	const char *devname = dev_name(dev);
-	unsigned int i;
-
-	for (i = 0; i < ipmmu->pdata->num_masters; ++i, ++master) {
-		if (strcmp(master->name, devname) == 0)
-			return master;
-	}
-
-	return NULL;
-}
-
 static int ipmmu_domain_init(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain;
@@ -727,9 +722,9 @@ static void ipmmu_domain_destroy(struct iommu_domain *io_domain)
 static int ipmmu_attach_device(struct iommu_domain *io_domain,
 			       struct device *dev)
 {
-	struct ipmmu_vmsa_device *mmu = dev->archdata.iommu;
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
+	struct ipmmu_vmsa_device *mmu = archdata->mmu;
 	struct ipmmu_vmsa_domain *domain = io_domain->priv;
-	const struct ipmmu_vmsa_master *master;
 	unsigned long flags;
 	int ret = 0;
 
@@ -759,11 +754,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	if (ret < 0)
 		return ret;
 
-	master = ipmmu_find_master(mmu, dev);
-	if (!master)
-		return -EINVAL;
-
-	ipmmu_utlb_enable(domain, master);
+	ipmmu_utlb_enable(domain, archdata->utlb);
 
 	return 0;
 }
@@ -771,14 +762,10 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
+	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct ipmmu_vmsa_domain *domain = io_domain->priv;
-	const struct ipmmu_vmsa_master *master;
 
-	master = ipmmu_find_master(domain->mmu, dev);
-	if (!master)
-		return;
-
-	ipmmu_utlb_disable(domain, master);
+	ipmmu_utlb_disable(domain, archdata->utlb);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
@@ -839,11 +826,26 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
 }
 
+static int ipmmu_find_utlb(struct ipmmu_vmsa_device *mmu, struct device *dev)
+{
+	const struct ipmmu_vmsa_master *master = mmu->pdata->masters;
+	const char *devname = dev_name(dev);
+	unsigned int i;
+
+	for (i = 0; i < mmu->pdata->num_masters; ++i, ++master) {
+		if (strcmp(master->name, devname) == 0)
+			return master->utlb;
+	}
+
+	return -1;
+}
+
 static int ipmmu_add_device(struct device *dev)
 {
-	const struct ipmmu_vmsa_master *master = NULL;
+	struct ipmmu_vmsa_archdata *archdata;
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_group *group;
+	int utlb = -1;
 	int ret;
 
 	if (dev->archdata.iommu) {
@@ -856,10 +858,10 @@ static int ipmmu_add_device(struct device *dev)
 	spin_lock(&ipmmu_devices_lock);
 
 	list_for_each_entry(mmu, &ipmmu_devices, list) {
-		master = ipmmu_find_master(mmu, dev);
-		if (master) {
+		utlb = ipmmu_find_utlb(mmu, dev);
+		if (utlb >= 0) {
 			/*
-			 * TODO Take a reference to the master to protect
+			 * TODO Take a reference to the MMU to protect
 			 * against device removal.
 			 */
 			break;
@@ -868,10 +870,10 @@ static int ipmmu_add_device(struct device *dev)
 
 	spin_unlock(&ipmmu_devices_lock);
 
-	if (!master)
+	if (utlb < 0)
 		return -ENODEV;
 
-	if (!master->utlb >= mmu->num_utlbs)
+	if (utlb >= mmu->num_utlbs)
 		return -EINVAL;
 
 	/* Create a device group and add the device to it. */
@@ -889,7 +891,15 @@ static int ipmmu_add_device(struct device *dev)
 		return ret;
 	}
 
-	dev->archdata.iommu = mmu;
+	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
+	if (!archdata) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	archdata->mmu = mmu;
+	archdata->utlb = utlb;
+	dev->archdata.iommu = archdata;
 
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
@@ -923,6 +933,7 @@ static int ipmmu_add_device(struct device *dev)
 	return 0;
 
 error:
+	kfree(dev->archdata.iommu);
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
 	return ret;
@@ -932,6 +943,7 @@ static void ipmmu_remove_device(struct device *dev)
 {
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
+	kfree(dev->archdata.iommu);
 	dev->archdata.iommu = NULL;
 }
 
-- 
1.8.5.5

