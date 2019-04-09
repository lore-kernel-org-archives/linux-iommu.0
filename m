From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/7] iommu/arm-smmu-v3: Store SteamIDs in master
Date: Tue,  9 Apr 2019 17:52:41 +0100
Message-ID: <20190409165245.26500-4-jean-philippe.brucker@arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190409165245.26500-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Simplify the attach/detach code a bit by keeping a pointer to the stream
IDs in the master structure. Although not completely obvious here, it does
make the subsequent support for ATS, PRI and PASID a bit simpler.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 50cb037f3d8a..25ba546cae7f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -594,6 +594,8 @@ struct arm_smmu_device {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct arm_smmu_strtab_ent	ste;
+	u32				*sids;
+	unsigned int			num_sids;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -1688,19 +1690,18 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	return step;
 }
 
-static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
+static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 {
 	int i, j;
-	struct arm_smmu_master *master = fwspec->iommu_priv;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	for (i = 0; i < fwspec->num_ids; ++i) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_sids; ++i) {
+		u32 sid = master->sids[i];
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (fwspec->ids[j] == sid)
+			if (master->sids[j] == sid)
 				break;
 		if (j < i)
 			continue;
@@ -1709,13 +1710,10 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 	}
 }
 
-static void arm_smmu_detach_dev(struct device *dev)
+static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct arm_smmu_master *master = fwspec->iommu_priv;
-
 	master->ste.assigned = false;
-	arm_smmu_install_ste_for_dev(fwspec);
+	arm_smmu_install_ste_for_dev(master);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1736,7 +1734,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	/* Already attached to a different domain? */
 	if (ste->assigned)
-		arm_smmu_detach_dev(dev);
+		arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
 
@@ -1770,7 +1768,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ste->s2_cfg = &smmu_domain->s2_cfg;
 	}
 
-	arm_smmu_install_ste_for_dev(fwspec);
+	arm_smmu_install_ste_for_dev(master);
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
@@ -1883,12 +1881,14 @@ static int arm_smmu_add_device(struct device *dev)
 			return -ENOMEM;
 
 		master->smmu = smmu;
+		master->sids = fwspec->ids;
+		master->num_sids = fwspec->num_ids;
 		fwspec->iommu_priv = master;
 	}
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_sids; i++) {
+		u32 sid = master->sids[i];
 
 		if (!arm_smmu_sid_in_range(smmu, sid))
 			return -ERANGE;
@@ -1922,7 +1922,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 	if (master && master->ste.assigned)
-		arm_smmu_detach_dev(dev);
+		arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
 	kfree(master);
-- 
2.21.0
