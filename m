From: Simon Xue <xxm@rock-chips.com>
Subject: [PATCH V2 3/3] iommu/rockchip: ignore isp mmu reset operation
Date: Fri, 21 Jul 2017 14:27:10 +0800
Message-ID: <1500618430-114821-3-git-send-email-xxm@rock-chips.com>
References: <1500618430-114821-1-git-send-email-xxm@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500618430-114821-1-git-send-email-xxm@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Simon <xxm@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

From: Simon <xxm@rock-chips.com>

ISP mmu can't support reset operation, it won't get the
expected result when reset, but rest functions work normally.
Add this patch as a WA for this issue.

Signed-off-by: Simon <xxm@rock-chips.com>
---
changes since V1:
 - use '-' instead of '_' for DT property.

 drivers/iommu/rockchip-iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 3c462c0..3c6dc81 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -92,6 +92,7 @@ struct rk_iommu {
 	int num_mmu;
 	int *irq;
 	int num_irq;
+	bool reset_disabled;
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
@@ -415,6 +416,9 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	int ret, i;
 	u32 dte_addr;
 
+	if (iommu->reset_disabled)
+		return 0;
+
 	/*
 	 * Check if register DTE_ADDR is working by writing DTE_ADDR_DUMMY
 	 * and verifying that upper 5 nybbles are read back.
@@ -1177,6 +1181,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		}
 	}
 
+	iommu->reset_disabled = device_property_read_bool(dev,
+					"rk-iommu,disable-reset-quirk");
+
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
 		return err;
-- 
1.9.1
