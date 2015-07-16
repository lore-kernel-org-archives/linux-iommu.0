From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] arm/smmu: Make use of of_parse_phandle_with_var_args
Date: Thu, 16 Jul 2015 10:30:44 +0200
Message-ID: <1437035444-13867-3-git-send-email-joro@8bytes.org>
References: <1437035444-13867-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437035444-13867-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The function of_parse_phandle_with_args() can only handle 16
args, but there are systems that require more (25 in my
case). So use the newly introduced function
of_parse_phandle_with_var_args() instead.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4cd0c29..1fe7f35 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -47,7 +47,7 @@
 #include "io-pgtable.h"
 
 /* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
+#define MAX_MASTER_STREAMIDS		128
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
@@ -1698,7 +1698,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	struct rb_node *node;
-	struct of_phandle_args masterspec;
+	struct of_phandle_args *masterspec;
 	int num_irqs, i, err;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
@@ -1757,15 +1757,19 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	masterspec = of_alloc_phandle_args(MAX_MASTER_STREAMIDS);
+	if (!masterspec)
+		return -ENOMEM;
+
 	i = 0;
 	smmu->masters = RB_ROOT;
-	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
-					   "#stream-id-cells", i,
-					   &masterspec)) {
-		err = register_smmu_master(smmu, dev, &masterspec);
+	while (!of_parse_phandle_with_var_args(dev->of_node, "mmu-masters",
+					   "#stream-id-cells", i, masterspec,
+					   MAX_MASTER_STREAMIDS)) {
+		err = register_smmu_master(smmu, dev, masterspec);
 		if (err) {
 			dev_err(dev, "failed to add master %s\n",
-				masterspec.np->name);
+				masterspec->np->name);
 			goto out_put_masters;
 		}
 
@@ -1797,6 +1801,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
+	of_free_phandle_args(masterspec);
+
 	INIT_LIST_HEAD(&smmu->list);
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
@@ -1810,6 +1816,9 @@ out_free_irqs:
 		free_irq(smmu->irqs[i], smmu);
 
 out_put_masters:
+
+	of_free_phandle_args(masterspec);
+
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master
 			= container_of(node, struct arm_smmu_master, node);
-- 
1.9.1
