From: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] iommu/rockchip: Fix "is stall active" check
Date: Tue,  5 Apr 2016 15:05:46 +0100
Message-ID: <1459865146-25308-1-git-send-email-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Since commit cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi
slaves") rk_iommu_is_stall_active() always returns false because the
bitwise AND operates on the boolean flag promoted to an integer and a
value that is either zero or BIT(2).

Explicitly convert the right-hand value to a boolean so that both sides
are guaranteed to be either zero or one.

rk_iommu_is_paging_enabled() does not suffer from the same problem since
RK_MMU_STATUS_PAGING_ENABLED is BIT(0), but let's apply the same change
for consistency and to make it clear that it's correct without needing
to lookup the value.

Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi slaves")
Signed-off-by: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a6f593a0a29e..5710a06c3049 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -315,8 +315,8 @@ static bool rk_iommu_is_stall_active(struct rk_iommu *iommu)
 	int i;
 
 	for (i = 0; i < iommu->num_mmu; i++)
-		active &= rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
-					RK_MMU_STATUS_STALL_ACTIVE;
+		active &= !!(rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
+					   RK_MMU_STATUS_STALL_ACTIVE);
 
 	return active;
 }
@@ -327,8 +327,8 @@ static bool rk_iommu_is_paging_enabled(struct rk_iommu *iommu)
 	int i;
 
 	for (i = 0; i < iommu->num_mmu; i++)
-		enable &= rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
-					RK_MMU_STATUS_PAGING_ENABLED;
+		enable &= !!(rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
+					   RK_MMU_STATUS_PAGING_ENABLED);
 
 	return enable;
 }
-- 
2.8.0.rc4.238.g874082a
