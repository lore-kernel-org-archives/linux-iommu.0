From: laurentiu.tudor@nxp.com
Subject: [PATCH v2 5/9] dpaa_eth: defer probing after qbman
Date: Sat, 27 Apr 2019 10:10:27 +0300
Message-ID: <20190427071031.6563-6-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
Cc: davem@davemloft.net, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: iommu@lists.linux-foundation.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Enabling SMMU altered the order of device probing causing the dpaa1
ethernet driver to get probed before qbman and causing a boot crash.
Add predictability in the probing order by deferring the ethernet
driver probe after qbman and portals by using the recently introduced
qbman APIs.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dfebc30c4841..647e90e7434f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2774,6 +2774,37 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	int err = 0, i, channel;
 	struct device *dev;
 
+	err = bman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to bman probe error\n");
+		return -ENODEV;
+	}
+	err = qman_is_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev, "failing probe due to qman probe error\n");
+		return -ENODEV;
+	}
+	err = bman_portals_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"failing probe due to bman portals probe error\n");
+		return -ENODEV;
+	}
+	err = qman_portals_probed();
+	if (!err)
+		return -EPROBE_DEFER;
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"failing probe due to qman portals probe error\n");
+		return -ENODEV;
+	}
+
 	/* device used for DMA mapping */
 	dev = pdev->dev.parent;
 	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
-- 
2.17.1
