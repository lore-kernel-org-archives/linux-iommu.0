From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 02/13] iommu/rockchip: Fix error handling in probe
Date: Wed, 24 Jan 2018 18:35:05 +0800
Message-ID: <20180124103516.2571-3-jeffy.chen@rock-chips.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Add missing iommu_device_sysfs_remove in error path.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 16cd8780c289..c2ef3cbd4401 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1193,8 +1193,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	err = iommu_device_register(&iommu->iommu);
+	if (err) {
+		iommu_device_sysfs_remove(&iommu->iommu);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
-- 
2.11.0
