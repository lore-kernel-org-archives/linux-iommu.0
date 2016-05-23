From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/3] iommu/exynos: Return proper errors from getting clocks
Date: Mon, 23 May 2016 11:30:07 +0200
Message-ID: <1463995809-26862-2-git-send-email-m.szyprowski@samsung.com>
References: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1463995809-26862-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch reworks driver probe code to propagate error codes from
clk_get() operation. This will allow to properly handle deferred probe
in the future.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 56 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index e27e3b7df4e7..989365682d14 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -602,37 +602,31 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->clk = devm_clk_get(dev, "sysmmu");
-	if (!IS_ERR(data->clk)) {
-		ret = clk_prepare(data->clk);
-		if (ret) {
-			dev_err(dev, "Failed to prepare clk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->clk) == -ENOENT)
 		data->clk = NULL;
-	}
+	else if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+	ret = clk_prepare(data->clk);
+	if (ret)
+		return ret;
 
 	data->aclk = devm_clk_get(dev, "aclk");
-	if (!IS_ERR(data->aclk)) {
-		ret = clk_prepare(data->aclk);
-		if (ret) {
-			dev_err(dev, "Failed to prepare aclk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->aclk) == -ENOENT)
 		data->aclk = NULL;
-	}
+	else if (IS_ERR(data->aclk))
+		return PTR_ERR(data->aclk);
+	ret = clk_prepare(data->aclk);
+	if (ret)
+		return ret;
 
 	data->pclk = devm_clk_get(dev, "pclk");
-	if (!IS_ERR(data->pclk)) {
-		ret = clk_prepare(data->pclk);
-		if (ret) {
-			dev_err(dev, "Failed to prepare pclk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->pclk) == -ENOENT)
 		data->pclk = NULL;
-	}
+	else if (IS_ERR(data->pclk))
+		return PTR_ERR(data->pclk);
+	ret = clk_prepare(data->pclk);
+	if (ret)
+		return ret;
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
 		dev_err(dev, "Failed to get device clock(s)!\n");
@@ -640,15 +634,13 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->clk_master = devm_clk_get(dev, "master");
-	if (!IS_ERR(data->clk_master)) {
-		ret = clk_prepare(data->clk_master);
-		if (ret) {
-			dev_err(dev, "Failed to prepare master's clk\n");
-			return ret;
-		}
-	} else {
+	if (PTR_ERR(data->clk_master) == -ENOENT)
 		data->clk_master = NULL;
-	}
+	else if (IS_ERR(data->clk_master))
+		return PTR_ERR(data->clk_master);
+	ret = clk_prepare(data->clk_master);
+	if (ret)
+		return ret;
 
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
-- 
1.9.2
