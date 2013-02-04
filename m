From: Sami Liedes <sliedes@nvidia.com>
Subject: [PATCH] iommu/tegra: Add missing spinlock initialization
Date: Mon, 4 Feb 2013 14:31:48 +0200
Message-ID: <1359981110-9924-1-git-send-email-sliedes@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Sami Liedes <sliedes@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Fix tegra_smmu_probe() to initialize client_lock spinlocks in
per-address-space structures.

Signed-off-by: Sami Liedes <sliedes@nvidia.com>
---
 drivers/iommu/tegra-smmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index f08dbcd..46cc8cf 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1,7 +1,7 @@
 /*
  * IOMMU API for SMMU in Tegra30
  *
- * Copyright (c) 2011-2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2011-2013, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1217,6 +1217,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		as->pte_attr = _PTE_ATTR;
 
 		spin_lock_init(&as->lock);
+		spin_lock_init(&as->client_lock);
 		INIT_LIST_HEAD(&as->client);
 	}
 	spin_lock_init(&smmu->lock);
-- 
1.7.9.5
