From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/8] iommu: Add generic_device_group() function
Date: Wed, 21 Oct 2015 23:51:38 +0200
Message-ID: <1445464303-18206-4-git-send-email-joro@8bytes.org>
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

This function can be used as a device_group call-back and
just allocates one iommu-group per device.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 15 +++++++++++++++
 include/linux/iommu.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fdea700..a80c9c5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -728,6 +728,21 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
 }
 
 /*
+ * Generic device_group call-back function. It just allocates one
+ * iommu-group per device.
+ */
+struct iommu_group *generic_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+
+	group = iommu_group_alloc();
+	if (IS_ERR(group))
+		return NULL;
+
+	return group;
+}
+
+/*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
  */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8026e6a..c73824f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -318,6 +318,8 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 
 /* PCI device grouping function */
 extern struct iommu_group *pci_device_group(struct device *dev);
+/* Generic device grouping function */
+extern struct iommu_group *generic_device_group(struct device *dev);
 
 #else /* CONFIG_IOMMU_API */
 
-- 
1.9.1
