From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 02/18] arm: exynos: bind power domains earlier,
 on device creation
Date: Tue, 16 Sep 2014 13:54:29 +0200
Message-ID: <1410868485-4143-3-git-send-email-m.szyprowski@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patches change initialization time of power domain driver from client
device driver bind to device creation. This lets other core drivers to
register power domain notifiers before client driver is bound.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index fd76e1b5a471..1d368a26528c 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -159,13 +159,13 @@ static int exynos_pm_notifier_call(struct notifier_block *nb,
 	struct device *dev = data;
 
 	switch (event) {
-	case BUS_NOTIFY_BIND_DRIVER:
+	case BUS_NOTIFY_ADD_DEVICE:
 		if (dev->of_node)
 			exynos_read_domain_from_dt(dev);
 
 		break;
 
-	case BUS_NOTIFY_UNBOUND_DRIVER:
+	case BUS_NOTIFY_DEL_DEVICE:
 		exynos_remove_device_from_domain(dev);
 
 		break;
@@ -177,6 +177,13 @@ static struct notifier_block platform_nb = {
 	.notifier_call = exynos_pm_notifier_call,
 };
 
+static int exynos_pm_domain_add(struct device *dev, void *priv)
+{
+	if (dev->of_node)
+		exynos_read_domain_from_dt(dev);
+	return 0;
+}
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
@@ -236,6 +243,7 @@ no_clk:
 	}
 
 	bus_register_notifier(&platform_bus_type, &platform_nb);
+	bus_for_each_dev(&platform_bus_type, NULL, NULL, exynos_pm_domain_add);
 
 	return 0;
 }
-- 
1.9.2
