From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v8 4/5] iommu/arm-smmu: Add the device_link between masters
	and smmu
Date: Fri,  2 Mar 2018 15:40:49 +0530
Message-ID: <20180302101050.6191-5-vivek.gautam@codeaurora.org>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180302101050.6191-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3d6a1875431f..bb1ea82c1003 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -217,6 +217,9 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	/* runtime PM link to master */
+	struct device_link *link;
 };
 
 enum arm_smmu_context_fmt {
@@ -1470,10 +1473,26 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	/*
+	 * Establish the link between smmu and master, so that the
+	 * smmu gets runtime enabled/disabled as per the master's
+	 * needs.
+	 */
+	smmu->link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+	if (!smmu->link) {
+		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
+			 dev_name(smmu->dev), dev_name(dev));
+		ret = -ENODEV;
+		goto out_unlink;
+	}
+
 	arm_smmu_rpm_put(smmu);
 
 	return 0;
 
+out_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_master_free_smes(fwspec);
 out_rpm_put:
 	arm_smmu_rpm_put(smmu);
 out_cfg_free:
@@ -1496,6 +1515,8 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	device_link_del(smmu->link);
+
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
 		return;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
