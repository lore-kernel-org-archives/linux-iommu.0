Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1E64E
	for <iommu@lists.linux.dev>; Sun, 26 Mar 2023 12:45:35 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id gPd9pANE3TpvfgPd9p9CXS; Sun, 26 Mar 2023 14:37:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 14:37:56 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH] iommu/exynos: Use the devm_clk_get_optional() helper
Date: Sun, 26 Mar 2023 14:37:50 +0200
Message-Id: <99c0d5ce643737ee0952df41fd60433a0bbeb447.1679834256.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_optional() instead of hand writing it.
This saves some loC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/exynos-iommu.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 483aaaeb6dae..867f409e0325 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -747,22 +747,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->clk = devm_clk_get(dev, "sysmmu");
-	if (PTR_ERR(data->clk) == -ENOENT)
-		data->clk = NULL;
-	else if (IS_ERR(data->clk))
+	data->clk = devm_clk_get_optional(dev, "sysmmu");
+	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
-	data->aclk = devm_clk_get(dev, "aclk");
-	if (PTR_ERR(data->aclk) == -ENOENT)
-		data->aclk = NULL;
-	else if (IS_ERR(data->aclk))
+	data->aclk = devm_clk_get_optional(dev, "aclk");
+	if (IS_ERR(data->aclk))
 		return PTR_ERR(data->aclk);
 
-	data->pclk = devm_clk_get(dev, "pclk");
-	if (PTR_ERR(data->pclk) == -ENOENT)
-		data->pclk = NULL;
-	else if (IS_ERR(data->pclk))
+	data->pclk = devm_clk_get_optional(dev, "pclk");
+	if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);
 
 	if (!data->clk && (!data->aclk || !data->pclk)) {
@@ -770,10 +764,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 		return -ENOSYS;
 	}
 
-	data->clk_master = devm_clk_get(dev, "master");
-	if (PTR_ERR(data->clk_master) == -ENOENT)
-		data->clk_master = NULL;
-	else if (IS_ERR(data->clk_master))
+	data->clk_master = devm_clk_get_optional(dev, "master");
+	if (IS_ERR(data->clk_master))
 		return PTR_ERR(data->clk_master);
 
 	data->sysmmu = dev;
-- 
2.34.1

