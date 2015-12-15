From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC 01/10] iommu/ipmmu-vmsa: Introduce features, break out alias
Date: Tue, 15 Dec 2015 22:05:18 +0900
Message-ID: <20151215130518.13535.13822.sendpatchset@little-apple>
References: <20151215130508.13535.26186.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215130508.13535.26186.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Introduce struct ipmmu_features to track various hardware
and software implementation changes inside the driver for
various kinds of IPMMU hardware. Add use_ns_alias_offset
as a first example of a feature to control if the secure
register bank offset should be used or not.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

--- 0009/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 13:41:22.600513000 +0900
@@ -31,6 +31,10 @@
 
 #define IPMMU_CTX_MAX 1
 
+struct ipmmu_features {
+	bool use_ns_alias_offset;
+};
+
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
@@ -43,6 +47,7 @@ struct ipmmu_vmsa_device {
 #ifdef CONFIG_ARM
 	struct dma_iommu_mapping *mapping;
 #endif
+	const struct ipmmu_features *features;
 };
 
 struct ipmmu_vmsa_domain {
@@ -817,13 +822,33 @@ static void ipmmu_device_reset(struct ip
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
@@ -833,6 +858,7 @@ static int ipmmu_probe(struct platform_d
 	mmu->dev = &pdev->dev;
 	mmu->num_utlbs = 32;
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
+	mmu->features = match->data;
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -852,7 +878,8 @@ static int ipmmu_probe(struct platform_d
 	 * Offset the registers base unconditionally to point to the non-secure
 	 * alias space for now.
 	 */
-	mmu->base += IM_NS_ALIAS_OFFSET;
+	if (mmu->features->use_ns_alias_offset)
+		mmu->base += IM_NS_ALIAS_OFFSET;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -899,11 +926,6 @@ static int ipmmu_remove(struct platform_
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
