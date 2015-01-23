From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 1/6] of: iommu: add ptr to OF node arg to
	of_iommu_configure()
Date: Fri, 23 Jan 2015 17:32:34 -0500
Message-ID: <1422052359-12384-2-git-send-email-m-karicheri2@ti.com>
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422052359-12384-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Function of_iommu_configure() is called from of_dma_configure() to
setup iommu ops using DT property. This API is currently used for
platform devices for which DMA configuration (including iommu ops)
may come from device's parent. To extend this functionality for PCI
devices, this API need to take a parent node ptr as an argument
instead of assuming device's parent. This is needed since for PCI, the
dma configuration may be defined in the DT node of the root bus bridge's
parent device. Currently only dma-range is used for PCI and iommu is not
supported. So return error if the device is PCI.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/of_iommu.c |   10 ++++++++--
 drivers/of/platform.c    |    2 +-
 include/linux/of_iommu.h |    6 ++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index af1dc6a..439235b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -133,19 +133,25 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
-struct iommu_ops *of_iommu_configure(struct device *dev)
+struct iommu_ops *of_iommu_configure(struct device *dev,
+				     struct device_node *iommu_np)
 {
 	struct of_phandle_args iommu_spec;
 	struct device_node *np;
 	struct iommu_ops *ops = NULL;
 	int idx = 0;
 
+	if (dev_is_pci(dev)) {
+		dev_err(dev, "iommu is currently not supported for PCI\n");
+		return NULL;
+	}
+
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
 	 * See the `Notes:' section of
 	 * Documentation/devicetree/bindings/iommu/iommu.txt
 	 */
-	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
+	while (!of_parse_phandle_with_args(iommu_np, "iommus",
 					   "#iommu-cells", idx,
 					   &iommu_spec)) {
 		np = iommu_spec.np;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a54ec10..7675b79 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -196,7 +196,7 @@ static void of_dma_configure(struct device *dev)
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu = of_iommu_configure(dev);
+	iommu = of_iommu_configure(dev, dev->of_node);
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 16c7554..a97e5bd 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -12,7 +12,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     size_t *size);
 
 extern void of_iommu_init(void);
-extern struct iommu_ops *of_iommu_configure(struct device *dev);
+extern struct iommu_ops *of_iommu_configure(struct device *dev,
+					struct device_node *iommu_np);
 
 #else
 
@@ -24,7 +25,8 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 }
 
 static inline void of_iommu_init(void) { }
-static inline struct iommu_ops *of_iommu_configure(struct device *dev)
+static inline struct iommu_ops *of_iommu_configure(struct device *dev,
+					 struct device_node *iommu_np)
 {
 	return NULL;
 }
-- 
1.7.9.5
