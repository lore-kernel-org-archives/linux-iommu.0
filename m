From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 4/6] iommu/arm-smmu-v3: Add SVM support for platform
	devices
Date: Thu, 31 Aug 2017 16:20:40 +0800
Message-ID: <1504167642-14922-5-git-send-email-xieyisheng1@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1504167642-14922-1-git-send-email-xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, xieyisheng-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>

Platform device can realise SVM function by using the stall mode. That
is to say, when device access a memory via iova which is not populated,
it will stalled and when SMMU try to translate this iova, it also will
stall and meanwhile send an event to CPU via MSI.

After SMMU driver handle the event and populated the iova, it will send
a RESUME command to SMMU to exit the stall mode, therefore the platform
device can contiue access the memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 218 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 181 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index cafbeef..d44256a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -359,6 +359,7 @@
 #define CTXDESC_CD_0_TCR_HA_SHIFT	43
 #define CTXDESC_CD_0_HD			(1UL << CTXDESC_CD_0_TCR_HD_SHIFT)
 #define CTXDESC_CD_0_HA			(1UL << CTXDESC_CD_0_TCR_HA_SHIFT)
+#define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
 #define CTXDESC_CD_0_A			(1UL << 46)
 #define CTXDESC_CD_0_ASET_SHIFT		47
@@ -432,6 +433,15 @@
 #define CMDQ_PRI_1_RESP_FAIL		(1UL << CMDQ_PRI_1_RESP_SHIFT)
 #define CMDQ_PRI_1_RESP_SUCC		(2UL << CMDQ_PRI_1_RESP_SHIFT)
 
+#define CMDQ_RESUME_0_SID_SHIFT		32
+#define CMDQ_RESUME_0_SID_MASK		0xffffffffUL
+#define CMDQ_RESUME_0_ACTION_SHIFT	12
+#define CMDQ_RESUME_0_ACTION_TERM	(0UL << CMDQ_RESUME_0_ACTION_SHIFT)
+#define CMDQ_RESUME_0_ACTION_RETRY	(1UL << CMDQ_RESUME_0_ACTION_SHIFT)
+#define CMDQ_RESUME_0_ACTION_ABORT	(2UL << CMDQ_RESUME_0_ACTION_SHIFT)
+#define CMDQ_RESUME_1_STAG_SHIFT	0
+#define CMDQ_RESUME_1_STAG_MASK		0xffffUL
+
 #define CMDQ_SYNC_0_CS_SHIFT		12
 #define CMDQ_SYNC_0_CS_NONE		(0UL << CMDQ_SYNC_0_CS_SHIFT)
 #define CMDQ_SYNC_0_CS_SEV		(2UL << CMDQ_SYNC_0_CS_SHIFT)
@@ -443,6 +453,31 @@
 #define EVTQ_0_ID_SHIFT			0
 #define EVTQ_0_ID_MASK			0xffUL
 
+#define EVT_ID_TRANSLATION_FAULT	0x10
+#define EVT_ID_ADDR_SIZE_FAULT		0x11
+#define EVT_ID_ACCESS_FAULT		0x12
+#define EVT_ID_PERMISSION_FAULT		0x13
+
+#define EVTQ_0_SSV			(1UL << 11)
+#define EVTQ_0_SSID_SHIFT		12
+#define EVTQ_0_SSID_MASK		0xfffffUL
+#define EVTQ_0_SID_SHIFT		32
+#define EVTQ_0_SID_MASK			0xffffffffUL
+#define EVTQ_1_STAG_SHIFT		0
+#define EVTQ_1_STAG_MASK		0xffffUL
+#define EVTQ_1_STALL			(1UL << 31)
+#define EVTQ_1_PRIV			(1UL << 33)
+#define EVTQ_1_EXEC			(1UL << 34)
+#define EVTQ_1_READ			(1UL << 35)
+#define EVTQ_1_S2			(1UL << 39)
+#define EVTQ_1_CLASS_SHIFT		40
+#define EVTQ_1_CLASS_MASK		0x3UL
+#define EVTQ_1_TT_READ			(1UL << 44)
+#define EVTQ_2_ADDR_SHIFT		0
+#define EVTQ_2_ADDR_MASK		0xffffffffffffffffUL
+#define EVTQ_3_IPA_SHIFT		12
+#define EVTQ_3_IPA_MASK			0xffffffffffUL
+
 /* PRI queue */
 #define PRIQ_ENT_DWORDS			2
 #define PRIQ_MAX_SZ_SHIFT		8
