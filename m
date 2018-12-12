From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 15/24] memory: tegra: Do not ask for IRQ sharing
Date: Wed, 12 Dec 2018 23:38:58 +0300
Message-ID: <20181212203907.23461-16-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Memory Controller driver never shared IRQ with any other driver and very
unlikely that it will. Hence there is no need to request IRQ sharing and
the corresponding flag can be dropped safely.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3545868c51c0..570da2129fa6 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -682,7 +682,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 	mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
-	err = devm_request_irq(&pdev->dev, mc->irq, isr, IRQF_SHARED,
+	err = devm_request_irq(&pdev->dev, mc->irq, isr, 0,
 			       dev_name(&pdev->dev), mc);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", mc->irq,
-- 
2.20.0
