Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC6D6FA4
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 18:14:05 +0000 (UTC)
Received: from pop-os.home ([86.243.100.34])
	by smtp.orange.fr with ESMTPA
	id 7KWtpg0ivBonI7KWtprGLS; Mon, 19 Dec 2022 19:06:28 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Dec 2022 19:06:28 +0100
X-ME-IP: 86.243.100.34
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Honghui Zhang <honghui.zhang@mediatek.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe()
Date: Mon, 19 Dec 2022 19:06:22 +0100
Message-Id: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A clk, prepared and enabled in mtk_iommu_v1_hw_init(), is not released in
the error handling path of mtk_iommu_v1_probe().

Add the corresponding clk_disable_unprepare(), as already done in the
remove function.

Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Another option would be to use devm_clk_get_enabled(). This would save a
few LoC in mtk_iommu_v1_hw_init() and in the remove function.
However, it would change the order of function calls in the remove function
so I leave it as-is.
Let me know if it is fine and if you prefer this alternative.
---
 drivers/iommu/mtk_iommu_v1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 69682ee068d2..ca581ff1c769 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -683,7 +683,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(&pdev->dev));
 	if (ret)
-		return ret;
+		goto out_clk_unprepare;
 
 	ret = iommu_device_register(&data->iommu, &mtk_iommu_v1_ops, dev);
 	if (ret)
@@ -698,6 +698,8 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
+out_clk_unprepare:
+	clk_disable_unprepare(data->bclk);
 	return ret;
 }
 
-- 
2.34.1

