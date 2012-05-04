From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Fri, 4 May 2012 08:23:53 +0300
Message-ID: <20120504082353.0aa40c8ebb7f3548f665404c@nvidia.com>
References: <1334588670-15124-1-git-send-email-thierry.reding@avionic-design.de>
	<4FA2CE32.7010406@wwwdotorg.org>
	<4FA2D55F.2090708@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA2D55F.2090708-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 3 May 2012 20:58:39 +0200
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 05/03/2012 12:28 PM, Stephen Warren wrote:
> > On 04/16/2012 09:04 AM, Thierry Reding wrote:
> >> This commit adds the device node required to probe NVIDIA Tegra 20 GART
> >> hardware from the device tree.
> > 
> >> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> > 
> >> +	gart: gart@7000f000 {
> >> +		compatible = "nvidia,tegra20-gart";
> >> +		reg = < 0x7000f000 0x00000100    /* controller registers */
> >> +		        0x58000000 0x02000000 >; /* GART aperture */
> >> +	};
> ...
> > As such, I think this node should be more like:
> > 
> > mc: mc@7000f000 {
> >     compatible = "nvidia,tegra20-mc";
> >     reg = <0x7000f000 0x00000100>;
> > };
> > 
> > Then, one of following options can be taken:
> [to represent the fact that MC and GART are essentially the same HW module]
> ...
> 
> Yet another option is to explicitly use the MFD subsystem for this; I
> guess options 1 and 3 that I gave were essentially open-coding MFD anyway.
> 
> Offline, Hiroshi mentioned that he had looked at MFD, and ended up
> thinking it was a rather heavy-weight solution in this case though.

It's because we just spawns a single child device(SMMU) from MC. I
guess that MFD framework would be more beneficial when it spawns
multiple/many children(?). 

Here's my MFD experiment:

>From 720331a8d54052da3ee214dd80193b9c853b9d93 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Wed, 2 May 2012 13:36:10 +0300
Subject: [PATCH 1/1] ARM: tegra: Memory Controller(MC) adds IOMMU device via
 MFD

Tegra IOMMU devices(GART/SMMU) share some resources with MC. Those
IOMMUs can be considered as a part of MC. MC adds GART/SMMU as its
child device at probe().

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-tegra/tegra-mc.c |   31 +++++++++++++++++++-----
 drivers/iommu/tegra-smmu.c     |   50 +++++++++++++++++++++++++++++----------
 2 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra-mc.c b/arch/arm/mach-tegra/tegra-mc.c
index 7af2a99..eb95dce 100644
--- a/arch/arm/mach-tegra/tegra-mc.c
+++ b/arch/arm/mach-tegra/tegra-mc.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/mfd/core.h>
 
 #define DRV_NAME "tegra-mc"
 
@@ -107,6 +108,7 @@ struct tegra_mc_info {
 	const char * const *client;
 	int num_client;
 	u32 id_mask;
+	struct mfd_cell iommu;
 };
 
 struct tegra_mc {
@@ -228,6 +230,9 @@ static struct tegra_mc_info tegra20_mc_info = {
 	.client = tegra20_mc_client,
 	.num_client = ARRAY_SIZE(tegra20_mc_client),
 	.id_mask = 0x3f,
+	.iommu = {
+		.name	= "tegra-gart",
+	},
 };
 #else
 static struct tegra_mc_info tegra20_mc_info = {};
@@ -354,6 +359,9 @@ static struct tegra_mc_info tegra30_mc_info = {
 	.client = tegra30_mc_client,
 	.num_client = ARRAY_SIZE(tegra30_mc_client),
 	.id_mask = 0x7f,
+	.iommu = {
+		.name	= "tegra-smmu",
+	},
 };
 
 static u32 tegra_mc_ctx[] = {
@@ -437,7 +445,7 @@ static irqreturn_t tegra_mc_isr(int irq, void *data)
 
 static int __devinit tegra_mc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
+	struct resource *mem, *irq;
 	struct tegra_mc *mc;
 	size_t bytes;
 	int err;
@@ -450,17 +458,18 @@ static int __devinit tegra_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	mc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
 		return -ENODEV;
-	mc->regs = devm_request_and_ioremap(&pdev->dev, res);
+	mc->regs = devm_request_and_ioremap(&pdev->dev, mem);
 	if (!mc->regs)
 		return -EBUSY;
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res)
+	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!irq)
 		return -ENODEV;
