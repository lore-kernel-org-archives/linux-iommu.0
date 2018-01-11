From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 2/9] iommu/rockchip: Fix error handling in attach
Date: Thu, 11 Jan 2018 16:22:22 +0800
Message-ID: <20180111082229.24011-3-jeffy.chen@rock-chips.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga@chromium.org>

Currently if the driver encounters an error while attaching device, it
will leave the IOMMU in an inconsistent state. Even though it shouldn't
really happen in reality, let's just add proper error path to keep
things consistent.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/iommu/rockchip-iommu.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9d991c2d8767..ee805e1dfba7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -826,17 +826,10 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
-		return ret;
+		goto err_disable_stall;
 
 	iommu->domain = domain;
 
-	for (i = 0; i < iommu->num_irq; i++) {
-		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
-				       IRQF_SHARED, dev_name(dev), iommu);
-		if (ret)
-			return ret;
-	}
-
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
 			       rk_domain->dt_dma);
@@ -844,9 +837,16 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
 
+	for (i = 0; i < iommu->num_irq; i++) {
+		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
+				       IRQF_SHARED, dev_name(dev), iommu);
+		if (ret)
+			goto err_free_irq;
+	}
+
 	ret = rk_iommu_enable_paging(iommu);
 	if (ret)
-		return ret;
+		goto err_free_irq;
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_add_tail(&iommu->node, &rk_domain->iommus);
@@ -857,6 +857,14 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	rk_iommu_disable_stall(iommu);
 
 	return 0;
+
+err_free_irq:
+	while (i--)
+		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
+err_disable_stall:
+	rk_iommu_disable_stall(iommu);
+
+	return ret;
 }
 
 static void rk_iommu_detach_device(struct iommu_domain *domain,
-- 
2.11.0
