From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 1/3] iommu: Introduce iommu_group
Date: Mon, 02 Apr 2012 15:14:40 -0600
Message-ID: <20120402211440.28977.74440.stgit@bling.home>
References: <20120402203721.28977.95285.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120402203721.28977.95285.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

IOMMUs often do not have visibility of individual devices in the
system.  Due to IOMMU design, bus topology, or device quirks, we
can often only identify groups of devices.  Examples include
Intel VT-d & AMD-Vi which often have function level visibility
compared to POWER partitionable endpoints which have bridge level
granularity.  PCIe-to-PCI bridges also often cloud the IOMMU
visibility as it cannot distiguish devices behind the bridge.
Devices can also sometimes hurt themselves by initiating DMA using
the wrong source ID on a multifunction PCI device.

IOMMU groups are meant to help solve these problems and hopefully
become the working unit of the IOMMI API.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 include/linux/device.h |    2 ++
 include/linux/iommu.h  |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index b63fb39..6acab1c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -35,6 +35,7 @@ struct subsys_private;
 struct bus_type;
 struct device_node;
 struct iommu_ops;
+struct iommu_group;
 
 struct bus_attribute {
 	struct attribute	attr;
@@ -683,6 +684,7 @@ struct device {
 	const struct attribute_group **groups;	/* optional groups */
 
 	void	(*release)(struct device *dev);
+	struct iommu_group	*iommu_group;
 };
 
 /* Get the wakeup routines, which depend on struct device */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d937580..2ee375c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -26,6 +26,7 @@
 #define IOMMU_CACHE	(4) /* DMA cache coherency */
 
 struct iommu_ops;
+struct iommu_group;
 struct bus_type;
 struct device;
 struct iommu_domain;
@@ -78,6 +79,9 @@ struct iommu_ops {
 	unsigned long pgsize_bitmap;
 };
 
+struct iommu_group {
+};
+
 extern int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
@@ -140,6 +144,7 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
+struct iommu_group {};
 
 static inline bool iommu_present(struct bus_type *bus)
 {
