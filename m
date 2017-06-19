From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 01/09] iommu/ipmmu-vmsa: Introduce features, break out alias
Date: Mon, 19 Jun 2017 18:13:56 +0900
Message-ID: <149786363603.14868.4644894466721476408.sendpatchset@little-apple>
References: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149786362527.14868.2143461703972595839.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce struct ipmmu_features to track various hardware
and software implementation changes inside the driver for
different kinds of IPMMU hardware. Add use_ns_alias_offset
as a first example of a feature to control if the secure
register bank offset should be used or not.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V3:
 - Use of_device_get_match_data(), thanks Robin!

 Changes since V2:
 - None

 Changes since V1:
 - Moved patch to front of the series

 drivers/iommu/ipmmu-vmsa.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

--- 0014/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-19 13:57:36.300607110 +0900
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -33,12 +34,16 @@
 
 #define IPMMU_CTX_MAX 1
 
+struct ipmmu_features {
+	bool use_ns_alias_offset;
+};
+
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
 	struct iommu_device iommu;
 	struct list_head list;
-
+	const struct ipmmu_features *features;
 	unsigned int num_utlbs;
 	spinlock_t lock;			/* Protects ctx and domains[] */
 	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
@@ -904,6 +909,21 @@ static void ipmmu_device_reset(struct ip
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
@@ -921,6 +941,7 @@ static int ipmmu_probe(struct platform_d
 	mmu->num_utlbs = 32;
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
+	mmu->features = of_device_get_match_data(&pdev->dev);
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -940,7 +961,8 @@ static int ipmmu_probe(struct platform_d
 	 * Offset the registers base unconditionally to point to the non-secure
 	 * alias space for now.
 	 */
-	mmu->base += IM_NS_ALIAS_OFFSET;
+	if (mmu->features->use_ns_alias_offset)
+		mmu->base += IM_NS_ALIAS_OFFSET;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -998,11 +1020,6 @@ static int ipmmu_remove(struct platform_
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
