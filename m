From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 02/29] ARM: Exynos: bind power domains earlier,
 on device creation
Date: Tue, 05 Aug 2014 12:47:30 +0200
Message-ID: <1407235677-26324-3-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, linaro-mm-sig@lists.linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patches change initialization time of power domain driver from client
device driver bind to device creation. This lets other core drivers to
register power domain notifiers before client driver is bound.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index fd76e1b..1d368a2 100644
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
