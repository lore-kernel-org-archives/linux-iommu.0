From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V2 1/5] iommu/msm: Add DT adaptation
Date: Wed,  6 Apr 2016 19:59:31 +0530
Message-ID: <1459952975-1250-2-git-send-email-sricharan@codeaurora.org>
References: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com, robdclark@gmail.com, joro@8bytes.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, Will.Deacon@arm.com, stepanm@codeaurora.org, treding@nvidia.com
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

The driver currently works based on platform data. Remove this
and add support for DT. A single master can have multiple ports
connected to more than one iommu.

	  	      master
        	        |
	                |
	                |
	   ------------------------
           |  			  |
	IOMMU0			IOMMU1
           |			  |
      ctx0   ctx1	     ctx0   ctx1

This association of master and iommus/contexts were previously
represented by platform data parent/child device details. The client
drivers were responsible for programming all of the iommus/contexts
for the device. Now while adapting to generic DT bindings we maintain the
list of iommus, contexts that each master domain is connected to and
program all of them on attach/detach.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  59 ++++
 drivers/iommu/msm_iommu.c                          | 252 +++++++++--------
 drivers/iommu/msm_iommu.h                          |  73 ++---
 drivers/iommu/msm_iommu_dev.c                      | 315 +++++----------------
 4 files changed, 296 insertions(+), 403 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
