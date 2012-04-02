From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 3/3] iommu: Create attach/detach group interface
Date: Mon, 02 Apr 2012 15:14:55 -0600
Message-ID: <20120402211454.28977.32677.stgit@bling.home>
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

IOMMU ops should be working at a group level rather than a device
level as we cannot arbitrarily assign devices from the same group
to different domains.  For now this is just a simple wrapper that
makes use of the dma_dev within a group.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/iommu.c |   12 ++++++++++++
 include/linux/iommu.h |   15 +++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6a51ed9..af77da1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -327,6 +327,18 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
+int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
+{
+	return iommu_attach_device(domain, group->dma_dev);
+}
+EXPORT_SYMBOL_GPL(iommu_attach_group);
+
+void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
+{
+	iommu_detach_device(domain, group->dma_dev);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_group);
+
 phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
 			       unsigned long iova)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 24004d6..d4e9a7a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -107,6 +107,10 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_attach_group(struct iommu_domain *domain,
+			      struct iommu_group *group);
+extern void iommu_detach_group(struct iommu_domain *domain,
+			       struct iommu_group *group);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
@@ -194,6 +198,17 @@ static inline void iommu_detach_device(struct iommu_domain *domain,
 {
 }
 
+static inline int iommu_attach_group(struct iommu_domain *domain,
+				     struct iommu_group *group)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_detach_group(struct iommu_domain *domain,
+				      struct iommu_group *group)
+{
+}
+
 static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, int gfp_order, int prot)
 {
