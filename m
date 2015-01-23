From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 02/18] arm: exynos: pm_domains: add support for devices
 registered before arch_initcall
Date: Fri, 23 Jan 2015 16:51:12 +0100
Message-ID: <1422028288-891-3-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

SYSMMU devices will be registered early before any other devices and
before calling arch_initcall. To add them to respective power domains,
additional scan of all platform devices is needed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 37266a8..0e2bc36 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -105,6 +105,12 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
+static __init int exynos_pd_init_platform_dev(struct device *dev, void *data)
+{
+	dev_pm_domain_attach(dev, true);
+	return 0;
+}
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
@@ -189,6 +195,7 @@ no_clk:
 		of_node_put(np);
 	}
 
-	return 0;
+	return bus_for_each_dev(&platform_bus_type, NULL, NULL,
+				exynos_pd_init_platform_dev);
 }
 arch_initcall(exynos4_pm_init_power_domain);
-- 
1.9.2
