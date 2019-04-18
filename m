From: Julien Grall <julien.grall-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two parts
Date: Thu, 18 Apr 2019 18:26:06 +0100
Message-ID: <20190418172611.21561-3-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190418172611.21561-1-julien.grall-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, douliyangs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Julien Grall <julien.grall-5wv7dgnIgG8@public.gmane.org>, miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On RT, the function iommu_dma_map_msi_msg may be called from
non-preemptible context. This will lead to a splat with
CONFIG_DEBUG_ATOMIC_SLEEP as the function is using spin_lock
(they can sleep on RT).

The function iommu_dma_map_msi_msg is used to map the MSI page in the
IOMMU PT and update the MSI message with the IOVA.

Only the part to lookup for the MSI page requires to be called in
preemptible context. As the MSI page cannot change over the lifecycle
of the MSI interrupt, the lookup can be cached and re-used later on.

This patch split the function iommu_dma_map_msi_msg in two new
functions:
    - iommu_dma_prepare_msi: This function will prepare the mapping in
    the IOMMU and store the cookie in the structure msi_desc. This
    function should be called in preemptible context.
    - iommu_dma_compose_msi_msg: This function will update the MSI
    message with the IOVA when the device is behind an IOMMU.

Signed-off-by: Julien Grall <julien.grall-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 43 ++++++++++++++++++++++++++++++++-----------
 include/linux/dma-iommu.h | 21 +++++++++++++++++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe637a60..f5c1f1685095 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -888,17 +888,17 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
-	struct device *dev = msi_desc_to_dev(irq_get_msi_desc(irq));
+	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie;
-	struct iommu_dma_msi_page *msi_page;
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
 	unsigned long flags;
 
-	if (!domain || !domain->iova_cookie)
-		return;
+	if (!domain || !domain->iova_cookie) {
+		desc->iommu_cookie = NULL;
+		return 0;
+	}
 
 	cookie = domain->iova_cookie;
 
@@ -908,10 +908,33 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 	 * of an MSI from within an IPI handler.
 	 */
 	spin_lock_irqsave(&cookie->msi_lock, flags);
-	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
+	desc->iommu_cookie = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	spin_unlock_irqrestore(&cookie->msi_lock, flags);
 
-	if (WARN_ON(!msi_page)) {
+	return (desc->iommu_cookie) ? 0 : -ENOMEM;
+}
+
+void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	struct device *dev = msi_desc_to_dev(desc);
+	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_dma_msi_page *msi_page = desc->iommu_cookie;
+
+	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
+		return;
+
+	msg->address_hi = upper_32_bits(msi_page->iova);
+	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
+	msg->address_lo += lower_32_bits(msi_page->iova);
+}
+
+void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
 		/*
 		 * We're called from a void callback, so the best we can do is
 		 * 'fail' by filling the message with obviously bogus values.
@@ -922,8 +945,6 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->address_lo = ~0U;
 		msg->data = ~0U;
 	} else {
-		msg->address_hi = upper_32_bits(msi_page->iova);
-		msg->address_lo &= cookie_msi_granule(cookie) - 1;
-		msg->address_lo += lower_32_bits(msi_page->iova);
+		iommu_dma_compose_msi_msg(irq, msg);
 	}
 }
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..2f4b2c2cc859 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -71,12 +71,23 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 /* The DMA API isn't _quite_ the whole story, though... */
+/*
+ * Map the MSI page in the IOMMU device and store it in @desc
+ *
+ * Return 0 if succeeded other an error if the preparation has failed.
+ */
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+
+/* Update the MSI message if required. */
+void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg);
+
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
 
 struct iommu_domain;
+struct msi_desc;
 struct msi_msg;
 struct device;
 
@@ -99,6 +110,16 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
+					phys_addr_t msi_addr)
+{
+	return 0;
+}
+
+static inline void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg)
+{
+}
+
 static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 {
 }
-- 
2.11.0
