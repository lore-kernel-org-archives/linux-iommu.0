From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/8] iommu: Export and rename iommu_group_get_for_pci_dev()
Date: Wed, 21 Oct 2015 23:51:37 +0200
Message-ID: <1445464303-18206-3-git-send-email-joro@8bytes.org>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445464303-18206-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Rename that function to pci_device_group() and export it, so
that IOMMU drivers can use it as their device_group
call-back.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 8 ++++++--
 include/linux/iommu.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5637463..fdea700 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -731,13 +731,17 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
  */
-static struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev)
+struct iommu_group *pci_device_group(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct group_for_pci_data data;
 	struct pci_bus *bus;
 	struct iommu_group *group = NULL;
 	u64 devfns[4] = { 0 };
 
+	if (WARN_ON(!dev_is_pci(dev)))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Find the upstream DMA alias for the device.  A device must not
 	 * be aliased due to topology in order to have its own IOMMU group.
@@ -827,7 +831,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (ops && ops->device_group)
 		group = ops->device_group(dev);
 	else if (dev_is_pci(dev))
-		group = iommu_group_get_for_pci_dev(to_pci_dev(dev));
+		group = pci_device_group(dev);
 
 	if (IS_ERR(group))
 		return group;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5a19952..8026e6a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -316,6 +316,9 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 	return domain->ops->map_sg(domain, iova, sg, nents, prot);
 }
 
+/* PCI device grouping function */
+extern struct iommu_group *pci_device_group(struct device *dev);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
1.9.1
