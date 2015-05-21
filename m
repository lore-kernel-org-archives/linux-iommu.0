From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] iommu/rockchip: silence attaching and detaching of devices
Date: Thu, 21 May 2015 09:57:29 +0200
Message-ID: <1638542.l3M1oAbtAT@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently the driver emits a log line every time a device attaches or
detaches - which happens at every unblank/blank of the drm for example.
The message itself also has no real value to the average user and is
merely useful when debugging a problem, so make it a dev_dbg instead.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 140a7bb..ebf0adb 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -785,7 +785,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	list_add_tail(&iommu->node, &rk_domain->iommus);
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
-	dev_info(dev, "Attached to iommu domain\n");
+	dev_dbg(dev, "Attached to iommu domain\n");
 
 	rk_iommu_disable_stall(iommu);
 
@@ -819,7 +819,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 
 	iommu->domain = NULL;
 
-	dev_info(dev, "Detached from iommu domain\n");
+	dev_dbg(dev, "Detached from iommu domain\n");
 }
 
 static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
-- 
2.1.4
