From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] iommu: return dma alias from iommu_group_get_for_pci_dev()
Date: Fri, 16 Jan 2015 16:58:33 +0000
Message-ID: <1421427514-16579-2-git-send-email-will.deacon@arm.com>
References: <1421427514-16579-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421427514-16579-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: m-karicheri2-l0cyMroinI0@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Some IOMMU drivers (e.g. the ARM SMMU) require not only the IOMMU group
for a PCI device, but also the effective alias of the device (as seen by
the IOMMU) in order to program the translations correctly.

This patch extends iommu_group_get_for_pci_dev to return the DMA alias
of the device as well as the group, which can potentially be overridden
by quirks in the PCI layer. The function is also made visible to drivers
so that the new functionality can be used.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu.c | 14 ++++++++++++--
 include/linux/iommu.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7718d73e984..5300b6507481 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -616,6 +616,7 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 struct group_for_pci_data {
 	struct pci_dev *pdev;
 	struct iommu_group *group;
+	u16 alias;
 };
 
 /*
@@ -628,6 +629,7 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
 
 	data->pdev = pdev;
 	data->group = iommu_group_get(&pdev->dev);
+	data->alias = alias;
 
 	return data->group != NULL;
 }
@@ -636,7 +638,8 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
  */
-static struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev)
+struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev,
+						u16 *alias)
 {
 	struct group_for_pci_data data;
 	struct pci_bus *bus;
@@ -653,6 +656,13 @@ static struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev)
 		return data.group;
 
 	pdev = data.pdev;
+	if (alias) {
+		u8 busn = PCI_BUS_NUM(pdev->bus->number);
+		if (pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)
+			*alias = PCI_DEVID(busn, pdev->dma_alias_devfn);
+		else
+			*alias = data.alias;
+	}
 
 	/*
 	 * Continue upstream from the point of minimum IOMMU granularity
@@ -717,7 +727,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (!dev_is_pci(dev))
 		return ERR_PTR(-EINVAL);
 
-	group = iommu_group_get_for_pci_dev(to_pci_dev(dev));
+	group = iommu_group_get_for_pci_dev(to_pci_dev(dev), NULL);
 
 	if (IS_ERR(group))
 		return group;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38daa453f2e5..1fe97d62a286 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -199,6 +199,8 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
 extern int iommu_group_id(struct iommu_group *group);
+extern struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *dev,
+						       u16 *alias);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 
 extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
-- 
2.1.4