@@ -586,6 +621,13 @@ struct arm_smmu_cmdq_ent {
 			enum fault_status	resp;
 		} pri;
 
+		#define CMDQ_OP_RESUME		0x44
+		struct {
+			u32			sid;
+			u16			stag;
+			enum fault_status	resp;
+		} resume;
+
 		#define CMDQ_OP_CMD_SYNC	0x46
 	};
 };
@@ -659,6 +701,7 @@ struct arm_smmu_s1_cfg {
 
 	struct list_head		contexts;
 	size_t				num_contexts;
+	bool				can_stall;
 
 	struct arm_smmu_ctx_desc	cd; /* Default context (SSID0) */
 };
@@ -682,6 +725,7 @@ struct arm_smmu_strtab_ent {
 	struct arm_smmu_s2_cfg		*s2_cfg;
 
 	bool				prg_response_needs_ssid;
+	bool				can_stall;
 };
 
 struct arm_smmu_strtab_cfg {
@@ -816,6 +860,7 @@ struct arm_smmu_fault {
 	bool				priv;
 
 	bool				last;
+	bool				stall;
 
 	struct work_struct		work;
 };
@@ -1098,6 +1143,21 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 			return -EINVAL;
 		}
 		break;
+	case CMDQ_OP_RESUME:
+		switch (ent->resume.resp) {
+		case ARM_SMMU_FAULT_FAIL:
+		case ARM_SMMU_FAULT_DENY:
+			cmd[0] |= CMDQ_RESUME_0_ACTION_ABORT;
+			break;
+		case ARM_SMMU_FAULT_SUCC:
+			cmd[0] |= CMDQ_RESUME_0_ACTION_RETRY;
+			break;
+		default:
+			return -EINVAL;
+		}
+		cmd[0] |= (u64)ent->resume.sid << CMDQ_RESUME_0_SID_SHIFT;
+		cmd[1] |= ent->resume.stag << CMDQ_RESUME_1_STAG_SHIFT;
+		break;
 	case CMDQ_OP_CMD_SYNC:
 		cmd[0] |= CMDQ_SYNC_0_CS_SEV;
 		break;
@@ -1194,16 +1254,21 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 static void arm_smmu_fault_reply(struct arm_smmu_fault *fault,
 				 enum fault_status resp)
 {
-	struct arm_smmu_cmdq_ent cmd = {
-		.opcode			= CMDQ_OP_PRI_RESP,
-		.substream_valid	= fault->ssv,
-		.pri			= {
-			.sid	= fault->sid,
-			.ssid	= fault->ssid,
-			.grpid	= fault->grpid,
-			.resp	= resp,
-		},
-	};
+	struct arm_smmu_cmdq_ent cmd = { 0 };
+
+	if (fault->stall) {
+		cmd.opcode		= CMDQ_OP_RESUME;
+		cmd.resume.sid		= fault->sid;
+		cmd.resume.stag		= fault->grpid;
+		cmd.resume.resp		= resp;
+	} else {
+		cmd.opcode		= CMDQ_OP_PRI_RESP;
+		cmd.substream_valid	= fault->ssv;
+		cmd.pri.sid		= fault->sid;
+		cmd.pri.ssid		= fault->ssid;
+		cmd.pri.grpid		= fault->grpid;
+		cmd.pri.resp		= resp;
+	}
 
 	if (!fault->last || resp == ARM_SMMU_FAULT_IGNORE)
 		return;
@@ -1402,8 +1467,13 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		      (u64)cd->asid << CTXDESC_CD_0_ASID_SHIFT |
 		      CTXDESC_CD_0_V;
 
-		cdptr[0] = cpu_to_le64(val);
+		/*
+		 * FIXME: STALL_MODEL==0b10 && CD.S==0 is ILLEGAL
+		 */
+		if (ssid && smmu_domain->s1_cfg.can_stall)
+			val |= CTXDESC_CD_0_S;
 
+		cdptr[0] = cpu_to_le64(val);
 	}
 
 	if (ssid || cd_live)
