From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v2 07/13] iommu/rockchip: Fix TLB flush of secondary IOMMUs
Date: Tue, 16 Jan 2018 21:25:34 +0800
Message-ID: <20180116132540.18939-8-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga@chromium.org>

Due to the bug in current code, only first IOMMU has the TLB lines
flushed in rk_iommu_zap_lines. This patch fixes the inner loop to
execute for all IOMMUs and properly flush the TLB.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 8179306d464a..52c6ff8602d8 100644
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
