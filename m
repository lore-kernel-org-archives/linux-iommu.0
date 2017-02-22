From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 2/2] iommu: add qcom_iommu
Date: Wed, 22 Feb 2017 15:01:01 +0530
Message-ID: <008001d28cee$6527d4e0$2f777ea0$@codeaurora.org>
References: <20170215215743.5673-1-robdclark@gmail.com>
	<20170215215743.5673-2-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170215215743.5673-2-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: 'Mark Rutland' <mark.rutland-5wv7dgnIgG8@public.gmane.org>, 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

>diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>new file mode 100644
>index 0000000..78a8d65
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>@@ -0,0 +1,45 @@
>+* QCOM IOMMU Implementation
>+
>+Qualcomm "B" family devices which are not compatible with arm-smmu have
>+a similar looking IOMMU but without access to the global register space.
>+This is modelled as separate IOMMU devices which have just a single
>+master.
>+
>+** Required properties:
>+
>+- compatible    : Should be one of:
>+
>+                        "qcom,msm8916-iommu-context-bank"
>+
>+                  depending on the particular implementation and/or the
>+                  version of the architecture implemented.
>+
>+- reg           : Base address and size of the SMMU.  And optionally,
>+                  if present, the "smmu_local_base"
>+
>+- interrupts    : The context fault irq.
>+
>+- #iommu-cells  : Must be 0
>+
>+- qcom,iommu-ctx-asid   : context ASID
>+
>+- qcom,iommu-secure-id  : secure-id
>+
>+- clocks        : The interface clock (iface_clk) and bus clock (bus_clk)
>+
>+** Examples:
>+
>+	mdp_iommu: iommu-context-bank@1e24000 {
>+		compatible = "qcom,msm8916-iommu-context-bank";
>+		reg = <0x1e24000 0x1000
>+			0x1ef0000 0x3000>;
>+		reg-names = "iommu_base", "smmu_local_base";
>+		interrupts = <GIC_SPI 70 0>;
>+		qcom,iommu-ctx-asid = <4>;
>+		qcom,iommu-secure-id = <17>;

This is not an per context bank property and can be programmed for an
given iommu only once. So we call qcom_iommu_sec_init for
each context bank once, which does not look correct. Similarly for
smmu_local_base as well. So should this be handled using an global
once for all contexts ?

>+		#iommu-cells = <0>;
>+		clocks = <&gcc GCC_SMMU_CFG_CLK>,
>+			 <&gcc GCC_APSS_TCU_CLK>;
>+		clock-names = "iface_clk", "bus_clk";

I am trying to generalize the clock bindings for MMU-500 and one more
qcom specific. Anyways this can follow that.

>+		status = "okay";

<..>

>+#define pr_fmt(fmt) "qcom-iommu: " fmt
>+
>+#include <linux/atomic.h>
>+#include <linux/clk.h>
>+#include <linux/delay.h>
>+#include <linux/dma-iommu.h>
>+#include <linux/dma-mapping.h>
>+#include <linux/err.h>
>+#include <linux/interrupt.h>
>+#include <linux/io.h>
>+#include <linux/io-64-nonatomic-hi-lo.h>
>+#include <linux/iommu.h>
>+#include <linux/iopoll.h>
>+#include <linux/module.h>
>+#include <linux/of.h>
>+#include <linux/of_address.h>
>+#include <linux/of_device.h>
>+#include <linux/of_iommu.h>
>+#include <linux/platform_device.h>
>+#include <linux/pm_runtime.h>
>+#include <linux/qcom_scm.h>
>+#include <linux/slab.h>
>+#include <linux/spinlock.h>
>+
>+#include "io-pgtable.h"
>+#include "arm-smmu-regs.h"
>+
>+// TODO are these qcom specific, or just something no one bothered to add to arm-smmu
>+#define SMMU_CB_TLBSYNC      0x7f0
>+#define SMMU_CB_TLBSTATUS    0x7f4

I think the reason was in arm-smmu, we are using the global TLBSYNC/STATUS bits, as its
used in both global device reset and flush path. Otherwise here, its correct to add this.

>+#define SMMU_INTR_SEL_NS     0x2000
>+
>+
>+struct qcom_iommu_device {
>+	struct device		*dev;
>+
>+	void __iomem		*base;
>+	void __iomem		*local_base;
>+	unsigned int		 irq;
>+	struct clk		*iface_clk;
>+	struct clk		*bus_clk;
>+
>+	bool			 secure_init;
>+	u32			 asid;      /* asid and ctx bank # are 1:1 */
>+	u32			 sec_id;
>+
>+	/* single group per device: */
>+	struct iommu_group	*group;
>+};
>+
>+struct qcom_iommu_domain {
>+	struct qcom_iommu_device	*iommu;
>+	struct io_pgtable_ops		*pgtbl_ops;
>+	spinlock_t			 pgtbl_lock;
>+	struct mutex			 init_mutex; /* Protects iommu pointer */
>+	struct iommu_domain		 domain;
>+};
>+
>+static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
>+{
>+	return container_of(dom, struct qcom_iommu_domain, domain);
>+}
>+
>+static const struct iommu_ops qcom_iommu_ops;
>+static struct platform_driver qcom_iommu_driver;
>+
>+static struct qcom_iommu_device * dev_to_iommu(struct device *dev)
>+{
>+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>+	if (WARN_ON(!fwspec || fwspec->ops != &qcom_iommu_ops))
>+		return NULL;
>+	return fwspec->iommu_priv;
>+}
>+
>+static inline void
>+iommu_writel(struct qcom_iommu_device *qcom_iommu, unsigned reg, u32 val)
>+{
>+	writel_relaxed(val, qcom_iommu->base + reg);
>+}
>+
>+static inline void
>+iommu_writeq(struct qcom_iommu_device *qcom_iommu, unsigned reg, u64 val)
>+{
>+	writeq_relaxed(val, qcom_iommu->base + reg);
>+}
>+
>+static inline u32
>+iommu_readl(struct qcom_iommu_device *qcom_iommu, unsigned reg)
>+{
>+	return readl_relaxed(qcom_iommu->base + reg);
>+}
>+
>+static inline u32
>+iommu_readq(struct qcom_iommu_device *qcom_iommu, unsigned reg)
>+{
>+	return readq_relaxed(qcom_iommu->base + reg);
>+}
>+
>+static void __sync_tlb(struct qcom_iommu_device *qcom_iommu)
>+{
>+	unsigned int val;
>+	unsigned int ret;
>+
>+	iommu_writel(qcom_iommu, SMMU_CB_TLBSYNC, 0);
>+
>+	ret = readl_poll_timeout(qcom_iommu->base + SMMU_CB_TLBSTATUS, val,
>+				 (val & 0x1) == 0, 0, 5000000);
>+	if (ret)
>+		dev_err(qcom_iommu->dev, "timeout waiting for TLB SYNC\n");
>+}
>+
>+
>+static void qcom_iommu_tlb_sync (void *cookie)
>+{
>+	struct qcom_iommu_device *qcom_iommu = cookie;
>+	__sync_tlb(qcom_iommu);
>+}
>+
>+static void qcom_iommu_tlb_inv_context(void *cookie)
>+{
>+	struct qcom_iommu_device *qcom_iommu = cookie;
>+
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_S1_TLBIASID, qcom_iommu->asid);
>+	__sync_tlb(qcom_iommu);
>+}
>+
>+static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>+					    size_t granule, bool leaf, void *cookie)
>+{
>+	struct qcom_iommu_device *qcom_iommu = cookie;
>+	unsigned reg;
>+
>+	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
>+
>+	/* TODO do we need to support aarch64 fmt too? */
>+
>+	iova >>= 12;
>+	iova |= (u64)qcom_iommu->asid << 48;
>+	do {
>+		iommu_writeq(qcom_iommu, reg, iova);
>+		iova += granule >> 12;
>+	} while (size -= granule);

Is this not for ARCH64 format ?, i see that the arm-smmu does this when the
format is ARCH64. This is what you mentioned as fixed in V2, otherwise.

>+}
>+
>+static const struct iommu_gather_ops qcom_gather_ops = {
>+	.tlb_flush_all	= qcom_iommu_tlb_inv_context,
>+	.tlb_add_flush	= qcom_iommu_tlb_inv_range_nosync,
>+	.tlb_sync	= qcom_iommu_tlb_sync,
>+};
>+
>+static irqreturn_t qcom_iommu_fault(int irq, void *dev)
>+{
>+	struct qcom_iommu_device *qcom_iommu = dev;
>+	u32 fsr, fsynr;
>+	unsigned long iova;
>+
>+	fsr = iommu_readl(qcom_iommu, ARM_SMMU_CB_FSR);
>+
>+	if (!(fsr & FSR_FAULT))
>+		return IRQ_NONE;
>+
>+	fsynr = iommu_readl(qcom_iommu, ARM_SMMU_CB_FSYNR0);
>+	iova = iommu_readq(qcom_iommu, ARM_SMMU_CB_FAR);
>+
>+	dev_err_ratelimited(qcom_iommu->dev,
>+			    "Unhandled context fault: fsr=0x%x, "
>+			    "iova=0x%08lx, fsynr=0x%x, cb=%d\n",
>+			    fsr, iova, fsynr, qcom_iommu->asid);
>+
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_FSR, fsr);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static int qcom_iommu_sec_init(struct qcom_iommu_device *qcom_iommu)
>+{
>+	if (qcom_iommu->local_base) {
>+		writel_relaxed(0xffffffff, qcom_iommu->local_base + SMMU_INTR_SEL_NS);
>+		mb();
>+	}
>+
>+	return qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, qcom_iommu->asid);
>+}
>+
>+
>+static int qcom_iommu_init_domain_context(struct iommu_domain *domain,
>+					  struct qcom_iommu_device *qcom_iommu)
>+{
>+	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
>+	struct io_pgtable_ops *pgtbl_ops;
>+	struct io_pgtable_cfg pgtbl_cfg;
>+	int ret = 0;
>+	u32 reg;
>+
>+	mutex_lock(&qcom_domain->init_mutex);
>+	if (qcom_domain->iommu)
>+		goto out_unlock;
>+
>+	/*
>+	 * TODO do we need to make the pagetable format configurable to
>+	 * support other devices?  Is deciding based on compat string
>+	 * sufficient?
>+	 */

The problem in choosing the pagetable format is, the firmware has set the
format for CBA2R to ARM_32_LPAE_S1 as default. So that register has to be changed
using some scm api to choose 64bit format, if we have to support some device.
But also, there is no way for an device to pass in this option either. Downstream driver
was never enabling 64bit format for any devices. So i feel, we can
introduce the support for 64bit format additionally if required.

>+
>+	pgtbl_cfg = (struct io_pgtable_cfg) {
>+		.pgsize_bitmap	= qcom_iommu_ops.pgsize_bitmap,
>+		.ias		= 32,
>+		.oas		= 40,
>+		.tlb		= &qcom_gather_ops,
>+		.iommu_dev	= qcom_iommu->dev,
>+	};
>+
>+	qcom_domain->iommu = qcom_iommu;
>+	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_iommu);
>+	if (!pgtbl_ops) {
>+		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
>+		ret = -ENOMEM;
>+		goto out_clear_iommu;
>+	}
>+
>+	/* Update the domain's page sizes to reflect the page table format */
>+	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>+	domain->geometry.aperture_end = (1UL << 48) - 1;
>+	domain->geometry.force_aperture = true;
>+
>+	if (!qcom_iommu->secure_init) {
>+		ret = qcom_iommu_sec_init(qcom_iommu);
>+		if (ret) {
>+			dev_err(qcom_iommu->dev, "secure init failed: %d\n", ret);
>+			goto out_clear_iommu;
>+		}
>+		qcom_iommu->secure_init = true;
>+	}
>+
>+	/* TTBRs */
>+	iommu_writeq(qcom_iommu, ARM_SMMU_CB_TTBR0,
>+		     pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0] |
>+		     ((u64)qcom_iommu->asid << TTBRn_ASID_SHIFT));
>+	iommu_writeq(qcom_iommu, ARM_SMMU_CB_TTBR1,
>+		     pgtbl_cfg.arm_lpae_s1_cfg.ttbr[1] |
>+		     ((u64)qcom_iommu->asid << TTBRn_ASID_SHIFT));
>+
>+	/* TTBCR */
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_TTBCR2,
>+		     (pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
>+		     TTBCR2_SEP_UPSTREAM);
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_TTBCR,
>+		     pgtbl_cfg.arm_lpae_s1_cfg.tcr);
>+
>+	/* MAIRs (stage-1 only) */
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_S1_MAIR0,
>+		     pgtbl_cfg.arm_lpae_s1_cfg.mair[0]);
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_S1_MAIR1,
>+		     pgtbl_cfg.arm_lpae_s1_cfg.mair[1]);
>+
>+	/* SCTLR */
>+	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M |
>+		SCTLR_S1_ASIDPNE;
>+#ifdef __BIG_ENDIAN
>+	reg |= SCTLR_E;
>+#endif
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_SCTLR, reg);
>+
>+	mutex_unlock(&qcom_domain->init_mutex);
>+
>+	/* Publish page table ops for map/unmap */
>+	qcom_domain->pgtbl_ops = pgtbl_ops;
>+
>+	return 0;
>+
>+out_clear_iommu:
>+	qcom_domain->iommu = NULL;
>+out_unlock:
>+	mutex_unlock(&qcom_domain->init_mutex);
>+	return ret;
>+}
>+
>+static struct iommu_domain *qcom_iommu_domain_alloc(unsigned type)
>+{
>+	struct qcom_iommu_domain *qcom_domain;
>+
>+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>+		return NULL;
>+	/*
>+	 * Allocate the domain and initialise some of its data structures.
>+	 * We can't really do anything meaningful until we've added a
>+	 * master.
>+	 */
>+	qcom_domain = kzalloc(sizeof(*qcom_domain), GFP_KERNEL);
>+	if (!qcom_domain)
>+		return NULL;
>+
>+	if (type == IOMMU_DOMAIN_DMA &&
>+	    iommu_get_dma_cookie(&qcom_domain->domain)) {
>+		kfree(qcom_domain);
>+		return NULL;
>+	}
>+
>+	mutex_init(&qcom_domain->init_mutex);
>+	spin_lock_init(&qcom_domain->pgtbl_lock);
>+
>+	return &qcom_domain->domain;
>+}
>+
>+static void qcom_iommu_domain_free(struct iommu_domain *domain)
>+{
>+	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
>+	struct qcom_iommu_device *qcom_iommu = qcom_domain->iommu;
>+
>+	if (!qcom_iommu)
>+		return;
>+
>+	/*
>+	 * Free the domain resources. We assume that all devices have
>+	 * already been detached.
>+	 */
>+	iommu_put_dma_cookie(domain);
>+
>+	/*
>+	 * Disable the context bank before freeing page table
>+	 */
>+	iommu_writel(qcom_iommu, ARM_SMMU_CB_SCTLR, 0);
>+

We need to add a pm_runtime here as well, at this point the device_link between
master and smmu might not be there any more.

>+	free_io_pgtable_ops(qcom_domain->pgtbl_ops);
>+
>+	kfree(qcom_domain);
>+}
>+