-	err = devm_request_irq(&pdev->dev, res->start, tegra_mc_isr,
+
+	err = devm_request_irq(&pdev->dev, irq->start, tegra_mc_isr,
 			       IRQF_SHARED, dev_name(&pdev->dev), mc);
 	if (err)
 		return -ENODEV;
@@ -473,6 +482,14 @@ static int __devinit tegra_mc_probe(struct platform_device *pdev)
 	info = id->data;
 	if (!info)
 		return -EINVAL;
+
+	if (&info->iommu) {
+		err = mfd_add_devices(&pdev->dev, pdev->id, &info->iommu, 1,
+				      NULL, irq->start);
+		if (err)
+			return -ENODEV;
+	}
+
 	mc->info = info;
 	info->intmask |= MC_INT_DECERR_EMEM | MC_INT_SECURITY_VIOLATION;
 	mc_writel(mc, info->intmask, MC_INTMASK);
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c70e4e7..21c15bb 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -31,6 +31,7 @@
 #include <linux/iommu.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
@@ -113,7 +114,6 @@
 
 #define SMMU_PDE_NEXT_SHIFT		28
 
-#define SMMU_NUM_ASIDS				4
 #define SMMU_TLB_FLUSH_VA_SECTION__MASK		0xffc00000
 #define SMMU_TLB_FLUSH_VA_SECTION__SHIFT	12 /* right shift */
 #define SMMU_TLB_FLUSH_VA_GROUP__MASK		0xffffc000
@@ -872,21 +872,38 @@ static int tegra_smmu_resume(struct device *dev)
 static int tegra_smmu_probe(struct platform_device *pdev)
 {
 	struct smmu_device *smmu;
-	struct resource *regs, *window;
 	struct device *dev = &pdev->dev;
-	int i, err = 0;
+	int i, asids, err = 0;
+	dma_addr_t base;
+	size_t size;
+	const void *prop;
+	struct device_node *mc;
+	struct resource *res;
 
 	if (smmu_handle)
 		return -EIO;
 
 	BUILD_BUG_ON(PAGE_SHIFT != SMMU_PAGE_SHIFT);
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	window = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!regs || !window) {
-		dev_err(dev, "No SMMU resources\n");
+	mc = pdev->dev.parent->of_node;
+	if (!mc)
+		return -ENODEV;
+
+	err = of_get_dma_window(mc, "dma-window", 0, NULL,
+				&base, &size);
+	if (err)
+		return -ENODEV;
+
+	size >>= SMMU_PAGE_SHIFT;
+	if (!size)
+		return -ENODEV;
+
+	prop = of_get_property(mc, "nvidia,#asids", NULL);
+	if (!prop)
+		return -ENODEV;
+	asids = be32_to_cpup(prop);
+	if (!asids)
 		return -ENODEV;
-	}
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -895,17 +912,23 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	}
 
 	smmu->dev = dev;
-	smmu->num_as = SMMU_NUM_ASIDS;
-	smmu->iovmm_base = (unsigned long)window->start;
-	smmu->page_count = resource_size(window) >> SMMU_PAGE_SHIFT;
-	smmu->regs = devm_ioremap(dev, regs->start, resource_size(regs));
+	smmu->num_as = asids;
+	smmu->iovmm_base = base;
+	smmu->page_count = size;
+
+	res = platform_get_resource(to_platform_device(pdev->dev.parent),
+				    IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	smmu->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!smmu->regs) {
 		dev_err(dev, "failed to remap SMMU registers\n");
 		err = -ENXIO;
 		goto fail;
 	}
 
-	smmu->ahb = of_parse_phandle(pdev->dev.of_node, "ahb", 0);
+	smmu->ahb = of_parse_phandle(mc, "ahb", 0);
 	if (!smmu->ahb)
 		return -ENODEV;
 
@@ -1019,4 +1042,5 @@ module_exit(tegra_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_ALIAS("platform:tegra-smmu");
 MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
