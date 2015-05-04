From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v6 02/25] arm: exynos: pm_domains: register power domain driver
 from core_initcall
Date: Mon, 04 May 2015 10:15:57 +0200
Message-ID: <1430727380-10912-3-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

SYSMMU devices are registered very early in arch_initcall, so ensure
that they can get access to power domains by registering power domain
driver from earlier initcall. This change requires dropping usage of the
platform device associated with each power domain and replacing clock
calls with respective of_clk_* equivalents.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index cbe56b35aea0..708eb88aa677 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -117,16 +117,11 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 
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
-		dev = &pdev->dev;
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
@@ -135,7 +130,8 @@ static __init int exynos4_pm_init_power_domain(void)
 			return -ENOMEM;
 		}
 
-		pd->pd.name = kstrdup(dev_name(dev), GFP_KERNEL);
+		pd->pd.name = kstrdup_const(strrchr(np->full_name, '/') + 1,
+					    GFP_KERNEL);
 		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
@@ -145,12 +141,12 @@ static __init int exynos4_pm_init_power_domain(void)
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
 
@@ -158,11 +154,11 @@ static __init int exynos4_pm_init_power_domain(void)
 			char clk_name[8];
 
 			snprintf(clk_name, sizeof(clk_name), "clk%d", i);
-			pd->clk[i] = clk_get(dev, clk_name);
+			pd->clk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->clk[i]))
 				break;
 			snprintf(clk_name, sizeof(clk_name), "pclk%d", i);
-			pd->pclk[i] = clk_get(dev, clk_name);
+			pd->pclk[i] = of_clk_get_by_name(np, clk_name);
 			if (IS_ERR(pd->pclk[i])) {
 				clk_put(pd->clk[i]);
 				pd->clk[i] = ERR_PTR(-EINVAL);
@@ -210,4 +206,4 @@ no_clk:
 
 	return 0;
 }
-arch_initcall(exynos4_pm_init_power_domain);
+core_initcall(exynos4_pm_init_power_domain);
-- 
1.9.2
