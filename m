From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] iommu/tegra: gart: Reserve iomem resource
Date: Wed, 20 Jun 2012 10:04:33 +0300
Message-ID: <1340175873-12531-2-git-send-email-hdoyu@nvidia.com>
References: <1340054045.1367.31.camel@tellur>
 <1340175873-12531-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340175873-12531-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

GART Register/Aperture range should be reserved.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
 drivers/iommu/tegra-gart.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 33a23b6..a431006 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -366,12 +366,18 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	gart_regs = devm_ioremap(dev, res->start, resource_size(res));
+	gart_regs = devm_request_and_ioremap(dev, res);
 	if (!gart_regs) {
 		dev_err(dev, "failed to remap GART registers\n");
 		return -ENXIO;
 	}
 
+	if (!devm_request_mem_region(dev, res_remap->start,
+				     resource_size(res_remap), dev_name(dev))) {
+		dev_err(dev, "failed to reserve GART aperture\n");
+		return -EBUSY;
+	}
+
 	gart->dev = &pdev->dev;
 	spin_lock_init(&gart->pte_lock);
 	spin_lock_init(&gart->client_lock);
-- 
1.7.5.4
