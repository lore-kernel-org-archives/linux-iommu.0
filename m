From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 6/6] iommu/arm-smmu-v3: Add support for auxiliary domains
Date: Fri, 19 Oct 2018 19:11:58 +0100
Message-ID: <20181019181158.2395-7-jean-philippe.brucker@arm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181019181158.2395-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Allow device driver to create PASID contexts by setting a device in
'auxiliary' mode and allocating new domains. Each domain corrsponds to a
PASID.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 157 ++++++++++++++++++++++++++++++++++--
 1 file changed, 151 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 665365b5f02e..ae10c78d20a8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -539,6 +539,7 @@ struct arm_smmu_s1_cfg {
 	struct iommu_pasid_table_cfg	tables;
 	struct iommu_pasid_table_ops	*ops;
 	struct iommu_pasid_entry	*cd0; /* Default context */
+	int				pasid;
 };
 
 struct arm_smmu_s2_cfg {
@@ -656,6 +657,7 @@ struct arm_smmu_master_data {
 	struct device			*dev;
 	size_t				ssid_bits;
 	bool				can_fault;
+	bool				auxd;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -715,6 +717,13 @@ static struct arm_smmu_mm *to_smmu_mm(struct io_mm *io_mm)
 	return container_of(io_mm, struct arm_smmu_mm, io_mm);
 }
 
+static struct arm_smmu_master_data *dev_to_master(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+
+	return fwspec ? fwspec->iommu_priv : NULL;
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -2007,10 +2016,12 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct iommu_pasid_table_ops *ops = smmu_domain->s1_cfg.ops;
 
-		if (ops) {
+		if (smmu_domain->s1_cfg.pasid)
+			iommu_sva_free_pasid(smmu_domain->s1_cfg.pasid);
+		if (smmu_domain->s1_cfg.cd0)
 			iommu_free_pasid_entry(smmu_domain->s1_cfg.cd0);
+		if (ops)
 			iommu_free_pasid_ops(ops);
-		}
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -2068,6 +2079,28 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	return ret;
 }
 
+static int arm_smmu_domain_finalise_aux(struct arm_smmu_domain *smmu_domain,
+					struct arm_smmu_master_data *master,
+					struct io_pgtable_cfg *pgtbl_cfg)
+{
+	struct iommu_pasid_entry *entry;
+	struct iommu_pasid_table_ops *ops;
+
+	if (!master->ste.s1_cfg)
+		return -EINVAL;
+
+	ops = master->ste.s1_cfg->ops;
+	if (!ops)
+		return -EINVAL;
+
+	entry = ops->alloc_priv_entry(ops, ARM_64_LPAE_S1, pgtbl_cfg);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	smmu_domain->s1_cfg.cd0 = entry; /* FIXME: cd, not cd0 */
+	return 0;
+}
+
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_master_data *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
@@ -2130,6 +2163,13 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		return -EINVAL;
 	}
 
+	if (master->auxd) {
+		if (WARN_ON(smmu_domain->stage != ARM_SMMU_DOMAIN_S1))
+			return -EINVAL;
+		/* We're initializing an auxiliary domain */
+		finalise_stage_fn = arm_smmu_domain_finalise_aux;
+	}
+
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
@@ -2202,11 +2242,36 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 	}
 }
 
+static void arm_smmu_detach_dev_aux(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master_data *master)
+{
+	int pasid;
+	struct iommu_pasid_table_ops *ops = master->ste.s1_cfg->ops;
+
+	if (WARN_ON(!ops))
+		return;
+
+	pasid = smmu_domain->s1_cfg.pasid;
+	if (WARN_ON(!pasid))
+		return;
+	ops->clear_entry(ops, pasid, smmu_domain->s1_cfg.cd0);
+	arm_smmu_atc_inv_master_all(master, pasid);
+	/*
+	 * We don't count the number of attached devices, so free the
+	 * PASID in domain_free.
+	 */
+}
+
 static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	unsigned long flags;
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
-	struct arm_smmu_domain *smmu_domain = master->domain;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (master->auxd) {
+		arm_smmu_detach_dev_aux(smmu_domain, master);
+		return;
+	}
 
 	if (smmu_domain) {
 		iommu_sva_unbind_device_all(dev);
@@ -2224,6 +2289,39 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 	arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
 }
 
