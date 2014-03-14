From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v11 07/27] iommu/exynos: always enable runtime PM
Date: Fri, 14 Mar 2014 14:05:00 +0900
Message-ID: <20140314140500.d854a6a8fed6ec7c0886a44b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Cc: Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

Checking if the probing device has a parent device was just to discover
if the probing device is involved in a power domain when the power
domain controlled by Samsung's custom implementation.
Since generic IO power domain is applied, it is required to remove
the condition to see if the probing device has a parent device.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index bee1bb1..8dc7031 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -632,8 +632,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__set_fault_handler(data, &default_fault_handler);
 
-	if (dev->parent)
-		pm_runtime_enable(dev);
+	pm_runtime_enable(dev);
 
 	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
 	return 0;
-- 
1.7.9.5
