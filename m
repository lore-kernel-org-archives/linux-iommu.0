From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC 2/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Wed,  1 Feb 2017 10:23:40 -0500
Message-ID: <20170201152341.29142-3-robdclark@gmail.com>
References: <20170201152341.29142-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170201152341.29142-1-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

TODO maybe some dev_dbg() or some other way to tell if stalling is
actually enabled?

Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |  3 +
 drivers/iommu/arm-smmu.c                           | 85 ++++++++++++++++++++--
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index ef465b0..5f405a6 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -68,6 +68,9 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- arm,smmu-enable-stall : Enable stall mode to stall memory transactions
+                  and resume after fault is handled
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d505432..96a1be6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -350,6 +350,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_ENABLE_STALL      (1 << 1)
 	u32				options;
 	enum arm_smmu_arch_version	version;
 	enum arm_smmu_implementation	model;
@@ -377,6 +378,8 @@ struct arm_smmu_device {
 	int                             num_clocks;
 	struct clk                      **clocks;
 
+	struct list_head		domain_list;
+
 	u32				cavium_id_base; /* Specific to Cavium */
 };
 
@@ -412,6 +415,7 @@ struct arm_smmu_domain {
 	enum arm_smmu_domain_stage	stage;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	struct iommu_domain		domain;
+	struct list_head		domain_node;
 };
 
 struct arm_smmu_option_prop {
@@ -425,6 +429,7 @@ static bool using_legacy_binding, using_generic_binding;
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ ARM_SMMU_OPT_ENABLE_STALL,      "arm,smmu-enable-stall" },
 	{ 0, NULL},
 };
 
@@ -676,7 +681,8 @@ static struct iommu_gather_ops arm_smmu_gather_ops = {
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
-	u32 fsr, fsynr;
+	int flags, ret;
+	u32 fsr, fsynr, resume;
 	unsigned long iova;
 	struct iommu_domain *domain = dev;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -690,15 +696,48 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	if (!(fsr & FSR_FAULT))
 		return IRQ_NONE;
 
+	if (fsr & FSR_IGN)
+		dev_err_ratelimited(smmu->dev,
+				    "Unexpected context fault (fsr 0x%x)\n",
+				    fsr);
+
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
-	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
 
-	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cfg->cbndx);
+	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
+		ret = IRQ_HANDLED;
+		resume = RESUME_RETRY;
+	} else {
+		dev_err_ratelimited(smmu->dev,
+		    "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
+		    iova, fsynr, cfg->cbndx);
+		ret = IRQ_NONE;
+		resume = RESUME_TERMINATE;
+	}
 
+	/* Clear the faulting FSR */
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
-	return IRQ_HANDLED;
+
+	if ((fsr & FSR_SS) && !domain->can_stall) {
+		/* Retry or terminate any stalled transactions */
+		writel_relaxed(resume, cb_base + ARM_SMMU_CB_RESUME);
+	}
+
+	return ret;
+}
+
+static void arm_smmu_domain_resume(struct iommu_domain *domain, bool resume)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *cb_base;
+
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+
+	writel_relaxed(resume ? RESUME_RETRY : RESUME_TERMINATE,
+			cb_base + ARM_SMMU_CB_RESUME);
 }
 
 static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
@@ -725,6 +764,20 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static bool arm_smmu_can_stall(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_domain *smmu_domain;
+
+	if (!(smmu->options & ARM_SMMU_OPT_ENABLE_STALL))
+		return false;
+
+	list_for_each_entry(smmu_domain, &smmu->domain_list, domain_node)
+		if (!smmu_domain->domain.can_stall)
+			return false;
+
+	return true;
+}
+
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
@@ -824,6 +877,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
 	/* SCTLR */
 	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
+	if (arm_smmu_can_stall(smmu))
+		reg |= SCTLR_CFCFG;
 	if (stage1)
 		reg |= SCTLR_S1_ASIDPNE;
 #ifdef __BIG_ENDIAN
@@ -1049,6 +1104,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
+	INIT_LIST_HEAD(&smmu_domain->domain_node);
 
 	return &smmu_domain->domain;
 }
@@ -1246,6 +1302,13 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	list_del_init(&smmu_domain->domain_node);
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
@@ -1259,6 +1322,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	smmu = fwspec_smmu(fwspec);
+
+	if (WARN_ON(!list_empty(&smmu_domain->domain_node)))
+		return -EINVAL;
+
+	list_add_tail(&smmu_domain->domain_node, &smmu->domain_list);
+
 	/* Ensure that the domain is finalised */
 	ret = arm_smmu_init_domain_context(domain, smmu);
 	if (ret < 0)
@@ -1578,6 +1647,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.domain_free		= arm_smmu_domain_free,
+	.detach_dev		= arm_smmu_detach_dev,
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
@@ -1588,6 +1658,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.domain_resume		= arm_smmu_domain_resume,
 	.of_xlate		= arm_smmu_of_xlate,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
@@ -2001,6 +2072,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	INIT_LIST_HEAD(&smmu->domain_list);
+
 	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
-- 
2.9.3
