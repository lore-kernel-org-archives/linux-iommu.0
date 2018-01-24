From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 04/13] iommu/rockchip: Fix error handling in attach
Date: Wed, 24 Jan 2018 18:35:07 +0800
Message-ID: <20180124103516.2571-5-jeffy.chen@rock-chips.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Tomasz Figa <tfiga@chromium.org>

Currently if the driver encounters an error while attaching device, it
will leave the IOMMU in an inconsistent state. Even though it shouldn't
really happen in reality, let's just add proper error path to keep
things consistent.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v5:
Use out labels to save the duplication between the error and success paths.

Changes in v4: None
Changes in v3: None
Changes in v2:
Move irq request to probe(in patch[0])

 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index b743d82e6fe1..f7ff3a3645ea 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -824,7 +824,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
-		return ret;
+		goto out_disable_stall;
 
 	iommu->domain = domain;
 
@@ -837,7 +837,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	ret = rk_iommu_enable_paging(iommu);
 	if (ret)
-		return ret;
+		goto out_disable_stall;
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_add_tail(&iommu->node, &rk_domain->iommus);
@@ -845,9 +845,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	dev_dbg(dev, "Attached to iommu domain\n");
 
+out_disable_stall:
 	rk_iommu_disable_stall(iommu);
-
-	return 0;
+	return ret;
 }
 
 static void rk_iommu_detach_device(struct iommu_domain *domain,
-- 
2.11.0
