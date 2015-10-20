From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/12] iommu/amd: Remove old alias handling code
Date: Tue, 20 Oct 2015 17:33:39 +0200
Message-ID: <1445355225-17557-7-git-send-email-joro@8bytes.org>
References: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445355225-17557-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This mostly removes the code to create dev_data structures
for alias device ids. They are not necessary anymore, as
they were only created for device ids which have no struct
pci_dev associated with it.  But these device ids are
handled in a simpler way now, so there is no need for this
code anymore.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 99 -----------------------------------------------
 1 file changed, 99 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 187a8bf..1a7c78d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -89,8 +89,6 @@ static struct dma_map_ops amd_iommu_dma_ops;
 struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct list_head dev_data_list;	  /* For global dev_data_list */
-	struct list_head alias_list;      /* Link alias-groups together */
-	struct iommu_dev_data *alias_data;/* The alias dev_data */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
@@ -136,8 +134,6 @@ static struct iommu_dev_data *alloc_dev_data(u16 devid)
 	if (!dev_data)
 		return NULL;
 
-	INIT_LIST_HEAD(&dev_data->alias_list);
-
 	dev_data->devid = devid;
 
 	spin_lock_irqsave(&dev_data_list_lock, flags);
@@ -147,17 +143,6 @@ static struct iommu_dev_data *alloc_dev_data(u16 devid)
 	return dev_data;
 }
 
-static void free_dev_data(struct iommu_dev_data *dev_data)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev_data_list_lock, flags);
-	list_del(&dev_data->dev_data_list);
-	spin_unlock_irqrestore(&dev_data_list_lock, flags);
-
-	kfree(dev_data);
-}
-
 static struct iommu_dev_data *search_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -311,73 +296,10 @@ out:
 	iommu_group_put(group);
 }
 
-static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
-{
-	*(u16 *)data = alias;
-	return 0;
-}
-
-static u16 get_alias(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	u16 devid, ivrs_alias, pci_alias;
-
-	devid = get_device_id(dev);
-	ivrs_alias = amd_iommu_alias_table[devid];
-	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
-
-	if (ivrs_alias == pci_alias)
-		return ivrs_alias;
-
-	/*
-	 * DMA alias showdown
-	 *
-	 * The IVRS is fairly reliable in telling us about aliases, but it
-	 * can't know about every screwy device.  If we don't have an IVRS
-	 * reported alias, use the PCI reported alias.  In that case we may
-	 * still need to initialize the rlookup and dev_table entries if the
-	 * alias is to a non-existent device.
-	 */
-	if (ivrs_alias == devid) {
-		if (!amd_iommu_rlookup_table[pci_alias]) {
-			amd_iommu_rlookup_table[pci_alias] =
-				amd_iommu_rlookup_table[devid];
-			memcpy(amd_iommu_dev_table[pci_alias].data,
-			       amd_iommu_dev_table[devid].data,
-			       sizeof(amd_iommu_dev_table[pci_alias].data));
-		}
-
-		return pci_alias;
-	}
-
-	pr_info("AMD-Vi: Using IVRS reported alias %02x:%02x.%d "
-		"for device %s[%04x:%04x], kernel reported alias "
-		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
-		PCI_FUNC(ivrs_alias), dev_name(dev), pdev->vendor, pdev->device,
-		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
-		PCI_FUNC(pci_alias));
-
-	/*
-	 * If we don't have a PCI DMA alias and the IVRS alias is on the same
-	 * bus, then the IVRS table may know about a quirk that we don't.
-	 */
-	if (pci_alias == devid &&
-	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
-		pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-		pdev->dma_alias_devfn = ivrs_alias & 0xff;
-		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
-			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
-			dev_name(dev));
-	}
-
-	return ivrs_alias;
-}
-
 static int iommu_init_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
-	u16 alias;
 
 	if (dev->archdata.iommu)
 		return 0;
@@ -386,24 +308,6 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
-	alias = get_alias(dev);
-
-	if (alias != dev_data->devid) {
-		struct iommu_dev_data *alias_data;
-
-		alias_data = find_dev_data(alias);
-		if (alias_data == NULL) {
-			pr_err("AMD-Vi: Warning: Unhandled device %s\n",
-					dev_name(dev));
-			free_dev_data(dev_data);
-			return -ENOTSUPP;
-		}
-		dev_data->alias_data = alias_data;
-
-		/* Add device to the alias_list */
-		list_add(&dev_data->alias_list, &alias_data->alias_list);
-	}
-
 	if (pci_iommuv2_capable(pdev)) {
 		struct amd_iommu *iommu;
 
@@ -445,9 +349,6 @@ static void iommu_uninit_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 
-	/* Unlink from alias, it may change if another device is re-plugged */
-	dev_data->alias_data = NULL;
-
 	/* Remove dma-ops */
 	dev->archdata.dma_ops = NULL;
 
-- 
1.9.1
