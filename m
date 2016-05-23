From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 4/5] iommu/rockchip: add ARM64 cache flush operation for iommu
Date: Mon, 23 May 2016 09:37:18 +0800
Message-ID: <1463967439-13354-5-git-send-email-zhengsq@rock-chips.com>
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

Signed-off-by: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 043d18c..1741b65 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -95,12 +95,16 @@ struct rk_iommu {
 
 static inline void rk_table_flush(u32 *va, unsigned int count)
 {
+#if defined(CONFIG_ARM)
 	phys_addr_t pa_start = virt_to_phys(va);
 	phys_addr_t pa_end = virt_to_phys(va + count);
 	size_t size = pa_end - pa_start;
 
 	__cpuc_flush_dcache_area(va, size);
 	outer_flush_range(pa_start, pa_end);
+#elif defined(CONFIG_ARM64)
+	__dma_flush_range(va, va + count);
+#endif
 }
 
 static struct rk_iommu_domain *to_rk_domain(struct iommu_domain *dom)
-- 
1.9.1
