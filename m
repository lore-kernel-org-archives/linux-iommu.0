From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch 2/2] iommu/mediatek: checking for IS_ERR() instead of NULL
Date: Wed, 2 Mar 2016 13:10:27 +0300
Message-ID: <20160302101027.GG5533@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

of_platform_device_create() returns NULL on error, it never returns
error pointers.

Fixes: 0df4fabe208d ('iommu/mediatek: Add mt8173 IOMMU driver')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1a4022c..4682da4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -628,7 +628,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			plarbdev = of_platform_device_create(
 						larbnode, NULL,
 						platform_bus_type.dev_root);
-			if (IS_ERR(plarbdev))
+			if (!plarbdev)
 				return -EPROBE_DEFER;
 		}
 		data->smi_imu.larb_imu[i].dev = &plarbdev->dev;
@@ -721,8 +721,8 @@ static int mtk_iommu_init_fn(struct device_node *np)
 	struct platform_device *pdev;
 
 	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	if (!pdev)
+		return -ENOMEM;
 
 	ret = platform_driver_register(&mtk_iommu_driver);
 	if (ret) {
