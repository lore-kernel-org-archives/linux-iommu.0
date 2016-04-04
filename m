From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/6] iommu/arm-smmu: Make use of phandle iterators in
	device-tree parsing
Date: Mon,  4 Apr 2016 17:49:22 +0200
Message-ID: <1459784962-9808-7-git-send-email-joro@8bytes.org>
References: <1459784962-9808-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1459784962-9808-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Remove the usage of of_parse_phandle_with_args() and replace
it by the phandle-iterator implementation so that we can
parse out all of the potentially present 128 stream-ids.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2409e3b..a1c965c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -49,7 +49,7 @@
 #include "io-pgtable.h"
 
 /* Maximum number of stream IDs assigned to a single device */
-#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
+#define MAX_MASTER_STREAMIDS		128
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
@@ -357,6 +357,12 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+struct arm_smmu_phandle_args {
+	struct device_node *np;
+	int args_count;
+	uint32_t args[MAX_MASTER_STREAMIDS];
+};
+
 static struct iommu_ops arm_smmu_ops;
 
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
@@ -466,7 +472,7 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
 
 static int register_smmu_master(struct arm_smmu_device *smmu,
 				struct device *dev,
-				struct of_phandle_args *masterspec)
+				struct arm_smmu_phandle_args *masterspec)
 {
 	int i;
 	struct arm_smmu_master *master;
@@ -1737,7 +1743,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	struct rb_node *node;
-	struct of_phandle_args masterspec;
+	struct of_phandle_iterator it;
+	struct arm_smmu_phandle_args *masterspec;
 	int num_irqs, i, err;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
@@ -1798,20 +1805,35 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	i = 0;
 	smmu->masters = RB_ROOT;
-	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
-					   "#stream-id-cells", i,
-					   &masterspec)) {
-		err = register_smmu_master(smmu, dev, &masterspec);
+
+	err = -ENOMEM;
+	/* No need to zero the memory for masterspec */
+	masterspec = kmalloc(sizeof(*masterspec), GFP_KERNEL);
+	if (!masterspec)
+		goto out_put_masters;
+
+	of_for_each_phandle(&it, err, dev->of_node,
+			    "mmu-masters", "#stream-id-cells", 0) {
+		int count = of_phandle_iterator_args(&it, masterspec->args,
+						     MAX_MASTER_STREAMIDS);
+		masterspec->np		= of_node_get(it.node);
+		masterspec->args_count	= count;
+
+		err = register_smmu_master(smmu, dev, masterspec);
 		if (err) {
 			dev_err(dev, "failed to add master %s\n",
-				masterspec.np->name);
+				masterspec->np->name);
+			kfree(masterspec);
 			goto out_put_masters;
 		}
 
 		i++;
 	}
+
 	dev_notice(dev, "registered %d master devices\n", i);
 
+	kfree(masterspec);
+
 	parse_driver_options(smmu);
 
 	if (smmu->version > ARM_SMMU_V1 &&
-- 
1.9.1