+static int arm_smmu_attach_dev_aux(struct arm_smmu_domain *smmu_domain,
+				   struct arm_smmu_master_data *master)
+{
+	int pasid, ret;
+	struct iommu_pasid_table_ops *ops = master->ste.s1_cfg->ops;
+
+	if (!ops)
+		return -EINVAL;
+
+	if (smmu_domain->s1_cfg.pasid) {
+		/*
+		 * Reuse PASID if already allocated for another device. As the
+		 * PASID space is global and this is the same SMMU, we know that
+		 * the below set_entry will work.
+		 *
+		 * TODO: check device boundaries (sva_param)
+		 */
+		pasid = smmu_domain->s1_cfg.pasid;
+	} else {
+		pasid = iommu_sva_alloc_pasid(master->dev);
+		if (pasid < 0)
+			return pasid;
+
+		smmu_domain->s1_cfg.pasid = pasid;
+	}
+
+	ret = ops->set_entry(ops, pasid, smmu_domain->s1_cfg.cd0);
+	if (ret)
+		return ret;
+
+	return 1; /* Auxd needs special value. */
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -2240,8 +2338,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	smmu = master->smmu;
 	ste = &master->ste;
 
+	/* Spurious attach_dev when doing detach on an aux domain... */
+	if (master->domain == smmu_domain)
+		return !!master->auxd;
+
 	/* Already attached to a different domain? */
-	if (master->domain)
+	if (master->domain && !master->auxd)
 		arm_smmu_detach_dev(&master->domain->domain, dev);
 
 	mutex_lock(&smmu_domain->init_mutex);
@@ -2262,6 +2364,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
+	if (master->auxd) {
+		/* Now install the context descriptor */
+		ret = arm_smmu_attach_dev_aux(smmu_domain, master);
+		goto out_unlock;
+	}
+
 	ste->assigned = true;
 	master->domain = smmu_domain;
 
@@ -2411,7 +2519,7 @@ static int arm_smmu_sva_init(struct device *dev, struct iommu_sva_param *param)
 	if (!master->ssid_bits)
 		return -EINVAL;
 
-	if (param->features & ~IOMMU_SVA_FEAT_IOPF)
+	if (param->features & ~(IOMMU_SVA_FEAT_IOPF | IOMMU_SVA_FEAT_AUXD))
 		return -EINVAL;
 
 	if (param->features & IOMMU_SVA_FEAT_IOPF) {
@@ -2426,6 +2534,9 @@ static int arm_smmu_sva_init(struct device *dev, struct iommu_sva_param *param)
 			goto err_disable_pri;
 	}
 
+	if (param->features & IOMMU_SVA_FEAT_AUXD)
+		master->auxd = true;
+
 	if (!param->max_pasid)
 		param->max_pasid = 0xfffffU;
 
@@ -2443,7 +2554,13 @@ static int arm_smmu_sva_init(struct device *dev, struct iommu_sva_param *param)
 
 static void arm_smmu_sva_shutdown(struct device *dev)
 {
-	arm_smmu_disable_pri(dev->iommu_fwspec->iommu_priv);
+	struct arm_smmu_master_data *master = dev_to_master(dev);
+
+	if (!master)
+		return;
+
+	master->auxd = false;
+	arm_smmu_disable_pri(master);
 	iopf_queue_remove_device(dev);
 }
 
@@ -2874,6 +2991,11 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_AUXD_ID:
+		if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+			return -EINVAL;
+		*(int *)data = smmu_domain->s1_cfg.pasid;
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -2912,6 +3034,28 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static int arm_smmu_get_dev_attr(struct device *dev, enum iommu_dev_attr attr,
+				 void *data)
+{
+	bool *auxd;
+	struct arm_smmu_master_data *master = dev_to_master(dev);
+
+	if (!master || !data)
+		return -ENODEV;
+
+	switch (attr) {
+	case IOMMU_DEV_ATTR_AUXD_CAPABILITY:
+		auxd = data;
+		/* PASID supported */
+		*auxd = !!master->ssid_bits;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2966,6 +3110,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.get_dev_attr		= arm_smmu_get_dev_attr,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
-- 
2.19.1
