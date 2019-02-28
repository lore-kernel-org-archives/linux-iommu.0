From: Yang Wei <albin_yang@163.com>
Subject: [PATCH] iommu/mediatek: fix semicolon code style issue
Date: Thu, 28 Feb 2019 22:45:01 +0800
Message-ID: <1551365101-4397-1-git-send-email-albin_yang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, albin_yang@163.com, yang.wei9@zte.com.cn, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Yang Wei <yang.wei9@zte.com.cn>

Delete a superfluous semicolon in mtk_iommu_add_device().

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
---
 drivers/iommu/mtk_iommu_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 7e0df67..52b01e3 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -474,7 +474,7 @@ static int mtk_iommu_add_device(struct device *dev)
 		return err;
 	}
 
-	return iommu_device_link(&data->iommu, dev);;
+	return iommu_device_link(&data->iommu, dev);
 }
 
 static void mtk_iommu_remove_device(struct device *dev)
-- 
2.7.4
