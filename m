From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 5/6] iommu/arm-smmu: Don't fail device attach if already
	attached to a domain
Date: Fri, 19 Feb 2016 17:46:42 +0000
Message-ID: <1455904003-28069-6-git-send-email-will.deacon@arm.com>
References: <1455904003-28069-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455904003-28069-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM SMMU attach_dev implementations returns -EEXIST if the device
being attached is already attached to a domain. This doesn't play nicely
with the default domain, resulting in splats such as:

  WARNING: at drivers/iommu/iommu.c:1257
  Modules linked in:

  CPU: 3 PID: 1939 Comm: virtio-net-tx Tainted: G S              4.5.0-rc4+ #1
  Hardware name: FVP Base (DT)
  task: ffffffc87a9d0000 ti: ffffffc07a278000 task.ti: ffffffc07a278000
  PC is at __iommu_detach_group+0x68/0xe8
  LR is at __iommu_detach_group+0x48/0xe8

This patch fixes the problem by forcefully detaching the device from
its old domain, if present, when attaching to a new one. The unused
->detach_dev callback is also removed the iommu_ops structures.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 33 ++++++++++++---------------------
 drivers/iommu/arm-smmu.c    | 33 ++++++++++++++-------------------
 2 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f003b3ab646b..d96d45ddf500 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1638,6 +1638,17 @@ static int arm_smmu_install_ste_for_group(struct arm_smmu_group *smmu_group)
 	return 0;
 }
 
+static void arm_smmu_detach_dev(struct device *dev)
+{
+	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
+
+	smmu_group->ste.bypass = true;
+	if (IS_ERR_VALUE(arm_smmu_install_ste_for_group(smmu_group)))
+		dev_warn(dev, "failed to install bypass STE\n");
+
+	smmu_group->domain = NULL;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -1650,7 +1661,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	/* Already attached to a different domain? */
 	if (smmu_group->domain && smmu_group->domain != smmu_domain)
-		return -EEXIST;
+		arm_smmu_detach_dev(dev);
 
 	smmu = smmu_group->smmu;
 	mutex_lock(&smmu_domain->init_mutex);
@@ -1687,25 +1698,6 @@ out_unlock:
 	return ret;
 }
 
-static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
-{
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
-
-	BUG_ON(!smmu_domain);
-	BUG_ON(!smmu_group);
-
-	mutex_lock(&smmu_domain->init_mutex);
-	BUG_ON(smmu_group->domain != smmu_domain);
-
-	smmu_group->ste.bypass = true;
-	if (IS_ERR_VALUE(arm_smmu_install_ste_for_group(smmu_group)))
-		dev_warn(dev, "failed to install bypass STE\n");
-
-	smmu_group->domain = NULL;
-	mutex_unlock(&smmu_domain->init_mutex);
-}
-
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
@@ -1943,7 +1935,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
-	.detach_dev		= arm_smmu_detach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7012531abe62..f21332a15040 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1131,6 +1131,16 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_master_free_smrs(smmu, cfg);
 }
 
+static void arm_smmu_detach_dev(struct device *dev,
+				struct arm_smmu_master_cfg *cfg)
+{
+	struct iommu_domain *domain = dev->archdata.iommu;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	dev->archdata.iommu = NULL;
+	arm_smmu_domain_remove_master(smmu_domain, cfg);
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
@@ -1144,11 +1154,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENXIO;
 	}
 
-	if (dev->archdata.iommu) {
-		dev_err(dev, "already attached to IOMMU domain\n");
-		return -EEXIST;
-	}
-
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu);
 	if (IS_ERR_VALUE(ret))
@@ -1170,25 +1175,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!cfg)
 		return -ENODEV;
 
+	/* Detach the dev from its current domain */
+	if (dev->archdata.iommu)
+		arm_smmu_detach_dev(dev, cfg);
+
 	ret = arm_smmu_domain_add_master(smmu_domain, cfg);
 	if (!ret)
 		dev->archdata.iommu = domain;
 	return ret;
 }
 
-static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
-{
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_master_cfg *cfg;
-
-	cfg = find_smmu_master_cfg(dev);
-	if (!cfg)
-		return;
-
-	dev->archdata.iommu = NULL;
-	arm_smmu_domain_remove_master(smmu_domain, cfg);
-}
-
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
@@ -1464,7 +1460,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
-	.detach_dev		= arm_smmu_detach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
-- 
2.1.4
