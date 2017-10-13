From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/4] iommu/ipmmu-vmsa: Unify domain alloc/free
Date: Fri, 13 Oct 2017 19:23:39 +0100
Message-ID: <764101fdd58e798686186e094e7574c41379c942.1507918320.git.robin.murphy@arm.com>
References: <cover.1507918320.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1507918320.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We have two implementations for ipmmu_ops->alloc depending on
CONFIG_IOMMU_DMA, the difference being whether they accept the
IOMMU_DOMAIN_DMA type or not. However, iommu_dma_get_cookie() is
guaranteed to return an error when !CONFIG_IOMMU_DMA, so if
ipmmu_domain_alloc_dma() was actually checking and handling the return
value correctly, it would behave the same as ipmmu_domain_alloc()
anyway.

Similarly for freeing; iommu_put_dma_cookie() is robust by design.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 65 +++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 0bef160de7dd..dedb386fa81d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -528,6 +528,27 @@ static struct iommu_domain *__ipmmu_domain_alloc(unsigned type)
 	return &domain->io_domain;
 }
 
+static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
+{
+	struct iommu_domain *io_domain = NULL;
+
+	switch (type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		io_domain = __ipmmu_domain_alloc(type);
+		break;
+
+	case IOMMU_DOMAIN_DMA:
+		io_domain = __ipmmu_domain_alloc(type);
+		if (io_domain && iommu_get_dma_cookie(io_domain)) {
+			kfree(io_domain);
+			io_domain = NULL;
+		}
+		break;
+	}
+
+	return io_domain;
+}
+
 static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
@@ -536,6 +557,7 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 	 * Free the domain resources. We assume that all devices have already
 	 * been detached.
 	 */
+	iommu_put_dma_cookie(io_domain);
 	ipmmu_domain_destroy_context(domain);
 	free_io_pgtable_ops(domain->iop);
 	kfree(domain);
@@ -671,14 +693,6 @@ static int ipmmu_of_xlate(struct device *dev,
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 
-static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
-{
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
-	return __ipmmu_domain_alloc(type);
-}
-
 static int ipmmu_add_device(struct device *dev)
 {
 	struct ipmmu_vmsa_device *mmu = NULL;
@@ -779,37 +793,6 @@ static const struct iommu_ops ipmmu_ops = {
 static DEFINE_SPINLOCK(ipmmu_slave_devices_lock);
 static LIST_HEAD(ipmmu_slave_devices);
 
-static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
-{
-	struct iommu_domain *io_domain = NULL;
-
-	switch (type) {
-	case IOMMU_DOMAIN_UNMANAGED:
-		io_domain = __ipmmu_domain_alloc(type);
-		break;
-
-	case IOMMU_DOMAIN_DMA:
-		io_domain = __ipmmu_domain_alloc(type);
-		if (io_domain)
-			iommu_get_dma_cookie(io_domain);
-		break;
-	}
-
-	return io_domain;
-}
-
-static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
-{
-	switch (io_domain->type) {
-	case IOMMU_DOMAIN_DMA:
-		iommu_put_dma_cookie(io_domain);
-		/* fall-through */
-	default:
-		ipmmu_domain_free(io_domain);
-		break;
-	}
-}
-
 static int ipmmu_add_device_dma(struct device *dev)
 {
 	struct iommu_group *group;
@@ -878,8 +861,8 @@ static struct iommu_group *ipmmu_find_group_dma(struct device *dev)
 }
 
 static const struct iommu_ops ipmmu_ops = {
-	.domain_alloc = ipmmu_domain_alloc_dma,
-	.domain_free = ipmmu_domain_free_dma,
+	.domain_alloc = ipmmu_domain_alloc,
+	.domain_free = ipmmu_domain_free,
 	.attach_dev = ipmmu_attach_device,
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
-- 
2.13.4.dirty
