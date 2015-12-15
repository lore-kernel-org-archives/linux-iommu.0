From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/06] iommu/ipmmu-vmsa: Remove platform data handling
Date: Tue, 15 Dec 2015 21:02:21 +0900
Message-ID: <20151215120221.26216.739.sendpatchset@little-apple>
References: <20151215120212.26216.61530.sendpatchset@little-apple>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215120212.26216.61530.sendpatchset@little-apple>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

The IPMMU driver is using DT these days, and platform data is no longer
used by the driver. Remove unused code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |    5 -----
 1 file changed, 5 deletions(-)

--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 11:35:00.490513000 +0900
@@ -766,11 +766,6 @@ static int ipmmu_probe(struct platform_d
 	int irq;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_OF) && !pdev->dev.platform_data) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -EINVAL;
-	}
-
 	mmu = devm_kzalloc(&pdev->dev, sizeof(*mmu), GFP_KERNEL);
 	if (!mmu) {
 		dev_err(&pdev->dev, "cannot allocate device data\n");
