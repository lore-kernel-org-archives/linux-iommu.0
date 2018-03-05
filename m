From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 2/6] iommu: support iommu configuration for fsl-mc devices
Date: Mon,  5 Mar 2018 19:59:22 +0530
Message-ID: <1520260166-29387-3-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
---
 drivers/iommu/of_iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..cc2fb9c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -160,6 +161,26 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int
+of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+		      struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec;
+	int err;
+
+	iommu_spec.np = of_parse_phandle(master_np, "iommu-parent", 0);
+	if (!iommu_spec.np)
+		return NO_IOMMU;
+
+	iommu_spec.args[0] = mc_dev->icid;
+	iommu_spec.args_count = 1;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -191,6 +212,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
