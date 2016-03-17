From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/10] iommu/ipmmu-vmsa: Introduce features, break out alias
Date: Fri, 18 Mar 2016 01:29:55 +0900
Message-ID: <20160317162955.24104.26177.sendpatchset@little-apple>
References: <20160317162909.24104.31682.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160317162909.24104.31682.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Introduce struct ipmmu_features to track various hardware
and software implementation changes inside the driver for
different kinds of IPMMU hardware. Add use_ns_alias_offset
as a first example of a feature to control if the secure
register bank offset should be used or not.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

--- 0017/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-03-18 00:29:15.860513000 +0900
@@ -33,6 +33,10 @@
 
 #define IPMMU_CTX_MAX 4
 
+struct ipmmu_features {
+	bool use_ns_alias_offset;
+};
+
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
@@ -45,6 +49,7 @@ struct ipmmu_vmsa_device {
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 	struct dma_iommu_mapping *mapping;
 #endif
+	const struct ipmmu_features *features;
 };
 
 struct ipmmu_vmsa_domain {
@@ -932,13 +937,33 @@ static void ipmmu_device_reset(struct ip
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
@@ -948,6 +973,7 @@ static int ipmmu_probe(struct platform_d
 	mmu->dev = &pdev->dev;
 	mmu->num_utlbs = 32;
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
+	mmu->features = match->data;
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 
 	/* Map I/O memory and request IRQ. */
@@ -968,7 +994,8 @@ static int ipmmu_probe(struct platform_d
 	 * Offset the registers base unconditionally to point to the non-secure
 	 * alias space for now.
 	 */
-	mmu->base += IM_NS_ALIAS_OFFSET;
+	if (mmu->features->use_ns_alias_offset)
+		mmu->base += IM_NS_ALIAS_OFFSET;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -1015,11 +1042,6 @@ static int ipmmu_remove(struct platform_
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
