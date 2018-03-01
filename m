From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 06/14] iommu/rockchip: Fix TLB flush of secondary IOMMUs
Date: Thu,  1 Mar 2018 18:08:16 +0800
Message-ID: <20180301100824.14887-7-jeffy.chen@rock-chips.com>
References: <20180301100824.14887-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180301100824.14887-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Due to the bug in current code, only first IOMMU has the TLB lines
flushed in rk_iommu_zap_lines. This patch fixes the inner loop to
execute for all IOMMUs and properly flush the TLB.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index baba283ccdf9..c4131ca792e0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -274,19 +274,21 @@ static void rk_iommu_base_command(void __iomem *base, u32 command)
 {
 	writel(command, base + RK_MMU_COMMAND);
 }
-static void rk_iommu_zap_lines(struct rk_iommu *iommu, dma_addr_t iova,
+static void rk_iommu_zap_lines(struct rk_iommu *iommu, dma_addr_t iova_start,
 			       size_t size)
 {
 	int i;
-
-	dma_addr_t iova_end = iova + size;
+	dma_addr_t iova_end = iova_start + size;
 	/*
 	 * TODO(djkurtz): Figure out when it is more efficient to shootdown the
 	 * entire iotlb rather than iterate over individual iovas.
 	 */
-	for (i = 0; i < iommu->num_mmu; i++)
-		for (; iova < iova_end; iova += SPAGE_SIZE)
+	for (i = 0; i < iommu->num_mmu; i++) {
+		dma_addr_t iova;
+
+		for (iova = iova_start; iova < iova_end; iova += SPAGE_SIZE)
 			rk_iommu_write(iommu->bases[i], RK_MMU_ZAP_ONE_LINE, iova);
+	}
 }
 
 static bool rk_iommu_is_stall_active(struct rk_iommu *iommu)
-- 
2.11.0