new file mode 100644
index 0000000..21bfbfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
@@ -0,0 +1,59 @@
+* QCOM IOMMU
+
+The QCOM IOMMU is an implementation compatible with the ARM VMSA short
+descriptor page tables. It provides address translation for bus masters outside
+of the CPU, each connected to the IOMMU through a port called micro-TLB.
+
+Required Properties:
+
+  - compatible: Must contain "qcom,iommu-v0".
+  - reg: Base address and size of the IOMMU registers.
+  - interrupts: Specifiers for the MMU fault interrupts. For instances that
+    support secure mode two interrupts must be specified, for non-secure and
+    secure mode, in that order. For instances that don't support secure mode a
+    single interrupt must be specified.
+  - #iommu-cells: This is the total number of stream ids that a master would
+		  use during transactions which will be specified as a list
+		  as a part of iommus property below.
+  - ncb: The total number of context banks in the IOMMU.
+  - clocks	: List of clocks to be used during SMMU register access. See
+		  Documentation/devicetree/bindings/clock/clock-bindings.txt
+		  for information about the format. For each clock specified
+		  here, there must be a corresponding entry in clock-names
+		  (see below).
+
+  - clock-names	: List of clock names corresponding to the clocks specified in
+		  the "clocks" property (above). See
+		  Documentation/devicetree/bindings/clock/clock-bindings.txt
+		  for more info.
+
+Each bus master connected to an IOMMU must reference the IOMMU in its device
+node with the following property:
+
+  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
+	    phandle to the IOMMU and the second cell is the list of the
+	    stream ids used by the device.
+
+Example: mdp iommu and its bus master
+
+                mdp_port0: qcom,iommu@7500000 {
+			compatible = "msm,iommu-v0";
+			#iommu-cells = <2>;
+			clock-names =
+			    "smmu_pclk",
+			    "iommu_clk";
+			clocks =
+			    <&mmcc SMMU_AHB_CLK>,
+			    <&mmcc MDP_AXI_CLK>;
+			reg = <0x07500000 0x100000>;
+			interrupts =
+			    <GIC_SPI 63 0>,
+			    <GIC_SPI 64 0>;
+			ncb = <2>;
+		};
+
+		mdp: qcom,mdp@5100000 {
+			compatible = "qcom,mdp";
+			...
+			iommus = <&mdp_port0 0 2>;
+		};
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index e321fa5..bc1a4e3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -48,6 +48,7 @@ __asm__ __volatile__ (							\
 static int msm_iommu_tex_class[4];
 
 DEFINE_SPINLOCK(msm_iommu_lock);
+static LIST_HEAD(qcom_iommu_devices);
 
 struct msm_priv {
 	unsigned long *pgtable;
@@ -60,35 +61,37 @@ static struct msm_priv *to_msm_priv(struct iommu_domain *dom)
 	return container_of(dom, struct msm_priv, domain);
 }
 
-static int __enable_clocks(struct msm_iommu_drvdata *drvdata)
+static int __enable_clocks(struct msm_iommu_dev *iommu)
 {
 	int ret;
 
-	ret = clk_enable(drvdata->pclk);
+	ret = clk_enable(iommu->pclk);
 	if (ret)
 		goto fail;
 
-	if (drvdata->clk) {
-		ret = clk_enable(drvdata->clk);
+	if (iommu->clk) {
+		ret = clk_enable(iommu->clk);
 		if (ret)
-			clk_disable(drvdata->pclk);
+			clk_disable(iommu->pclk);
 	}
 fail:
 	return ret;
 }
 
-static void __disable_clocks(struct msm_iommu_drvdata *drvdata)
+static void __disable_clocks(struct msm_iommu_dev *iommu)
 {
-	clk_disable(drvdata->clk);
-	clk_disable(drvdata->pclk);
+	if (iommu->clk)
+		clk_disable(iommu->clk);
+	clk_disable(iommu->pclk);
 }
 
 static int __flush_iotlb(struct iommu_domain *domain)
 {
 	struct msm_priv *priv = to_msm_priv(domain);
-	struct msm_iommu_drvdata *iommu_drvdata;
-	struct msm_iommu_ctx_drvdata *ctx_drvdata;
+	struct msm_iommu_dev *iommu = NULL;
+	struct msm_iommu_ctx_dev *master;
 	int ret = 0;
+
 #ifndef CONFIG_IOMMU_PGTABLES_L2
 	unsigned long *fl_table = priv->pgtable;
 	int i;
@@ -105,24 +108,67 @@ static int __flush_iotlb(struct iommu_domain *domain)
 	}
 #endif
 
-	list_for_each_entry(ctx_drvdata, &priv->list_attached, attached_elm) {
-
-		BUG_ON(!ctx_drvdata->pdev || !ctx_drvdata->pdev->dev.parent);
-
-		iommu_drvdata = dev_get_drvdata(ctx_drvdata->pdev->dev.parent);
-		BUG_ON(!iommu_drvdata);
-
-		ret = __enable_clocks(iommu_drvdata);
+	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
+		ret = __enable_clocks(iommu);
 		if (ret)
 			goto fail;
 
-		SET_CTX_TLBIALL(iommu_drvdata->base, ctx_drvdata->num, 0);
-		__disable_clocks(iommu_drvdata);
+		list_for_each_entry(master, &iommu->ctx_list, list)
+			SET_CTX_TLBIALL(iommu->base, master->num, 0);
+
+		__disable_clocks(iommu);
 	}
 fail:
 	return ret;
 }
 
+static int msm_iommu_alloc_ctx(unsigned long *map, int start, int end)
+{
+	int idx;
+
+	do {
+		idx = find_next_zero_bit(map, end, start);
+		if (idx == end)
+			return -ENOSPC;
+	} while (test_and_set_bit(idx, map));
+
+	return idx;
+}
+
+static void msm_iommu_free_ctx(unsigned long *map, int idx)
+{
+	clear_bit(idx, map);
+}
+
+static void config_mids(struct msm_iommu_dev *iommu,
+			struct msm_iommu_ctx_dev *master)
+{
+	int mid, ctx, i;
+
+	for (i = 0; i < master->num_mids; i++) {
+		mid = master->mids[i];
+		ctx = master->num;
+
+		SET_M2VCBR_N(iommu->base, mid, 0);
+		SET_CBACR_N(iommu->base, ctx, 0);
+
+		/* Set VMID = 0 */
+		SET_VMID(iommu->base, mid, 0);
+
+		/* Set the context number for that MID to this context */
+		SET_CBNDX(iommu->base, mid, ctx);
+
+		/* Set MID associated with this context bank to 0*/
+		SET_CBVMID(iommu->base, ctx, 0);
+
+		/* Set the ASID for TLB tagging for this context */
+		SET_CONTEXTIDR_ASID(iommu->base, ctx, ctx);
+
+		/* Set security bit override to be Non-secure */
+		SET_NSCFG(iommu->base, mid, 3);
+	}
+}
+
 static void __reset_context(void __iomem *base, int ctx)
 {
 	SET_BPRCOSH(base, ctx, 0);
@@ -272,94 +318,76 @@ static void msm_iommu_domain_free(struct iommu_domain *domain)
 
 static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct msm_priv *priv;
-	struct msm_iommu_ctx_dev *ctx_dev;
-	struct msm_iommu_drvdata *iommu_drvdata;
-	struct msm_iommu_ctx_drvdata *ctx_drvdata;
-	struct msm_iommu_ctx_drvdata *tmp_drvdata;
 	int ret = 0;
 	unsigned long flags;
+	struct msm_iommu_dev *iommu;
+	struct msm_priv *priv = to_msm_priv(domain);
+	struct msm_iommu_ctx_dev *master;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-
-	priv = to_msm_priv(domain);
-
-	if (!dev) {
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	iommu_drvdata = dev_get_drvdata(dev->parent);
-	ctx_drvdata = dev_get_drvdata(dev);
-	ctx_dev = dev->platform_data;
-
-	if (!iommu_drvdata || !ctx_drvdata || !ctx_dev) {
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	if (!list_empty(&ctx_drvdata->attached_elm)) {
-		ret = -EBUSY;
-		goto fail;
-	}
-
-	list_for_each_entry(tmp_drvdata, &priv->list_attached, attached_elm)
-		if (tmp_drvdata == ctx_drvdata) {
-			ret = -EBUSY;
-			goto fail;
+	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
+		master = list_first_entry(&iommu->ctx_list,
+					  struct msm_iommu_ctx_dev,
+					  list);
+		if (master->of_node == dev->of_node) {
+			ret = __enable_clocks(iommu);
+			if (ret)
+				goto fail;
+
+			list_for_each_entry(master, &iommu->ctx_list, list) {
+				if (master->num) {
+					dev_err(dev, "domain already attached");
+					ret = -EEXIST;
+					goto fail;
+				}
+				master->num =
+					msm_iommu_alloc_ctx(iommu->context_map,
+							    0, iommu->ncb);
+					if (IS_ERR_VALUE(master->num)) {
+						ret = -ENODEV;
+						goto fail;
+					}
+				config_mids(iommu, master);
+				__program_context(iommu->base, master->num,
+						  __pa(priv->pgtable));
+			}
+			__disable_clocks(iommu);
+			list_add(&iommu->dom_node, &priv->list_attached);
 		}
+	}
 
-	ret = __enable_clocks(iommu_drvdata);
-	if (ret)
-		goto fail;
-
-	__program_context(iommu_drvdata->base, ctx_dev->num,
-			  __pa(priv->pgtable));
-
-	__disable_clocks(iommu_drvdata);
-	list_add(&(ctx_drvdata->attached_elm), &priv->list_attached);
 	ret = __flush_iotlb(domain);
-
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
 	return ret;
 }
 
 static void msm_iommu_detach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct msm_priv *priv;
-	struct msm_iommu_ctx_dev *ctx_dev;
-	struct msm_iommu_drvdata *iommu_drvdata;
-	struct msm_iommu_ctx_drvdata *ctx_drvdata;
+	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
+	struct msm_iommu_dev *iommu;
+	struct msm_iommu_ctx_dev *master;
 	int ret;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	priv = to_msm_priv(domain);
-
-	if (!dev)
-		goto fail;
-
-	iommu_drvdata = dev_get_drvdata(dev->parent);
-	ctx_drvdata = dev_get_drvdata(dev);
-	ctx_dev = dev->platform_data;
-
-	if (!iommu_drvdata || !ctx_drvdata || !ctx_dev)
-		goto fail;
-
 	ret = __flush_iotlb(domain);
 	if (ret)
 		goto fail;
 
-	ret = __enable_clocks(iommu_drvdata);
-	if (ret)
-		goto fail;
-
-	__reset_context(iommu_drvdata->base, ctx_dev->num);
-	__disable_clocks(iommu_drvdata);
-	list_del_init(&ctx_drvdata->attached_elm);
+	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
+		ret = __enable_clocks(iommu);
+		if (ret)
+			goto fail;
 
+		list_for_each_entry(master, &iommu->ctx_list, list) {
+			msm_iommu_free_ctx(iommu->context_map, master->num);
+			__reset_context(iommu->base, master->num);
+		}
+		__disable_clocks(iommu);
+	}
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 }
@@ -555,47 +583,46 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t va)
 {
 	struct msm_priv *priv;
-	struct msm_iommu_drvdata *iommu_drvdata;
-	struct msm_iommu_ctx_drvdata *ctx_drvdata;
+	struct msm_iommu_dev *iommu;
+	struct msm_iommu_ctx_dev *master;
 	unsigned int par;
 	unsigned long flags;
-	void __iomem *base;
 	phys_addr_t ret = 0;
-	int ctx;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
 	priv = to_msm_priv(domain);
-	if (list_empty(&priv->list_attached))
-		goto fail;
+	iommu = list_first_entry(&priv->list_attached,
+				 struct msm_iommu_dev, dom_node);
 
-	ctx_drvdata = list_entry(priv->list_attached.next,
-				 struct msm_iommu_ctx_drvdata, attached_elm);
-	iommu_drvdata = dev_get_drvdata(ctx_drvdata->pdev->dev.parent);
+	if (list_empty(&iommu->ctx_list))
+		goto fail;
 
-	base = iommu_drvdata->base;
-	ctx = ctx_drvdata->num;
+	master = list_first_entry(&iommu->ctx_list,
+				  struct msm_iommu_ctx_dev, list);
+	if (!master)
+		goto fail;
 
-	ret = __enable_clocks(iommu_drvdata);
+	ret = __enable_clocks(iommu);
 	if (ret)
 		goto fail;
 
 	/* Invalidate context TLB */
-	SET_CTX_TLBIALL(base, ctx, 0);
-	SET_V2PPR(base, ctx, va & V2Pxx_VA);
+	SET_CTX_TLBIALL(iommu->base, master->num, 0);
+	SET_V2PPR(iommu->base, master->num, va & V2Pxx_VA);
 
-	par = GET_PAR(base, ctx);
+	par = GET_PAR(iommu->base, master->num);
 
 	/* We are dealing with a supersection */
-	if (GET_NOFAULT_SS(base, ctx))
+	if (GET_NOFAULT_SS(iommu->base, master->num))
 		ret = (par & 0xFF000000) | (va & 0x00FFFFFF);
 	else	/* Upper 20 bits from PAR, lower 12 from VA */
 		ret = (par & 0xFFFFF000) | (va & 0x00000FFF);
 
-	if (GET_FAULT(base, ctx))
+	if (GET_FAULT(iommu->base, master->num))
 		ret = 0;
 
-	__disable_clocks(iommu_drvdata);
+	__disable_clocks(iommu);
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 	return ret;
@@ -635,37 +662,34 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 
 irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 {
-	struct msm_iommu_drvdata *drvdata = dev_id;
-	void __iomem *base;
+	struct msm_iommu_dev *iommu = dev_id;
 	unsigned int fsr;
 	int i, ret;
 
 	spin_lock(&msm_iommu_lock);
 
-	if (!drvdata) {
+	if (!iommu) {
 		pr_err("Invalid device ID in context interrupt handler\n");
 		goto fail;
 	}
 
-	base = drvdata->base;
-
 	pr_err("Unexpected IOMMU page fault!\n");
-	pr_err("base = %08x\n", (unsigned int) base);
+	pr_err("base = %08x\n", (unsigned int)iommu->base);
 
-	ret = __enable_clocks(drvdata);
+	ret = __enable_clocks(iommu);
 	if (ret)
 		goto fail;
 
-	for (i = 0; i < drvdata->ncb; i++) {
-		fsr = GET_FSR(base, i);
+	for (i = 0; i < iommu->ncb; i++) {
+		fsr = GET_FSR(iommu->base, i);
 		if (fsr) {
 			pr_err("Fault occurred in context %d.\n", i);
 			pr_err("Interesting registers:\n");
-			print_ctx_regs(base, i);
-			SET_FSR(base, i, 0x4000000F);
+			print_ctx_regs(iommu->base, i);
+			SET_FSR(iommu->base, i, 0x4000000F);
 		}
 	}
-	__disable_clocks(drvdata);
+	__disable_clocks(iommu);
 fail:
 	spin_unlock(&msm_iommu_lock);
 	return 0;
diff --git a/drivers/iommu/msm_iommu.h b/drivers/iommu/msm_iommu.h
index 5c7c955..4ca25d5 100644
--- a/drivers/iommu/msm_iommu.h
+++ b/drivers/iommu/msm_iommu.h
@@ -42,74 +42,53 @@
  */
 #define MAX_NUM_MIDS	32
 
+/* Maximum number of context banks that can be present in IOMMU */
+#define IOMMU_MAX_CBS	128
+
 /**
  * struct msm_iommu_dev - a single IOMMU hardware instance
- * name		Human-readable name given to this IOMMU HW instance
  * ncb		Number of context banks present on this IOMMU HW instance
+ * dev:		IOMMU device
+ * irq:		Interrupt number
+ * clk:		The bus clock for this IOMMU hardware instance
+ * pclk:	The clock for the IOMMU bus interconnect
+ * dev_node:	list head in qcom_iommu_device_list
+ * dom_node:	list head for domain
+ * ctx_list:	list of 'struct msm_iommu_ctx_dev'
+ * context_map: Bitmap to track allocated context banks
  */
 struct msm_iommu_dev {
-	const char *name;
+	void __iomem *base;
 	int ncb;
+	struct device *dev;
+	int irq;
+	struct clk *clk;
+	struct clk *pclk;
+	struct list_head dev_node;
+	struct list_head dom_node;
+	struct list_head ctx_list;
+	DECLARE_BITMAP(context_map, IOMMU_MAX_CBS);
 };
 
 /**
  * struct msm_iommu_ctx_dev - an IOMMU context bank instance
- * name		Human-readable name given to this context bank
+ * of_node	node ptr of client device
  * num		Index of this context bank within the hardware
  * mids		List of Machine IDs that are to be mapped into this context
  *		bank, terminated by -1. The MID is a set of signals on the
  *		AXI bus that identifies the function associated with a specific
  *		memory request. (See ARM spec).
+ * num_mids	Total number of mids
+ * node		list head in ctx_list
  */
 struct msm_iommu_ctx_dev {
-	const char *name;
+	struct device_node *of_node;
 	int num;
 	int mids[MAX_NUM_MIDS];
+	int num_mids;
+	struct list_head list;
 };
 
-
-/**
- * struct msm_iommu_drvdata - A single IOMMU hardware instance
- * @base:	IOMMU config port base address (VA)
- * @ncb		The number of contexts on this IOMMU
- * @irq:	Interrupt number
- * @clk:	The bus clock for this IOMMU hardware instance
- * @pclk:	The clock for the IOMMU bus interconnect
- *
- * A msm_iommu_drvdata holds the global driver data about a single piece
- * of an IOMMU hardware instance.
- */
-struct msm_iommu_drvdata {
-	void __iomem *base;
-	int irq;
-	int ncb;
-	struct clk *clk;
-	struct clk *pclk;
-};
-
-/**
- * struct msm_iommu_ctx_drvdata - an IOMMU context bank instance
- * @num:		Hardware context number of this context
- * @pdev:		Platform device associated wit this HW instance
- * @attached_elm:	List element for domains to track which devices are
- *			attached to them
- *
- * A msm_iommu_ctx_drvdata holds the driver data for a single context bank
- * within each IOMMU hardware instance
- */
-struct msm_iommu_ctx_drvdata {
-	int num;
-	struct platform_device *pdev;
-	struct list_head attached_elm;
-};
-
-/*
- * Look up an IOMMU context device by its context name. NULL if none found.
- * Useful for testing and drivers that do not yet fully have IOMMU stuff in
- * their platform devices.
- */
-struct device *msm_iommu_get_ctx(const char *ctx_name);
-
 /*
  * Interrupt handler for the IOMMU context fault interrupt. Hooking the
  * interrupt is not supported in the API yet, but this will print an error
diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
index 4b09e81..9bde35c 100644
--- a/drivers/iommu/msm_iommu_dev.c
+++ b/drivers/iommu/msm_iommu_dev.c
@@ -30,60 +30,6 @@
 #include "msm_iommu_hw-8xxx.h"
 #include "msm_iommu.h"
 
-struct iommu_ctx_iter_data {
-	/* input */
-	const char *name;
-
-	/* output */
-	struct device *dev;
-};
-
-static struct platform_device *msm_iommu_root_dev;
-
-static int each_iommu_ctx(struct device *dev, void *data)
-{
-	struct iommu_ctx_iter_data *res = data;
-	struct msm_iommu_ctx_dev *c = dev->platform_data;
-
-	if (!res || !c || !c->name || !res->name)
-		return -EINVAL;
-
-	if (!strcmp(res->name, c->name)) {
-		res->dev = dev;
-		return 1;
-	}
-	return 0;
-}
-
-static int each_iommu(struct device *dev, void *data)
-{
-	return device_for_each_child(dev, data, each_iommu_ctx);
-}
-
-struct device *msm_iommu_get_ctx(const char *ctx_name)
-{
-	struct iommu_ctx_iter_data r;
-	int found;
-
-	if (!msm_iommu_root_dev) {
-		pr_err("No root IOMMU device.\n");
-		goto fail;
-	}
-
-	r.name = ctx_name;
-	found = device_for_each_child(&msm_iommu_root_dev->dev, &r, each_iommu);
-
-	if (!found) {
-		pr_err("Could not find context <%s>\n", ctx_name);
-		goto fail;
-	}
-
-	return r.dev;
-fail:
-	return NULL;
-}
-EXPORT_SYMBOL(msm_iommu_get_ctx);
-
 static void msm_iommu_reset(void __iomem *base, int ncb)
 {
 	int ctx;
@@ -128,237 +74,122 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
 static int msm_iommu_probe(struct platform_device *pdev)
 {
 	struct resource *r;
-	struct clk *iommu_clk;
-	struct clk *iommu_pclk;
-	struct msm_iommu_drvdata *drvdata;
-	struct msm_iommu_dev *iommu_dev = dev_get_platdata(&pdev->dev);
-	void __iomem *regs_base;
-	int ret, irq, par;
+	struct msm_iommu_dev *iommu;
+	int ret, par, val;
 
-	if (pdev->id == -1) {
-		msm_iommu_root_dev = pdev;
-		return 0;
-	}
+	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		return -ENODEV;
 
-	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	iommu->dev = &pdev->dev;
+	INIT_LIST_HEAD(&iommu->ctx_list);
 
-	if (!drvdata) {
-		ret = -ENOMEM;
-		goto fail;
+	iommu->pclk = devm_clk_get(iommu->dev, "smmu_pclk");
+	if (IS_ERR(iommu->pclk)) {
+		dev_err(iommu->dev, "could not get smmu_pclk\n");
+		return PTR_ERR(iommu->pclk);
 	}
 
-	if (!iommu_dev) {
-		ret = -ENODEV;
-		goto fail;
+	ret = clk_prepare(iommu->pclk);
+	if (ret) {
+		dev_err(iommu->dev, "could not prepare smmu_pclk\n");
+		return ret;
 	}
 
-	iommu_pclk = clk_get(NULL, "smmu_pclk");
-	if (IS_ERR(iommu_pclk)) {
-		ret = -ENODEV;
-		goto fail;
+	iommu->clk = devm_clk_get(iommu->dev, "iommu_clk");
+	if (IS_ERR(iommu->clk)) {
+		dev_err(iommu->dev, "could not get iommu_clk\n");
+		clk_unprepare(iommu->pclk);
+		return PTR_ERR(iommu->clk);
 	}
 
-	ret = clk_prepare_enable(iommu_pclk);
-	if (ret)
-		goto fail_enable;
-
-	iommu_clk = clk_get(&pdev->dev, "iommu_clk");
-
-	if (!IS_ERR(iommu_clk))	{
-		if (clk_get_rate(iommu_clk) == 0)
-			clk_set_rate(iommu_clk, 1);
-
-		ret = clk_prepare_enable(iommu_clk);
-		if (ret) {
-			clk_put(iommu_clk);
-			goto fail_pclk;
-		}
-	} else
-		iommu_clk = NULL;
+	ret = clk_prepare(iommu->clk);
+	if (ret) {
+		dev_err(iommu->dev, "could not prepare iommu_clk\n");
+		clk_unprepare(iommu->pclk);
+		return ret;
+	}
 
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "physbase");
-	regs_base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(regs_base)) {
-		ret = PTR_ERR(regs_base);
-		goto fail_clk;
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iommu->base = devm_ioremap_resource(iommu->dev, r);
+	if (IS_ERR(iommu->base)) {
+		dev_err(iommu->dev, "could not get iommu base\n");
+		ret = PTR_ERR(iommu->base);
+		goto fail;
 	}
 
-	irq = platform_get_irq_byname(pdev, "secure_irq");
-	if (irq < 0) {
+	iommu->irq = platform_get_irq(pdev, 0);
+	if (iommu->irq < 0) {
+		dev_err(iommu->dev, "could not get iommu irq\n");
 		ret = -ENODEV;
-		goto fail_clk;
+		goto fail;
 	}
 
-	msm_iommu_reset(regs_base, iommu_dev->ncb);
+	ret = of_property_read_u32(iommu->dev->of_node, "ncb", &val);
+	if (ret) {
+		dev_err(iommu->dev, "could not get ncb\n");
+		goto fail;
+	}
+	iommu->ncb = val;
 
-	SET_M(regs_base, 0, 1);
-	SET_PAR(regs_base, 0, 0);
-	SET_V2PCFG(regs_base, 0, 1);
-	SET_V2PPR(regs_base, 0, 0);
-	par = GET_PAR(regs_base, 0);
-	SET_V2PCFG(regs_base, 0, 0);
-	SET_M(regs_base, 0, 0);
+	msm_iommu_reset(iommu->base, iommu->ncb);
+	SET_M(iommu->base, 0, 1);
+	SET_PAR(iommu->base, 0, 0);
+	SET_V2PCFG(iommu->base, 0, 1);
+	SET_V2PPR(iommu->base, 0, 0);
+	par = GET_PAR(iommu->base, 0);
+	SET_V2PCFG(iommu->base, 0, 0);
+	SET_M(iommu->base, 0, 0);
 
 	if (!par) {
-		pr_err("%s: Invalid PAR value detected\n", iommu_dev->name);
+		pr_err("Invalid PAR value detected\n");
 		ret = -ENODEV;
-		goto fail_clk;
+		goto fail;
 	}
 
-	ret = request_irq(irq, msm_iommu_fault_handler, 0,
-			"msm_iommu_secure_irpt_handler", drvdata);
+	ret = devm_request_threaded_irq(iommu->dev, iommu->irq, NULL,
+					msm_iommu_fault_handler,
+					IRQF_ONESHOT | IRQF_SHARED,
+					"msm_iommu_secure_irpt_handler",
+					iommu);
 	if (ret) {
-		pr_err("Request IRQ %d failed with ret=%d\n", irq, ret);
-		goto fail_clk;
+		pr_err("Request IRQ %d failed with ret=%d\n", iommu->irq, ret);
+		goto fail;
 	}
 
+	list_add(&iommu->dev_node, &qcom_iommu_devices);
 
-	drvdata->pclk = iommu_pclk;
-	drvdata->clk = iommu_clk;
-	drvdata->base = regs_base;
-	drvdata->irq = irq;
-	drvdata->ncb = iommu_dev->ncb;
-
-	pr_info("device %s mapped at %p, irq %d with %d ctx banks\n",
-		iommu_dev->name, regs_base, irq, iommu_dev->ncb);
-
-	platform_set_drvdata(pdev, drvdata);
-
-	clk_disable(iommu_clk);
-
-	clk_disable(iommu_pclk);
-
-	return 0;
-fail_clk:
-	if (iommu_clk) {
-		clk_disable(iommu_clk);
-		clk_put(iommu_clk);
-	}
-fail_pclk:
-	clk_disable_unprepare(iommu_pclk);
-fail_enable:
-	clk_put(iommu_pclk);
+	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
+		iommu->base, iommu->irq, iommu->ncb);
 fail:
-	kfree(drvdata);
+	clk_unprepare(iommu->clk);
+	clk_unprepare(iommu->pclk);
 	return ret;
 }
 
+static const struct of_device_id msm_iommu_dt_match[] = {
+	{ .compatible = "qcom,iommu-v0" },
+	{}
+};
+
 static int msm_iommu_remove(struct platform_device *pdev)
 {
-	struct msm_iommu_drvdata *drv = NULL;
+	struct msm_iommu_dev *iommu = platform_get_drvdata(pdev);
 
-	drv = platform_get_drvdata(pdev);
-	if (drv) {
-		if (drv->clk) {
-			clk_unprepare(drv->clk);
-			clk_put(drv->clk);
-		}
-		clk_unprepare(drv->pclk);
-		clk_put(drv->pclk);
-		memset(drv, 0, sizeof(*drv));
-		kfree(drv);
-	}
-	return 0;
-}
-
-static int msm_iommu_ctx_probe(struct platform_device *pdev)
-{
-	struct msm_iommu_ctx_dev *c = dev_get_platdata(&pdev->dev);
-	struct msm_iommu_drvdata *drvdata;
-	struct msm_iommu_ctx_drvdata *ctx_drvdata;
-	int i, ret;
-
-	if (!c || !pdev->dev.parent)
-		return -EINVAL;
-
-	drvdata = dev_get_drvdata(pdev->dev.parent);
-	if (!drvdata)
-		return -ENODEV;
-
-	ctx_drvdata = kzalloc(sizeof(*ctx_drvdata), GFP_KERNEL);
-	if (!ctx_drvdata)
-		return -ENOMEM;
-
-	ctx_drvdata->num = c->num;
-	ctx_drvdata->pdev = pdev;
-
-	INIT_LIST_HEAD(&ctx_drvdata->attached_elm);
-	platform_set_drvdata(pdev, ctx_drvdata);
-
-	ret = clk_prepare_enable(drvdata->pclk);
-	if (ret)
-		goto fail;
-
-	if (drvdata->clk) {
-		ret = clk_prepare_enable(drvdata->clk);
-		if (ret) {
-			clk_disable_unprepare(drvdata->pclk);
-			goto fail;
-		}
-	}
-
-	/* Program the M2V tables for this context */
-	for (i = 0; i < MAX_NUM_MIDS; i++) {
-		int mid = c->mids[i];
-		if (mid == -1)
-			break;
-
-		SET_M2VCBR_N(drvdata->base, mid, 0);
-		SET_CBACR_N(drvdata->base, c->num, 0);
-
-		/* Set VMID = 0 */
-		SET_VMID(drvdata->base, mid, 0);
-
-		/* Set the context number for that MID to this context */
-		SET_CBNDX(drvdata->base, mid, c->num);
-
-		/* Set MID associated with this context bank to 0*/
-		SET_CBVMID(drvdata->base, c->num, 0);
-
-		/* Set the ASID for TLB tagging for this context */
-		SET_CONTEXTIDR_ASID(drvdata->base, c->num, c->num);
-
-		/* Set security bit override to be Non-secure */
-		SET_NSCFG(drvdata->base, mid, 3);
-	}
-
-	clk_disable(drvdata->clk);
-	clk_disable(drvdata->pclk);
-
-	dev_info(&pdev->dev, "context %s using bank %d\n", c->name, c->num);
-	return 0;
-fail:
-	kfree(ctx_drvdata);
-	return ret;
-}
-
-static int msm_iommu_ctx_remove(struct platform_device *pdev)
-{
-	struct msm_iommu_ctx_drvdata *drv = NULL;
-	drv = platform_get_drvdata(pdev);
-	if (drv) {
-		memset(drv, 0, sizeof(struct msm_iommu_ctx_drvdata));
-		kfree(drv);
-	}
+	clk_unprepare(iommu->clk);
+	clk_unprepare(iommu->pclk);
 	return 0;
 }
 
 static struct platform_driver msm_iommu_driver = {
 	.driver = {
 		.name	= "msm_iommu",
+		.of_match_table = msm_iommu_dt_match,
 	},
 	.probe		= msm_iommu_probe,
 	.remove		= msm_iommu_remove,
 };
 
-static struct platform_driver msm_iommu_ctx_driver = {
-	.driver = {
-		.name	= "msm_iommu_ctx",
-	},
-	.probe		= msm_iommu_ctx_probe,
-	.remove		= msm_iommu_ctx_remove,
-};
-
 static struct platform_driver * const drivers[] = {
 	&msm_iommu_driver,
 	&msm_iommu_ctx_driver,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
