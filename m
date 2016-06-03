From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 6/7] iommu/arm-smmu: Finish off SMMUv3 default domain support
Date: Fri,  3 Jun 2016 18:15:41 +0100
Message-ID: <aabcdd814b93b2b6a902b189f6911f929a29b64f.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The driver's current reliance on attaching/detaching an entire group
for the first device it sees is at odds with the IOMMU core's initial
construction of a group by adding each device and attaching it to the
default domain in turn. As it turns out, we can happily do away with the
whole palaver by simply letting each device be in charge of its own
stream ID/stream table entry, and reducing the problem of tracking
duplicate IDs and domains down to "Is the STE already associated with
the appropriate context?", which is easily done by just looking at the
stream table itself.

With an of_xlate() callback in place, devices attached to default
domains will now get appropriate DMA ops installed, so make sure we
enable translation again to stop them getting horribly confused - this
reverts the SMMUv3 portion of cbf8277ef456 ("iommu/arm-smmu: Treat
IOMMU_DOMAIN_DMA as bypass for now")

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: New.

 drivers/iommu/arm-smmu-v3.c | 183 +++++++++-----------------------------------
 1 file changed, 38 insertions(+), 145 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7631639cc209..28dcc5ca237e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -607,15 +607,6 @@ struct arm_smmu_device {
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 };
 
-/* SMMU private data for an IOMMU group */
-struct arm_smmu_group {
-	struct arm_smmu_device		*smmu;
-	struct arm_smmu_domain		*domain;
-	int				num_sids;
-	u32				*sids;
-	struct arm_smmu_strtab_ent	ste;
-};
-
 /* SMMU private data for an IOMMU domain */
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
@@ -642,6 +633,8 @@ struct arm_smmu_domain {
 /* SMMU private data for each master */
 struct arm_smmu_master_data {
 	struct arm_smmu_device		*smmu;
+
+	struct arm_smmu_strtab_ent	ste;
 	u32				sid;
 };
 
@@ -1020,9 +1013,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	 * 1. Update Config, return (init time STEs aren't live)
 	 * 2. Write everything apart from dword 0, sync, write dword 0, sync
 	 * 3. Update Config, sync
+	 *
+	 * Note that with the departure of the explicit detach callback from
+	 * the API, we may be doing 3 & 2 back-to-back in the same call.
 	 */
 	u64 val = le64_to_cpu(dst[0]);
 	bool ste_live = false;
+	bool ste_ok = false;
+	dma_addr_t s1ctxptr = ste->s1_cfg ? ste->s1_cfg->cdptr_dma : 0;
+	u16 vmid = ste->s2_cfg ? ste->s2_cfg->vmid : 0;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1035,17 +1034,27 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 
 		cfg = val & STRTAB_STE_0_CFG_MASK << STRTAB_STE_0_CFG_SHIFT;
 		switch (cfg) {
+		case STRTAB_STE_0_CFG_ABORT:
 		case STRTAB_STE_0_CFG_BYPASS:
+			ste_ok = ste->bypass;
 			break;
 		case STRTAB_STE_0_CFG_S1_TRANS:
 		case STRTAB_STE_0_CFG_S2_TRANS:
 			ste_live = true;
+			ste_ok = ((val & STRTAB_STE_0_S1CTXPTR_MASK <<
+				   STRTAB_STE_0_S1CTXPTR_SHIFT) == s1ctxptr) &&
+				 ((le64_to_cpu(dst[2]) &
+				  STRTAB_STE_2_S2VMID_MASK) == vmid);
 			break;
 		default:
 			BUG(); /* STE corruption */
 		}
 	}
 
+	/* No point rewriting things to the exact same state... */
+	if (ste_ok)
+		return;
+
 	/* Nuke the existing Config, as we're going to rewrite it */
 	val &= ~(STRTAB_STE_0_CFG_MASK << STRTAB_STE_0_CFG_SHIFT);
 
@@ -1054,7 +1063,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	else
 		val &= ~STRTAB_STE_0_V;
 
-	if (ste->bypass) {
+	if (ste_live || ste->bypass) {
 		val |= disable_bypass ? STRTAB_STE_0_CFG_ABORT
 				      : STRTAB_STE_0_CFG_BYPASS;
 		dst[0] = cpu_to_le64(val);
@@ -1063,11 +1072,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		dst[2] = 0; /* Nuke the VMID */
 		if (ste_live)
 			arm_smmu_sync_ste_for_sid(smmu, sid);
-		return;
+		if (ste->bypass)
+			return;
 	}
 
 	if (ste->s1_cfg) {
-		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 STRTAB_STE_1_S1C_CACHE_WBRA
 			 << STRTAB_STE_1_S1CIR_SHIFT |
@@ -1082,16 +1091,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
+		val |= (s1ctxptr & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
 			STRTAB_STE_0_CFG_S1_TRANS;
 
 	}
 
 	if (ste->s2_cfg) {
-		BUG_ON(ste_live);
 		dst[2] = cpu_to_le64(
-			 ste->s2_cfg->vmid << STRTAB_STE_2_S2VMID_SHIFT |
+			 vmid << STRTAB_STE_2_S2VMID_SHIFT |
 			 (ste->s2_cfg->vtcr & STRTAB_STE_2_VTCR_MASK)
 			  << STRTAB_STE_2_VTCR_SHIFT |
 #ifdef __BIG_ENDIAN
@@ -1582,20 +1590,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	return ret;
 }
 
-static struct arm_smmu_group *arm_smmu_group_get(struct device *dev)
-{
-	struct iommu_group *group;
-	struct arm_smmu_group *smmu_group;
-
-	group = iommu_group_get(dev);
-	if (!group)
-		return NULL;
-
-	smmu_group = iommu_group_get_iommudata(group);
-	iommu_group_put(group);
-	return smmu_group;
-}
-
 static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 {
 	__le64 *step;
@@ -1618,12 +1612,12 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	return step;
 }
 
-static int arm_smmu_install_ste_for_group(struct arm_smmu_group *smmu_group)
+static void arm_smmu_install_ste(struct arm_smmu_master_data *master,
+				struct arm_smmu_domain *smmu_domain)
 {
-	int i;
-	struct arm_smmu_domain *smmu_domain = smmu_group->domain;
-	struct arm_smmu_strtab_ent *ste = &smmu_group->ste;
-	struct arm_smmu_device *smmu = smmu_group->smmu;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_strtab_ent *ste = &master->ste;
+	__le64 *step = arm_smmu_get_step_for_sid(smmu, master->sid);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		ste->s1_cfg = &smmu_domain->s1_cfg;
@@ -1634,42 +1628,16 @@ static int arm_smmu_install_ste_for_group(struct arm_smmu_group *smmu_group)
 		ste->s2_cfg = &smmu_domain->s2_cfg;
 	}
 
-	for (i = 0; i < smmu_group->num_sids; ++i) {
-		u32 sid = smmu_group->sids[i];
-		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
-
-		arm_smmu_write_strtab_ent(smmu, sid, step, ste);
-	}
-
-	return 0;
-}
-
-static void arm_smmu_detach_dev(struct device *dev)
-{
-	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
-
-	smmu_group->ste.bypass = true;
-	if (arm_smmu_install_ste_for_group(smmu_group) < 0)
-		dev_warn(dev, "failed to install bypass STE\n");
-
-	smmu_group->domain = NULL;
+	arm_smmu_write_strtab_ent(smmu, master->sid, step, ste);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
-	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
+	struct arm_smmu_master_data *master = dev->archdata.iommu;
+	struct arm_smmu_device *smmu = master->smmu;
 
-	if (!smmu_group)
-		return -ENOENT;
-
-	/* Already attached to a different domain? */
-	if (smmu_group->domain && smmu_group->domain != smmu_domain)
-		arm_smmu_detach_dev(dev);
-
-	smmu = smmu_group->smmu;
 	mutex_lock(&smmu_domain->init_mutex);
 
 	if (!smmu_domain->smmu) {
@@ -1688,21 +1656,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
-	/* Group already attached to this domain? */
-	if (smmu_group->domain)
-		goto out_unlock;
+	master->ste.bypass = false;
 
-	smmu_group->domain	= smmu_domain;
-
-	/*
-	 * FIXME: This should always be "false" once we have IOMMU-backed
-	 * DMA ops for all devices behind the SMMU.
-	 */
-	smmu_group->ste.bypass	= domain->type == IOMMU_DOMAIN_DMA;
-
-	ret = arm_smmu_install_ste_for_group(smmu_group);
-	if (ret < 0)
-		smmu_group->domain = NULL;
+	arm_smmu_install_ste(master, smmu_domain);
 
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
@@ -1761,11 +1717,6 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ret;
 }
 
-static void __arm_smmu_release_pci_iommudata(void *data)
-{
-	kfree(data);
-}
-
 static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
 {
 	struct platform_device *smmu_pdev = of_find_device_by_node(np);
@@ -1788,12 +1739,8 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 
 static int arm_smmu_add_device(struct device *dev)
 {
-	int i, ret;
-	u32 sid, *sids;
-	struct iommu_group *group;
 	struct device_node *np;
-	struct arm_smmu_group *smmu_group;
-	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_data *data = dev->archdata.iommu;
 
 	if (!data)
@@ -1805,73 +1752,19 @@ static int arm_smmu_add_device(struct device *dev)
 	if (!smmu)
 		return -ENODEV;
 
-	sid = data->sid;
-
 	/* Check the SID is in range of the SMMU and our stream table */
-	if (!arm_smmu_sid_in_range(smmu, sid))
+	if (!arm_smmu_sid_in_range(smmu, data->sid))
 		return -ERANGE;
 
 	/* Ensure l2 strtab is initialised */
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		ret = arm_smmu_init_l2_strtab(smmu, sid);
+		int ret = arm_smmu_init_l2_strtab(smmu, data->sid);
+
 		if (ret)
 			return ret;
 	}
 
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	smmu_group = iommu_group_get_iommudata(group);
-	if (!smmu_group) {
-		smmu = arm_smmu_get_by_node(np);
-		if (!smmu) {
-			ret = -ENOENT;
-			goto out_remove_dev;
-		}
-
-		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
-		if (!smmu_group) {
-			ret = -ENOMEM;
-			goto out_remove_dev;
-		}
-
-		smmu_group->ste.valid	= true;
-		smmu_group->smmu	= smmu;
-		iommu_group_set_iommudata(group, smmu_group,
-					  __arm_smmu_release_pci_iommudata);
-	} else {
-		smmu = smmu_group->smmu;
-	}
-
-	for (i = 0; i < smmu_group->num_sids; ++i) {
-		/* If we already know about this SID, then we're done */
-		if (smmu_group->sids[i] == sid)
-			goto out_put_group;
-	}
-
-	/* Resize the SID array for the group */
-	smmu_group->num_sids++;
-	sids = krealloc(smmu_group->sids, smmu_group->num_sids * sizeof(*sids),
-			GFP_KERNEL);
-	if (!sids) {
-		smmu_group->num_sids--;
-		ret = -ENOMEM;
-		goto out_remove_dev;
-	}
-
-	/* Add the new SID */
-	sids[smmu_group->num_sids - 1] = sid;
-	smmu_group->sids = sids;
-
-out_put_group:
-	iommu_group_put(group);
-	return 0;
-
-out_remove_dev:
-	iommu_group_remove_device(dev);
-	iommu_group_put(group);
-	return ret;
+	return PTR_ERR_OR_ZERO(iommu_group_get_for_dev(dev));
 }
 
 static void arm_smmu_remove_device(struct device *dev)
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
