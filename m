From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 23/30] iommu/arm-smmu-v3: Bind/unbind device and task
Date: Mon, 27 Feb 2017 19:54:34 +0000
Message-ID: <20170227195441.5170-24-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Now that everything is in place, implement bind and unbind operations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 178 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5e0008ac68cb..3ba7f65020f9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -742,6 +742,7 @@ struct arm_smmu_master_data {
 
 	bool				can_fault;
 	u32				avail_contexts;
+	const struct iommu_svm_ops	*svm_ops;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -820,6 +821,7 @@ struct arm_smmu_context {
 
 	struct arm_smmu_task		*task;
 	struct arm_smmu_master_data	*master;
+	void				*priv;
 
 	struct list_head		task_head;
 	struct rb_node			master_node;
@@ -2085,6 +2087,26 @@ static size_t arm_smmu_atc_invalidate_task(struct arm_smmu_task *smmu_task,
 	return size;
 }
 
+static size_t arm_smmu_atc_invalidate_context(struct arm_smmu_context *smmu_context,
+					      unsigned long iova, size_t size)
+{
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_device *smmu = smmu_context->master->smmu;
+	struct arm_smmu_cmdq_ent sync_cmd = {
+		.opcode = CMDQ_OP_CMD_SYNC,
+	};
+
+	arm_smmu_atc_invalidate_to_cmd(smmu, iova, size, &cmd);
+
+	cmd.substream_valid = true;
+	cmd.atc.ssid = smmu_context->ssid;
+
+	arm_smmu_atc_invalidate_master(smmu_context->master, &cmd);
+	arm_smmu_cmdq_issue_cmd(smmu, &sync_cmd);
+
+	return size;
+}
+
 /* IOMMU API */
 static bool arm_smmu_capable(enum iommu_cap cap)
 {
@@ -2098,7 +2120,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
-__maybe_unused
 static struct arm_smmu_context *
 arm_smmu_attach_task(struct arm_smmu_task *smmu_task,
 		     struct arm_smmu_master_data *master)
@@ -2444,7 +2465,6 @@ static void arm_smmu_free_task_pgtable(struct arm_smmu_task *smmu_task)
 	arm_smmu_bitmap_free(smmu->asid_map, smmu_task->s1_cfg.asid);
 }
 
-__maybe_unused
 static struct arm_smmu_task *arm_smmu_alloc_task(struct arm_smmu_device *smmu,
 						 struct task_struct *task)
 {
@@ -2741,7 +2761,156 @@ static void arm_smmu_handle_fault(struct work_struct *work)
 
 static bool arm_smmu_master_supports_svm(struct arm_smmu_master_data *master)
 {
-	return false;
+	return dev_is_pci(master->dev) && master->can_fault &&
+		master->avail_contexts;
+}
+
+static int arm_smmu_set_svm_ops(struct device *dev,
+				const struct iommu_svm_ops *svm_ops)
+{
+	struct arm_smmu_master_data *master;
+
+	if (!dev->iommu_fwspec)
+		return -EINVAL;
+
+	master = dev->iommu_fwspec->iommu_priv;
+	if (!master)
+		return -EINVAL;
+
+	master->svm_ops = svm_ops;
+
+	return 0;
+}
+
+static int arm_smmu_bind_task(struct device *dev, struct task_struct *task,
+			      int *pasid, int flags, void *priv)
+{
+	int ret = 0;
+	struct pid *pid;
+	struct iommu_group *group;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_group *smmu_group;
+	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_task *smmu_task = NULL, *cur_task;
+	struct arm_smmu_context *smmu_context = NULL, *cur_context;
+
+	if (!dev->iommu_fwspec)
+		return -EINVAL;
+
+	master = dev->iommu_fwspec->iommu_priv;
+	if (!master)
+		return -EINVAL;
+
+	if (!arm_smmu_master_supports_svm(master))
+		return -EINVAL;
+
+	smmu = master->smmu;
+
+	group = iommu_group_get(dev);
+	smmu_group = to_smmu_group(group);
+
+	smmu_domain = smmu_group->domain;
+	if (!smmu_domain) {
+		iommu_group_put(group);
+		return -EINVAL;
+	}
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1) {
+		/* We do not support stage-2 SVM yet... */
+		iommu_group_put(group);
+		return -ENOSYS;
+	}
+
+	iommu_group_put(group);
+
+	pid = get_task_pid(task, PIDTYPE_PID);
+
+	spin_lock(&smmu->contexts_lock);
+
+	list_for_each_entry(cur_task, &smmu->tasks, smmu_head) {
+		if (cur_task->pid == pid) {
+			kref_get(&cur_task->kref);
+			smmu_task = cur_task;
+			break;
+		}
+	}
+
+	if (smmu_task) {
+		list_for_each_entry(cur_context, &smmu_task->contexts,
+				    task_head) {
+			if (cur_context->master->dev == dev) {
+				smmu_context = cur_context;
+				_arm_smmu_put_task(cur_task);
+				break;
+			}
+		}
+	}
+	spin_unlock(&smmu->contexts_lock);
+
+	put_pid(pid);
+
+	if (smmu_context)
+		/* We don't support nested bind/unbind calls */
+		return -EEXIST;
+
+	if (!smmu_task) {
+		smmu_task = arm_smmu_alloc_task(smmu, task);
+		if (IS_ERR(smmu_task))
+			return -PTR_ERR(smmu_task);
+	}
+
+	smmu_context = arm_smmu_attach_task(smmu_task, master);
+	if (IS_ERR(smmu_context)) {
+		arm_smmu_put_task(smmu, smmu_task);
+		return PTR_ERR(smmu_context);
+	}
+
+	smmu_context->priv = priv;
+
+	*pasid = smmu_context->ssid;
+	dev_dbg(dev, "bound to task %d with PASID %d\n", pid_vnr(pid), *pasid);
+
+	return ret;
+}
+
+static int arm_smmu_unbind_task(struct device *dev, int pasid, int flags)
+{
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_context *smmu_context = NULL;
+
+	if (!dev->iommu_fwspec)
+		return -EINVAL;
+
+	master = dev->iommu_fwspec->iommu_priv;
+	if (!master)
+		return -EINVAL;
+
+	smmu = master->smmu;
+
+	smmu_context = arm_smmu_get_context_by_id(smmu, master, 0, pasid);
+	if (!smmu_context)
+		return -ESRCH;
+
+	dev_dbg(dev, "unbind PASID %d\n", pasid);
+
+	/*
+	 * There isn't any "ATC invalidate all by PASID" command. If this isn't
+	 * good enough, we'll need fine-grained invalidation for each vma.
+	 */
+	arm_smmu_atc_invalidate_context(smmu_context, 0, -1);
+
+	spin_lock(&smmu->contexts_lock);
+	if (smmu_context->task)
+		arm_smmu_detach_task(smmu_context);
+
+	/* Release the ref we got earlier in this function */
+	_arm_smmu_put_context(smmu_context);
+	_arm_smmu_put_context(smmu_context);
+	spin_unlock(&smmu->contexts_lock);
+
+	return 0;
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -3626,6 +3795,9 @@ static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
+	.set_svm_ops		= arm_smmu_set_svm_ops,
+	.bind_task		= arm_smmu_bind_task,
+	.unbind_task		= arm_smmu_unbind_task,
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
-- 
2.11.0
