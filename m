From: laurentiu.tudor@nxp.com
Subject: [PATCH 04/13] soc/fsl/qman-portal: map CENA area in the iommu
Date: Fri, 29 Mar 2019 16:00:05 +0200
Message-ID: <20190329140014.8126-5-laurentiu.tudor@nxp.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: iommu@lists.linux-foundation.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a one-to-one iommu mapping for qman portal CENA register area.
This is required for QMAN stashing to work without faults behind
an iommu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 661c9b234d32..dfb62f9815e9 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -29,6 +29,7 @@
  */
 
 #include "qman_priv.h"
+#include <linux/iommu.h>
 
 struct qman_portal *qman_dma_portal;
 EXPORT_SYMBOL(qman_dma_portal);
@@ -224,6 +225,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct iommu_domain *domain;
 	struct qm_portal_config *pcfg;
 	struct resource *addr_phys[2];
 	int irq, cpu, err;
@@ -286,6 +288,21 @@ static int qman_portal_probe(struct platform_device *pdev)
 		goto err_ioremap2;
 	}
 
+	/* Create an 1-to-1 iommu mapping for cena portal area */
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		/*
+		 * Note: not mapping this as cacheable triggers the infamous
+		 * QMan CIDE error.
+		 */
+		err = iommu_map(domain,
+				addr_phys[0]->start, addr_phys[0]->start,
+				resource_size(addr_phys[0]),
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (err)
+			dev_warn(dev, "failed to iommu_map() %d\n", err);
+	}
+
 	pcfg->pools = qm_get_pools_sdqcr();
 
 	spin_lock(&qman_lock);
-- 
2.17.1