<..>

>+static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>+{
>+	struct platform_device *iommu_pdev;
>+	u32 fwid = 0;
>+
>+	if (args->args_count != 0) {
>+		dev_err(dev, "incorrect number of iommu params found for %s "
>+			"(found %d, expected 0)\n",
>+			args->np->full_name, args->args_count);
>+		return -EINVAL;
>+	}
>+
>+	if (!dev->iommu_fwspec->iommu_priv) {
>+		iommu_pdev = of_find_device_by_node(args->np);
>+		if (WARN_ON(!iommu_pdev))
>+			return -EINVAL;
>+
>+		dev->iommu_fwspec->iommu_priv = platform_get_drvdata(iommu_pdev);

This can be done as a part of the add_device callback as well.

>+	}
>+
>+	return iommu_fwspec_add_ids(dev, &fwid, 1);

This is not required, we do not have any fwid to add here.

>+}
>+
>+static const struct iommu_ops qcom_iommu_ops = {
>+	.capable		= qcom_iommu_capable,
>+	.domain_alloc		= qcom_iommu_domain_alloc,
>+	.domain_free		= qcom_iommu_domain_free,
>+	.attach_dev		= qcom_iommu_attach_dev,
>+	.map			= qcom_iommu_map,
>+	.unmap			= qcom_iommu_unmap,
>+	.map_sg			= default_iommu_map_sg,
>+	.iova_to_phys		= qcom_iommu_iova_to_phys,
>+	.add_device		= qcom_iommu_add_device,
>+	.remove_device		= qcom_iommu_remove_device,
>+	.device_group		= qcom_iommu_device_group,
>+	.of_xlate		= qcom_iommu_of_xlate,
>+	.pgsize_bitmap		= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
>+};
>+
>+static const struct of_device_id qcom_iommu_of_match[] = {
>+// TODO we probably need to use this driver (vs arm-smmu) for all the early
>+// "B" family devices prior to 8x96 or so.. so maybe having msm8916 in the
>+// compat name isn't right.. or maybe we just add a bunch more compat strings
>+// as needed?
>+	{ .compatible = "qcom,msm8916-iommu-context-bank" },

Maybe, qcom,msm-sec-iommu-context-bank, meaning that this driver
is always for iommu which is secure and we will need an extra binding when
we try to add secure context banks as well.
 
>+	{ /* sentinel */ }
>+};
>+MODULE_DEVICE_TABLE(of, qcom_iommu_of_match);
>+
>+static int qcom_iommu_enable_clocks(struct qcom_iommu_device *qcom_iommu)
>+{
>+	int ret;
>+
>+	ret = clk_prepare_enable(qcom_iommu->iface_clk);
>+	if (ret) {
>+		dev_err(qcom_iommu->dev, "Couldn't enable iface_clk\n");
>+		return ret;
>+	}
>+
>+	ret = clk_prepare_enable(qcom_iommu->bus_clk);
>+	if (ret) {
>+		dev_err(qcom_iommu->dev, "Couldn't enable bus_clk\n");
>+		clk_disable_unprepare(qcom_iommu->iface_clk);
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+static void qcom_iommu_disable_clocks(struct qcom_iommu_device *qcom_iommu)
>+{
>+	clk_disable_unprepare(qcom_iommu->bus_clk);
>+	clk_disable_unprepare(qcom_iommu->iface_clk);
>+}
>+
>+static int qcom_iommu_device_probe(struct platform_device *pdev)
>+{
>+	struct resource *res;
>+	struct qcom_iommu_device *qcom_iommu;
>+	struct device *dev = &pdev->dev;
>+	int ret;
>+
>+	qcom_iommu = devm_kzalloc(dev, sizeof(*qcom_iommu), GFP_KERNEL);
>+	if (!qcom_iommu) {
>+		dev_err(dev, "failed to allocate qcom_iommu_device\n");
>+		return -ENOMEM;
>+	}
>+	qcom_iommu->dev = dev;
>+
>+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>+	qcom_iommu->base = devm_ioremap_resource(dev, res);
>+	if (IS_ERR(qcom_iommu->base))
>+		return PTR_ERR(qcom_iommu->base);
>+
>+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>+					   "smmu_local_base");
>+	if (res)
>+		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
>+
>+	qcom_iommu->irq = platform_get_irq(pdev, 0);
>+	if (qcom_iommu->irq < 0) {
>+		dev_err(dev, "failed to get irq\n");
>+		return -ENODEV;
>+	}
>+
>+	ret = devm_request_irq(dev, qcom_iommu->irq,
>+			       qcom_iommu_fault,
>+			       IRQF_SHARED,
>+			       "qcom-iommu-fault",
>+			       qcom_iommu);
>+	if (ret) {
>+		dev_err(dev, "failed to request IRQ %u\n",
>+			qcom_iommu->irq);
>+		return ret;
>+	}
>+
>+	qcom_iommu->iface_clk = devm_clk_get(dev, "iface_clk");
>+	if (IS_ERR(qcom_iommu->iface_clk)) {
>+		dev_err(dev, "failed to get iface_clk\n");
>+		return PTR_ERR(qcom_iommu->iface_clk);
>+	}
>+
>+	qcom_iommu->bus_clk = devm_clk_get(dev, "bus_clk");
>+	if (IS_ERR(qcom_iommu->bus_clk)) {
>+		dev_err(dev, "failed to get bus_clk\n");
>+		return PTR_ERR(qcom_iommu->bus_clk);
>+	}
>+
>+	if (of_property_read_u32(dev->of_node, "qcom,iommu-ctx-asid",
>+				 &qcom_iommu->asid)) {
>+		dev_err(dev, "missing qcom,iommu-ctx-asid property\n");
>+		return -ENODEV;
>+	}
>+
>+	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
>+				 &qcom_iommu->sec_id)) {
>+		dev_err(dev, "missing qcom,iommu-secure-id property\n");
>+		return -ENODEV;
>+	}
>+
>+	iommu_register_instance(dev->fwnode, &qcom_iommu_ops);
>+	platform_set_drvdata(pdev, qcom_iommu);
>+	pm_runtime_enable(dev);
>+	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
>+
>+	return 0;
>+}
>+
>+static int qcom_iommu_device_remove(struct platform_device *pdev)
>+{
>+	pm_runtime_force_suspend(&pdev->dev);
>+	platform_set_drvdata(pdev, NULL);
>+
>+	return 0;
>+}
>+
>+#ifdef CONFIG_PM
>+static int qcom_iommu_resume(struct device *dev)
>+{
>+	struct platform_device *pdev = to_platform_device(dev);
>+	struct qcom_iommu_device *qcom_iommu = platform_get_drvdata(pdev);
>+
>+	return qcom_iommu_enable_clocks(qcom_iommu);
>+}
>+
>+static int qcom_iommu_suspend(struct device *dev)
>+{
>+	struct platform_device *pdev = to_platform_device(dev);
>+	struct qcom_iommu_device *qcom_iommu = platform_get_drvdata(pdev);
>+
>+	qcom_iommu_disable_clocks(qcom_iommu);
>+
>+	return 0;
>+}
>+#endif
>+
>+static const struct dev_pm_ops qcom_iommu_pm_ops = {
>+	SET_RUNTIME_PM_OPS(qcom_iommu_suspend, qcom_iommu_resume, NULL)
>+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>+				pm_runtime_force_resume)
>+};
>+
>+
>+static struct platform_driver qcom_iommu_driver = {
>+	.driver	= {
>+		.name		= "qcom-iommu",
>+		.of_match_table	= of_match_ptr(qcom_iommu_of_match),
>+		.pm		= &qcom_iommu_pm_ops,
>+	},
>+	.probe	= qcom_iommu_device_probe,
>+	.remove	= qcom_iommu_device_remove,
>+};
>+module_platform_driver(qcom_iommu_driver);
>+
>+IOMMU_OF_DECLARE(qcom_iommu, "qcom,msm8916-iommu-context-bank", NULL);
>+
>+MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU implementations");
>+MODULE_LICENSE("GPL v2");
>--
>2.9.3

Regards,
 Sricharan
