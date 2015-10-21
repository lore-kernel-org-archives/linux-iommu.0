From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/8] iommu: Revive device_group iommu-ops call-back
Date: Wed, 21 Oct 2015 23:51:36 +0200
Message-ID: <1445464303-18206-2-git-send-email-joro@8bytes.org>
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

That call-back is currently unused, change it into a
call-back function for finding the right IOMMU group for a
device.
This is a first step to remove the hard-coded PCI dependency
in the iommu-group code.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 9 ++++++---
 include/linux/iommu.h | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 049df49..5637463 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -814,6 +814,7 @@ static struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev)
  */
 struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct iommu_group *group;
 	int ret;
 
@@ -821,10 +822,12 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (group)
 		return group;
 
-	if (!dev_is_pci(dev))
-		return ERR_PTR(-EINVAL);
+	group = ERR_PTR(-EINVAL);
 
-	group = iommu_group_get_for_pci_dev(to_pci_dev(dev));
+	if (ops && ops->device_group)
+		group = ops->device_group(dev);
+	else if (dev_is_pci(dev))
+		group = iommu_group_get_for_pci_dev(to_pci_dev(dev));
 
 	if (IS_ERR(group))
 		return group;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f9c1b6d..5a19952 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -167,7 +167,7 @@ struct iommu_ops {
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
-	int (*device_group)(struct device *dev, unsigned int *groupid);
+	struct iommu_group *(*device_group)(struct device *dev);
 	int (*domain_get_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
 	int (*domain_set_attr)(struct iommu_domain *domain,
-- 
1.9.1
