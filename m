From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH] iommu/ipmmu-vmsa: Unify domain alloc/free implementations
Date: Fri, 11 Nov 2016 04:01:02 +0200
Message-ID: <1478829662-19689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <20161019233623.10506.49016.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161019233623.10506.49016.sendpatchset@little-apple>
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
Cc: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM and ARM64 implementations of the IOMMU domain alloc/free
operations can be unified with the correct combination of type checking,
as the domain type can never be IOMMU_DOMAIN_DMA on 32-bit ARM due to
the driver calling iommu_group_get_for_dev() on ARM64 only. Do so.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 58 +++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

Hi Magnus,

This cleans up patch 5/7, making patch 4/7 unnecessary. I proposed squashing
4/7, 5/7 and this one in v7.

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 11550ac90d65..827aa72aaf28 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -529,16 +529,22 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
  * IOMMU Operations
  */
 
-static struct iommu_domain *__ipmmu_domain_alloc(unsigned type)
+static struct iommu_domain *ipmmu_domain_alloc(unsigned int type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
+		return NULL;
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
 	spin_lock_init(&domain->lock);
 
+	if (type == IOMMU_DOMAIN_DMA)
+		iommu_get_dma_cookie(&domain->io_domain);
+
 	return &domain->io_domain;
 }
 
@@ -546,6 +552,9 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+	if (io_domain->type)
+		iommu_put_dma_cookie(io_domain);
+
 	/*
 	 * Free the domain resources. We assume that all devices have already
 	 * been detached.
@@ -821,14 +830,6 @@ static void ipmmu_remove_device(struct device *dev)
 	set_archdata(dev, NULL);
 }
 
-static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
-{
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
-
-	return __ipmmu_domain_alloc(type);
-}
-
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
 	.domain_free = ipmmu_domain_free,
@@ -847,42 +848,11 @@ static const struct iommu_ops ipmmu_ops = {
 
 #ifdef CONFIG_IOMMU_DMA
 
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
 
-	/* only accept devices with iommus property */
+	/* Only accept devices with an iommus property. */
 	if (of_count_phandle_with_args(dev->of_node, "iommus",
 				       "#iommu-cells") < 0)
 		return -ENODEV;
@@ -920,13 +890,13 @@ static struct iommu_group *ipmmu_device_group_dma(struct device *dev)
 static int ipmmu_of_xlate_dma(struct device *dev,
 			      struct of_phandle_args *spec)
 {
-	/* dummy callback to satisfy of_iommu_configure() */
+	/* Dummy callback to satisfy of_iommu_configure(). */
 	return 0;
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
Regards,

Laurent Pinchart
