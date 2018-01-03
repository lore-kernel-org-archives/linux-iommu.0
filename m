From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] iommu/of: Only do IOMMU lookup for available ones
Date: Wed,  3 Jan 2018 14:09:20 +0800
Message-ID: <20180103060920.23475-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

The for_each_matching_node_and_match() would return every matching
nodes including unavailable ones.

It's pointless to init unavailable IOMMUs, so add a sanity check to
avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/iommu/of_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 50947ebb6d17..6f7456caa30d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -240,6 +240,9 @@ static int __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
+		if (!of_device_is_available(np))
+			continue;
+
 		if (init_fn && init_fn(np))
 			pr_err("Failed to initialise IOMMU %pOF\n", np);
 	}
-- 
2.11.0
