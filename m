From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/6] ARM: Exynos: pm_domains: register power domain driver from
 core_initcall
Date: Mon, 01 Jun 2015 12:10:45 +0200
Message-ID: <1433153450-3680-2-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433153450-3680-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: iommu@lists.linux-foundation.org

SYSMMU devices are registered very early in arch_initcall, so ensure
that they can get access to power domains by registering power domain
driver from earlier initcall. This change requires dropping usage of the
platform device associated with each power domain and replacing clock
calls with respective of_clk_* equivalents.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 1639645bddeb..6001f1c9d136 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -121,22 +121,11 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 
 static __init int exynos4_pm_init_power_domain(void)
 {
-	struct platform_device *pdev;
 	struct device_node *np;
 
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
 		int on, i;
-		struct device *dev;
-
-		pdev = of_find_device_by_node(np);
-		if (!pdev) {
-			pr_err("%s: failed to find device for node %s\n",
-					__func__, np->name);
-			of_node_put(np);
-			continue;
-		}
-		dev = &pdev->dev;
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
@@ -145,8 +134,8 @@ static __init int exynos4_pm_init_power_domain(void)
 			of_node_put(np);
 			return -ENOMEM;
 		}
-
-		pd->pd.name = kstrdup(dev_name(dev), GFP_KERNEL);
+		pd->pd.name = kstrdup_const(strrchr(np->full_name, '/') + 1,
+					    GFP_KERNEL);
 		if (!pd->pd.name) {
 			kfree(pd);
 			of_node_put(np);
@@ -156,7 +145,7 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
 		if (!pd->base) {
-			dev_warn(&pdev->dev, "Failed to map memory\n");
+			pr_warn("%s: failed to map memory\n", __func__);
 			kfree(pd->pd.name);
 			kfree(pd);
 			of_node_put(np);
@@ -170,12 +159,12 @@ static __init int exynos4_pm_init_power_domain(void)
 			char clk_name[8];
 
 			snprintf(clk_name, sizeof(clk_name), "asb%d", i);
-			pd->asb_clk[i] = clk_get(dev, clk_name);
+			pd->asb_clk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->asb_clk[i]))
 				break;
 		}
 
-		pd->oscclk = clk_get(dev, "oscclk");
+		pd->oscclk = of_clk_get_by_name(np, "oscclk");
 		if (IS_ERR(pd->oscclk))
 			goto no_clk;
 
@@ -183,7 +172,7 @@ static __init int exynos4_pm_init_power_domain(void)
 			char clk_name[8];
 
 			snprintf(clk_name, sizeof(clk_name), "clk%d", i);
-			pd->clk[i] = clk_get(dev, clk_name);
+			pd->clk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->clk[i]))
 				break;
 			/*
@@ -234,4 +223,4 @@ next_pd:
 
 	return 0;
 }
-arch_initcall(exynos4_pm_init_power_domain);
+core_initcall(exynos4_pm_init_power_domain);
-- 
1.9.2
