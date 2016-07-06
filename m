From: weiyj_lk@163.com
Subject: [PATCH -next] iommu/exynos: Fix return value check in exynos_iommu_of_setup()
Date: Wed,  6 Jul 2016 12:15:54 +0000
Message-ID: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function of_platform_device_create() returns
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iommu/exynos-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 33dcc29..9b23059 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1345,8 +1345,8 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
 		exynos_iommu_init();
 
 	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	if (!pdev)
+		return -ENOMEM;
 
 	/*
 	 * use the first registered sysmmu device for performing