@@ -1619,7 +1689,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		if (ste->prg_response_needs_ssid)
 			dst[1] |= STRTAB_STE_1_PPAR;
 
-		if (smmu->features & ARM_SMMU_FEAT_STALLS)
+		/*
+		 * FIXME: it is illegal to set S1STALLD if STALL_MODEL=0b10
+		 * (force). But according to the spec, it *must* be set for
+		 * devices that aren't capable of stalling (notably pci!)
+		 * So we need a "STALL_MODEL=0b00" feature bit.
+		 */
+		if (smmu->features & ARM_SMMU_FEAT_STALLS && !ste->can_stall)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (s1ctxptr & STRTAB_STE_0_S1CTXPTR_MASK
@@ -1701,6 +1777,53 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static void arm_smmu_handle_fault(struct work_struct *work);
+
+static int arm_smmu_handle_stall(struct arm_smmu_device *smmu, u64 *evt)
+{
+	u8 id = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
+	struct arm_smmu_fault *fault;
+	struct arm_smmu_fault params = {
+		.smmu	= smmu,
+
+		.sid	= evt[0] >> EVTQ_0_SID_SHIFT & EVTQ_0_SID_MASK,
+		.ssv	= evt[0] & EVTQ_0_SSV,
+		.ssid	= evt[0] >> EVTQ_0_SSID_SHIFT & EVTQ_0_SSID_MASK,
+		.grpid	= evt[1] >> EVTQ_1_STAG_SHIFT & EVTQ_1_STAG_MASK,
+
+		.iova	= evt[2] >> EVTQ_2_ADDR_SHIFT & EVTQ_2_ADDR_MASK,
+		.read	= evt[1] & EVTQ_1_READ,
+		.write	= !(evt[1] & EVTQ_1_READ),
+		.exec	= evt[1] & EVTQ_1_EXEC,
+		.priv	= evt[1] & EVTQ_1_PRIV,
+
+		.last	= true,
+		.stall	= true,
+	};
+
+	switch (id) {
+	case EVT_ID_TRANSLATION_FAULT:
+	case EVT_ID_ADDR_SIZE_FAULT:
+	case EVT_ID_ACCESS_FAULT:
+	case EVT_ID_PERMISSION_FAULT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fault = kmem_cache_alloc(arm_smmu_fault_cache, GFP_KERNEL);
+	if (!fault) {
+		arm_smmu_fault_reply(&params, ARM_SMMU_FAULT_FAIL);
+		return -ENOMEM;
+	}
+
+	*fault = params;
+	INIT_WORK(&fault->work, arm_smmu_handle_fault);
+	queue_work(smmu->fault_queue, &fault->work);
+
+	return 0;
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -1713,6 +1836,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt)) {
 			u8 id = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
 
+			if (evt[1] & EVTQ_1_STALL &&
+			    !arm_smmu_handle_stall(smmu, evt))
+				continue;
+
 			dev_info(smmu->dev, "event 0x%02x received:\n", id);
 			for (i = 0; i < ARRAY_SIZE(evt); ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
@@ -1733,8 +1860,6 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void arm_smmu_handle_fault(struct work_struct *work);
-
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt,
 				bool overflowing)
 {
@@ -2648,11 +2773,13 @@ static enum fault_status _arm_smmu_handle_fault(struct arm_smmu_fault *fault)
 		goto out_put_context;
 	}
 
-	list_for_each_entry(tmp_prg, &smmu_context->prgs, list) {
-		if (tmp_prg->sid == fault->sid && tmp_prg->index ==
-		    fault->grpid) {
-			prg = tmp_prg;
-			break;
+	if (!fault->stall) {
+		list_for_each_entry(tmp_prg, &smmu_context->prgs, list) {
+			if (tmp_prg->sid == fault->sid &&
+			    tmp_prg->index == fault->grpid) {
+				prg = tmp_prg;
+				break;
+			}
 		}
 	}
 
@@ -2742,8 +2869,7 @@ static void arm_smmu_flush_prgs(struct work_struct *work)
 
 static bool arm_smmu_master_supports_svm(struct arm_smmu_master_data *master)
 {
-	return dev_is_pci(master->dev) && master->can_fault &&
-		master->num_ssids > 1;
+	return master->can_fault && master->num_ssids > 1;
 }
 
 static int arm_smmu_set_svm_ops(struct device *dev,
@@ -2892,7 +3018,7 @@ static int arm_smmu_unbind_task(struct device *dev, int pasid)
 	 * TODO: only do this if the context hasn't been invalidated yet (with a
 	 * stop PASID).
 	 */
-	if (master->can_fault) {
+	if (dev_is_pci(dev) && master->can_fault) {
 		ret = arm_smmu_flush_priq(smmu);
 		if (ret)
 			return ret;
@@ -2958,7 +3084,7 @@ static int arm_smmu_detach_all_contexts(struct arm_smmu_master_data *master)
 	spin_unlock(&smmu->contexts_lock);
 
 	/* Propagate the invalidations */
-	if (master->can_fault) {
+	if (dev_is_pci(master->dev) && master->can_fault) {
 		arm_smmu_flush_priq(smmu); /* may fail */
 		flush_workqueue(smmu->fault_queue);
 	}
@@ -3271,8 +3397,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
 
-		if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 			smmu_domain->s1_cfg.num_contexts = master->num_ssids;
+			smmu_domain->s1_cfg.can_stall = master->ste.can_stall;
+		}
 
 		ret = arm_smmu_domain_finalise(domain);
 		if (ret) {
@@ -3286,17 +3414,26 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			dev_name(smmu->dev));
 		ret = -ENXIO;
 		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->num_ssids > 1 &&
-		   smmu_domain->s1_cfg.num_contexts > master->num_ssids) {
-		/*
-		 * New device does not support enough contexts for SVM. This is
-		 * OK within a domain (the device can simply be put in its own
-		 * domain) but within a group it might be problematic. FIXME
-		 */
-		dev_err(dev, "cannot attach to domain (not enough contexts)");
-		ret = -ESRCH;
-		goto out_unlock;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		/* Sanity checks */
+		if (master->num_ssids > 1 &&
+		    smmu_domain->s1_cfg.num_contexts > master->num_ssids) {
+			/*
+			 * New device does not support enough contexts for SVM.
+			 * This is OK within a domain (the device can simply be
+			 * put in its own domain) but within a group it might be
+			 * problematic. FIXME
+			 */
+			dev_err(dev, "cannot attach to domain (not enough contexts)");
+			ret = -ESRCH;
+			goto out_unlock;
+		}
+
+		if (master->ste.can_stall != smmu_domain->s1_cfg.can_stall) {
+			dev_err(dev, "devices within a domain must have the same stall capabilities");
+			ret = -EINVAL;
+			goto out_unlock;
+		}
 	}
 
 	ste->assigned = true;
@@ -3444,9 +3581,10 @@ static int arm_smmu_enable_ssid(struct arm_smmu_master_data *master)
 	int features;
 	int num_ssids;
 	struct pci_dev *pdev;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
 
 	if (!dev_is_pci(master->dev))
-		return -ENOSYS;
+		return 1 << fwspec->num_pasid_bits;
 
 	pdev = to_pci_dev(master->dev);
 
@@ -3589,6 +3727,11 @@ static int arm_smmu_add_device(struct device *dev)
 	if (!arm_smmu_enable_ats(master))
 		arm_smmu_enable_pri(master);
 
+	if (fwspec->can_stall && smmu->features & ARM_SMMU_FEAT_STALLS) {
+		master->can_fault = true;
+		master->ste.can_stall = true;
+	}
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
@@ -3937,7 +4080,8 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 		return ret;
 
 	if (smmu->features & ARM_SMMU_FEAT_SVM &&
-	    smmu->features & ARM_SMMU_FEAT_PRI) {
+	    (smmu->features & ARM_SMMU_FEAT_PRI ||
+	     smmu->features & ARM_SMMU_FEAT_STALLS)) {
 		/*
 		 * Ensure strict ordering of the queue. We can't go reordering
 		 * page faults willy nilly since they work in groups, with a
-- 
1.7.12.4
