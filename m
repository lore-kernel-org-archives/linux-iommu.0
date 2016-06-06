From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 01/11] iommu/ipmmu-vmsa: Introduce features, break out alias
Date: Mon, 06 Jun 2016 12:57:32 +0900
Message-ID: <20160606035732.31763.39717.sendpatchset@little-apple>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160606035723.31763.66500.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce struct ipmmu_features to track various hardware
and software implementation changes inside the driver for
different kinds of IPMMU hardware. Add use_ns_alias_offset
as a first example of a feature to control if the secure
register bank offset should be used or not.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V1:
 - Moved patch to front of the series

 drivers/iommu/ipmmu-vmsa.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

--- 0008/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 10:08:53.410607110 +0900
@@ -32,11 +32,15 @@
 
 #define IPMMU_CTX_MAX 1
 
+struct ipmmu_features {
+	bool use_ns_alias_offset;
+};
+
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
 	struct list_head list;
-
+	const struct ipmmu_features *features;
 	unsigned int num_utlbs;
 	spinlock_t lock;			/* Protects ctx and domains[] */
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
@@ -929,13 +933,33 @@ static void ipmmu_device_reset(struct ip
 		ipmmu_write(mmu, i * IM_CTX_SIZE + IMCTR, 0);
 }
 
+static const struct ipmmu_features ipmmu_features_default = {
+	.use_ns_alias_offset = true,
+};
+
+static const struct of_device_id ipmmu_of_ids[] = {
+	{
+		.compatible = "renesas,ipmmu-vmsa",
+		.data = &ipmmu_features_default,
+	}, {
+		/* Terminator */
+	},
+};
+
+MODULE_DEVICE_TABLE(of, ipmmu_of_ids);
+
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu;
+	const struct of_device_id *match;
 	struct resource *res;
 	int irq;
 	int ret;
 
+	match = of_match_node(ipmmu_of_ids, pdev->dev.of_node);
+	if (!match)
+		return -EINVAL;
+
 	mmu = devm_kzalloc(&pdev->dev, sizeof(*mmu), GFP_KERNEL);
 	if (!mmu) {
 		dev_err(&pdev->dev, "cannot allocate device data\n");
@@ -946,6 +970,7 @@ static int ipmmu_probe(struct platform_d
 	mmu->num_utlbs = 32;
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
+	mmu->features = match->data;
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -965,7 +990,8 @@ static int ipmmu_probe(struct platform_d
 	 * Offset the registers base unconditionally to point to the non-secure
 	 * alias space for now.
 	 */
-	mmu->base += IM_NS_ALIAS_OFFSET;
+	if (mmu->features->use_ns_alias_offset)
+		mmu->base += IM_NS_ALIAS_OFFSET;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -1014,11 +1040,6 @@ static int ipmmu_remove(struct platform_
 	return 0;
 }
 
-static const struct of_device_id ipmmu_of_ids[] = {
-	{ .compatible = "renesas,ipmmu-vmsa", },
-	{ }
-};
-
 static struct platform_driver ipmmu_driver = {
 	.driver = {
 		.name = "ipmmu-vmsa",
