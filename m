From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/5] iommu/rockchip: add map_sg callback for rk_iommu_ops
Date: Mon, 23 May 2016 09:37:16 +0800
Message-ID: <1463967439-13354-3-git-send-email-zhengsq@rock-chips.com>
References: <1463967439-13354-1-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1463967439-13354-1-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

The iommu_dma_alloc() in iommu/dma-iommu.c calls iommu_map_sg()
that requires the callback iommu_ops .map_sg(). Adding the
default_iommu_map_sg() to rockchip iommu accordingly.

Signed-off-by: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ec0ce62..3c16ec3 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1022,6 +1022,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.detach_dev = rk_iommu_detach_device,
 	.map = rk_iommu_map,
 	.unmap = rk_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
 	.iova_to_phys = rk_iommu_iova_to_phys,
-- 
1.9.1
