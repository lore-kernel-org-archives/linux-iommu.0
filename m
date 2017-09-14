From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC] iommu: arm-smmu: stall support
Date: Thu, 14 Sep 2017 15:44:33 -0400
Message-ID: <20170914194444.32551-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Adds a new domain property for iommu clients to opt-in to stalling
with asynchronous resume, and for the client to determine if the
iommu supports this.

Current motivation is that:

a) On 8x96/a530, if we don't enable CFCFG (or HUPCF) then non-
   faulting translations which are happening concurrently with
   one that faults, fail (or return garbage), which triggers all
   sorts of fun GPU crashes, which generally have no relation
   to the root fault.  (The CP can be far ahead in the cmdstream
   from the other parts of the GPU...)

b) I am working on a debugfs feature to dump submits/batches
   that cause GPU hangs, and I would like to also use this for
   faults.  But it needs to run in non-atomic context, so I
   need to toss things off to a workqueue, and then resume
   the iommu after it finishes.

c) (and ofc at some point in the future for SVM we'd like to
   be able to pin unpinned pages and things like that, in
   response to faults.)

TODO
 - For RFC I thought it would be easier to review the idea
   as a single patch, but it should be split into separate
   core and arm-smmu parts

 - I vaguely remember someone (Will?) mentioning that there
   could be cases with multiple masters sharing a single
   context bank, and somehow stalling might not work in that
   case?  (How does that even happen, arm-smmu assignes the
   context banks?  Maybe I'm mis-remembering the details.)
   I think that this probably shouldn't effect the API parts
   of this RFC, the iommu driver should already know about
   all the devices that might attach because of ->attach_dev()
   so it could fail in _set_attr()?

Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 36 ++++++++++++++++++++++++++++++++----
 drivers/iommu/iommu.c    | 21 +++++++++++++++++++++
 include/linux/iommu.h    | 14 ++++++++++++++
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fe8e7fd61282..50131985a1e7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -239,6 +239,7 @@ struct arm_smmu_domain {
 	struct io_pgtable_ops		*pgtbl_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
+	bool				stall;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops */
 	struct iommu_domain		domain;
@@ -544,6 +545,24 @@ static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb_sync	= arm_smmu_tlb_sync_vmid,
 };
 
+static void arm_smmu_domain_resume(struct iommu_domain *domain, bool terminate)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *cb_base;
+	unsigned val;
+
+	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
+
+	if (terminate)
+		val = RESUME_TERMINATE;
+	else
+		val = RESUME_RETRY;
+
+	writel_relaxed(val, cb_base + ARM_SMMU_CB_RESUME);
+}
+
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	u32 fsr, fsynr;
@@ -563,11 +582,14 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
 	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
 
-	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cfg->cbndx);
-
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
+
+	if (!report_iommu_fault(domain, smmu->dev, iova, 0)) {
+		dev_err_ratelimited(smmu->dev,
+		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
+				    fsr, iova, fsynr, cfg->cbndx);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -698,6 +720,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
 	/* SCTLR */
 	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
+	if (smmu_domain->stall)
+		reg |= SCTLR_CFCFG;    /* stall on fault */
 	if (stage1)
 		reg |= SCTLR_S1_ASIDPNE;
 #ifdef __BIG_ENDIAN
@@ -1524,6 +1548,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
 		break;
+	case DOMAIN_ATTR_STALL:
+		smmu_domain->stall = *(bool *)data;
+		break;
 	default:
 		ret = -ENODEV;
 	}
@@ -1587,6 +1614,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.domain_resume		= arm_smmu_domain_resume,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f6ea160afed..49eecfb7abd7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1788,6 +1788,27 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+/**
+ * iommu_domain_resume - Resume translations for a domain after a fault.
+ *
+ * This can be called at some point after the fault handler is called,
+ * allowing the user of the IOMMU to (for example) handle the fault
+ * from a task context.  It is illegal to call this if
+ * iommu_domain_set_attr(STALL) failed.
+ *
+ * @domain:    the domain to resume
+ * @terminate: if true, the translation that triggered the fault should
+ *    be terminated, else it should be retried.
+ */
+void iommu_domain_resume(struct iommu_domain *domain, bool terminate)
+{
+	/* invalid to call if iommu_domain_set_attr(STALL) failed: */
+	if (WARN_ON(!domain->ops->domain_resume))
+		return;
+	domain->ops->domain_resume(domain, terminate);
+}
+EXPORT_SYMBOL_GPL(iommu_domain_resume);
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54adc4a33..2154fe2591a0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -124,6 +124,17 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	/*
+	 * Domain stalls faulting translations, if DOMAIN_ATTR_STALL is
+	 * enabled, user of domain calls iommu_domain_resume() at some
+	 * point (either from fault handler or asynchronously after
+	 * the fault handler is called (for example, from a workqueue)
+	 * to resume translations.
+	 *
+	 * The attribute value is a bool, and should be set before
+	 * attaching the domain.
+	 */
+	DOMAIN_ATTR_STALL,
 	DOMAIN_ATTR_MAX,
 };
 
@@ -208,6 +219,8 @@ struct iommu_ops {
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
 
+	void (*domain_resume)(struct iommu_domain *domain, bool terminate);
+
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
@@ -333,6 +346,7 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern void iommu_domain_resume(struct iommu_domain *domain, bool terminate);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-- 
2.13.5
