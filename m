From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [RFC/PATCH 4/7] iommu: msm: Add MSM IOMMUv1 driver
Date: Mon, 30 Jun 2014 09:51:53 -0700
Message-ID: <1404147116-4598-5-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

MSM IOMMUv1 driver supports Qualcomm SoC MSM8974 and
MSM8084.

The IOMMU driver supports the following features:

    - ARM V7S page table format independent of ARM CPU page table format
    - 4K/64K/1M/16M mappings (V7S)
    - ATOS used for unit testing of driver
    - Sharing of page tables among SMMUs
    - Verbose context bank fault reporting
    - Verbose global fault reporting
    - Support for clocks and GDSC
    - map/unmap range
    - Domain specific enabling of coherent Hardware Table Walk (HTW)

Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/iommu/msm,iommu_v1.txt     |   56 +
 drivers/iommu/Kconfig                              |   36 +
 drivers/iommu/Makefile                             |    2 +
 drivers/iommu/msm_iommu-v1.c                       | 1448 +++++++++++++
 drivers/iommu/msm_iommu.c                          |  149 ++
 drivers/iommu/msm_iommu_dev-v1.c                   |  340 +++
 drivers/iommu/msm_iommu_hw-v1.h                    | 2236 ++++++++++++++++++++
 drivers/iommu/msm_iommu_pagetable.c                |  600 ++++++
 drivers/iommu/msm_iommu_pagetable.h                |   33 +
 drivers/iommu/msm_iommu_priv.h                     |   55 +
 include/linux/qcom_iommu.h                         |  221 ++
 11 files changed, 5176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
 create mode 100644 drivers/iommu/msm_iommu-v1.c
 create mode 100644 drivers/iommu/msm_iommu.c
 create mode 100644 drivers/iommu/msm_iommu_dev-v1.c
 create mode 100644 drivers/iommu/msm_iommu_hw-v1.h
 create mode 100644 drivers/iommu/msm_iommu_pagetable.c
 create mode 100644 drivers/iommu/msm_iommu_pagetable.h
 create mode 100644 drivers/iommu/msm_iommu_priv.h
 create mode 100644 include/linux/qcom_iommu.h

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt b/Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
new file mode 100644
index 0000000..412ed44
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/msm,iommu_v1.txt
@@ -0,0 +1,56 @@
+* Qualcomm MSM IOMMU v1
+
+Required properties:
+- compatible :
+	- "qcom,msm-smmu-v1"
+- reg : - offset and length of the register set for the device.
+	- Optional offset and length for clock halt register that
+	  needs to be turned on for access to this IOMMU.
+- reg-names: "iommu_base", "clk_halt_reg_base" (optional)
+- #global-interrupts : The number of global interrupts exposed by the
+                       device.
+- interrupts    : Interrupt list, with the first #global-irqs entries
+                  corresponding to the global interrupts and any
+                  following entries corresponding to context interrupts,
+                  specified in order of their indexing by the SMMU.
+
+Optional properties:
+- label: Symbolic name for this IOMMU instance used for debugging purposes.
+  For example when a page fault occurs on the jpeg iommu the text
+  "jpeg_iommu" will be printed letting people know which IOMMU is complaining.
+- qcom,vdd-supply: Regulator needed to access IOMMU
+- qcom,alt-vdd-supply : Alternative regulator needed to access IOMMU
+  configuration registers.
+- qcom,iommu-bfb-regs : An array of unsigned 32-bit integers corresponding to
+  Burst Fetch Buffers (BFB) register addresses that need to be configured
+  for performance tuning purposes. BFB holds cached values of TLB/PTE entries
+  in the SMMU. BFB registers controls the configuration of the TLB/PTE fetching
+  mechanism in the SMMU. In general these values comes from performance
+  modelling team.
+  If this property is present, the qcom,iommu-bfb-data must also be
+  present. Register addresses are specified as an offset from the base of the
+  IOMMU hardware block. This property may be omitted if no BFB register
+  configuration needs to be done for a particular IOMMU hardware instance. The
+  registers specified by this property shall fall within the IOMMU
+  implementation-defined register region.
+- qcom,iommu-bfb-data : An array of unsigned 32-bit integers representing the
+  values to be programmed into the corresponding registers given by the
+  qcom,iommu-bfb-regs property. If this property is present, the
+  qcom,iommu-bfb-regs property shall also be present, and the lengths of both
+  properties shall be the same.
+
+Example:
+
+	qcom,iommu@fda64000 {
+		compatible = "qcom,msm-smmu-v1";
+		reg = <0xfda64000 0x10000>;
+		reg-names = "iommu_base";
+		vdd-supply = <&gdsc_iommu>;
+		qcom,iommu-bfb-regs = <0x204c 0x2050>;
+		qcom,iommu-bfb-data = <0xffff 0xffce>;
+		label = "iommu_0";
+		#global-interrupts = <2>;
+		interrupts = <0 229 0>,
+			     <0 231 0>,
+			     <0 70 0>;
+	};
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 705a257..e972127 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -50,6 +50,42 @@ config IOMMU_PGTABLES_L2
 	def_bool y
 	depends on MSM_IOMMU && MMU && SMP && CPU_DCACHE_DISABLE=n
 
+# MSM IOMMUv1 support
+config MSM_IOMMU_V1
+	bool "MSM IOMMUv1 Support"
+	depends on ARCH_MSM8974 || ARCH_MSM8226 || ARCH_APQ8084 || ARCH_MSM8994
+	select IOMMU_API
+	select MSM_IOMMU
+	help
+	  Support for the IOMMUs (v1) found on certain Qualcomm SOCs.
+	  These IOMMUs allow virtualization of the address space used by most
+	  cores within the multimedia subsystem.
+
+	  If unsure, say N here.
+
+config MSM_IOMMU_VBIF_CHECK
+	bool "Enable support for VBIF check when IOMMU gets stuck"
+	depends on MSM_IOMMU
+	help
+	  Utilize the Virtual Bus Interface (VBIF) to get more debug
+	  information. Enables an extra check in the IOMMU driver that logs
+	  debugging information when TLB sync or iommu halt issue occurs.
+	  This helps in debugging such issues.
+
+	  If unsure, say N here.
+
+config IOMMU_FORCE_4K_MAPPINGS
+	bool "Turns off mapping optimization and map only 4K pages"
+	depends on MSM_IOMMU
+        help
+         Say Y here if you want the IOMMU driver to map buffers with
+         4KB mapping only. With this, we don't get performance gains
+         by optimizing mapping. This is a debug feature and should be
+         used only when we want to profile the performance in the
+         worst case scenario.
+
+         If unsure, say N here.
+
 # AMD IOMMU support
 config AMD_IOMMU
 	bool "AMD IOMMU support"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 894ced9..1f98fcc 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -2,6 +2,8 @@ obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU_V0) += msm_iommu-v0.o msm_iommu_dev-v0.o
+obj-$(CONFIG_MSM_IOMMU_V1) += msm_iommu-v1.o msm_iommu_dev-v1.o msm_iommu.o
+obj-$(CONFIG_MSM_IOMMU_V1) += msm_iommu_pagetable.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
diff --git a/drivers/iommu/msm_iommu-v1.c b/drivers/iommu/msm_iommu-v1.c
new file mode 100644
index 0000000..046c3cf
--- /dev/null
+++ b/drivers/iommu/msm_iommu-v1.c
@@ -0,0 +1,1448 @@
+/* Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/clk.h>
+#include <linux/scatterlist.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/qcom_iommu.h>
+#include <linux/sizes.h>
+#include <linux/iopoll.h>
+
+#include "msm_iommu_hw-v1.h"
+#include "msm_iommu_priv.h"
+#include "msm_iommu_pagetable.h"
+
+/* bitmap of the page sizes currently supported */
+#define MSM_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
+
+#define IOMMU_MSEC_STEP		10
+#define IOMMU_MSEC_TIMEOUT	5000
+
+
+static DEFINE_MUTEX(msm_iommu_lock);
+struct dump_regs_tbl_entry dump_regs_tbl[MAX_DUMP_REGS];
+
+static int __enable_regulators(struct msm_iommu_drvdata *drvdata)
+{
+	int ret = 0;
+
+	if (drvdata->gdsc) {
+		ret = regulator_enable(drvdata->gdsc);
+		if (ret)
+			goto fail;
+
+		if (drvdata->alt_gdsc)
+			ret = regulator_enable(drvdata->alt_gdsc);
+
+		if (ret) {
+			regulator_disable(drvdata->gdsc);
+			goto fail;
+		}
+
+	}
+	++drvdata->powered_on;
+fail:
+	return ret;
+}
+
+static void __disable_regulators(struct msm_iommu_drvdata *drvdata)
+{
+	if (drvdata->alt_gdsc)
+		regulator_disable(drvdata->alt_gdsc);
+
+	if (drvdata->gdsc)
+		regulator_disable(drvdata->gdsc);
+
+	--drvdata->powered_on;
+}
+
+static int __enable_clocks(struct msm_iommu_drvdata *drvdata)
+{
+	int ret = 0;
+	unsigned int i;
+
+	for (i = 0; i < MAX_CLKS; ++i) {
+		if (drvdata->clk[i])
+			ret = clk_prepare_enable(drvdata->clk[i]);
+		else
+			break;
+		if (ret)
+			goto fail;
+	}
+
+	if (drvdata->clk_reg_virt) {
+		unsigned int value;
+
+		value = readl_relaxed(drvdata->clk_reg_virt);
+		value &= ~0x1;
+		writel_relaxed(value, drvdata->clk_reg_virt);
+		/* Ensure clock is on before continuing */
+		mb();
+	}
+	return 0;
+
+fail:
+	while (i--)
+		clk_disable_unprepare(drvdata->clk[i]);
+	return ret;
+}
+
+static void __disable_clocks(struct msm_iommu_drvdata *drvdata)
+{
+	unsigned int i;
+
+	for (i = 0; i < MAX_CLKS; ++i) {
+		if (drvdata->clk[i])
+			clk_disable_unprepare(drvdata->clk[i]);
+		else
+			break;
+	}
+}
+
+static void _iommu_lock_acquire(unsigned int need_extra_lock)
+{
+	mutex_lock(&msm_iommu_lock);
+}
+
+static void _iommu_lock_release(unsigned int need_extra_lock)
+{
+	mutex_unlock(&msm_iommu_lock);
+}
+
+struct msm_iommu_access_ops msm_iommu_access_ops_v1 = {
+	.iommu_power_on = __enable_regulators,
+	.iommu_power_off = __disable_regulators,
+	.iommu_clk_on = __enable_clocks,
+	.iommu_clk_off = __disable_clocks,
+	.iommu_lock_acquire = _iommu_lock_acquire,
+	.iommu_lock_release = _iommu_lock_release,
+};
+
+#ifdef CONFIG_MSM_IOMMU_VBIF_CHECK
+
+#define VBIF_XIN_HALT_CTRL0 0x200
+#define VBIF_XIN_HALT_CTRL1 0x204
+#define VBIF_AXI_HALT_CTRL0 0x208
+#define VBIF_AXI_HALT_CTRL1 0x20C
+
+static void __halt_vbif_xin(void __iomem *vbif_base)
+{
+	pr_err("Halting VBIF_XIN\n");
+	writel_relaxed(0xFFFFFFFF, vbif_base + VBIF_XIN_HALT_CTRL0);
+}
+
+static void __dump_vbif_state(void __iomem *base, void __iomem *vbif_base)
+{
+	unsigned int reg_val;
+
+	reg_val = readl_relaxed(base + MICRO_MMU_CTRL);
+	pr_err("Value of SMMU_IMPLDEF_MICRO_MMU_CTRL = 0x%x\n", reg_val);
+
+	reg_val = readl_relaxed(vbif_base + VBIF_XIN_HALT_CTRL0);
+	pr_err("Value of VBIF_XIN_HALT_CTRL0 = 0x%x\n", reg_val);
+	reg_val = readl_relaxed(vbif_base + VBIF_XIN_HALT_CTRL1);
+	pr_err("Value of VBIF_XIN_HALT_CTRL1 = 0x%x\n", reg_val);
+	reg_val = readl_relaxed(vbif_base + VBIF_AXI_HALT_CTRL0);
+	pr_err("Value of VBIF_AXI_HALT_CTRL0 = 0x%x\n", reg_val);
+	reg_val = readl_relaxed(vbif_base + VBIF_AXI_HALT_CTRL1);
+	pr_err("Value of VBIF_AXI_HALT_CTRL1 = 0x%x\n", reg_val);
+}
+
+static int __check_vbif_state(struct msm_iommu_drvdata const *drvdata)
+{
+	phys_addr_t addr = (phys_addr_t) (drvdata->phys_base
+			   - (phys_addr_t) 0x4000);
+	void __iomem *base = ioremap(addr, 0x1000);
+	int ret = 0;
+
+	if (base) {
+		__dump_vbif_state(drvdata->base, base);
+		__halt_vbif_xin(drvdata->base);
+		__dump_vbif_state(drvdata->base, base);
+		iounmap(base);
+	} else {
+		pr_err("%s: Unable to ioremap\n", __func__);
+		ret = -ENOMEM;
+	}
+	return ret;
+}
+
+static void check_halt_state(struct msm_iommu_drvdata const *drvdata)
+{
+	int res;
+	unsigned int val;
+	void __iomem *base = drvdata->base;
+	char const *name = drvdata->name;
+
+	pr_err("Timed out waiting for IOMMU halt to complete for %s\n", name);
+	res = __check_vbif_state(drvdata);
+	if (res)
+		BUG();
+
+	pr_err("Checking if IOMMU halt completed for %s\n", name);
+
+	res = readl_tight_poll_timeout(
+		GLB_REG(MICRO_MMU_CTRL, base), val,
+			(val & MMU_CTRL_IDLE) == MMU_CTRL_IDLE, 5000000);
+
+	if (res) {
+		pr_err("Timed out (again) waiting for IOMMU halt to complete for %s\n",
+			name);
+	} else {
+		pr_err("IOMMU halt completed. VBIF FIFO most likely not getting drained by master\n");
+	}
+	BUG();
+}
+
+static void check_tlb_sync_state(struct msm_iommu_drvdata const *drvdata,
+				int ctx)
+{
+	int res;
+	unsigned int val;
+	void __iomem *base = drvdata->base;
+	char const *name = drvdata->name;
+
+	pr_err("Timed out waiting for TLB SYNC to complete for %s\n", name);
+	res = __check_vbif_state(drvdata);
+	if (res)
+		BUG();
+
+	pr_err("Checking if TLB sync completed for %s\n", name);
+
+	res = readl_tight_poll_timeout(CTX_REG(CB_TLBSTATUS, base, ctx), val,
+				(val & CB_TLBSTATUS_SACTIVE) == 0, 5000000);
+	if (res) {
+		pr_err("Timed out (again) waiting for TLB SYNC to complete for %s\n",
+			name);
+	} else {
+		pr_err("TLB Sync completed. VBIF FIFO most likely not getting drained by master\n");
+	}
+	BUG();
+}
+
+#else
+
+/*
+ * For targets without VBIF or for targets with the VBIF check disabled
+ * we directly just crash to capture the issue
+ */
+static void check_halt_state(struct msm_iommu_drvdata const *drvdata)
+{
+	BUG();
+}
+
+static void check_tlb_sync_state(struct msm_iommu_drvdata const *drvdata,
+				int ctx)
+{
+	BUG();
+}
+
+#endif
+
+void iommu_halt(struct msm_iommu_drvdata const *iommu_drvdata)
+{
+	if (iommu_drvdata->halt_enabled) {
+		unsigned int val;
+		void __iomem *base = iommu_drvdata->base;
+		int res;
+
+		SET_MICRO_MMU_CTRL_HALT_REQ(base, 1);
+		res = readl_tight_poll_timeout(
+			GLB_REG(MICRO_MMU_CTRL, base), val,
+			     (val & MMU_CTRL_IDLE) == MMU_CTRL_IDLE, 5000000);
+
+		if (res)
+			check_halt_state(iommu_drvdata);
+		/* Ensure device is idle before continuing */
+		mb();
+	}
+}
+
+void iommu_resume(const struct msm_iommu_drvdata *iommu_drvdata)
+{
+	if (iommu_drvdata->halt_enabled) {
+		/*
+		 * Ensure transactions have completed before releasing
+		 * the halt
+		 */
+		mb();
+		SET_MICRO_MMU_CTRL_HALT_REQ(iommu_drvdata->base, 0);
+		/*
+		 * Ensure write is complete before continuing to ensure
+		 * we don't turn off clocks while transaction is still
+		 * pending.
+		 */
+		mb();
+	}
+}
+
+static void __sync_tlb(struct msm_iommu_drvdata *iommu_drvdata, int ctx)
+{
+	unsigned int val;
+	unsigned int res;
+	void __iomem *base = iommu_drvdata->cb_base;
+
+	SET_TLBSYNC(base, ctx, 0);
+	/* No barrier needed due to read dependency */
+
+	res = readl_tight_poll_timeout(CTX_REG(CB_TLBSTATUS, base, ctx), val,
+				(val & CB_TLBSTATUS_SACTIVE) == 0, 5000000);
+	if (res)
+		check_tlb_sync_state(iommu_drvdata, ctx);
+}
+
+static int __flush_iotlb_va(struct iommu_domain *domain, unsigned int va)
+{
+	struct msm_iommu_priv *priv = domain->priv;
+	struct msm_iommu_master *master;
+	int ret = 0;
+
+	list_for_each_entry(master, &priv->list_attached, attached_elm) {
+		struct msm_iommu_drvdata *iommu_drvdata = master->drvdata;
+
+		BUG_ON(!iommu_drvdata);
+
+		/*
+		 * SMMU programming clocks are in general not needed to be
+		 * on when the SMMU is in use and we are not touching SMMU
+		 * registers. So we leave the programming clocks off until we
+		 * actually touch SMMU registers.
+		 */
+		ret = __enable_clocks(iommu_drvdata);
+		if (ret)
+			goto fail;
+
+		SET_TLBIVA(iommu_drvdata->cb_base, master->cb_num,
+			   master->asid | (va & CB_TLBIVA_VA));
+		/* Ensure all page tables updates have completed before cont. */
+		mb();
+		__sync_tlb(iommu_drvdata, master->cb_num);
+		__disable_clocks(iommu_drvdata);
+	}
+fail:
+	return ret;
+}
+
+static int __flush_iotlb(struct iommu_domain *domain)
+{
+	struct msm_iommu_priv *priv = domain->priv;
+	struct msm_iommu_master *master;
+	int ret = 0;
+
+	list_for_each_entry(master, &priv->list_attached, attached_elm) {
+		struct msm_iommu_drvdata *iommu_drvdata = master->drvdata;
+
+		BUG_ON(!iommu_drvdata);
+
+		/*
+		 * SMMU programming clocks are in general not needed to be
+		 * on when the SMMU is in use and we are not touching SMMU
+		 * registers. So we leave the programming clocks off until we
+		 * actually touch SMMU registers.
+		 */
+		ret = __enable_clocks(iommu_drvdata);
+		if (ret)
+			goto fail;
+
+		SET_TLBIASID(iommu_drvdata->cb_base, master->cb_num,
+			     master->asid);
+		/* Ensure all page tables updates have completed before cont. */
+		mb();
+		__sync_tlb(iommu_drvdata, master->cb_num);
+		__disable_clocks(iommu_drvdata);
+	}
+
+fail:
+	return ret;
+}
+
+static void __reset_iommu(struct msm_iommu_drvdata *iommu_drvdata)
+{
+	int i, smt_size;
+	void __iomem *base = iommu_drvdata->base;
+
+	SET_ACR(base, 0);
+	SET_CR2(base, 0);
+	SET_GFAR(base, 0);
+	SET_GFSRRESTORE(base, 0);
+	SET_TLBIALLNSNH(base, 0);
+	smt_size = GET_IDR0_NUMSMRG(base);
+
+	for (i = 0; i < smt_size; i++)
+		SET_SMR_VALID(base, i, 0);
+
+	/* Ensure SMRs are marked as invalid before continuing */
+	mb();
+}
+
+static void __program_iommu(struct msm_iommu_drvdata *drvdata)
+{
+	__reset_iommu(drvdata);
+
+	SET_CR0_SMCFCFG(drvdata->base, 1);
+	SET_CR0_USFCFG(drvdata->base, 1);
+	SET_CR0_STALLD(drvdata->base, 1);
+	SET_CR0_GCFGFIE(drvdata->base, 1);
+	SET_CR0_GCFGFRE(drvdata->base, 1);
+	SET_CR0_GFIE(drvdata->base, 1);
+	SET_CR0_GFRE(drvdata->base, 1);
+
+	mb(); /* Make sure writes complete before returning */
+}
+
+void program_iommu_bfb_settings(void __iomem *base,
+			const struct msm_iommu_bfb_settings *bfb_settings)
+{
+	unsigned int i;
+
+	if (bfb_settings)
+		for (i = 0; i < bfb_settings->length; i++)
+			SET_GLOBAL_REG(base, bfb_settings->regs[i],
+					     bfb_settings->data[i]);
+
+	mb(); /* Make sure writes complete before returning */
+}
+
+static void __reset_context(struct msm_iommu_drvdata *iommu_drvdata, int ctx)
+{
+	void __iomem *base = iommu_drvdata->cb_base;
+
+	SET_ACTLR(base, ctx, 0);
+	SET_FAR(base, ctx, 0);
+	SET_FSRRESTORE(base, ctx, 0);
+	SET_NMRR(base, ctx, 0);
+	SET_PAR(base, ctx, 0);
+	SET_PRRR(base, ctx, 0);
+	SET_SCTLR(base, ctx, 0);
+	SET_TLBIALL(base, ctx, 0);
+	SET_TTBCR(base, ctx, 0);
+	SET_TTBR0(base, ctx, 0);
+	SET_TTBR1(base, ctx, 0);
+	/* Ensure writes complete before returning */
+	mb();
+}
+
+static void __release_SMT(u32 cb_num, void __iomem *base)
+{
+	int i, smt_size;
+	u32 tmp_cb;
+
+	smt_size = GET_IDR0_NUMSMRG(base);
+
+	for (i = 0; i < smt_size; i++) {
+		if (GET_SMR_VALID(base, i)) {
+			tmp_cb = GET_S2CR_CBNDX(base, cb_num);
+			if (tmp_cb == cb_num)
+				SET_SMR_VALID(base, i, 0);
+		}
+	}
+}
+
+static void msm_iommu_set_ASID(void __iomem *base, unsigned int ctx_num,
+			       unsigned int asid)
+{
+	SET_CB_CONTEXTIDR_ASID(base, ctx_num, asid);
+}
+
+static void msm_iommu_assign_ASID(const struct msm_iommu_drvdata *iommu_drvdata,
+				  struct msm_iommu_master *master,
+				  struct msm_iommu_priv *priv)
+{
+	unsigned int found = 0;
+	void __iomem *cb_base = iommu_drvdata->cb_base;
+	unsigned int i;
+	unsigned int ncb = iommu_drvdata->ncb;
+	struct msm_iommu_master *tmp_master;
+
+	/* Find if this page table is used elsewhere, and re-use ASID */
+	if (!list_empty(&priv->list_attached)) {
+		tmp_master = list_first_entry(&priv->list_attached,
+				struct msm_iommu_master, attached_elm);
+
+		++iommu_drvdata->asid[tmp_master->asid - 1];
+		master->asid = tmp_master->asid;
+		found = 1;
+	}
+
+	/* If page table is new, find an unused ASID */
+	if (!found) {
+		for (i = 0; i < ncb; ++i) {
+			if (iommu_drvdata->asid[i] == 0) {
+				++iommu_drvdata->asid[i];
+				master->asid = i + 1;
+				found = 1;
+				break;
+			}
+		}
+		BUG_ON(!found);
+	}
+
+	msm_iommu_set_ASID(cb_base, master->cb_num, master->asid);
+}
+
+static void msm_iommu_setup_ctx(void __iomem *base, unsigned int ctx)
+{
+	/* Turn on TEX Remap */
+	SET_CB_SCTLR_TRE(base, ctx, 1);
+}
+
+static void msm_iommu_setup_memory_remap(void __iomem *base, unsigned int ctx)
+{
+	SET_PRRR(base, ctx, msm_iommu_get_prrr());
+	SET_NMRR(base, ctx, msm_iommu_get_nmrr());
+}
+
+static void msm_iommu_setup_pg_l2_redirect(void __iomem *base, unsigned int ctx)
+{
+	/* Configure page tables as inner-cacheable and shareable to reduce
+	 * the TLB miss penalty.
+	 */
+	SET_CB_TTBR0_S(base, ctx, 1);
+	SET_CB_TTBR0_NOS(base, ctx, 1);
+	SET_CB_TTBR0_IRGN1(base, ctx, 0); /* WB, WA */
+	SET_CB_TTBR0_IRGN0(base, ctx, 1);
+	SET_CB_TTBR0_RGN(base, ctx, 1);   /* WB, WA */
+}
+
+static int program_SMT(struct msm_iommu_master *master, void __iomem *base)
+{
+	u32 *sids = master->sids;
+	unsigned int ctx = master->cb_num;
+	int num = 0, i, smt_size;
+	int len = master->nsids;
+
+	smt_size = GET_IDR0_NUMSMRG(base);
+	/* Program the SMT tables for this context */
+	for (i = 0; i < len; i++) {
+		for (; num < smt_size; num++)
+			if (GET_SMR_VALID(base, num) == 0)
+				break;
+		BUG_ON(num >= smt_size);
+
+		SET_SMR_VALID(base, num, 1);
+		SET_SMR_MASK(base, num, 0);
+		SET_SMR_ID(base, num, sids[i]);
+
+		SET_S2CR_N(base, num, 0);
+		SET_S2CR_CBNDX(base, num, ctx);
+		SET_S2CR_MEMATTR(base, num, 0x0A);
+		/* Set security bit override to be Non-secure */
+		SET_S2CR_NSCFG(base, num, 3);
+	}
+	return 0;
+}
+
+static void __program_context(struct msm_iommu_drvdata *iommu_drvdata,
+			      struct msm_iommu_master *master,
+			      struct msm_iommu_priv *priv, bool is_secure)
+{
+	phys_addr_t pn;
+	void __iomem *base = iommu_drvdata->base;
+	void __iomem *cb_base = iommu_drvdata->cb_base;
+	unsigned int ctx = master->cb_num;
+	phys_addr_t pgtable = __pa(priv->pt.fl_table);
+
+	__reset_context(iommu_drvdata, ctx);
+	msm_iommu_setup_ctx(cb_base, ctx);
+
+	if (priv->pt.redirect)
+		msm_iommu_setup_pg_l2_redirect(cb_base, ctx);
+
+	msm_iommu_setup_memory_remap(cb_base, ctx);
+
+	pn = pgtable >> CB_TTBR0_ADDR_SHIFT;
+	SET_CB_TTBR0_ADDR(cb_base, ctx, pn);
+
+	/* Enable context fault interrupt */
+	SET_CB_SCTLR_CFIE(cb_base, ctx, 1);
+
+	/* Redirect all cacheable requests to L2 slave port. */
+	SET_CB_ACTLR_BPRCISH(cb_base, ctx, 1);
+	SET_CB_ACTLR_BPRCOSH(cb_base, ctx, 1);
+	SET_CB_ACTLR_BPRCNSH(cb_base, ctx, 1);
+
+	/* Enable private ASID namespace */
+	SET_CB_SCTLR_ASIDPNE(cb_base, ctx, 1);
+
+	program_SMT(master, iommu_drvdata->base);
+
+	SET_CBAR_N(base, ctx, 0);
+
+	/* Stage 1 Context with Stage 2 bypass */
+	SET_CBAR_TYPE(base, ctx, 1);
+
+	/* Route page faults to the non-secure interrupt */
+	SET_CBAR_IRPTNDX(base, ctx, 1);
+
+	/* Set VMID to non-secure HLOS */
+	SET_CBAR_VMID(base, ctx, 3);
+
+	/* Bypass is treated as inner-shareable */
+	SET_CBAR_BPSHCFG(base, ctx, 2);
+
+	/* Do not downgrade memory attributes */
+	SET_CBAR_MEMATTR(base, ctx, 0x0A);
+
+	msm_iommu_assign_ASID(iommu_drvdata, master, priv);
+
+	/* Enable the MMU */
+	SET_CB_SCTLR_M(cb_base, ctx, 1);
+
+	/* Ensure all writes have completed before returning to caller */
+	mb();
+}
+
+static int msm_iommu_domain_init(struct iommu_domain *domain)
+{
+	struct msm_iommu_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		goto fail_nomem;
+
+	priv->pt.redirect = 0;
+
+	INIT_LIST_HEAD(&priv->list_attached);
+	if (msm_iommu_pagetable_alloc(&priv->pt))
+		goto fail_nomem;
+
+	domain->priv = priv;
+	return 0;
+
+fail_nomem:
+	kfree(priv);
+	return -ENOMEM;
+}
+
+static void msm_iommu_domain_destroy(struct iommu_domain *domain)
+{
+	struct msm_iommu_priv *priv;
+
+	mutex_lock(&msm_iommu_lock);
+	priv = domain->priv;
+	domain->priv = NULL;
+
+	if (priv)
+		msm_iommu_pagetable_free(&priv->pt);
+
+	kfree(priv);
+	mutex_unlock(&msm_iommu_lock);
+}
+
+static int msm_iommu_context_alloc(struct msm_iommu_drvdata *drvdata,
+				   struct msm_iommu_master *master)
+{
+	int ret = 0;
+	int num_cb = ida_simple_get(&drvdata->cb_ida, 0,
+				    drvdata->ncb, GFP_KERNEL);
+	if (num_cb >= 0)
+		master->cb_num = num_cb;
+	else
+		ret = -ENOMEM;
+	return ret;
+}
+
+static void msm_iommu_context_release(struct msm_iommu_drvdata *drvdata,
+				     struct msm_iommu_master *master)
+{
+	ida_simple_remove(&drvdata->cb_ida, master->cb_num);
+}
+
+static irqreturn_t msm_iommu_fault_handler(int irq, void *data);
+
+static int msm_iommu_interrupt_enable(struct msm_iommu_drvdata *drvdata,
+				      struct msm_iommu_master *master,
+				      struct iommu_domain *domain)
+{
+	int ret;
+	int irq = drvdata->cb_irq[master->irq_num];
+
+	ret = devm_request_threaded_irq(drvdata->dev, irq, NULL,
+				msm_iommu_fault_handler,
+				IRQF_ONESHOT | IRQF_SHARED,
+				"msm_iommu_nonsecure_irq", domain);
+	if (ret)
+		pr_err("Request IRQ %d failed with ret=%d\n", irq, ret);
+
+	return ret;
+}
+
+static void msm_iommu_interrupt_disable(struct msm_iommu_drvdata *drvdata,
+					struct msm_iommu_master *master,
+					struct iommu_domain *domain)
+{
+	int irq = drvdata->cb_irq[master->irq_num];
+
+	devm_free_irq(drvdata->dev, irq, domain);
+}
+
+static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct msm_iommu_priv *priv;
+	struct msm_iommu_drvdata *iommu_drvdata;
+	int ret = 0;
+	int is_secure;
+	struct msm_iommu_master *master;
+
+	mutex_lock(&msm_iommu_lock);
+
+	priv = domain->priv;
+	if (!priv || !dev) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	iommu_drvdata = dev->archdata.iommu;
+	master = msm_iommu_find_master(iommu_drvdata, dev);
+
+	if (!master) {
+		pr_err("Device is not an IOMMU master: %s\n", dev->init_name);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (msm_iommu_context_alloc(iommu_drvdata, master)) {
+		pr_err("%s: Out of context banks!\n", iommu_drvdata->name);
+		goto unlock;
+	}
+
+	ret = __enable_regulators(iommu_drvdata);
+	if (ret)
+		goto free_ctx;
+
+	ret = __enable_clocks(iommu_drvdata);
+	if (ret) {
+		__disable_regulators(iommu_drvdata);
+		goto free_ctx;
+	}
+
+	/* We need to only do this once */
+	if (!iommu_drvdata->ctx_attach_count) {
+		__program_iommu(iommu_drvdata);
+		program_iommu_bfb_settings(iommu_drvdata->base,
+					   iommu_drvdata->bfb_settings);
+	}
+
+	iommu_halt(iommu_drvdata);
+	__program_context(iommu_drvdata, master, priv, is_secure);
+	iommu_resume(iommu_drvdata);
+
+	ret = msm_iommu_interrupt_enable(iommu_drvdata, master, domain);
+
+	if (!iommu_drvdata->ctx_attach_count)
+		SET_CR0_CLIENTPD(iommu_drvdata->base, 0);
+
+	__disable_clocks(iommu_drvdata);
+
+	list_add(&(master->attached_elm), &priv->list_attached);
+	++iommu_drvdata->ctx_attach_count;
+	mutex_unlock(&msm_iommu_lock);
+
+	return ret;
+free_ctx:
+	msm_iommu_context_release(iommu_drvdata, master);
+unlock:
+	mutex_unlock(&msm_iommu_lock);
+	return ret;
+}
+
+static void msm_iommu_detach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	struct msm_iommu_priv *priv;
+	struct msm_iommu_drvdata *iommu_drvdata;
+	struct msm_iommu_master *master;
+	int ret;
+
+	mutex_lock(&msm_iommu_lock);
+	priv = domain->priv;
+	if (!priv || !dev)
+		goto unlock;
+
+	iommu_drvdata = dev->archdata.iommu;
+	master = msm_iommu_find_master(iommu_drvdata, dev);
+
+	if (!master) {
+		pr_err("Device is not an IOMMU master: %s\n", dev->init_name);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = __enable_clocks(iommu_drvdata);
+	if (ret)
+		goto unlock;
+
+	msm_iommu_interrupt_disable(iommu_drvdata, master, domain);
+
+	SET_TLBIASID(iommu_drvdata->cb_base, master->cb_num, master->asid);
+
+	BUG_ON(iommu_drvdata->asid[master->asid - 1] == 0);
+	iommu_drvdata->asid[master->asid - 1]--;
+	master->asid = -1;
+
+	__reset_context(iommu_drvdata, master->cb_num);
+
+	iommu_halt(iommu_drvdata);
+	__release_SMT(master->cb_num, iommu_drvdata->base);
+	iommu_resume(iommu_drvdata);
+
+	__disable_clocks(iommu_drvdata);
+
+	__disable_regulators(iommu_drvdata);
+
+	list_del_init(&master->attached_elm);
+	BUG_ON(iommu_drvdata->ctx_attach_count == 0);
+	--iommu_drvdata->ctx_attach_count;
+	msm_iommu_context_release(iommu_drvdata, master);
+unlock:
+	mutex_unlock(&msm_iommu_lock);
+}
+
+static int msm_iommu_map(struct iommu_domain *domain, unsigned long va,
+			 phys_addr_t pa, size_t len, int prot)
+{
+	struct msm_iommu_priv *priv;
+	int ret = 0;
+
+	mutex_lock(&msm_iommu_lock);
+
+	priv = domain->priv;
+	if (!priv) {
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	ret = msm_iommu_pagetable_map(&priv->pt, va, pa, len, prot);
+	if (ret)
+		goto fail;
+
+	ret = __flush_iotlb_va(domain, va);
+fail:
+	mutex_unlock(&msm_iommu_lock);
+	return ret;
+}
+
+static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long va,
+			    size_t len)
+{
+	struct msm_iommu_priv *priv;
+	int ret = -ENODEV;
+
+	mutex_lock(&msm_iommu_lock);
+
+	priv = domain->priv;
+	if (!priv)
+		goto fail;
+
+	ret = msm_iommu_pagetable_unmap(&priv->pt, va, len);
+	if (ret < 0)
+		goto fail;
+
+	ret = __flush_iotlb_va(domain, va);
+
+	msm_iommu_pagetable_free_tables(&priv->pt, va, len);
+fail:
+	mutex_unlock(&msm_iommu_lock);
+
+	/* the IOMMU API requires us to return how many bytes were unmapped */
+	len = ret ? 0 : len;
+	return len;
+}
+
+static int msm_iommu_map_range(struct iommu_domain *domain, unsigned int va,
+			       struct scatterlist *sg, unsigned int len,
+			       int prot)
+{
+	int ret;
+	struct msm_iommu_priv *priv;
+
+	mutex_lock(&msm_iommu_lock);
+
+	priv = domain->priv;
+	if (!priv) {
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	ret = msm_iommu_pagetable_map_range(&priv->pt, va, sg, len, prot);
+	if (ret)
+		goto fail;
+
+	__flush_iotlb(domain);
+fail:
+	mutex_unlock(&msm_iommu_lock);
+	return ret;
+}
+
+
+static int msm_iommu_unmap_range(struct iommu_domain *domain, unsigned int va,
+				 unsigned int len)
+{
+	struct msm_iommu_priv *priv;
+
+	mutex_lock(&msm_iommu_lock);
+
+	priv = domain->priv;
+	msm_iommu_pagetable_unmap_range(&priv->pt, va, len);
+
+	__flush_iotlb(domain);
+
+	msm_iommu_pagetable_free_tables(&priv->pt, va, len);
+	mutex_unlock(&msm_iommu_lock);
+	return 0;
+}
+
+static phys_addr_t msm_iommu_get_phy_from_PAR(unsigned long va, u64 par)
+{
+	phys_addr_t phy;
+
+	/* We are dealing with a supersection */
+	if (par & CB_PAR_SS)
+		phy = (par & 0xFF000000) | (va & 0x00FFFFFF);
+	else /* Upper 20 bits from PAR, lower 12 from VA */
+		phy = (par & 0xFFFFF000) | (va & 0x00000FFF);
+
+	return phy;
+}
+
+static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
+					  phys_addr_t va)
+{
+	struct msm_iommu_priv *priv;
+	struct msm_iommu_drvdata *iommu_drvdata;
+	struct msm_iommu_master *master;
+	u64 par;
+	void __iomem *base;
+	phys_addr_t ret = 0;
+	int ctx;
+	int i;
+
+	mutex_lock(&msm_iommu_lock);
+
+	priv = domain->priv;
+	if (list_empty(&priv->list_attached))
+		goto fail;
+
+	master = list_entry(priv->list_attached.next,
+			    struct msm_iommu_master, attached_elm);
+	iommu_drvdata = master->drvdata;
+	BUG_ON(!iommu_drvdata);
+
+	base = iommu_drvdata->cb_base;
+	ctx = master->cb_num;
+
+	ret = __enable_clocks(iommu_drvdata);
+	if (ret) {
+		ret = 0;	/* 0 indicates translation failed */
+		goto fail;
+	}
+
+	SET_ATS1PR(base, ctx, va & CB_ATS1PR_ADDR);
+	/* Ensure command is completed before polling the activity bi */
+	mb();
+	for (i = 0; i < IOMMU_MSEC_TIMEOUT; i += IOMMU_MSEC_STEP)
+		if (GET_CB_ATSR_ACTIVE(base, ctx) == 0)
+			break;
+		else
+			msleep(IOMMU_MSEC_STEP);
+
+	if (i >= IOMMU_MSEC_TIMEOUT) {
+		pr_err("%s: iova to phys timed out on %pa for %s (ctx: %u)\n",
+			__func__, &va, iommu_drvdata->name, master->cb_num);
+		ret = 0;
+		goto fail;
+	}
+
+	par = GET_PAR(base, ctx);
+	__disable_clocks(iommu_drvdata);
+
+	if (par & CB_PAR_F) {
+		unsigned int level = (par & CB_PAR_PLVL) >> CB_PAR_PLVL_SHIFT;
+
+		pr_err("IOMMU translation fault!\n");
+		pr_err("name = %s\n", iommu_drvdata->name);
+		pr_err("context = %d\n", master->cb_num);
+		pr_err("Interesting registers:\n");
+		pr_err("PAR = %16llx [%s%s%s%s%s%s%s%sPLVL%u %s]\n", par,
+			(par & CB_PAR_F) ? "F " : "",
+			(par & CB_PAR_TF) ? "TF " : "",
+			(par & CB_PAR_AFF) ? "AFF " : "",
+			(par & CB_PAR_PF) ? "PF " : "",
+			(par & CB_PAR_EF) ? "EF " : "",
+			(par & CB_PAR_TLBMCF) ? "TLBMCF " : "",
+			(par & CB_PAR_TLBLKF) ? "TLBLKF " : "",
+			(par & CB_PAR_ATOT) ? "ATOT " : "",
+			level,
+			(par & CB_PAR_STAGE) ? "S2 " : "S1 ");
+		ret = 0;
+	} else {
+		ret = msm_iommu_get_phy_from_PAR(va, par);
+	}
+
+fail:
+	mutex_unlock(&msm_iommu_lock);
+	return ret;
+}
+
+static int msm_iommu_domain_has_cap(struct iommu_domain *domain,
+				    unsigned long cap)
+{
+	return 0;
+}
+
+static inline void print_ctx_mem_attr_regs(struct msm_iommu_context_reg regs[])
+{
+	pr_err("PRRR   = %08x    NMRR   = %08x\n",
+		 regs[DUMP_REG_PRRR].val, regs[DUMP_REG_NMRR].val);
+}
+
+void print_ctx_regs(struct msm_iommu_context_reg regs[])
+{
+	uint32_t fsr = regs[DUMP_REG_FSR].val;
+	u64 ttbr;
+	enum dump_reg iter;
+
+	pr_err("FAR    = %016llx\n",
+		COMBINE_DUMP_REG(
+			regs[DUMP_REG_FAR1].val,
+			regs[DUMP_REG_FAR0].val));
+	pr_err("PAR    = %016llx\n",
+		COMBINE_DUMP_REG(
+			regs[DUMP_REG_PAR1].val,
+			regs[DUMP_REG_PAR0].val));
+	pr_err("FSR    = %08x [%s%s%s%s%s%s%s%s%s]\n", fsr,
+			(fsr & 0x02) ? "TF " : "",
+			(fsr & 0x04) ? "AFF " : "",
+			(fsr & 0x08) ? "PF " : "",
+			(fsr & 0x10) ? "EF " : "",
+			(fsr & 0x20) ? "TLBMCF " : "",
+			(fsr & 0x40) ? "TLBLKF " : "",
+			(fsr & 0x80) ? "MHF " : "",
+			(fsr & 0x40000000) ? "SS " : "",
+			(fsr & 0x80000000) ? "MULTI " : "");
+
+	pr_err("FSYNR0 = %08x    FSYNR1 = %08x\n",
+		 regs[DUMP_REG_FSYNR0].val, regs[DUMP_REG_FSYNR1].val);
+
+	ttbr = COMBINE_DUMP_REG(regs[DUMP_REG_TTBR0_1].val,
+				regs[DUMP_REG_TTBR0_0].val);
+	if (regs[DUMP_REG_TTBR0_1].valid)
+		pr_err("TTBR0  = %016llx\n", ttbr);
+	else
+		pr_err("TTBR0  = %016llx (32b)\n", ttbr);
+
+	ttbr = COMBINE_DUMP_REG(regs[DUMP_REG_TTBR1_1].val,
+				regs[DUMP_REG_TTBR1_0].val);
+
+	if (regs[DUMP_REG_TTBR1_1].valid)
+		pr_err("TTBR1  = %016llx\n", ttbr);
+	else
+		pr_err("TTBR1  = %016llx (32b)\n", ttbr);
+
+	pr_err("SCTLR  = %08x    ACTLR  = %08x\n",
+		 regs[DUMP_REG_SCTLR].val, regs[DUMP_REG_ACTLR].val);
+	pr_err("CBAR  = %08x    CBFRSYNRA  = %08x\n",
+		regs[DUMP_REG_CBAR_N].val, regs[DUMP_REG_CBFRSYNRA_N].val);
+	print_ctx_mem_attr_regs(regs);
+
+	for (iter = DUMP_REG_FIRST; iter < MAX_DUMP_REGS; ++iter)
+		if (!regs[iter].valid)
+			pr_err("NOTE: Value actually unknown for %s\n",
+				dump_regs_tbl[iter].name);
+}
+
+static void __print_ctx_regs(struct msm_iommu_drvdata *drvdata, int ctx,
+					unsigned int fsr)
+{
+	void __iomem *base = drvdata->base;
+	void __iomem *cb_base = drvdata->cb_base;
+	struct msm_iommu_context_reg regs[MAX_DUMP_REGS];
+	unsigned int i;
+
+	memset(regs, 0, sizeof(regs));
+
+	for (i = DUMP_REG_FIRST; i < MAX_DUMP_REGS; ++i) {
+		struct msm_iommu_context_reg *r = &regs[i];
+		unsigned long regaddr = dump_regs_tbl[i].reg_offset;
+
+		r->valid = 1;
+		switch (dump_regs_tbl[i].dump_reg_type) {
+		case DRT_CTX_REG:
+			r->val = GET_CTX_REG(regaddr, cb_base, ctx);
+			break;
+		case DRT_GLOBAL_REG:
+			r->val = GET_GLOBAL_REG(regaddr, base);
+			break;
+		case DRT_GLOBAL_REG_N:
+			r->val = GET_GLOBAL_REG_N(regaddr, ctx, base);
+			break;
+		default:
+			pr_info("Unknown dump_reg_type...\n");
+			r->valid = 0;
+			break;
+		}
+	}
+	print_ctx_regs(regs);
+}
+
+static void print_global_regs(void __iomem *base, unsigned int gfsr)
+{
+	pr_err("GFAR    = %016llx\n", GET_GFAR(base));
+
+	pr_err("GFSR    = %08x [%s%s%s%s%s%s%s%s%s%s]\n", gfsr,
+			(gfsr & 0x01) ? "ICF " : "",
+			(gfsr & 0x02) ? "USF " : "",
+			(gfsr & 0x04) ? "SMCF " : "",
+			(gfsr & 0x08) ? "UCBF " : "",
+			(gfsr & 0x10) ? "UCIF " : "",
+			(gfsr & 0x20) ? "CAF " : "",
+			(gfsr & 0x40) ? "EF " : "",
+			(gfsr & 0x80) ? "PF " : "",
+			(gfsr & 0x40000000) ? "SS " : "",
+			(gfsr & 0x80000000) ? "MULTI " : "");
+
+	pr_err("GFSYNR0	= %08x\n", GET_GFSYNR0(base));
+	pr_err("GFSYNR1	= %08x\n", GET_GFSYNR1(base));
+	pr_err("GFSYNR2	= %08x\n", GET_GFSYNR2(base));
+}
+
+irqreturn_t msm_iommu_global_fault_handler(int irq, void *dev_id)
+{
+	struct msm_iommu_drvdata *drvdata = dev_id;
+	unsigned int gfsr;
+	int ret;
+
+	mutex_lock(&msm_iommu_lock);
+
+	if (!drvdata->powered_on) {
+		ret = IRQ_NONE;
+		goto fail;
+	}
+
+	ret = __enable_clocks(drvdata);
+	if (ret) {
+		ret = IRQ_NONE;
+		goto fail;
+	}
+
+	gfsr = GET_GFSR(drvdata->base);
+	if (gfsr) {
+		pr_err("Unexpected %s global fault !!\n", drvdata->name);
+		print_global_regs(drvdata->base, gfsr);
+		SET_GFSR(drvdata->base, gfsr);
+		ret = IRQ_HANDLED;
+	} else
+		ret = IRQ_NONE;
+
+	__disable_clocks(drvdata);
+fail:
+	mutex_unlock(&msm_iommu_lock);
+	return ret;
+}
+
+int msm_iommu_check_fault(struct msm_iommu_drvdata *drvdata,
+			  struct msm_iommu_master *master,
+			  struct iommu_domain *domain)
+{
+	int ret = IRQ_NONE;
+	unsigned int fsr;
+
+	fsr = GET_FSR(drvdata->cb_base, master->cb_num);
+	if (fsr) {
+		u64 faulty_iova;
+
+		faulty_iova = GET_FAR(drvdata->cb_base, master->cb_num);
+		ret = report_iommu_fault(domain, drvdata->dev, faulty_iova, 0);
+
+		if (ret == -ENOSYS) {
+			pr_err("Unexpected IOMMU page fault!\n");
+			pr_err("name = %s\n", drvdata->name);
+			pr_err("context = %d\n", master->cb_num);
+			pr_err("Interesting registers:\n");
+			__print_ctx_regs(drvdata, master->cb_num, fsr);
+		}
+
+		if (ret != -EBUSY)
+			SET_FSR(drvdata->cb_base, master->cb_num, fsr);
+		ret = IRQ_HANDLED;
+	}
+	return ret;
+}
+
+static irqreturn_t msm_iommu_fault_handler(int irq, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct msm_iommu_drvdata *drvdata = 0;
+	struct msm_iommu_master *master;
+	int ret;
+	struct msm_iommu_priv *priv;
+	bool handled = false;
+
+	mutex_lock(&msm_iommu_lock);
+
+	if (!domain) {
+		pr_err("Unexpected IOMMU context fault interrupt from irq %d\n",
+			irq);
+		ret = IRQ_HANDLED;
+		goto fail;
+	}
+
+	priv = domain->priv;
+
+	list_for_each_entry(master, &priv->list_attached, attached_elm) {
+		struct msm_iommu_drvdata *drvdata = master->drvdata;
+
+		if (drvdata->powered_on) {
+			ret = __enable_clocks(drvdata);
+			if (ret) {
+				pr_err("Unable to turn on clocks in page fault handler\n");
+				ret = IRQ_NONE;
+				goto fail;
+			}
+			ret = msm_iommu_check_fault(drvdata, master, domain);
+			__disable_clocks(drvdata);
+
+			handled = (ret == IRQ_HANDLED);
+		}
+	}
+
+	if (!handled) {
+		pr_err("Unexpected IOMMU page fault!\n");
+		if (drvdata)
+			pr_err("name = %s\n", drvdata->name);
+		pr_err("Power is OFF. Unable to read page fault information\n");
+		/*
+		 * We cannot determine which context bank caused the issue so
+		 * we just return handled here to ensure IRQ handler code is
+		 * happy
+		 */
+		ret = IRQ_HANDLED;
+	}
+
+fail:
+	mutex_unlock(&msm_iommu_lock);
+	return ret;
+}
+
+#define DUMP_REG_INIT(dump_reg, cb_reg, mbp, drt)		\
+	do {							\
+		dump_regs_tbl[dump_reg].reg_offset = cb_reg;	\
+		dump_regs_tbl[dump_reg].name = #cb_reg;		\
+		dump_regs_tbl[dump_reg].must_be_present = mbp;	\
+		dump_regs_tbl[dump_reg].dump_reg_type = drt;	\
+	} while (0)
+
+static void msm_iommu_build_dump_regs_table(void)
+{
+	DUMP_REG_INIT(DUMP_REG_FAR0,	CB_FAR,       1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_FAR1,	CB_FAR + 4,   1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_PAR0,	CB_PAR,       1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_PAR1,	CB_PAR + 4,   1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_FSR,	CB_FSR,       1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_FSYNR0,	CB_FSYNR0,    1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_FSYNR1,	CB_FSYNR1,    1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_TTBR0_0,	CB_TTBR0,     1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_TTBR0_1,	CB_TTBR0 + 4, 0, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_TTBR1_0,	CB_TTBR1,     1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_TTBR1_1,	CB_TTBR1 + 4, 0, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_SCTLR,	CB_SCTLR,     1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_ACTLR,	CB_ACTLR,     1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_PRRR,	CB_PRRR,      1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_NMRR,	CB_NMRR,      1, DRT_CTX_REG);
+	DUMP_REG_INIT(DUMP_REG_CBAR_N,	CBAR,         1, DRT_GLOBAL_REG_N);
+	DUMP_REG_INIT(DUMP_REG_CBFRSYNRA_N, CBFRSYNRA, 1, DRT_GLOBAL_REG_N);
+}
+
+static int msm_iommu_add_master(struct device *dev, s32 nSIDs)
+{
+	u32 i;
+	struct msm_iommu_master *master;
+	struct msm_iommu_drvdata *iommu;
+	struct of_phandle_args args;
+	s32 ret = 0;
+
+	master = kzalloc(sizeof(*master), GFP_KERNEL);
+	if (!master) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = of_parse_phandle_with_args(dev->of_node,
+			"iommus", "#iommu-cells", 0, &args);
+	if (ret) {
+		pr_err("Failed to parse iommus: %d\n", ret);
+		goto free_master;
+	}
+
+	iommu = msm_iommu_find_iommu(args.np);
+	if (!iommu) {
+		pr_err("Could not find iommu\n");
+		ret = -EINVAL;
+		goto free_master;
+	}
+
+	master->cb_num = -1;
+	master->irq_num = 0;
+	master->nsids = 0;
+	INIT_LIST_HEAD(&master->attached_elm);
+	master->drvdata = iommu;
+	master->dev = dev;
+
+	for (i = 0; i < nSIDs; ++i) {
+		ret = of_parse_phandle_with_args(dev->of_node,
+				"iommus", "#iommu-cells", i, &args);
+		if (ret) {
+			pr_err("Failed to parse iommus: %d\n", ret);
+			goto free_master;
+		}
+		if (args.args_count == 1) {
+			master->sids[i] = args.args[0];
+		} else {
+			pr_err("Incorrect number of phandle arguments: %d\n",
+				args.args_count);
+			goto free_master;
+		}
+	}
+	master->nsids = nSIDs;
+
+	list_add(&master->list, &iommu->masters);
+	dev->archdata.iommu = iommu;
+	goto out;
+
+free_master:
+	kfree(master);
+out:
+	return ret;
+}
+
+static void msm_iommu_remove_master(struct device *dev)
+{
+	struct msm_iommu_master *master;
+
+	master = msm_iommu_find_master(dev->archdata.iommu, dev);
+
+	if (master) {
+		list_del(&master->list);
+		dev->archdata.iommu = 0;
+		kfree(master);
+	}
+}
+
+
+static int msm_iommu_add_device(struct device *dev)
+{
+	s32 nSIDs;
+	s32 ret = 0;
+
+	if (!dev)
+		return ret;
+
+	nSIDs = of_count_phandle_with_args(dev->of_node, "iommus",
+					   "#iommu-cells");
+
+	if (nSIDs >= MAX_NUM_SMR) {
+		pr_err("Too many SIDs: %u. Only support %u SID\n",
+			nSIDs, MAX_NUM_SMR);
+		ret = -EINVAL;
+	} else if (nSIDs > 0) {
+		mutex_lock(&msm_iommu_lock);
+		ret = msm_iommu_add_master(dev, nSIDs);
+		mutex_unlock(&msm_iommu_lock);
+	}
+
+	return ret;
+}
+
+static void msm_iommu_remove_device(struct device *dev)
+{
+	if (dev->archdata.iommu) {
+		mutex_lock(&msm_iommu_lock);
+		msm_iommu_remove_master(dev);
+		mutex_unlock(&msm_iommu_lock);
+	}
+
+	dev->archdata.iommu = 0;
+}
+
+static int msm_domain_get_attr(struct iommu_domain *domain,
+			       enum iommu_attr attr, void *data)
+{
+	s32 ret = 0;
+
+	switch (attr) {
+	default:
+		pr_err("Unsupported attribute type\n");
+		ret = -EINVAL;
+		break;
+	};
+
+	return ret;
+}
+
+static int msm_domain_set_attr(struct iommu_domain *domain,
+			       enum iommu_attr attr, void *data)
+{
+	s32 ret = 0;
+
+	switch (attr) {
+	default:
+		pr_err("Unsupported attribute type\n");
+		ret = -EINVAL;
+		break;
+	};
+
+	return ret;
+}
+
+static struct iommu_ops msm_iommu_ops = {
+	.domain_init = msm_iommu_domain_init,
+	.domain_destroy = msm_iommu_domain_destroy,
+	.attach_dev = msm_iommu_attach_dev,
+	.detach_dev = msm_iommu_detach_dev,
+	.add_device = msm_iommu_add_device,
+	.remove_device = msm_iommu_remove_device,
+	.map = msm_iommu_map,
+	.unmap = msm_iommu_unmap,
+	.map_range = msm_iommu_map_range,
+	.unmap_range = msm_iommu_unmap_range,
+	.iova_to_phys = msm_iommu_iova_to_phys,
+	.domain_has_cap = msm_iommu_domain_has_cap,
+	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
+	.domain_get_attr = msm_domain_get_attr,
+	.domain_set_attr = msm_domain_set_attr,
+};
+
+int __init msm_iommu_init(void)
+{
+	msm_iommu_pagetable_init();
+	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
+	msm_iommu_build_dump_regs_table();
+
+	return 0;
+}
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MSM SMMU v1 Driver");
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
new file mode 100644
index 0000000..5c7981e
--- /dev/null
+++ b/drivers/iommu/msm_iommu.c
@@ -0,0 +1,149 @@
+/* Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/export.h>
+#include <linux/iommu.h>
+#include <linux/qcom_iommu.h>
+
+static DEFINE_MUTEX(iommu_list_lock);
+static LIST_HEAD(iommu_list);
+
+#define MRC(reg, processor, op1, crn, crm, op2)				\
+__asm__ __volatile__ (							\
+"   mrc   "   #processor "," #op1 ", %0,"  #crn "," #crm "," #op2 "\n"  \
+: "=r" (reg))
+
+#define RCP15_PRRR(reg)   MRC(reg, p15, 0, c10, c2, 0)
+#define RCP15_NMRR(reg)   MRC(reg, p15, 0, c10, c2, 1)
+
+#define RCP15_MAIR0(reg)   MRC(reg, p15, 0, c10, c2, 0)
+#define RCP15_MAIR1(reg)   MRC(reg, p15, 0, c10, c2, 1)
+
+/* These values come from proc-v7-2level.S */
+#define PRRR_VALUE 0xff0a81a8
+#define NMRR_VALUE 0x40e040e0
+
+/* These values come from proc-v7-3level.S */
+#define MAIR0_VALUE 0xeeaa4400
+#define MAIR1_VALUE 0xff000004
+
+static struct msm_iommu_access_ops *msm_iommu_access_ops;
+
+void msm_set_iommu_access_ops(struct msm_iommu_access_ops *ops)
+{
+	msm_iommu_access_ops = ops;
+}
+
+struct msm_iommu_access_ops *msm_get_iommu_access_ops()
+{
+	BUG_ON(msm_iommu_access_ops == NULL);
+	return msm_iommu_access_ops;
+}
+EXPORT_SYMBOL(msm_get_iommu_access_ops);
+
+void msm_iommu_add_drv(struct msm_iommu_drvdata *drv)
+{
+	mutex_lock(&iommu_list_lock);
+	list_add(&drv->list, &iommu_list);
+	mutex_unlock(&iommu_list_lock);
+}
+
+void msm_iommu_remove_drv(struct msm_iommu_drvdata *drv)
+{
+	mutex_lock(&iommu_list_lock);
+	list_del(&drv->list);
+	mutex_unlock(&iommu_list_lock);
+}
+
+struct msm_iommu_drvdata *msm_iommu_find_iommu(struct device_node *np)
+{
+	struct msm_iommu_drvdata *drv;
+	struct msm_iommu_drvdata *drvdata = 0;
+
+	mutex_lock(&iommu_list_lock);
+	list_for_each_entry(drv, &iommu_list, list) {
+		if (drv->dev->of_node == np) {
+			drvdata = drv;
+			goto unlock;
+		}
+	}
+unlock:
+	mutex_unlock(&iommu_list_lock);
+	return drvdata;
+}
+
+struct msm_iommu_master *msm_iommu_find_master(struct msm_iommu_drvdata *drv,
+					       struct device *dev)
+{
+	struct msm_iommu_master *tmp;
+	struct msm_iommu_master *master = 0;
+
+	if (drv) {
+		list_for_each_entry(tmp, &drv->masters, list) {
+			if (tmp->dev == dev) {
+				master = tmp;
+				break;
+			}
+		}
+	}
+	return master;
+}
+
+#ifdef CONFIG_ARM
+#ifdef CONFIG_ARM_LPAE
+u32 msm_iommu_get_prrr(void)
+{
+	return PRRR_VALUE;
+}
+
+u32 msm_iommu_get_nmrr(void)
+{
+	return NMRR_VALUE;
+}
+#else
+#define RCP15_PRRR(reg)		MRC(reg, p15, 0, c10, c2, 0)
+#define RCP15_NMRR(reg)		MRC(reg, p15, 0, c10, c2, 1)
+
+u32 msm_iommu_get_prrr(void)
+{
+	u32 prrr;
+
+	RCP15_PRRR(prrr);
+	return prrr;
+}
+
+u32 msm_iommu_get_nmrr(void)
+{
+	u32 nmrr;
+
+	RCP15_NMRR(nmrr);
+	return nmrr;
+}
+#endif
+#endif
+#ifdef CONFIG_ARM64
+u32 msm_iommu_get_prrr(void)
+{
+	return PRRR_VALUE;
+}
+
+u32 msm_iommu_get_nmrr(void)
+{
+	return NMRR_VALUE;
+}
+#endif
diff --git a/drivers/iommu/msm_iommu_dev-v1.c b/drivers/iommu/msm_iommu_dev-v1.c
new file mode 100644
index 0000000..c1fa732
--- /dev/null
+++ b/drivers/iommu/msm_iommu_dev-v1.c
@@ -0,0 +1,340 @@
+/* Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/iommu.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/qcom_iommu.h>
+
+#include "msm_iommu_hw-v1.h"
+
+static const char *BFB_REG_NODE_NAME = "qcom,iommu-bfb-regs";
+static const char *BFB_DATA_NODE_NAME = "qcom,iommu-bfb-data";
+
+static int msm_iommu_parse_bfb_settings(struct platform_device *pdev,
+				    struct msm_iommu_drvdata *drvdata)
+{
+	struct msm_iommu_bfb_settings *bfb_settings;
+	u32 nreg, nval;
+	int ret;
+
+	/*
+	 * It is not valid for a device to have the BFB_REG_NODE_NAME
+	 * property but not the BFB_DATA_NODE_NAME property, and vice versa.
+	 */
+	if (!of_get_property(pdev->dev.of_node, BFB_REG_NODE_NAME, &nreg)) {
+		if (of_get_property(pdev->dev.of_node, BFB_DATA_NODE_NAME,
+				    &nval))
+			return -EINVAL;
+		return 0;
+	}
+
+	if (!of_get_property(pdev->dev.of_node, BFB_DATA_NODE_NAME, &nval))
+		return -EINVAL;
+
+	if (nreg >= sizeof(bfb_settings->regs))
+		return -EINVAL;
+
+	if (nval >= sizeof(bfb_settings->data))
+		return -EINVAL;
+
+	if (nval != nreg)
+		return -EINVAL;
+
+	bfb_settings = devm_kzalloc(&pdev->dev, sizeof(*bfb_settings),
+				    GFP_KERNEL);
+	if (!bfb_settings)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(pdev->dev.of_node,
+					 BFB_REG_NODE_NAME,
+					 bfb_settings->regs,
+					 nreg / sizeof(*bfb_settings->regs));
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_array(pdev->dev.of_node,
+					 BFB_DATA_NODE_NAME,
+					 bfb_settings->data,
+					 nval / sizeof(*bfb_settings->data));
+	if (ret)
+		return ret;
+
+	bfb_settings->length = nreg / sizeof(*bfb_settings->regs);
+
+	drvdata->bfb_settings = bfb_settings;
+	return 0;
+}
+
+static int msm_iommu_parse_dt(struct platform_device *pdev,
+				struct msm_iommu_drvdata *drvdata)
+{
+	int ret = 0;
+	struct resource *r;
+	unsigned int i;
+
+	drvdata->dev = &pdev->dev;
+
+	ret = msm_iommu_parse_bfb_settings(pdev, drvdata);
+	if (ret)
+		goto fail;
+
+	if (of_get_property(pdev->dev.of_node, "vdd-supply", NULL)) {
+
+		drvdata->gdsc = devm_regulator_get(&pdev->dev, "vdd");
+		if (IS_ERR(drvdata->gdsc)) {
+			ret = PTR_ERR(drvdata->gdsc);
+			goto fail;
+		}
+
+		drvdata->alt_gdsc = devm_regulator_get(&pdev->dev,
+							"qcom,alt-vdd");
+		if (IS_ERR(drvdata->alt_gdsc))
+			drvdata->alt_gdsc = NULL;
+	} else {
+		pr_debug("Warning: No regulator specified for IOMMU\n");
+	}
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					 "clk_halt_reg_base");
+	if (r) {
+		drvdata->clk_reg_virt = devm_ioremap(&pdev->dev, r->start,
+						     resource_size(r));
+		if (!drvdata->clk_reg_virt) {
+			pr_err("Failed to map resource for iommu clk: %pr\n",
+				r);
+			ret = -ENOMEM;
+			goto fail;
+		}
+	}
+
+	msm_iommu_access_ops_v1.iommu_power_on(drvdata);
+	msm_iommu_access_ops_v1.iommu_clk_on(drvdata);
+	drvdata->ncb = GET_IDR1_NUMCB(drvdata->base);
+	msm_iommu_access_ops_v1.iommu_clk_off(drvdata);
+	msm_iommu_access_ops_v1.iommu_power_off(drvdata);
+
+	drvdata->asid = devm_kzalloc(&pdev->dev, drvdata->ncb * sizeof(int),
+				     GFP_KERNEL);
+
+	if (!drvdata->asid) {
+		pr_err("Unable to get memory for asid array\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	ret = of_property_read_string(pdev->dev.of_node, "label",
+				      &drvdata->name);
+	if (ret)
+		drvdata->name = "Iommu";
+
+	INIT_LIST_HEAD(&drvdata->masters);
+
+	if (of_property_read_u32(drvdata->dev->of_node, "#global-interrupts",
+				 &drvdata->n_glb_irq)) {
+		pr_err("missing #global-interrupts property\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	if (drvdata->n_glb_irq > MAX_GLB_IRQ) {
+		ret = -ENOMEM;
+		pr_err("Unable to initialize IOMMU. Increase MAX_GLB_IRQ\n");
+		goto fail;
+	}
+
+	for (i = 0; i < drvdata->n_glb_irq; ++i) {
+		int irq = platform_get_irq(pdev, i);
+
+		if (irq < 0) {
+			pr_err("Failed to get global interrupt\n");
+			ret = -ENODEV;
+			goto fail;
+		} else {
+			drvdata->glb_irq[i] = irq;
+		}
+	}
+
+	drvdata->n_cb_irq = 0;
+	for (i = 0; i < MAX_CB_IRQ; ++i) {
+		drvdata->cb_irq[i] = platform_get_irq(pdev,
+						      i + drvdata->n_glb_irq);
+		if (drvdata->cb_irq[i] < 0)
+			break;
+		++drvdata->n_cb_irq;
+	}
+
+	if (!drvdata->n_cb_irq)
+		pr_warn("No CB interrupts registered for IOMMU %s\n",
+			drvdata->name);
+
+	msm_iommu_add_drv(drvdata);
+	return 0;
+
+fail:
+	return ret;
+}
+
+static int msm_iommu_probe(struct platform_device *pdev)
+{
+	struct msm_iommu_drvdata *drvdata;
+	struct resource *r;
+	int ret;
+	unsigned int i;
+	unsigned int clk_no = 0;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	ida_init(&drvdata->cb_ida);
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "iommu_base");
+	if (!r)
+		return -EINVAL;
+
+	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (!drvdata->base)
+		return -ENOMEM;
+
+	drvdata->phys_base = r->start;
+	drvdata->glb_base = drvdata->base;
+	drvdata->cb_base = drvdata->base + 0x8000;
+
+	drvdata->clk[clk_no] = devm_clk_get(&pdev->dev, "core_clk");
+	if (IS_ERR(drvdata->clk[clk_no]))
+		return PTR_ERR(drvdata->clk[clk_no]);
+	++clk_no;
+
+	drvdata->clk[clk_no] = devm_clk_get(&pdev->dev, "iface_clk");
+	if (IS_ERR(drvdata->clk[clk_no]))
+		return PTR_ERR(drvdata->clk[clk_no]);
+	++clk_no;
+
+	drvdata->clk[clk_no] = devm_clk_get(&pdev->dev, "alt_core_clk");
+	if (IS_ERR(drvdata->clk[clk_no]))
+		drvdata->clk[clk_no] = 0;
+	else
+		++clk_no;
+
+	drvdata->clk[clk_no] = devm_clk_get(&pdev->dev, "alt_iface_clk");
+	if (IS_ERR(drvdata->clk[clk_no]))
+		drvdata->clk[clk_no] = 0;
+	else
+		++clk_no;
+
+	/*
+	 * Clocks requires to have a rate set before they can be turned on.
+	 * Just set the rate to a default rate for now.
+	 */
+	while (clk_no) {
+		--clk_no;
+		if (clk_get_rate(drvdata->clk[clk_no]) == 0) {
+			ret = clk_round_rate(drvdata->clk[clk_no], 1000);
+			clk_set_rate(drvdata->clk[clk_no], ret);
+		}
+	}
+
+	ret = msm_iommu_parse_dt(pdev, drvdata);
+	if (ret)
+		return ret;
+	/*
+	 * Enable halt of the IOMMU before programming certain registers.
+	 * Certain registers cannot be updated while the SMMU has transactions
+	 * in progress.
+	 */
+	drvdata->halt_enabled = true;
+
+	dev_info(&pdev->dev,
+		"device %s mapped at %p, with %d ctx banks\n",
+		drvdata->name, drvdata->base, drvdata->ncb);
+
+	platform_set_drvdata(pdev, drvdata);
+
+	for (i = 0; i < drvdata->n_glb_irq; ++i) {
+		ret = devm_request_threaded_irq(&pdev->dev, drvdata->glb_irq[i],
+				NULL,
+				msm_iommu_global_fault_handler,
+				IRQF_ONESHOT | IRQF_SHARED |
+				IRQF_TRIGGER_RISING,
+				"msm_iommu_global_irq", drvdata);
+		if (ret < 0) {
+			pr_err("Request Global IRQ %d failed with ret=%d\n",
+				drvdata->glb_irq[i], ret);
+		}
+	}
+
+	return 0;
+}
+
+static int msm_iommu_remove(struct platform_device *pdev)
+{
+	struct msm_iommu_drvdata *drv = NULL;
+
+	drv = platform_get_drvdata(pdev);
+	if (drv) {
+		msm_iommu_remove_drv(drv);
+		platform_set_drvdata(pdev, NULL);
+	}
+	return 0;
+}
+
+static struct of_device_id msm_iommu_match_table[] = {
+	{ .compatible = "qcom,msm-smmu-v1", },
+	{}
+};
+
+static struct platform_driver msm_iommu_driver = {
+	.driver = {
+		.name	= "msm_iommu-v1",
+		.of_match_table = msm_iommu_match_table,
+	},
+	.probe		= msm_iommu_probe,
+	.remove		= msm_iommu_remove,
+};
+
+static int __init msm_iommu_driver_init(void)
+{
+	int ret;
+
+	msm_set_iommu_access_ops(&msm_iommu_access_ops_v1);
+	ret = platform_driver_register(&msm_iommu_driver);
+	if (ret != 0) {
+		pr_err("Failed to register IOMMU driver\n");
+		goto error;
+	}
+
+	msm_iommu_init();
+error:
+	return ret;
+}
+
+static void __exit msm_iommu_driver_exit(void)
+{
+	platform_driver_unregister(&msm_iommu_driver);
+}
+
+subsys_initcall(msm_iommu_driver_init);
+module_exit(msm_iommu_driver_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/msm_iommu_hw-v1.h b/drivers/iommu/msm_iommu_hw-v1.h
new file mode 100644
index 0000000..f26ca7c
--- /dev/null
+++ b/drivers/iommu/msm_iommu_hw-v1.h
@@ -0,0 +1,2236 @@
+/* Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_ARM_MACH_MSM_IOMMU_HW_V1_H
+#define __ARCH_ARM_MACH_MSM_IOMMU_HW_V1_H
+
+#include <asm-generic/io-64-nonatomic-lo-hi.h>
+
+#define CTX_SHIFT  12
+
+#define CTX_REG(reg, base, ctx) \
+	((base) + (reg) + ((ctx) << CTX_SHIFT))
+#define GLB_REG(reg, base) \
+	((base) + (reg))
+#define GLB_REG_N(b, n, r) GLB_REG(b, ((r) + ((n) << 2)))
+#define GLB_FIELD(b, r) ((b) + (r))
+#define GLB_CTX_FIELD(b, c, r) (GLB_FIELD(b, r) + ((c) << CTX_SHIFT))
+#define GLB_FIELD_N(b, n, r) (GLB_FIELD(b, r) + ((n) << 2))
+
+
+#define GET_GLOBAL_REG(reg, base) (readl_relaxed(GLB_REG(reg, base)))
+#define GET_GLOBAL_REG_Q(reg, base) (readq(GLB_REG(reg, base)))
+#define GET_CTX_REG(reg, base, ctx) (readl_relaxed(CTX_REG(reg, base, ctx)))
+#define GET_CTX_REG_Q(reg, base, ctx) (readq(CTX_REG(reg, base, ctx)))
+
+#define SET_GLOBAL_REG(reg, base, val) writel_relaxed((val), GLB_REG(reg, base))
+#define SET_GLOBAL_REG_Q(reg, base, val) \
+	(writeq((val), GLB_REG(reg, base)))
+
+#define SET_CTX_REG(reg, base, ctx, val) \
+	writel_relaxed((val), (CTX_REG(reg, base, ctx)))
+#define SET_CTX_REG_Q(reg, base, ctx, val) \
+	writeq((val), CTX_REG(reg, base, ctx))
+
+/* Wrappers for numbered registers */
+#define SET_GLOBAL_REG_N(b, n, r, v) writel_relaxed(((v)), GLB_REG_N(b, n, r))
+#define GET_GLOBAL_REG_N(b, n, r) (readl_relaxed(GLB_REG_N(b, n, r)))
+
+/* Field wrappers */
+#define GET_GLOBAL_FIELD(b, r, F) \
+	GET_FIELD(GLB_FIELD(b, r), r##_##F##_MASK, r##_##F##_SHIFT)
+#define GET_CONTEXT_FIELD(b, c, r, F) \
+	GET_FIELD(GLB_CTX_FIELD(b, c, r),	\
+			r##_##F##_MASK, r##_##F##_SHIFT)
+#define GET_CONTEXT_FIELD_Q(b, c, r, F) \
+	GET_FIELD_Q(GLB_CTX_FIELD(b, c, r),	\
+			r##_##F##_MASK, r##_##F##_SHIFT)
+
+#define SET_GLOBAL_FIELD(b, r, F, v) \
+	SET_FIELD(GLB_FIELD(b, r), r##_##F##_MASK, r##_##F##_SHIFT, (v))
+#define SET_CONTEXT_FIELD(b, c, r, F, v) \
+	SET_FIELD(GLB_CTX_FIELD(b, c, r),		\
+			r##_##F##_MASK, r##_##F##_SHIFT, (v))
+#define SET_CONTEXT_FIELD_Q(b, c, r, F, v) \
+	SET_FIELD_Q(GLB_CTX_FIELD(b, c, r),	\
+			r##_##F##_MASK, r##_##F##_SHIFT, (v))
+
+/* Wrappers for numbered field registers */
+#define SET_GLOBAL_FIELD_N(b, n, r, F, v) \
+	SET_FIELD(GLB_FIELD_N(b, n, r), r##_##F##_MASK, r##_##F##_SHIFT, v)
+#define GET_GLOBAL_FIELD_N(b, n, r, F) \
+	GET_FIELD(GLB_FIELD_N(b, n, r), r##_##F##_MASK, r##_##F##_SHIFT)
+
+#define GET_FIELD(addr, mask, shift) ((readl_relaxed(addr) >> (shift)) & (mask))
+#define GET_FIELD_Q(addr, mask, shift) \
+	((readq(addr) >> (shift)) & (mask))
+
+#define SET_FIELD(addr, mask, shift, v) \
+do { \
+	int t = readl_relaxed(addr); \
+	writel_relaxed((t & ~((mask) << (shift))) + (((v) & \
+			(mask)) << (shift)), addr); \
+} while (0)
+
+#define SET_FIELD_Q(addr, mask, shift, v) \
+do { \
+	u64 t = readq(addr); \
+	writeq((t & ~(((u64) mask) << (shift))) + (((v) & \
+			((u64) mask)) << (shift)), addr); \
+} while (0)
+
+
+/* Global register space 0 setters / getters */
+#define SET_CR0(b, v)            SET_GLOBAL_REG(CR0, (b), (v))
+#define SET_SCR1(b, v)           SET_GLOBAL_REG(SCR1, (b), (v))
+#define SET_CR2(b, v)            SET_GLOBAL_REG(CR2, (b), (v))
+#define SET_ACR(b, v)            SET_GLOBAL_REG(ACR, (b), (v))
+#define SET_IDR0(b, N, v)        SET_GLOBAL_REG(IDR0, (b), (v))
+#define SET_IDR1(b, N, v)        SET_GLOBAL_REG(IDR1, (b), (v))
+#define SET_IDR2(b, N, v)        SET_GLOBAL_REG(IDR2, (b), (v))
+#define SET_IDR7(b, N, v)        SET_GLOBAL_REG(IDR7, (b), (v))
+#define SET_GFAR(b, v)           SET_GLOBAL_REG_Q(GFAR, (b), (v))
+#define SET_GFSR(b, v)           SET_GLOBAL_REG(GFSR, (b), (v))
+#define SET_GFSRRESTORE(b, v)    SET_GLOBAL_REG(GFSRRESTORE, (b), (v))
+#define SET_GFSYNR0(b, v)        SET_GLOBAL_REG(GFSYNR0, (b), (v))
+#define SET_GFSYNR1(b, v)        SET_GLOBAL_REG(GFSYNR1, (b), (v))
+#define SET_GFSYNR2(b, v)        SET_GLOBAL_REG(GFSYNR2, (b), (v))
+#define SET_TLBIVMID(b, v)       SET_GLOBAL_REG(TLBIVMID, (b), (v))
+#define SET_TLBIALLNSNH(b, v)    SET_GLOBAL_REG(TLBIALLNSNH, (b), (v))
+#define SET_TLBIALLH(b, v)       SET_GLOBAL_REG(TLBIALLH, (b), (v))
+#define SET_TLBGSYNC(b, v)       SET_GLOBAL_REG(TLBGSYNC, (b), (v))
+#define SET_TLBGSTATUS(b, v)     SET_GLOBAL_REG(TLBSTATUS, (b), (v))
+#define SET_TLBIVAH(b, v)        SET_GLOBAL_REG(TLBIVAH, (b), (v))
+#define SET_GATS1UR(b, v)        SET_GLOBAL_REG(GATS1UR, (b), (v))
+#define SET_GATS1UW(b, v)        SET_GLOBAL_REG(GATS1UW, (b), (v))
+#define SET_GATS1PR(b, v)        SET_GLOBAL_REG(GATS1PR, (b), (v))
+#define SET_GATS1PW(b, v)        SET_GLOBAL_REG(GATS1PW, (b), (v))
+#define SET_GATS12UR(b, v)       SET_GLOBAL_REG(GATS12UR, (b), (v))
+#define SET_GATS12UW(b, v)       SET_GLOBAL_REG(GATS12UW, (b), (v))
+#define SET_GATS12PR(b, v)       SET_GLOBAL_REG(GATS12PR, (b), (v))
+#define SET_GATS12PW(b, v)       SET_GLOBAL_REG(GATS12PW, (b), (v))
+#define SET_GPAR(b, v)           SET_GLOBAL_REG(GPAR, (b), (v))
+#define SET_GATSR(b, v)          SET_GLOBAL_REG(GATSR, (b), (v))
+#define SET_NSCR0(b, v)          SET_GLOBAL_REG(NSCR0, (b), (v))
+#define SET_NSCR2(b, v)          SET_GLOBAL_REG(NSCR2, (b), (v))
+#define SET_NSACR(b, v)          SET_GLOBAL_REG(NSACR, (b), (v))
+#define SET_NSGFAR(b, v)         SET_GLOBAL_REG(NSGFAR, (b), (v))
+#define SET_NSGFSRRESTORE(b, v)  SET_GLOBAL_REG(NSGFSRRESTORE, (b), (v))
+#define SET_PMCR(b, v)           SET_GLOBAL_REG(PMCR, (b), (v))
+#define SET_SMR_N(b, N, v)       SET_GLOBAL_REG_N(SMR, N, (b), (v))
+#define SET_S2CR_N(b, N, v)      SET_GLOBAL_REG_N(S2CR, N, (b), (v))
+
+#define GET_CR0(b)               GET_GLOBAL_REG(CR0, (b))
+#define GET_SCR1(b)              GET_GLOBAL_REG(SCR1, (b))
+#define GET_CR2(b)               GET_GLOBAL_REG(CR2, (b))
+#define GET_ACR(b)               GET_GLOBAL_REG(ACR, (b))
+#define GET_IDR0(b, N)           GET_GLOBAL_REG(IDR0, (b))
+#define GET_IDR1(b, N)           GET_GLOBAL_REG(IDR1, (b))
+#define GET_IDR2(b, N)           GET_GLOBAL_REG(IDR2, (b))
+#define GET_IDR7(b, N)           GET_GLOBAL_REG(IDR7, (b))
+#define GET_GFAR(b)              GET_GLOBAL_REG_Q(GFAR, (b))
+#define GET_GFSR(b)              GET_GLOBAL_REG(GFSR, (b))
+#define GET_GFSRRESTORE(b)       GET_GLOBAL_REG(GFSRRESTORE, (b))
+#define GET_GFSYNR0(b)           GET_GLOBAL_REG(GFSYNR0, (b))
+#define GET_GFSYNR1(b)           GET_GLOBAL_REG(GFSYNR1, (b))
+#define GET_GFSYNR2(b)           GET_GLOBAL_REG(GFSYNR2, (b))
+#define GET_TLBIVMID(b)          GET_GLOBAL_REG(TLBIVMID, (b))
+#define GET_TLBIALLNSNH(b)       GET_GLOBAL_REG(TLBIALLNSNH, (b))
+#define GET_TLBIALLH(b)          GET_GLOBAL_REG(TLBIALLH, (b))
+#define GET_TLBGSYNC(b)          GET_GLOBAL_REG(TLBGSYNC, (b))
+#define GET_TLBGSTATUS(b)        GET_GLOBAL_REG(TLBSTATUS, (b))
+#define GET_TLBIVAH(b)           GET_GLOBAL_REG(TLBIVAH, (b))
+#define GET_GATS1UR(b)           GET_GLOBAL_REG(GATS1UR, (b))
+#define GET_GATS1UW(b)           GET_GLOBAL_REG(GATS1UW, (b))
+#define GET_GATS1PR(b)           GET_GLOBAL_REG(GATS1PR, (b))
+#define GET_GATS1PW(b)           GET_GLOBAL_REG(GATS1PW, (b))
+#define GET_GATS12UR(b)          GET_GLOBAL_REG(GATS12UR, (b))
+#define GET_GATS12UW(b)          GET_GLOBAL_REG(GATS12UW, (b))
+#define GET_GATS12PR(b)          GET_GLOBAL_REG(GATS12PR, (b))
+#define GET_GATS12PW(b)          GET_GLOBAL_REG(GATS12PW, (b))
+#define GET_GPAR(b)              GET_GLOBAL_REG(GPAR, (b))
+#define GET_GATSR(b)             GET_GLOBAL_REG(GATSR, (b))
+#define GET_NSCR0(b)             GET_GLOBAL_REG(NSCR0, (b))
+#define GET_NSCR2(b)             GET_GLOBAL_REG(NSCR2, (b))
+#define GET_NSACR(b)             GET_GLOBAL_REG(NSACR, (b))
+#define GET_PMCR(b)              GET_GLOBAL_REG(PMCR, (b))
+#define GET_SMR_N(b, N)          GET_GLOBAL_REG_N(SMR, N, (b))
+#define GET_S2CR_N(b, N)         GET_GLOBAL_REG_N(S2CR, N, (b))
+
+/* Global register space 1 setters / getters */
+#define SET_CBAR_N(b, N, v)      SET_GLOBAL_REG_N(CBAR, N, (b), (v))
+#define SET_CBFRSYNRA_N(b, N, v) SET_GLOBAL_REG_N(CBFRSYNRA, N, (b), (v))
+
+#define GET_CBAR_N(b, N)         GET_GLOBAL_REG_N(CBAR, N, (b))
+#define GET_CBFRSYNRA_N(b, N)    GET_GLOBAL_REG_N(CBFRSYNRA, N, (b))
+
+/* Implementation defined register setters/getters */
+#define SET_MICRO_MMU_CTRL_HALT_REQ(b, v) \
+				SET_GLOBAL_FIELD(b, MICRO_MMU_CTRL, HALT_REQ, v)
+#define GET_MICRO_MMU_CTRL_IDLE(b) \
+				GET_GLOBAL_FIELD(b, MICRO_MMU_CTRL, IDLE)
+#define SET_MICRO_MMU_CTRL_RESERVED(b, v) \
+				SET_GLOBAL_FIELD(b, MICRO_MMU_CTRL, RESERVED, v)
+
+#define MMU_CTRL_IDLE (MICRO_MMU_CTRL_IDLE_MASK << MICRO_MMU_CTRL_IDLE_SHIFT)
+
+#define SET_PREDICTIONDIS0(b, v) SET_GLOBAL_REG(PREDICTIONDIS0, (b), (v))
+#define SET_PREDICTIONDIS1(b, v) SET_GLOBAL_REG(PREDICTIONDIS1, (b), (v))
+#define SET_S1L1BFBLP0(b, v)     SET_GLOBAL_REG(S1L1BFBLP0, (b), (v))
+
+/* SSD register setters/getters */
+#define SET_SSDR_N(b, N, v)      SET_GLOBAL_REG_N(SSDR_N, N, (b), (v))
+
+#define GET_SSDR_N(b, N)         GET_GLOBAL_REG_N(SSDR_N, N, (b))
+
+/* Context bank register setters/getters */
+#define SET_SCTLR(b, c, v)       SET_CTX_REG(CB_SCTLR, (b), (c), (v))
+#define SET_ACTLR(b, c, v)       SET_CTX_REG(CB_ACTLR, (b), (c), (v))
+#define SET_RESUME(b, c, v)      SET_CTX_REG(CB_RESUME, (b), (c), (v))
+#define SET_TTBCR(b, c, v)       SET_CTX_REG(CB_TTBCR, (b), (c), (v))
+#define SET_CONTEXTIDR(b, c, v)  SET_CTX_REG(CB_CONTEXTIDR, (b), (c), (v))
+#define SET_PRRR(b, c, v)        SET_CTX_REG(CB_PRRR, (b), (c), (v))
+#define SET_NMRR(b, c, v)        SET_CTX_REG(CB_NMRR, (b), (c), (v))
+#define SET_PAR(b, c, v)         SET_CTX_REG(CB_PAR, (b), (c), (v))
+#define SET_FSR(b, c, v)         SET_CTX_REG(CB_FSR, (b), (c), (v))
+#define SET_FSRRESTORE(b, c, v)  SET_CTX_REG(CB_FSRRESTORE, (b), (c), (v))
+#define SET_FAR(b, c, v)         SET_CTX_REG(CB_FAR, (b), (c), (v))
+#define SET_FSYNR0(b, c, v)      SET_CTX_REG(CB_FSYNR0, (b), (c), (v))
+#define SET_FSYNR1(b, c, v)      SET_CTX_REG(CB_FSYNR1, (b), (c), (v))
+#define SET_TLBIVA(b, c, v)      SET_CTX_REG(CB_TLBIVA, (b), (c), (v))
+#define SET_TLBIVAA(b, c, v)     SET_CTX_REG(CB_TLBIVAA, (b), (c), (v))
+#define SET_TLBIASID(b, c, v)    SET_CTX_REG(CB_TLBIASID, (b), (c), (v))
+#define SET_TLBIALL(b, c, v)     SET_CTX_REG(CB_TLBIALL, (b), (c), (v))
+#define SET_TLBIVAL(b, c, v)     SET_CTX_REG(CB_TLBIVAL, (b), (c), (v))
+#define SET_TLBIVAAL(b, c, v)    SET_CTX_REG(CB_TLBIVAAL, (b), (c), (v))
+#define SET_TLBSYNC(b, c, v)     SET_CTX_REG(CB_TLBSYNC, (b), (c), (v))
+#define SET_TLBSTATUS(b, c, v)   SET_CTX_REG(CB_TLBSTATUS, (b), (c), (v))
+#define SET_ATS1PR(b, c, v)      SET_CTX_REG(CB_ATS1PR, (b), (c), (v))
+#define SET_ATS1PW(b, c, v)      SET_CTX_REG(CB_ATS1PW, (b), (c), (v))
+#define SET_ATS1UR(b, c, v)      SET_CTX_REG(CB_ATS1UR, (b), (c), (v))
+#define SET_ATS1UW(b, c, v)      SET_CTX_REG(CB_ATS1UW, (b), (c), (v))
+#define SET_ATSR(b, c, v)        SET_CTX_REG(CB_ATSR, (b), (c), (v))
+
+#define GET_SCTLR(b, c)          GET_CTX_REG(CB_SCTLR, (b), (c))
+#define GET_ACTLR(b, c)          GET_CTX_REG(CB_ACTLR, (b), (c))
+#define GET_RESUME(b, c)         GET_CTX_REG(CB_RESUME, (b), (c))
+#define GET_TTBR0(b, c)          GET_CTX_REG(CB_TTBR0, (b), (c))
+#define GET_TTBR1(b, c)          GET_CTX_REG(CB_TTBR1, (b), (c))
+#define GET_TTBCR(b, c)          GET_CTX_REG(CB_TTBCR, (b), (c))
+#define GET_CONTEXTIDR(b, c)     GET_CTX_REG(CB_CONTEXTIDR, (b), (c))
+#define GET_PRRR(b, c)           GET_CTX_REG(CB_PRRR, (b), (c))
+#define GET_NMRR(b, c)           GET_CTX_REG(CB_NMRR, (b), (c))
+#define GET_PAR(b, c)            GET_CTX_REG_Q(CB_PAR, (b), (c))
+#define GET_FSR(b, c)            GET_CTX_REG(CB_FSR, (b), (c))
+#define GET_FSRRESTORE(b, c)     GET_CTX_REG(CB_FSRRESTORE, (b), (c))
+#define GET_FAR(b, c)            GET_CTX_REG_Q(CB_FAR, (b), (c))
+#define GET_FSYNR0(b, c)         GET_CTX_REG(CB_FSYNR0, (b), (c))
+#define GET_FSYNR1(b, c)         GET_CTX_REG(CB_FSYNR1, (b), (c))
+#define GET_TLBIVA(b, c)         GET_CTX_REG(CB_TLBIVA, (b), (c))
+#define GET_TLBIVAA(b, c)        GET_CTX_REG(CB_TLBIVAA, (b), (c))
+#define GET_TLBIASID(b, c)       GET_CTX_REG(CB_TLBIASID, (b), (c))
+#define GET_TLBIALL(b, c)        GET_CTX_REG(CB_TLBIALL, (b), (c))
+#define GET_TLBIVAL(b, c)        GET_CTX_REG(CB_TLBIVAL, (b), (c))
+#define GET_TLBIVAAL(b, c)       GET_CTX_REG(CB_TLBIVAAL, (b), (c))
+#define GET_TLBSYNC(b, c)        GET_CTX_REG(CB_TLBSYNC, (b), (c))
+#define GET_TLBSTATUS(b, c)      GET_CTX_REG(CB_TLBSTATUS, (b), (c))
+#define GET_ATS1PR(b, c)         GET_CTX_REG(CB_ATS1PR, (b), (c))
+#define GET_ATS1PW(b, c)         GET_CTX_REG(CB_ATS1PW, (b), (c))
+#define GET_ATS1UR(b, c)         GET_CTX_REG(CB_ATS1UR, (b), (c))
+#define GET_ATS1UW(b, c)         GET_CTX_REG(CB_ATS1UW, (b), (c))
+#define GET_ATSR(b, c)           GET_CTX_REG(CB_ATSR, (b), (c))
+
+/* Global Register field setters / getters */
+/* Configuration Register: CR0/NSCR0 */
+#define SET_CR0_NSCFG(b, v)        SET_GLOBAL_FIELD(b, CR0, NSCFG, v)
+#define SET_CR0_WACFG(b, v)        SET_GLOBAL_FIELD(b, CR0, WACFG, v)
+#define SET_CR0_RACFG(b, v)        SET_GLOBAL_FIELD(b, CR0, RACFG, v)
+#define SET_CR0_SHCFG(b, v)        SET_GLOBAL_FIELD(b, CR0, SHCFG, v)
+#define SET_CR0_SMCFCFG(b, v)      SET_GLOBAL_FIELD(b, CR0, SMCFCFG, v)
+#define SET_NSCR0_SMCFCFG(b, v)    SET_GLOBAL_FIELD(b, NSCR0, SMCFCFG, v)
+#define SET_CR0_MTCFG(b, v)        SET_GLOBAL_FIELD(b, CR0, MTCFG, v)
+#define SET_CR0_BSU(b, v)          SET_GLOBAL_FIELD(b, CR0, BSU, v)
+#define SET_CR0_FB(b, v)           SET_GLOBAL_FIELD(b, CR0, FB, v)
+#define SET_CR0_PTM(b, v)          SET_GLOBAL_FIELD(b, CR0, PTM, v)
+#define SET_CR0_VMIDPNE(b, v)      SET_GLOBAL_FIELD(b, CR0, VMIDPNE, v)
+#define SET_CR0_USFCFG(b, v)       SET_GLOBAL_FIELD(b, CR0, USFCFG, v)
+#define SET_NSCR0_USFCFG(b, v)     SET_GLOBAL_FIELD(b, NSCR0, USFCFG, v)
+#define SET_CR0_GSE(b, v)          SET_GLOBAL_FIELD(b, CR0, GSE, v)
+#define SET_CR0_STALLD(b, v)       SET_GLOBAL_FIELD(b, CR0, STALLD, v)
+#define SET_NSCR0_STALLD(b, v)     SET_GLOBAL_FIELD(b, NSCR0, STALLD, v)
+#define SET_CR0_TRANSIENTCFG(b, v) SET_GLOBAL_FIELD(b, CR0, TRANSIENTCFG, v)
+#define SET_CR0_GCFGFIE(b, v)      SET_GLOBAL_FIELD(b, CR0, GCFGFIE, v)
+#define SET_NSCR0_GCFGFIE(b, v)    SET_GLOBAL_FIELD(b, NSCR0, GCFGFIE, v)
+#define SET_CR0_GCFGFRE(b, v)      SET_GLOBAL_FIELD(b, CR0, GCFGFRE, v)
+#define SET_NSCR0_GCFGFRE(b, v)    SET_GLOBAL_FIELD(b, NSCR0, GCFGFRE, v)
+#define SET_CR0_GFIE(b, v)         SET_GLOBAL_FIELD(b, CR0, GFIE, v)
+#define SET_NSCR0_GFIE(b, v)       SET_GLOBAL_FIELD(b, NSCR0, GFIE, v)
+#define SET_CR0_GFRE(b, v)         SET_GLOBAL_FIELD(b, CR0, GFRE, v)
+#define SET_NSCR0_GFRE(b, v)       SET_GLOBAL_FIELD(b, NSCR0, GFRE, v)
+#define SET_CR0_CLIENTPD(b, v)     SET_GLOBAL_FIELD(b, CR0, CLIENTPD, v)
+#define SET_NSCR0_CLIENTPD(b, v)   SET_GLOBAL_FIELD(b, NSCR0, CLIENTPD, v)
+
+#define SET_ACR_SMTNMC_BPTLBEN(b, v)\
+	SET_GLOBAL_FIELD(b, ACR, SMTNMC_BPTLBEN, v)
+#define SET_ACR_MMUDIS_BPTLBEN(b, v)\
+	SET_GLOBAL_FIELD(b, ACR, MMUDIS_BPTLBEN, v)
+#define SET_ACR_S2CR_BPTLBEN(b, v)\
+	SET_GLOBAL_FIELD(b, ACR, S2CR_BPTLBEN, v)
+
+#define SET_NSACR_SMTNMC_BPTLBEN(b, v)\
+	SET_GLOBAL_FIELD(b, NSACR, SMTNMC_BPTLBEN, v)
+#define SET_NSACR_MMUDIS_BPTLBEN(b, v)\
+	SET_GLOBAL_FIELD(b, NSACR, MMUDIS_BPTLBEN, v)
+#define SET_NSACR_S2CR_BPTLBEN(b, v)\
+	SET_GLOBAL_FIELD(b, NSACR, S2CR_BPTLBEN, v)
+
+#define GET_CR0_NSCFG(b)           GET_GLOBAL_FIELD(b, CR0, NSCFG)
+#define GET_CR0_WACFG(b)           GET_GLOBAL_FIELD(b, CR0, WACFG)
+#define GET_CR0_RACFG(b)           GET_GLOBAL_FIELD(b, CR0, RACFG)
+#define GET_CR0_SHCFG(b)           GET_GLOBAL_FIELD(b, CR0, SHCFG)
+#define GET_CR0_SMCFCFG(b)         GET_GLOBAL_FIELD(b, CR0, SMCFCFG)
+#define GET_CR0_MTCFG(b)           GET_GLOBAL_FIELD(b, CR0, MTCFG)
+#define GET_CR0_BSU(b)             GET_GLOBAL_FIELD(b, CR0, BSU)
+#define GET_CR0_FB(b)              GET_GLOBAL_FIELD(b, CR0, FB)
+#define GET_CR0_PTM(b)             GET_GLOBAL_FIELD(b, CR0, PTM)
+#define GET_CR0_VMIDPNE(b)         GET_GLOBAL_FIELD(b, CR0, VMIDPNE)
+#define GET_CR0_USFCFG(b)          GET_GLOBAL_FIELD(b, CR0, USFCFG)
+#define GET_CR0_GSE(b)             GET_GLOBAL_FIELD(b, CR0, GSE)
+#define GET_CR0_STALLD(b)          GET_GLOBAL_FIELD(b, CR0, STALLD)
+#define GET_CR0_TRANSIENTCFG(b)    GET_GLOBAL_FIELD(b, CR0, TRANSIENTCFG)
+#define GET_CR0_GCFGFIE(b)         GET_GLOBAL_FIELD(b, CR0, GCFGFIE)
+#define GET_CR0_GCFGFRE(b)         GET_GLOBAL_FIELD(b, CR0, GCFGFRE)
+#define GET_CR0_GFIE(b)            GET_GLOBAL_FIELD(b, CR0, GFIE)
+#define GET_CR0_GFRE(b)            GET_GLOBAL_FIELD(b, CR0, GFRE)
+#define GET_CR0_CLIENTPD(b)        GET_GLOBAL_FIELD(b, CR0, CLIENTPD)
+
+/* Configuration Register: CR2 */
+#define SET_CR2_BPVMID(b, v)     SET_GLOBAL_FIELD(b, CR2, BPVMID, v)
+
+#define GET_CR2_BPVMID(b)        GET_GLOBAL_FIELD(b, CR2, BPVMID)
+
+/* Global Address Translation, Stage 1, Privileged Read: GATS1PR */
+#define SET_GATS1PR_ADDR(b, v)   SET_GLOBAL_FIELD(b, GATS1PR, ADDR, v)
+#define SET_GATS1PR_NDX(b, v)    SET_GLOBAL_FIELD(b, GATS1PR, NDX, v)
+
+#define GET_GATS1PR_ADDR(b)      GET_GLOBAL_FIELD(b, GATS1PR, ADDR)
+#define GET_GATS1PR_NDX(b)       GET_GLOBAL_FIELD(b, GATS1PR, NDX)
+
+/* Global Address Translation, Stage 1, Privileged Write: GATS1PW */
+#define SET_GATS1PW_ADDR(b, v)   SET_GLOBAL_FIELD(b, GATS1PW, ADDR, v)
+#define SET_GATS1PW_NDX(b, v)    SET_GLOBAL_FIELD(b, GATS1PW, NDX, v)
+
+#define GET_GATS1PW_ADDR(b)      GET_GLOBAL_FIELD(b, GATS1PW, ADDR)
+#define GET_GATS1PW_NDX(b)       GET_GLOBAL_FIELD(b, GATS1PW, NDX)
+
+/* Global Address Translation, Stage 1, User Read: GATS1UR */
+#define SET_GATS1UR_ADDR(b, v)   SET_GLOBAL_FIELD(b, GATS1UR, ADDR, v)
+#define SET_GATS1UR_NDX(b, v)    SET_GLOBAL_FIELD(b, GATS1UR, NDX, v)
+
+#define GET_GATS1UR_ADDR(b)      GET_GLOBAL_FIELD(b, GATS1UR, ADDR)
+#define GET_GATS1UR_NDX(b)       GET_GLOBAL_FIELD(b, GATS1UR, NDX)
+
+/* Global Address Translation, Stage 1, User Read: GATS1UW */
+#define SET_GATS1UW_ADDR(b, v)   SET_GLOBAL_FIELD(b, GATS1UW, ADDR, v)
+#define SET_GATS1UW_NDX(b, v)    SET_GLOBAL_FIELD(b, GATS1UW, NDX, v)
+
+#define GET_GATS1UW_ADDR(b)      GET_GLOBAL_FIELD(b, GATS1UW, ADDR)
+#define GET_GATS1UW_NDX(b)       GET_GLOBAL_FIELD(b, GATS1UW, NDX)
+
+/* Global Address Translation, Stage 1 and 2, Privileged Read: GATS12PR */
+#define SET_GATS12PR_ADDR(b, v)  SET_GLOBAL_FIELD(b, GATS12PR, ADDR, v)
+#define SET_GATS12PR_NDX(b, v)   SET_GLOBAL_FIELD(b, GATS12PR, NDX, v)
+
+#define GET_GATS12PR_ADDR(b)     GET_GLOBAL_FIELD(b, GATS12PR, ADDR)
+#define GET_GATS12PR_NDX(b)      GET_GLOBAL_FIELD(b, GATS12PR, NDX)
+
+/* Global Address Translation, Stage 1, Privileged Write: GATS1PW */
+#define SET_GATS12PW_ADDR(b, v)  SET_GLOBAL_FIELD(b, GATS12PW, ADDR, v)
+#define SET_GATS12PW_NDX(b, v)   SET_GLOBAL_FIELD(b, GATS12PW, NDX, v)
+
+#define GET_GATS12PW_ADDR(b)     GET_GLOBAL_FIELD(b, GATS12PW, ADDR)
+#define GET_GATS12PW_NDX(b)      GET_GLOBAL_FIELD(b, GATS12PW, NDX)
+
+/* Global Address Translation, Stage 1, User Read: GATS1UR */
+#define SET_GATS12UR_ADDR(b, v)  SET_GLOBAL_FIELD(b, GATS12UR, ADDR, v)
+#define SET_GATS12UR_NDX(b, v)   SET_GLOBAL_FIELD(b, GATS12UR, NDX, v)
+
+#define GET_GATS12UR_ADDR(b)     GET_GLOBAL_FIELD(b, GATS12UR, ADDR)
+#define GET_GATS12UR_NDX(b)      GET_GLOBAL_FIELD(b, GATS12UR, NDX)
+
+/* Global Address Translation, Stage 1, User Read: GATS1UW */
+#define SET_GATS12UW_ADDR(b, v)  SET_GLOBAL_FIELD(b, GATS12UW, ADDR, v)
+#define SET_GATS12UW_NDX(b, v)   SET_GLOBAL_FIELD(b, GATS12UW, NDX, v)
+
+#define GET_GATS12UW_ADDR(b)     GET_GLOBAL_FIELD(b, GATS12UW, ADDR)
+#define GET_GATS12UW_NDX(b)      GET_GLOBAL_FIELD(b, GATS12UW, NDX)
+
+/* Global Address Translation Status Register: GATSR */
+#define SET_GATSR_ACTIVE(b, v)   SET_GLOBAL_FIELD(b, GATSR, ACTIVE, v)
+
+#define GET_GATSR_ACTIVE(b)      GET_GLOBAL_FIELD(b, GATSR, ACTIVE)
+
+/* Global Fault Address Register: GFAR */
+#define SET_GFAR_FADDR(b, v)     SET_GLOBAL_FIELD(b, GFAR, FADDR, v)
+
+#define GET_GFAR_FADDR(b)        GET_GLOBAL_FIELD(b, GFAR, FADDR)
+
+/* Global Fault Status Register: GFSR */
+#define SET_GFSR_ICF(b, v)        SET_GLOBAL_FIELD(b, GFSR, ICF, v)
+#define SET_GFSR_USF(b, v)        SET_GLOBAL_FIELD(b, GFSR, USF, v)
+#define SET_GFSR_SMCF(b, v)       SET_GLOBAL_FIELD(b, GFSR, SMCF, v)
+#define SET_GFSR_UCBF(b, v)       SET_GLOBAL_FIELD(b, GFSR, UCBF, v)
+#define SET_GFSR_UCIF(b, v)       SET_GLOBAL_FIELD(b, GFSR, UCIF, v)
+#define SET_GFSR_CAF(b, v)        SET_GLOBAL_FIELD(b, GFSR, CAF, v)
+#define SET_GFSR_EF(b, v)         SET_GLOBAL_FIELD(b, GFSR, EF, v)
+#define SET_GFSR_PF(b, v)         SET_GLOBAL_FIELD(b, GFSR, PF, v)
+#define SET_GFSR_MULTI(b, v)      SET_GLOBAL_FIELD(b, GFSR, MULTI, v)
+
+#define GET_GFSR_ICF(b)           GET_GLOBAL_FIELD(b, GFSR, ICF)
+#define GET_GFSR_USF(b)           GET_GLOBAL_FIELD(b, GFSR, USF)
+#define GET_GFSR_SMCF(b)          GET_GLOBAL_FIELD(b, GFSR, SMCF)
+#define GET_GFSR_UCBF(b)          GET_GLOBAL_FIELD(b, GFSR, UCBF)
+#define GET_GFSR_UCIF(b)          GET_GLOBAL_FIELD(b, GFSR, UCIF)
+#define GET_GFSR_CAF(b)           GET_GLOBAL_FIELD(b, GFSR, CAF)
+#define GET_GFSR_EF(b)            GET_GLOBAL_FIELD(b, GFSR, EF)
+#define GET_GFSR_PF(b)            GET_GLOBAL_FIELD(b, GFSR, PF)
+#define GET_GFSR_MULTI(b)         GET_GLOBAL_FIELD(b, GFSR, MULTI)
+
+/* Global Fault Syndrome Register 0: GFSYNR0 */
+#define SET_GFSYNR0_NESTED(b, v)  SET_GLOBAL_FIELD(b, GFSYNR0, NESTED, v)
+#define SET_GFSYNR0_WNR(b, v)     SET_GLOBAL_FIELD(b, GFSYNR0, WNR, v)
+#define SET_GFSYNR0_PNU(b, v)     SET_GLOBAL_FIELD(b, GFSYNR0, PNU, v)
+#define SET_GFSYNR0_IND(b, v)     SET_GLOBAL_FIELD(b, GFSYNR0, IND, v)
+#define SET_GFSYNR0_NSSTATE(b, v) SET_GLOBAL_FIELD(b, GFSYNR0, NSSTATE, v)
+#define SET_GFSYNR0_NSATTR(b, v)  SET_GLOBAL_FIELD(b, GFSYNR0, NSATTR, v)
+
+#define GET_GFSYNR0_NESTED(b)     GET_GLOBAL_FIELD(b, GFSYNR0, NESTED)
+#define GET_GFSYNR0_WNR(b)        GET_GLOBAL_FIELD(b, GFSYNR0, WNR)
+#define GET_GFSYNR0_PNU(b)        GET_GLOBAL_FIELD(b, GFSYNR0, PNU)
+#define GET_GFSYNR0_IND(b)        GET_GLOBAL_FIELD(b, GFSYNR0, IND)
+#define GET_GFSYNR0_NSSTATE(b)    GET_GLOBAL_FIELD(b, GFSYNR0, NSSTATE)
+#define GET_GFSYNR0_NSATTR(b)     GET_GLOBAL_FIELD(b, GFSYNR0, NSATTR)
+
+/* Global Fault Syndrome Register 1: GFSYNR1 */
+#define SET_GFSYNR1_SID(b, v)     SET_GLOBAL_FIELD(b, GFSYNR1, SID, v)
+
+#define GET_GFSYNR1_SID(b)        GET_GLOBAL_FIELD(b, GFSYNR1, SID)
+
+/* Global Physical Address Register: GPAR */
+#define SET_GPAR_F(b, v)          SET_GLOBAL_FIELD(b, GPAR, F, v)
+#define SET_GPAR_SS(b, v)         SET_GLOBAL_FIELD(b, GPAR, SS, v)
+#define SET_GPAR_OUTER(b, v)      SET_GLOBAL_FIELD(b, GPAR, OUTER, v)
+#define SET_GPAR_INNER(b, v)      SET_GLOBAL_FIELD(b, GPAR, INNER, v)
+#define SET_GPAR_SH(b, v)         SET_GLOBAL_FIELD(b, GPAR, SH, v)
+#define SET_GPAR_NS(b, v)         SET_GLOBAL_FIELD(b, GPAR, NS, v)
+#define SET_GPAR_NOS(b, v)        SET_GLOBAL_FIELD(b, GPAR, NOS, v)
+#define SET_GPAR_PA(b, v)         SET_GLOBAL_FIELD(b, GPAR, PA, v)
+#define SET_GPAR_TF(b, v)         SET_GLOBAL_FIELD(b, GPAR, TF, v)
+#define SET_GPAR_AFF(b, v)        SET_GLOBAL_FIELD(b, GPAR, AFF, v)
+#define SET_GPAR_PF(b, v)         SET_GLOBAL_FIELD(b, GPAR, PF, v)
+#define SET_GPAR_EF(b, v)         SET_GLOBAL_FIELD(b, GPAR, EF, v)
+#define SET_GPAR_TLCMCF(b, v)     SET_GLOBAL_FIELD(b, GPAR, TLCMCF, v)
+#define SET_GPAR_TLBLKF(b, v)     SET_GLOBAL_FIELD(b, GPAR, TLBLKF, v)
+#define SET_GPAR_UCBF(b, v)       SET_GLOBAL_FIELD(b, GPAR, UCBF, v)
+
+#define GET_GPAR_F(b)             GET_GLOBAL_FIELD(b, GPAR, F)
+#define GET_GPAR_SS(b)            GET_GLOBAL_FIELD(b, GPAR, SS)
+#define GET_GPAR_OUTER(b)         GET_GLOBAL_FIELD(b, GPAR, OUTER)
+#define GET_GPAR_INNER(b)         GET_GLOBAL_FIELD(b, GPAR, INNER)
+#define GET_GPAR_SH(b)            GET_GLOBAL_FIELD(b, GPAR, SH)
+#define GET_GPAR_NS(b)            GET_GLOBAL_FIELD(b, GPAR, NS)
+#define GET_GPAR_NOS(b)           GET_GLOBAL_FIELD(b, GPAR, NOS)
+#define GET_GPAR_PA(b)            GET_GLOBAL_FIELD(b, GPAR, PA)
+#define GET_GPAR_TF(b)            GET_GLOBAL_FIELD(b, GPAR, TF)
+#define GET_GPAR_AFF(b)           GET_GLOBAL_FIELD(b, GPAR, AFF)
+#define GET_GPAR_PF(b)            GET_GLOBAL_FIELD(b, GPAR, PF)
+#define GET_GPAR_EF(b)            GET_GLOBAL_FIELD(b, GPAR, EF)
+#define GET_GPAR_TLCMCF(b)        GET_GLOBAL_FIELD(b, GPAR, TLCMCF)
+#define GET_GPAR_TLBLKF(b)        GET_GLOBAL_FIELD(b, GPAR, TLBLKF)
+#define GET_GPAR_UCBF(b)          GET_GLOBAL_FIELD(b, GPAR, UCBF)
+
+/* Identification Register: IDR0 */
+#define SET_IDR0_NUMSMRG(b, v)    SET_GLOBAL_FIELD(b, IDR0, NUMSMRG, v)
+#define SET_IDR0_NUMSIDB(b, v)    SET_GLOBAL_FIELD(b, IDR0, NUMSIDB, v)
+#define SET_IDR0_BTM(b, v)        SET_GLOBAL_FIELD(b, IDR0, BTM, v)
+#define SET_IDR0_CTTW(b, v)       SET_GLOBAL_FIELD(b, IDR0, CTTW, v)
+#define SET_IDR0_NUMIRPT(b, v)    SET_GLOBAL_FIELD(b, IDR0, NUMIRPT, v)
+#define SET_IDR0_PTFS(b, v)       SET_GLOBAL_FIELD(b, IDR0, PTFS, v)
+#define SET_IDR0_SMS(b, v)        SET_GLOBAL_FIELD(b, IDR0, SMS, v)
+#define SET_IDR0_NTS(b, v)        SET_GLOBAL_FIELD(b, IDR0, NTS, v)
+#define SET_IDR0_S2TS(b, v)       SET_GLOBAL_FIELD(b, IDR0, S2TS, v)
+#define SET_IDR0_S1TS(b, v)       SET_GLOBAL_FIELD(b, IDR0, S1TS, v)
+#define SET_IDR0_SES(b, v)        SET_GLOBAL_FIELD(b, IDR0, SES, v)
+
+#define GET_IDR0_NUMSMRG(b)       GET_GLOBAL_FIELD(b, IDR0, NUMSMRG)
+#define GET_IDR0_NUMSIDB(b)       GET_GLOBAL_FIELD(b, IDR0, NUMSIDB)
+#define GET_IDR0_BTM(b)           GET_GLOBAL_FIELD(b, IDR0, BTM)
+#define GET_IDR0_CTTW(b)          GET_GLOBAL_FIELD(b, IDR0, CTTW)
+#define GET_IDR0_NUMIRPT(b)       GET_GLOBAL_FIELD(b, IDR0, NUMIRPT)
+#define GET_IDR0_PTFS(b)          GET_GLOBAL_FIELD(b, IDR0, PTFS)
+#define GET_IDR0_SMS(b)           GET_GLOBAL_FIELD(b, IDR0, SMS)
+#define GET_IDR0_NTS(b)           GET_GLOBAL_FIELD(b, IDR0, NTS)
+#define GET_IDR0_S2TS(b)          GET_GLOBAL_FIELD(b, IDR0, S2TS)
+#define GET_IDR0_S1TS(b)          GET_GLOBAL_FIELD(b, IDR0, S1TS)
+#define GET_IDR0_SES(b)           GET_GLOBAL_FIELD(b, IDR0, SES)
+
+/* Identification Register: IDR1 */
+#define SET_IDR1_NUMCB(b, v)       SET_GLOBAL_FIELD(b, IDR1, NUMCB, v)
+#define SET_IDR1_NUMSSDNDXB(b, v)  SET_GLOBAL_FIELD(b, IDR1, NUMSSDNDXB, v)
+#define SET_IDR1_SSDTP(b, v)       SET_GLOBAL_FIELD(b, IDR1, SSDTP, v)
+#define SET_IDR1_SMCD(b, v)        SET_GLOBAL_FIELD(b, IDR1, SMCD, v)
+#define SET_IDR1_NUMS2CB(b, v)     SET_GLOBAL_FIELD(b, IDR1, NUMS2CB, v)
+#define SET_IDR1_NUMPAGENDXB(b, v) SET_GLOBAL_FIELD(b, IDR1, NUMPAGENDXB, v)
+#define SET_IDR1_PAGESIZE(b, v)    SET_GLOBAL_FIELD(b, IDR1, PAGESIZE, v)
+
+#define GET_IDR1_NUMCB(b)          GET_GLOBAL_FIELD(b, IDR1, NUMCB)
+#define GET_IDR1_NUMSSDNDXB(b)     GET_GLOBAL_FIELD(b, IDR1, NUMSSDNDXB)
+#define GET_IDR1_SSDTP(b)          GET_GLOBAL_FIELD(b, IDR1, SSDTP)
+#define GET_IDR1_SMCD(b)           GET_GLOBAL_FIELD(b, IDR1, SMCD)
+#define GET_IDR1_NUMS2CB(b)        GET_GLOBAL_FIELD(b, IDR1, NUMS2CB)
+#define GET_IDR1_NUMPAGENDXB(b)    GET_GLOBAL_FIELD(b, IDR1, NUMPAGENDXB)
+#define GET_IDR1_PAGESIZE(b)       GET_GLOBAL_FIELD(b, IDR1, PAGESIZE)
+
+/* Identification Register: IDR2 */
+#define SET_IDR2_IAS(b, v)       SET_GLOBAL_FIELD(b, IDR2, IAS, v)
+#define SET_IDR2_OAS(b, v)       SET_GLOBAL_FIELD(b, IDR2, OAS, v)
+
+#define GET_IDR2_IAS(b)          GET_GLOBAL_FIELD(b, IDR2, IAS)
+#define GET_IDR2_OAS(b)          GET_GLOBAL_FIELD(b, IDR2, OAS)
+
+/* Identification Register: IDR7 */
+#define SET_IDR7_MINOR(b, v)     SET_GLOBAL_FIELD(b, IDR7, MINOR, v)
+#define SET_IDR7_MAJOR(b, v)     SET_GLOBAL_FIELD(b, IDR7, MAJOR, v)
+
+#define GET_IDR7_MINOR(b)        GET_GLOBAL_FIELD(b, IDR7, MINOR)
+#define GET_IDR7_MAJOR(b)        GET_GLOBAL_FIELD(b, IDR7, MAJOR)
+
+/* Stream to Context Register: S2CR_N */
+#define SET_S2CR_CBNDX(b, n, v)   SET_GLOBAL_FIELD_N(b, n, S2CR, CBNDX, v)
+#define SET_S2CR_SHCFG(b, n, v)   SET_GLOBAL_FIELD_N(b, n, S2CR, SHCFG, v)
+#define SET_S2CR_MTCFG(b, n, v)   SET_GLOBAL_FIELD_N(b, n, S2CR, MTCFG, v)
+#define SET_S2CR_MEMATTR(b, n, v) SET_GLOBAL_FIELD_N(b, n, S2CR, MEMATTR, v)
+#define SET_S2CR_TYPE(b, n, v)    SET_GLOBAL_FIELD_N(b, n, S2CR, TYPE, v)
+#define SET_S2CR_NSCFG(b, n, v)   SET_GLOBAL_FIELD_N(b, n, S2CR, NSCFG, v)
+#define SET_S2CR_RACFG(b, n, v)   SET_GLOBAL_FIELD_N(b, n, S2CR, RACFG, v)
+#define SET_S2CR_WACFG(b, n, v)   SET_GLOBAL_FIELD_N(b, n, S2CR, WACFG, v)
+#define SET_S2CR_PRIVCFG(b, n, v) SET_GLOBAL_FIELD_N(b, n, S2CR, PRIVCFG, v)
+#define SET_S2CR_INSTCFG(b, n, v) SET_GLOBAL_FIELD_N(b, n, S2CR, INSTCFG, v)
+#define SET_S2CR_TRANSIENTCFG(b, n, v) \
+				SET_GLOBAL_FIELD_N(b, n, S2CR, TRANSIENTCFG, v)
+#define SET_S2CR_VMID(b, n, v)    SET_GLOBAL_FIELD_N(b, n, S2CR, VMID, v)
+#define SET_S2CR_BSU(b, n, v)     SET_GLOBAL_FIELD_N(b, n, S2CR, BSU, v)
+#define SET_S2CR_FB(b, n, v)      SET_GLOBAL_FIELD_N(b, n, S2CR, FB, v)
+
+#define GET_S2CR_CBNDX(b, n)      GET_GLOBAL_FIELD_N(b, n, S2CR, CBNDX)
+#define GET_S2CR_SHCFG(b, n)      GET_GLOBAL_FIELD_N(b, n, S2CR, SHCFG)
+#define GET_S2CR_MTCFG(b, n)      GET_GLOBAL_FIELD_N(b, n, S2CR, MTCFG)
+#define GET_S2CR_MEMATTR(b, n)    GET_GLOBAL_FIELD_N(b, n, S2CR, MEMATTR)
+#define GET_S2CR_TYPE(b, n)       GET_GLOBAL_FIELD_N(b, n, S2CR, TYPE)
+#define GET_S2CR_NSCFG(b, n)      GET_GLOBAL_FIELD_N(b, n, S2CR, NSCFG)
+#define GET_S2CR_RACFG(b, n)      GET_GLOBAL_FIELD_N(b, n, S2CR, RACFG)
+#define GET_S2CR_WACFG(b, n)      GET_GLOBAL_FIELD_N(b, n, S2CR, WACFG)
+#define GET_S2CR_PRIVCFG(b, n)    GET_GLOBAL_FIELD_N(b, n, S2CR, PRIVCFG)
+#define GET_S2CR_INSTCFG(b, n)    GET_GLOBAL_FIELD_N(b, n, S2CR, INSTCFG)
+#define GET_S2CR_TRANSIENTCFG(b, n) \
+				GET_GLOBAL_FIELD_N(b, n, S2CR, TRANSIENTCFG)
+#define GET_S2CR_VMID(b, n)       GET_GLOBAL_FIELD_N(b, n, S2CR, VMID)
+#define GET_S2CR_BSU(b, n)        GET_GLOBAL_FIELD_N(b, n, S2CR, BSU)
+#define GET_S2CR_FB(b, n)         GET_GLOBAL_FIELD_N(b, n, S2CR, FB)
+
+/* Stream Match Register: SMR_N */
+#define SET_SMR_ID(b, n, v)       SET_GLOBAL_FIELD_N(b, n, SMR, ID, v)
+#define SET_SMR_MASK(b, n, v)     SET_GLOBAL_FIELD_N(b, n, SMR, MASK, v)
+#define SET_SMR_VALID(b, n, v)    SET_GLOBAL_FIELD_N(b, n, SMR, VALID, v)
+
+#define GET_SMR_ID(b, n)          GET_GLOBAL_FIELD_N(b, n, SMR, ID)
+#define GET_SMR_MASK(b, n)        GET_GLOBAL_FIELD_N(b, n, SMR, MASK)
+#define GET_SMR_VALID(b, n)       GET_GLOBAL_FIELD_N(b, n, SMR, VALID)
+
+/* Global TLB Status: TLBGSTATUS */
+#define SET_TLBGSTATUS_GSACTIVE(b, v) \
+				SET_GLOBAL_FIELD(b, TLBGSTATUS, GSACTIVE, v)
+
+#define GET_TLBGSTATUS_GSACTIVE(b)    \
+				GET_GLOBAL_FIELD(b, TLBGSTATUS, GSACTIVE)
+
+/* Invalidate Hyp TLB by VA: TLBIVAH */
+#define SET_TLBIVAH_ADDR(b, v)  SET_GLOBAL_FIELD(b, TLBIVAH, ADDR, v)
+
+#define GET_TLBIVAH_ADDR(b)     GET_GLOBAL_FIELD(b, TLBIVAH, ADDR)
+
+/* Invalidate TLB by VMID: TLBIVMID */
+#define SET_TLBIVMID_VMID(b, v) SET_GLOBAL_FIELD(b, TLBIVMID, VMID, v)
+
+#define GET_TLBIVMID_VMID(b)    GET_GLOBAL_FIELD(b, TLBIVMID, VMID)
+
+/* Global Register Space 1 Field setters/getters*/
+/* Context Bank Attribute Register: CBAR_N */
+#define SET_CBAR_VMID(b, n, v)     SET_GLOBAL_FIELD_N(b, n, CBAR, VMID, v)
+#define SET_CBAR_CBNDX(b, n, v)    SET_GLOBAL_FIELD_N(b, n, CBAR, CBNDX, v)
+#define SET_CBAR_BPSHCFG(b, n, v)  SET_GLOBAL_FIELD_N(b, n, CBAR, BPSHCFG, v)
+#define SET_CBAR_HYPC(b, n, v)     SET_GLOBAL_FIELD_N(b, n, CBAR, HYPC, v)
+#define SET_CBAR_FB(b, n, v)       SET_GLOBAL_FIELD_N(b, n, CBAR, FB, v)
+#define SET_CBAR_MEMATTR(b, n, v)  SET_GLOBAL_FIELD_N(b, n, CBAR, MEMATTR, v)
+#define SET_CBAR_TYPE(b, n, v)     SET_GLOBAL_FIELD_N(b, n, CBAR, TYPE, v)
+#define SET_CBAR_BSU(b, n, v)      SET_GLOBAL_FIELD_N(b, n, CBAR, BSU, v)
+#define SET_CBAR_RACFG(b, n, v)    SET_GLOBAL_FIELD_N(b, n, CBAR, RACFG, v)
+#define SET_CBAR_WACFG(b, n, v)    SET_GLOBAL_FIELD_N(b, n, CBAR, WACFG, v)
+#define SET_CBAR_IRPTNDX(b, n, v)  SET_GLOBAL_FIELD_N(b, n, CBAR, IRPTNDX, v)
+
+#define GET_CBAR_VMID(b, n)        GET_GLOBAL_FIELD_N(b, n, CBAR, VMID)
+#define GET_CBAR_CBNDX(b, n)       GET_GLOBAL_FIELD_N(b, n, CBAR, CBNDX)
+#define GET_CBAR_BPSHCFG(b, n)     GET_GLOBAL_FIELD_N(b, n, CBAR, BPSHCFG)
+#define GET_CBAR_HYPC(b, n)        GET_GLOBAL_FIELD_N(b, n, CBAR, HYPC)
+#define GET_CBAR_FB(b, n)          GET_GLOBAL_FIELD_N(b, n, CBAR, FB)
+#define GET_CBAR_MEMATTR(b, n)     GET_GLOBAL_FIELD_N(b, n, CBAR, MEMATTR)
+#define GET_CBAR_TYPE(b, n)        GET_GLOBAL_FIELD_N(b, n, CBAR, TYPE)
+#define GET_CBAR_BSU(b, n)         GET_GLOBAL_FIELD_N(b, n, CBAR, BSU)
+#define GET_CBAR_RACFG(b, n)       GET_GLOBAL_FIELD_N(b, n, CBAR, RACFG)
+#define GET_CBAR_WACFG(b, n)       GET_GLOBAL_FIELD_N(b, n, CBAR, WACFG)
+#define GET_CBAR_IRPTNDX(b, n)     GET_GLOBAL_FIELD_N(b, n, CBAR, IRPTNDX)
+
+/* Context Bank Fault Restricted Syndrome Register A: CBFRSYNRA_N */
+#define SET_CBFRSYNRA_SID(b, n, v) SET_GLOBAL_FIELD_N(b, n, CBFRSYNRA, SID, v)
+
+#define GET_CBFRSYNRA_SID(b, n)    GET_GLOBAL_FIELD_N(b, n, CBFRSYNRA, SID)
+
+/* Stage 1 Context Bank Format Fields */
+#define SET_CB_ACTLR_REQPRIORITY (b, c, v) \
+		SET_CONTEXT_FIELD(b, c, CB_ACTLR, REQPRIORITY, v)
+#define SET_CB_ACTLR_REQPRIORITYCFG(b, c, v) \
+		SET_CONTEXT_FIELD(b, c, CB_ACTLR, REQPRIORITYCFG, v)
+#define SET_CB_ACTLR_PRIVCFG(b, c, v) \
+		SET_CONTEXT_FIELD(b, c, CB_ACTLR, PRIVCFG, v)
+#define SET_CB_ACTLR_BPRCOSH(b, c, v) \
+		SET_CONTEXT_FIELD(b, c, CB_ACTLR, BPRCOSH, v)
+#define SET_CB_ACTLR_BPRCISH(b, c, v) \
+		SET_CONTEXT_FIELD(b, c, CB_ACTLR, BPRCISH, v)
+#define SET_CB_ACTLR_BPRCNSH(b, c, v) \
+		SET_CONTEXT_FIELD(b, c, CB_ACTLR, BPRCNSH, v)
+
+#define GET_CB_ACTLR_REQPRIORITY (b, c) \
+		GET_CONTEXT_FIELD(b, c, CB_ACTLR, REQPRIORITY)
+#define GET_CB_ACTLR_REQPRIORITYCFG(b, c) \
+		GET_CONTEXT_FIELD(b, c, CB_ACTLR, REQPRIORITYCFG)
+#define GET_CB_ACTLR_PRIVCFG(b, c)  GET_CONTEXT_FIELD(b, c, CB_ACTLR, PRIVCFG)
+#define GET_CB_ACTLR_BPRCOSH(b, c)  GET_CONTEXT_FIELD(b, c, CB_ACTLR, BPRCOSH)
+#define GET_CB_ACTLR_BPRCISH(b, c)  GET_CONTEXT_FIELD(b, c, CB_ACTLR, BPRCISH)
+#define GET_CB_ACTLR_BPRCNSH(b, c)  GET_CONTEXT_FIELD(b, c, CB_ACTLR, BPRCNSH)
+
+/* Address Translation, Stage 1, Privileged Read: CB_ATS1PR */
+#define SET_CB_ATS1PR_ADDR(b, c, v) SET_CONTEXT_FIELD(b, c, CB_ATS1PR, ADDR, v)
+
+#define GET_CB_ATS1PR_ADDR(b, c)    GET_CONTEXT_FIELD(b, c, CB_ATS1PR, ADDR)
+
+/* Address Translation, Stage 1, Privileged Write: CB_ATS1PW */
+#define SET_CB_ATS1PW_ADDR(b, c, v) SET_CONTEXT_FIELD(b, c, CB_ATS1PW, ADDR, v)
+
+#define GET_CB_ATS1PW_ADDR(b, c)    GET_CONTEXT_FIELD(b, c, CB_ATS1PW, ADDR)
+
+/* Address Translation, Stage 1, User Read: CB_ATS1UR */
+#define SET_CB_ATS1UR_ADDR(b, c, v) SET_CONTEXT_FIELD(b, c, CB_ATS1UR, ADDR, v)
+
+#define GET_CB_ATS1UR_ADDR(b, c)    GET_CONTEXT_FIELD(b, c, CB_ATS1UR, ADDR)
+
+/* Address Translation, Stage 1, User Write: CB_ATS1UW */
+#define SET_CB_ATS1UW_ADDR(b, c, v) SET_CONTEXT_FIELD(b, c, CB_ATS1UW, ADDR, v)
+
+#define GET_CB_ATS1UW_ADDR(b, c)    GET_CONTEXT_FIELD(b, c, CB_ATS1UW, ADDR)
+
+/* Address Translation Status Register: CB_ATSR */
+#define SET_CB_ATSR_ACTIVE(b, c, v) SET_CONTEXT_FIELD(b, c, CB_ATSR, ACTIVE, v)
+
+#define GET_CB_ATSR_ACTIVE(b, c)    GET_CONTEXT_FIELD(b, c, CB_ATSR, ACTIVE)
+
+/* Context ID Register: CB_CONTEXTIDR */
+#define SET_CB_CONTEXTIDR_ASID(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_CONTEXTIDR, ASID, v)
+#define SET_CB_CONTEXTIDR_PROCID(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_CONTEXTIDR, PROCID, v)
+
+#define GET_CB_CONTEXTIDR_ASID(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_CONTEXTIDR, ASID)
+#define GET_CB_CONTEXTIDR_PROCID(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_CONTEXTIDR, PROCID)
+
+/* Fault Address Register: CB_FAR */
+#define SET_CB_FAR_FADDR(b, c, v) SET_CONTEXT_FIELD(b, c, CB_FAR, FADDR, v)
+
+#define GET_CB_FAR_FADDR(b, c)    GET_CONTEXT_FIELD(b, c, CB_FAR, FADDR)
+
+/* Fault Status Register: CB_FSR */
+#define SET_CB_FSR_TF(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_FSR, TF, v)
+#define SET_CB_FSR_AFF(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_FSR, AFF, v)
+#define SET_CB_FSR_PF(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_FSR, PF, v)
+#define SET_CB_FSR_EF(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_FSR, EF, v)
+#define SET_CB_FSR_TLBMCF(b, c, v) SET_CONTEXT_FIELD(b, c, CB_FSR, TLBMCF, v)
+#define SET_CB_FSR_TLBLKF(b, c, v) SET_CONTEXT_FIELD(b, c, CB_FSR, TLBLKF, v)
+#define SET_CB_FSR_SS(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_FSR, SS, v)
+#define SET_CB_FSR_MULTI(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_FSR, MULTI, v)
+
+#define GET_CB_FSR_TF(b, c)        GET_CONTEXT_FIELD(b, c, CB_FSR, TF)
+#define GET_CB_FSR_AFF(b, c)       GET_CONTEXT_FIELD(b, c, CB_FSR, AFF)
+#define GET_CB_FSR_PF(b, c)        GET_CONTEXT_FIELD(b, c, CB_FSR, PF)
+#define GET_CB_FSR_EF(b, c)        GET_CONTEXT_FIELD(b, c, CB_FSR, EF)
+#define GET_CB_FSR_TLBMCF(b, c)    GET_CONTEXT_FIELD(b, c, CB_FSR, TLBMCF)
+#define GET_CB_FSR_TLBLKF(b, c)    GET_CONTEXT_FIELD(b, c, CB_FSR, TLBLKF)
+#define GET_CB_FSR_SS(b, c)        GET_CONTEXT_FIELD(b, c, CB_FSR, SS)
+#define GET_CB_FSR_MULTI(b, c)     GET_CONTEXT_FIELD(b, c, CB_FSR, MULTI)
+
+/* Fault Syndrome Register 0: CB_FSYNR0 */
+#define SET_CB_FSYNR0_PLVL(b, c, v) SET_CONTEXT_FIELD(b, c, CB_FSYNR0, PLVL, v)
+#define SET_CB_FSYNR0_S1PTWF(b, c, v) \
+				SET_CONTEXT_FIELD(b, c, CB_FSYNR0, S1PTWF, v)
+#define SET_CB_FSYNR0_WNR(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_FSYNR0, WNR, v)
+#define SET_CB_FSYNR0_PNU(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_FSYNR0, PNU, v)
+#define SET_CB_FSYNR0_IND(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_FSYNR0, IND, v)
+#define SET_CB_FSYNR0_NSSTATE(b, c, v) \
+				SET_CONTEXT_FIELD(b, c, CB_FSYNR0, NSSTATE, v)
+#define SET_CB_FSYNR0_NSATTR(b, c, v) \
+				SET_CONTEXT_FIELD(b, c, CB_FSYNR0, NSATTR, v)
+#define SET_CB_FSYNR0_ATOF(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_FSYNR0, ATOF, v)
+#define SET_CB_FSYNR0_PTWF(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_FSYNR0, PTWF, v)
+#define SET_CB_FSYNR0_AFR(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_FSYNR0, AFR, v)
+#define SET_CB_FSYNR0_S1CBNDX(b, c, v) \
+				SET_CONTEXT_FIELD(b, c, CB_FSYNR0, S1CBNDX, v)
+
+#define GET_CB_FSYNR0_PLVL(b, c)    GET_CONTEXT_FIELD(b, c, CB_FSYNR0, PLVL)
+#define GET_CB_FSYNR0_S1PTWF(b, c)    \
+				GET_CONTEXT_FIELD(b, c, CB_FSYNR0, S1PTWF)
+#define GET_CB_FSYNR0_WNR(b, c)     GET_CONTEXT_FIELD(b, c, CB_FSYNR0, WNR)
+#define GET_CB_FSYNR0_PNU(b, c)     GET_CONTEXT_FIELD(b, c, CB_FSYNR0, PNU)
+#define GET_CB_FSYNR0_IND(b, c)     GET_CONTEXT_FIELD(b, c, CB_FSYNR0, IND)
+#define GET_CB_FSYNR0_NSSTATE(b, c)    \
+				GET_CONTEXT_FIELD(b, c, CB_FSYNR0, NSSTATE)
+#define GET_CB_FSYNR0_NSATTR(b, c)    \
+				GET_CONTEXT_FIELD(b, c, CB_FSYNR0, NSATTR)
+#define GET_CB_FSYNR0_ATOF(b, c)     GET_CONTEXT_FIELD(b, c, CB_FSYNR0, ATOF)
+#define GET_CB_FSYNR0_PTWF(b, c)     GET_CONTEXT_FIELD(b, c, CB_FSYNR0, PTWF)
+#define GET_CB_FSYNR0_AFR(b, c)      GET_CONTEXT_FIELD(b, c, CB_FSYNR0, AFR)
+#define GET_CB_FSYNR0_S1CBNDX(b, c)    \
+				GET_CONTEXT_FIELD(b, c, CB_FSYNR0, S1CBNDX)
+
+/* Normal Memory Remap Register: CB_NMRR */
+#define SET_CB_NMRR_IR0(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR0, v)
+#define SET_CB_NMRR_IR1(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR1, v)
+#define SET_CB_NMRR_IR2(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR2, v)
+#define SET_CB_NMRR_IR3(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR3, v)
+#define SET_CB_NMRR_IR4(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR4, v)
+#define SET_CB_NMRR_IR5(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR5, v)
+#define SET_CB_NMRR_IR6(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR6, v)
+#define SET_CB_NMRR_IR7(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, IR7, v)
+#define SET_CB_NMRR_OR0(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR0, v)
+#define SET_CB_NMRR_OR1(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR1, v)
+#define SET_CB_NMRR_OR2(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR2, v)
+#define SET_CB_NMRR_OR3(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR3, v)
+#define SET_CB_NMRR_OR4(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR4, v)
+#define SET_CB_NMRR_OR5(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR5, v)
+#define SET_CB_NMRR_OR6(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR6, v)
+#define SET_CB_NMRR_OR7(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_NMRR, OR7, v)
+
+#define GET_CB_NMRR_IR0(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR0)
+#define GET_CB_NMRR_IR1(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR1)
+#define GET_CB_NMRR_IR2(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR2)
+#define GET_CB_NMRR_IR3(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR3)
+#define GET_CB_NMRR_IR4(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR4)
+#define GET_CB_NMRR_IR5(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR5)
+#define GET_CB_NMRR_IR6(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR6)
+#define GET_CB_NMRR_IR7(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, IR7)
+#define GET_CB_NMRR_OR0(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, OR0)
+#define GET_CB_NMRR_OR1(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, OR1)
+#define GET_CB_NMRR_OR2(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, OR2)
+#define GET_CB_NMRR_OR3(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, OR3)
+#define GET_CB_NMRR_OR4(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, OR4)
+#define GET_CB_NMRR_OR5(b, c)       GET_CONTEXT_FIELD(b, c, CB_NMRR, OR5)
+
+/* Physical Address Register: CB_PAR */
+#define SET_CB_PAR_F(b, c, v)       SET_CONTEXT_FIELD(b, c, CB_PAR, F, v)
+#define SET_CB_PAR_SS(b, c, v)      SET_CONTEXT_FIELD(b, c, CB_PAR, SS, v)
+#define SET_CB_PAR_OUTER(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PAR, OUTER, v)
+#define SET_CB_PAR_INNER(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PAR, INNER, v)
+#define SET_CB_PAR_SH(b, c, v)      SET_CONTEXT_FIELD(b, c, CB_PAR, SH, v)
+#define SET_CB_PAR_NS(b, c, v)      SET_CONTEXT_FIELD(b, c, CB_PAR, NS, v)
+#define SET_CB_PAR_NOS(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_PAR, NOS, v)
+#define SET_CB_PAR_PA(b, c, v)      SET_CONTEXT_FIELD(b, c, CB_PAR, PA, v)
+#define SET_CB_PAR_TF(b, c, v)      SET_CONTEXT_FIELD(b, c, CB_PAR, TF, v)
+#define SET_CB_PAR_AFF(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_PAR, AFF, v)
+#define SET_CB_PAR_PF(b, c, v)      SET_CONTEXT_FIELD(b, c, CB_PAR, PF, v)
+#define SET_CB_PAR_TLBMCF(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_PAR, TLBMCF, v)
+#define SET_CB_PAR_TLBLKF(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_PAR, TLBLKF, v)
+#define SET_CB_PAR_ATOT(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PAR, ATOT, v)
+#define SET_CB_PAR_PLVL(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PAR, PLVL, v)
+#define SET_CB_PAR_STAGE(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PAR, STAGE, v)
+
+#define GET_CB_PAR_F(b, c)          GET_CONTEXT_FIELD(b, c, CB_PAR, F)
+#define GET_CB_PAR_SS(b, c)         GET_CONTEXT_FIELD(b, c, CB_PAR, SS)
+#define GET_CB_PAR_OUTER(b, c)      GET_CONTEXT_FIELD(b, c, CB_PAR, OUTER)
+#define GET_CB_PAR_INNER(b, c)      GET_CONTEXT_FIELD(b, c, CB_PAR, INNER)
+#define GET_CB_PAR_SH(b, c)         GET_CONTEXT_FIELD(b, c, CB_PAR, SH)
+#define GET_CB_PAR_NS(b, c)         GET_CONTEXT_FIELD(b, c, CB_PAR, NS)
+#define GET_CB_PAR_NOS(b, c)        GET_CONTEXT_FIELD(b, c, CB_PAR, NOS)
+#define GET_CB_PAR_PA(b, c)         GET_CONTEXT_FIELD(b, c, CB_PAR, PA)
+#define GET_CB_PAR_TF(b, c)         GET_CONTEXT_FIELD(b, c, CB_PAR, TF)
+#define GET_CB_PAR_AFF(b, c)        GET_CONTEXT_FIELD(b, c, CB_PAR, AFF)
+#define GET_CB_PAR_PF(b, c)         GET_CONTEXT_FIELD(b, c, CB_PAR, PF)
+#define GET_CB_PAR_TLBMCF(b, c)     GET_CONTEXT_FIELD(b, c, CB_PAR, TLBMCF)
+#define GET_CB_PAR_TLBLKF(b, c)     GET_CONTEXT_FIELD(b, c, CB_PAR, TLBLKF)
+#define GET_CB_PAR_ATOT(b, c)       GET_CONTEXT_FIELD(b, c, CB_PAR, ATOT)
+#define GET_CB_PAR_PLVL(b, c)       GET_CONTEXT_FIELD(b, c, CB_PAR, PLVL)
+#define GET_CB_PAR_STAGE(b, c)      GET_CONTEXT_FIELD(b, c, CB_PAR, STAGE)
+
+/* Primary Region Remap Register: CB_PRRR */
+#define SET_CB_PRRR_TR0(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR0, v)
+#define SET_CB_PRRR_TR1(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR1, v)
+#define SET_CB_PRRR_TR2(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR2, v)
+#define SET_CB_PRRR_TR3(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR3, v)
+#define SET_CB_PRRR_TR4(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR4, v)
+#define SET_CB_PRRR_TR5(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR5, v)
+#define SET_CB_PRRR_TR6(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR6, v)
+#define SET_CB_PRRR_TR7(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, TR7, v)
+#define SET_CB_PRRR_DS0(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, DS0, v)
+#define SET_CB_PRRR_DS1(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, DS1, v)
+#define SET_CB_PRRR_NS0(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, NS0, v)
+#define SET_CB_PRRR_NS1(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_PRRR, NS1, v)
+#define SET_CB_PRRR_NOS0(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS0, v)
+#define SET_CB_PRRR_NOS1(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS1, v)
+#define SET_CB_PRRR_NOS2(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS2, v)
+#define SET_CB_PRRR_NOS3(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS3, v)
+#define SET_CB_PRRR_NOS4(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS4, v)
+#define SET_CB_PRRR_NOS5(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS5, v)
+#define SET_CB_PRRR_NOS6(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS6, v)
+#define SET_CB_PRRR_NOS7(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_PRRR, NOS7, v)
+
+#define GET_CB_PRRR_TR0(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR0)
+#define GET_CB_PRRR_TR1(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR1)
+#define GET_CB_PRRR_TR2(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR2)
+#define GET_CB_PRRR_TR3(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR3)
+#define GET_CB_PRRR_TR4(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR4)
+#define GET_CB_PRRR_TR5(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR5)
+#define GET_CB_PRRR_TR6(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR6)
+#define GET_CB_PRRR_TR7(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, TR7)
+#define GET_CB_PRRR_DS0(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, DS0)
+#define GET_CB_PRRR_DS1(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, DS1)
+#define GET_CB_PRRR_NS0(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, NS0)
+#define GET_CB_PRRR_NS1(b, c)       GET_CONTEXT_FIELD(b, c, CB_PRRR, NS1)
+#define GET_CB_PRRR_NOS0(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS0)
+#define GET_CB_PRRR_NOS1(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS1)
+#define GET_CB_PRRR_NOS2(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS2)
+#define GET_CB_PRRR_NOS3(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS3)
+#define GET_CB_PRRR_NOS4(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS4)
+#define GET_CB_PRRR_NOS5(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS5)
+#define GET_CB_PRRR_NOS6(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS6)
+#define GET_CB_PRRR_NOS7(b, c)      GET_CONTEXT_FIELD(b, c, CB_PRRR, NOS7)
+
+/* Transaction Resume: CB_RESUME */
+#define SET_CB_RESUME_TNR(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_RESUME, TNR, v)
+
+#define GET_CB_RESUME_TNR(b, c)     GET_CONTEXT_FIELD(b, c, CB_RESUME, TNR)
+
+/* System Control Register: CB_SCTLR */
+#define SET_CB_SCTLR_M(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_SCTLR, M, v)
+#define SET_CB_SCTLR_TRE(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_SCTLR, TRE, v)
+#define SET_CB_SCTLR_AFE(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_SCTLR, AFE, v)
+#define SET_CB_SCTLR_AFFD(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_SCTLR, AFFD, v)
+#define SET_CB_SCTLR_E(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_SCTLR, E, v)
+#define SET_CB_SCTLR_CFRE(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_SCTLR, CFRE, v)
+#define SET_CB_SCTLR_CFIE(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_SCTLR, CFIE, v)
+#define SET_CB_SCTLR_CFCFG(b, c, v) SET_CONTEXT_FIELD(b, c, CB_SCTLR, CFCFG, v)
+#define SET_CB_SCTLR_HUPCF(b, c, v) SET_CONTEXT_FIELD(b, c, CB_SCTLR, HUPCF, v)
+#define SET_CB_SCTLR_WXN(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_SCTLR, WXN, v)
+#define SET_CB_SCTLR_UWXN(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_SCTLR, UWXN, v)
+#define SET_CB_SCTLR_ASIDPNE(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_SCTLR, ASIDPNE, v)
+#define SET_CB_SCTLR_TRANSIENTCFG(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_SCTLR, TRANSIENTCFG, v)
+#define SET_CB_SCTLR_MEMATTR(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_SCTLR, MEMATTR, v)
+#define SET_CB_SCTLR_MTCFG(b, c, v) SET_CONTEXT_FIELD(b, c, CB_SCTLR, MTCFG, v)
+#define SET_CB_SCTLR_SHCFG(b, c, v) SET_CONTEXT_FIELD(b, c, CB_SCTLR, SHCFG, v)
+#define SET_CB_SCTLR_RACFG(b, c, v) SET_CONTEXT_FIELD(b, c, CB_SCTLR, RACFG, v)
+#define SET_CB_SCTLR_WACFG(b, c, v) SET_CONTEXT_FIELD(b, c, CB_SCTLR, WACFG, v)
+#define SET_CB_SCTLR_NSCFG(b, c, v) SET_CONTEXT_FIELD(b, c, CB_SCTLR, NSCFG, v)
+
+#define GET_CB_SCTLR_M(b, c)        GET_CONTEXT_FIELD(b, c, CB_SCTLR, M)
+#define GET_CB_SCTLR_TRE(b, c)      GET_CONTEXT_FIELD(b, c, CB_SCTLR, TRE)
+#define GET_CB_SCTLR_AFE(b, c)      GET_CONTEXT_FIELD(b, c, CB_SCTLR, AFE)
+#define GET_CB_SCTLR_AFFD(b, c)     GET_CONTEXT_FIELD(b, c, CB_SCTLR, AFFD)
+#define GET_CB_SCTLR_E(b, c)        GET_CONTEXT_FIELD(b, c, CB_SCTLR, E)
+#define GET_CB_SCTLR_CFRE(b, c)     GET_CONTEXT_FIELD(b, c, CB_SCTLR, CFRE)
+#define GET_CB_SCTLR_CFIE(b, c)     GET_CONTEXT_FIELD(b, c, CB_SCTLR, CFIE)
+#define GET_CB_SCTLR_CFCFG(b, c)    GET_CONTEXT_FIELD(b, c, CB_SCTLR, CFCFG)
+#define GET_CB_SCTLR_HUPCF(b, c)    GET_CONTEXT_FIELD(b, c, CB_SCTLR, HUPCF)
+#define GET_CB_SCTLR_WXN(b, c)      GET_CONTEXT_FIELD(b, c, CB_SCTLR, WXN)
+#define GET_CB_SCTLR_UWXN(b, c)     GET_CONTEXT_FIELD(b, c, CB_SCTLR, UWXN)
+#define GET_CB_SCTLR_ASIDPNE(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_SCTLR, ASIDPNE)
+#define GET_CB_SCTLR_TRANSIENTCFG(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_SCTLR, TRANSIENTCFG)
+#define GET_CB_SCTLR_MEMATTR(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_SCTLR, MEMATTR)
+#define GET_CB_SCTLR_MTCFG(b, c)    GET_CONTEXT_FIELD(b, c, CB_SCTLR, MTCFG)
+#define GET_CB_SCTLR_SHCFG(b, c)    GET_CONTEXT_FIELD(b, c, CB_SCTLR, SHCFG)
+#define GET_CB_SCTLR_RACFG(b, c)    GET_CONTEXT_FIELD(b, c, CB_SCTLR, RACFG)
+#define GET_CB_SCTLR_WACFG(b, c)    GET_CONTEXT_FIELD(b, c, CB_SCTLR, WACFG)
+#define GET_CB_SCTLR_NSCFG(b, c)    GET_CONTEXT_FIELD(b, c, CB_SCTLR, NSCFG)
+
+/* Invalidate TLB by ASID: CB_TLBIASID */
+#define SET_CB_TLBIASID_ASID(b, c, v) \
+				SET_CONTEXT_FIELD(b, c, CB_TLBIASID, ASID, v)
+
+#define GET_CB_TLBIASID_ASID(b, c)    \
+				GET_CONTEXT_FIELD(b, c, CB_TLBIASID, ASID)
+
+/* Invalidate TLB by VA: CB_TLBIVA */
+#define SET_CB_TLBIVA_ASID(b, c, v) SET_CONTEXT_FIELD(b, c, CB_TLBIVA, ASID, v)
+#define SET_CB_TLBIVA_VA(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TLBIVA, VA, v)
+
+#define GET_CB_TLBIVA_ASID(b, c)    GET_CONTEXT_FIELD(b, c, CB_TLBIVA, ASID)
+#define GET_CB_TLBIVA_VA(b, c)      GET_CONTEXT_FIELD(b, c, CB_TLBIVA, VA)
+
+/* Invalidate TLB by VA, All ASID: CB_TLBIVAA */
+#define SET_CB_TLBIVAA_VA(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_TLBIVAA, VA, v)
+
+#define GET_CB_TLBIVAA_VA(b, c)     GET_CONTEXT_FIELD(b, c, CB_TLBIVAA, VA)
+
+/* Invalidate TLB by VA, All ASID, Last Level: CB_TLBIVAAL */
+#define SET_CB_TLBIVAAL_VA(b, c, v) SET_CONTEXT_FIELD(b, c, CB_TLBIVAAL, VA, v)
+
+#define GET_CB_TLBIVAAL_VA(b, c)    GET_CONTEXT_FIELD(b, c, CB_TLBIVAAL, VA)
+
+/* Invalidate TLB by VA, Last Level: CB_TLBIVAL */
+#define SET_CB_TLBIVAL_ASID(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_TLBIVAL, ASID, v)
+#define SET_CB_TLBIVAL_VA(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TLBIVAL, VA, v)
+
+#define GET_CB_TLBIVAL_ASID(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_TLBIVAL, ASID)
+#define GET_CB_TLBIVAL_VA(b, c)      GET_CONTEXT_FIELD(b, c, CB_TLBIVAL, VA)
+
+/* TLB Status: CB_TLBSTATUS */
+#define SET_CB_TLBSTATUS_SACTIVE(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_TLBSTATUS, SACTIVE, v)
+
+#define GET_CB_TLBSTATUS_SACTIVE(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_TLBSTATUS, SACTIVE)
+
+/* Translation Table Base Control Register: CB_TTBCR */
+#define GET_CB_TTBCR_EAE(b, c)       GET_CONTEXT_FIELD(b, c, CB_TTBCR, EAE)
+#define SET_CB_TTBCR_EAE(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_TTBCR, EAE, v)
+
+#define SET_CB_TTBCR_NSCFG0(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_TTBCR, NSCFG0, v)
+#define SET_CB_TTBCR_NSCFG1(b, c, v) \
+			SET_CONTEXT_FIELD(b, c, CB_TTBCR, NSCFG1, v)
+
+#define GET_CB_TTBCR_NSCFG0(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_TTBCR, NSCFG0)
+#define GET_CB_TTBCR_NSCFG1(b, c)    \
+			GET_CONTEXT_FIELD(b, c, CB_TTBCR, NSCFG1)
+
+#define SET_TTBR0(b, c, v)           SET_CTX_REG(CB_TTBR0, (b), (c), (v))
+#define SET_TTBR1(b, c, v)           SET_CTX_REG(CB_TTBR1, (b), (c), (v))
+
+#define SET_CB_TTBCR_PD0(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_TTBCR, PD0, v)
+#define SET_CB_TTBCR_PD1(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_TTBCR, PD1, v)
+
+#define SET_CB_TTBR0_IRGN1(b, c, v) SET_CONTEXT_FIELD(b, c, CB_TTBR0, IRGN1, v)
+#define SET_CB_TTBR0_S(b, c, v)     SET_CONTEXT_FIELD(b, c, CB_TTBR0, S, v)
+#define SET_CB_TTBR0_RGN(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBR0, RGN, v)
+#define SET_CB_TTBR0_NOS(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBR0, NOS, v)
+#define SET_CB_TTBR0_IRGN0(b, c, v) SET_CONTEXT_FIELD(b, c, CB_TTBR0, IRGN0, v)
+#define SET_CB_TTBR0_ADDR(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_TTBR0, ADDR, v)
+
+#define GET_CB_TTBR0_IRGN1(b, c)    GET_CONTEXT_FIELD(b, c, CB_TTBR0, IRGN1)
+#define GET_CB_TTBR0_S(b, c)        GET_CONTEXT_FIELD(b, c, CB_TTBR0, S)
+#define GET_CB_TTBR0_RGN(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBR0, RGN)
+#define GET_CB_TTBR0_NOS(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBR0, NOS)
+#define GET_CB_TTBR0_IRGN0(b, c)    GET_CONTEXT_FIELD(b, c, CB_TTBR0, IRGN0)
+#define GET_CB_TTBR0_ADDR(b, c)     GET_CONTEXT_FIELD(b, c, CB_TTBR0, ADDR)
+
+/* Translation Table Base Register 1: CB_TTBR1 */
+#define SET_CB_TTBR1_IRGN1(b, c, v) SET_CONTEXT_FIELD(b, c, CB_TTBR1, IRGN1, v)
+#define SET_CB_TTBR1_0S(b, c, v)    SET_CONTEXT_FIELD(b, c, CB_TTBR1, S, v)
+#define SET_CB_TTBR1_RGN(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBR1, RGN, v)
+#define SET_CB_TTBR1_NOS(b, c, v)   SET_CONTEXT_FIELD(b, c, CB_TTBR1, NOS, v)
+#define SET_CB_TTBR1_IRGN0(b, c, v) SET_CONTEXT_FIELD(b, c, CB_TTBR1, IRGN0, v)
+#define SET_CB_TTBR1_ADDR(b, c, v)  SET_CONTEXT_FIELD(b, c, CB_TTBR1, ADDR, v)
+
+#define GET_CB_TTBR1_IRGN1(b, c)    GET_CONTEXT_FIELD(b, c, CB_TTBR1, IRGN1)
+#define GET_CB_TTBR1_0S(b, c)       GET_CONTEXT_FIELD(b, c, CB_TTBR1, S)
+#define GET_CB_TTBR1_RGN(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBR1, RGN)
+#define GET_CB_TTBR1_NOS(b, c)      GET_CONTEXT_FIELD(b, c, CB_TTBR1, NOS)
+#define GET_CB_TTBR1_IRGN0(b, c)    GET_CONTEXT_FIELD(b, c, CB_TTBR1, IRGN0)
+#define GET_CB_TTBR1_ADDR(b, c)     GET_CONTEXT_FIELD(b, c, CB_TTBR1, ADDR)
+
+/* Global Register Space 0 */
+#define CR0		(0x0000)
+#define SCR1		(0x0004)
+#define CR2		(0x0008)
+#define ACR		(0x0010)
+#define IDR0		(0x0020)
+#define IDR1		(0x0024)
+#define IDR2		(0x0028)
+#define IDR7		(0x003C)
+#define GFAR		(0x0040)
+#define GFSR		(0x0048)
+#define GFSRRESTORE	(0x004C)
+#define GFSYNR0		(0x0050)
+#define GFSYNR1		(0x0054)
+#define GFSYNR2		(0x0058)
+#define TLBIVMID	(0x0064)
+#define TLBIALLNSNH	(0x0068)
+#define TLBIALLH	(0x006C)
+#define TLBGSYNC	(0x0070)
+#define TLBGSTATUS	(0x0074)
+#define TLBIVAH		(0x0078)
+#define GATS1UR		(0x0100)
+#define GATS1UW		(0x0108)
+#define GATS1PR		(0x0110)
+#define GATS1PW		(0x0118)
+#define GATS12UR	(0x0120)
+#define GATS12UW	(0x0128)
+#define GATS12PR	(0x0130)
+#define GATS12PW	(0x0138)
+#define GPAR		(0x0180)
+#define GATSR		(0x0188)
+#define NSCR0		(0x0400)
+#define NSCR2		(0x0408)
+#define NSACR		(0x0410)
+#define NSGFAR		(0x0440)
+#define NSGFSRRESTORE	(0x044C)
+#define SMR		(0x0800)
+#define S2CR		(0x0C00)
+
+/* SMMU_LOCAL */
+#define SMMU_INTR_SEL_NS	(0x2000)
+
+/* Global Register Space 1 */
+#define CBAR		(0x1000)
+#define CBFRSYNRA	(0x1400)
+
+/* Implementation defined Register Space */
+#define MICRO_MMU_CTRL	(0x2000)
+#define PREDICTIONDIS0	(0x204C)
+#define PREDICTIONDIS1	(0x2050)
+#define S1L1BFBLP0	(0x215C)
+
+/* Performance Monitoring Register Space */
+#define PMEVCNTR_N	(0x3000)
+#define PMEVTYPER_N	(0x3400)
+#define PMCGCR_N	(0x3800)
+#define PMCGSMR_N	(0x3A00)
+#define PMCNTENSET_N	(0x3C00)
+#define PMCNTENCLR_N	(0x3C20)
+#define PMINTENSET_N	(0x3C40)
+#define PMINTENCLR_N	(0x3C60)
+#define PMOVSCLR_N	(0x3C80)
+#define PMOVSSET_N	(0x3CC0)
+#define PMCFGR		(0x3E00)
+#define PMCR		(0x3E04)
+#define PMCEID0		(0x3E20)
+#define PMCEID1		(0x3E24)
+#define PMAUTHSTATUS	(0x3FB8)
+#define PMDEVTYPE	(0x3FCC)
+
+/* Secure Status Determination Address Space */
+#define SSDR_N		(0x4000)
+
+/* Stage 1 Context Bank Format */
+#define CB_SCTLR	(0x000)
+#define CB_ACTLR	(0x004)
+#define CB_RESUME	(0x008)
+#define CB_TTBR0	(0x020)
+#define CB_TTBR1	(0x028)
+#define CB_TTBCR	(0x030)
+#define CB_CONTEXTIDR	(0x034)
+#define CB_PRRR		(0x038)
+#define CB_MAIR0	(0x038)
+#define CB_NMRR		(0x03C)
+#define CB_MAIR1	(0x03C)
+#define CB_PAR		(0x050)
+#define CB_FSR		(0x058)
+#define CB_FSRRESTORE	(0x05C)
+#define CB_FAR		(0x060)
+#define CB_FSYNR0	(0x068)
+#define CB_FSYNR1	(0x06C)
+#define CB_TLBIVA	(0x600)
+#define CB_TLBIVAA	(0x608)
+#define CB_TLBIASID	(0x610)
+#define CB_TLBIALL	(0x618)
+#define CB_TLBIVAL	(0x620)
+#define CB_TLBIVAAL	(0x628)
+#define CB_TLBSYNC	(0x7F0)
+#define CB_TLBSTATUS	(0x7F4)
+#define CB_ATS1PR	(0x800)
+#define CB_ATS1PW	(0x808)
+#define CB_ATS1UR	(0x810)
+#define CB_ATS1UW	(0x818)
+#define CB_ATSR		(0x8F0)
+#define CB_PMXEVCNTR_N	(0xE00)
+#define CB_PMXEVTYPER_N	(0xE80)
+#define CB_PMCFGR	(0xF00)
+#define CB_PMCR		(0xF04)
+#define CB_PMCEID0	(0xF20)
+#define CB_PMCEID1	(0xF24)
+#define CB_PMCNTENSET	(0xF40)
+#define CB_PMCNTENCLR	(0xF44)
+#define CB_PMINTENSET	(0xF48)
+#define CB_PMINTENCLR	(0xF4C)
+#define CB_PMOVSCLR	(0xF50)
+#define CB_PMOVSSET	(0xF58)
+#define CB_PMAUTHSTATUS	(0xFB8)
+
+/* Global Register Fields */
+/* Configuration Register: CR0 */
+#define CR0_NSCFG         (CR0_NSCFG_MASK         << CR0_NSCFG_SHIFT)
+#define CR0_WACFG         (CR0_WACFG_MASK         << CR0_WACFG_SHIFT)
+#define CR0_RACFG         (CR0_RACFG_MASK         << CR0_RACFG_SHIFT)
+#define CR0_SHCFG         (CR0_SHCFG_MASK         << CR0_SHCFG_SHIFT)
+#define CR0_SMCFCFG       (CR0_SMCFCFG_MASK       << CR0_SMCFCFG_SHIFT)
+#define CR0_MTCFG         (CR0_MTCFG_MASK         << CR0_MTCFG_SHIFT)
+#define CR0_MEMATTR       (CR0_MEMATTR_MASK       << CR0_MEMATTR_SHIFT)
+#define CR0_BSU           (CR0_BSU_MASK           << CR0_BSU_SHIFT)
+#define CR0_FB            (CR0_FB_MASK            << CR0_FB_SHIFT)
+#define CR0_PTM           (CR0_PTM_MASK           << CR0_PTM_SHIFT)
+#define CR0_VMIDPNE       (CR0_VMIDPNE_MASK       << CR0_VMIDPNE_SHIFT)
+#define CR0_USFCFG        (CR0_USFCFG_MASK        << CR0_USFCFG_SHIFT)
+#define CR0_GSE           (CR0_GSE_MASK           << CR0_GSE_SHIFT)
+#define CR0_STALLD        (CR0_STALLD_MASK        << CR0_STALLD_SHIFT)
+#define CR0_TRANSIENTCFG  (CR0_TRANSIENTCFG_MASK  << CR0_TRANSIENTCFG_SHIFT)
+#define CR0_GCFGFIE       (CR0_GCFGFIE_MASK       << CR0_GCFGFIE_SHIFT)
+#define CR0_GCFGFRE       (CR0_GCFGFRE_MASK       << CR0_GCFGFRE_SHIFT)
+#define CR0_GFIE          (CR0_GFIE_MASK          << CR0_GFIE_SHIFT)
+#define CR0_GFRE          (CR0_GFRE_MASK          << CR0_GFRE_SHIFT)
+#define CR0_CLIENTPD      (CR0_CLIENTPD_MASK      << CR0_CLIENTPD_SHIFT)
+
+/* Configuration Register: CR2 */
+#define CR2_BPVMID        (CR2_BPVMID_MASK << CR2_BPVMID_SHIFT)
+
+/* Global Address Translation, Stage 1, Privileged Read: GATS1PR */
+#define GATS1PR_ADDR  (GATS1PR_ADDR_MASK  << GATS1PR_ADDR_SHIFT)
+#define GATS1PR_NDX   (GATS1PR_NDX_MASK   << GATS1PR_NDX_SHIFT)
+
+/* Global Address Translation, Stage 1, Privileged Write: GATS1PW */
+#define GATS1PW_ADDR  (GATS1PW_ADDR_MASK  << GATS1PW_ADDR_SHIFT)
+#define GATS1PW_NDX   (GATS1PW_NDX_MASK   << GATS1PW_NDX_SHIFT)
+
+/* Global Address Translation, Stage 1, User Read: GATS1UR */
+#define GATS1UR_ADDR  (GATS1UR_ADDR_MASK  << GATS1UR_ADDR_SHIFT)
+#define GATS1UR_NDX   (GATS1UR_NDX_MASK   << GATS1UR_NDX_SHIFT)
+
+/* Global Address Translation, Stage 1, User Write: GATS1UW */
+#define GATS1UW_ADDR  (GATS1UW_ADDR_MASK  << GATS1UW_ADDR_SHIFT)
+#define GATS1UW_NDX   (GATS1UW_NDX_MASK   << GATS1UW_NDX_SHIFT)
+
+/* Global Address Translation, Stage 1 and 2, Privileged Read: GATS1PR */
+#define GATS12PR_ADDR (GATS12PR_ADDR_MASK << GATS12PR_ADDR_SHIFT)
+#define GATS12PR_NDX  (GATS12PR_NDX_MASK  << GATS12PR_NDX_SHIFT)
+
+/* Global Address Translation, Stage 1 and 2, Privileged Write: GATS1PW */
+#define GATS12PW_ADDR (GATS12PW_ADDR_MASK << GATS12PW_ADDR_SHIFT)
+#define GATS12PW_NDX  (GATS12PW_NDX_MASK  << GATS12PW_NDX_SHIFT)
+
+/* Global Address Translation, Stage 1 and 2, User Read: GATS1UR */
+#define GATS12UR_ADDR (GATS12UR_ADDR_MASK << GATS12UR_ADDR_SHIFT)
+#define GATS12UR_NDX  (GATS12UR_NDX_MASK  << GATS12UR_NDX_SHIFT)
+
+/* Global Address Translation, Stage 1 and 2, User Write: GATS1UW */
+#define GATS12UW_ADDR (GATS12UW_ADDR_MASK << GATS12UW_ADDR_SHIFT)
+#define GATS12UW_NDX  (GATS12UW_NDX_MASK  << GATS12UW_NDX_SHIFT)
+
+/* Global Address Translation Status Register: GATSR */
+#define GATSR_ACTIVE  (GATSR_ACTIVE_MASK  << GATSR_ACTIVE_SHIFT)
+
+/* Global Fault Address Register: GFAR */
+#define GFAR_FADDR    (GFAR_FADDR_MASK << GFAR_FADDR_SHIFT)
+
+/* Global Fault Status Register: GFSR */
+#define GFSR_ICF      (GFSR_ICF_MASK   << GFSR_ICF_SHIFT)
+#define GFSR_USF      (GFSR_USF_MASK   << GFSR_USF_SHIFT)
+#define GFSR_SMCF     (GFSR_SMCF_MASK  << GFSR_SMCF_SHIFT)
+#define GFSR_UCBF     (GFSR_UCBF_MASK  << GFSR_UCBF_SHIFT)
+#define GFSR_UCIF     (GFSR_UCIF_MASK  << GFSR_UCIF_SHIFT)
+#define GFSR_CAF      (GFSR_CAF_MASK   << GFSR_CAF_SHIFT)
+#define GFSR_EF       (GFSR_EF_MASK    << GFSR_EF_SHIFT)
+#define GFSR_PF       (GFSR_PF_MASK    << GFSR_PF_SHIFT)
+#define GFSR_MULTI    (GFSR_MULTI_MASK << GFSR_MULTI_SHIFT)
+
+/* Global Fault Syndrome Register 0: GFSYNR0 */
+#define GFSYNR0_NESTED  (GFSYNR0_NESTED_MASK  << GFSYNR0_NESTED_SHIFT)
+#define GFSYNR0_WNR     (GFSYNR0_WNR_MASK     << GFSYNR0_WNR_SHIFT)
+#define GFSYNR0_PNU     (GFSYNR0_PNU_MASK     << GFSYNR0_PNU_SHIFT)
+#define GFSYNR0_IND     (GFSYNR0_IND_MASK     << GFSYNR0_IND_SHIFT)
+#define GFSYNR0_NSSTATE (GFSYNR0_NSSTATE_MASK << GFSYNR0_NSSTATE_SHIFT)
+#define GFSYNR0_NSATTR  (GFSYNR0_NSATTR_MASK  << GFSYNR0_NSATTR_SHIFT)
+
+/* Global Fault Syndrome Register 1: GFSYNR1 */
+#define GFSYNR1_SID     (GFSYNR1_SID_MASK     << GFSYNR1_SID_SHIFT)
+
+/* Global Physical Address Register: GPAR */
+#define GPAR_F          (GPAR_F_MASK      << GPAR_F_SHIFT)
+#define GPAR_SS         (GPAR_SS_MASK     << GPAR_SS_SHIFT)
+#define GPAR_OUTER      (GPAR_OUTER_MASK  << GPAR_OUTER_SHIFT)
+#define GPAR_INNER      (GPAR_INNER_MASK  << GPAR_INNER_SHIFT)
+#define GPAR_SH         (GPAR_SH_MASK     << GPAR_SH_SHIFT)
+#define GPAR_NS         (GPAR_NS_MASK     << GPAR_NS_SHIFT)
+#define GPAR_NOS        (GPAR_NOS_MASK    << GPAR_NOS_SHIFT)
+#define GPAR_PA         (GPAR_PA_MASK     << GPAR_PA_SHIFT)
+#define GPAR_TF         (GPAR_TF_MASK     << GPAR_TF_SHIFT)
+#define GPAR_AFF        (GPAR_AFF_MASK    << GPAR_AFF_SHIFT)
+#define GPAR_PF         (GPAR_PF_MASK     << GPAR_PF_SHIFT)
+#define GPAR_EF         (GPAR_EF_MASK     << GPAR_EF_SHIFT)
+#define GPAR_TLCMCF     (GPAR_TLBMCF_MASK << GPAR_TLCMCF_SHIFT)
+#define GPAR_TLBLKF     (GPAR_TLBLKF_MASK << GPAR_TLBLKF_SHIFT)
+#define GPAR_UCBF       (GPAR_UCBF_MASK   << GFAR_UCBF_SHIFT)
+
+/* Identification Register: IDR0 */
+#define IDR0_NUMSMRG    (IDR0_NUMSMRG_MASK  << IDR0_NUMSMGR_SHIFT)
+#define IDR0_NUMSIDB    (IDR0_NUMSIDB_MASK  << IDR0_NUMSIDB_SHIFT)
+#define IDR0_BTM        (IDR0_BTM_MASK      << IDR0_BTM_SHIFT)
+#define IDR0_CTTW       (IDR0_CTTW_MASK     << IDR0_CTTW_SHIFT)
+#define IDR0_NUMIRPT    (IDR0_NUMIPRT_MASK  << IDR0_NUMIRPT_SHIFT)
+#define IDR0_PTFS       (IDR0_PTFS_MASK     << IDR0_PTFS_SHIFT)
+#define IDR0_SMS        (IDR0_SMS_MASK      << IDR0_SMS_SHIFT)
+#define IDR0_NTS        (IDR0_NTS_MASK      << IDR0_NTS_SHIFT)
+#define IDR0_S2TS       (IDR0_S2TS_MASK     << IDR0_S2TS_SHIFT)
+#define IDR0_S1TS       (IDR0_S1TS_MASK     << IDR0_S1TS_SHIFT)
+#define IDR0_SES        (IDR0_SES_MASK      << IDR0_SES_SHIFT)
+
+/* Identification Register: IDR1 */
+#define IDR1_NUMCB       (IDR1_NUMCB_MASK       << IDR1_NUMCB_SHIFT)
+#define IDR1_NUMSSDNDXB  (IDR1_NUMSSDNDXB_MASK  << IDR1_NUMSSDNDXB_SHIFT)
+#define IDR1_SSDTP       (IDR1_SSDTP_MASK       << IDR1_SSDTP_SHIFT)
+#define IDR1_SMCD        (IDR1_SMCD_MASK        << IDR1_SMCD_SHIFT)
+#define IDR1_NUMS2CB     (IDR1_NUMS2CB_MASK     << IDR1_NUMS2CB_SHIFT)
+#define IDR1_NUMPAGENDXB (IDR1_NUMPAGENDXB_MASK << IDR1_NUMPAGENDXB_SHIFT)
+#define IDR1_PAGESIZE    (IDR1_PAGESIZE_MASK    << IDR1_PAGESIZE_SHIFT)
+
+/* Identification Register: IDR2 */
+#define IDR2_IAS         (IDR2_IAS_MASK << IDR2_IAS_SHIFT)
+#define IDR1_OAS         (IDR2_OAS_MASK << IDR2_OAS_SHIFT)
+
+/* Identification Register: IDR7 */
+#define IDR7_MINOR       (IDR7_MINOR_MASK << IDR7_MINOR_SHIFT)
+#define IDR7_MAJOR       (IDR7_MAJOR_MASK << IDR7_MAJOR_SHIFT)
+
+/* Stream to Context Register: S2CR */
+#define S2CR_CBNDX        (S2CR_CBNDX_MASK         << S2cR_CBNDX_SHIFT)
+#define S2CR_SHCFG        (S2CR_SHCFG_MASK         << s2CR_SHCFG_SHIFT)
+#define S2CR_MTCFG        (S2CR_MTCFG_MASK         << S2CR_MTCFG_SHIFT)
+#define S2CR_MEMATTR      (S2CR_MEMATTR_MASK       << S2CR_MEMATTR_SHIFT)
+#define S2CR_TYPE         (S2CR_TYPE_MASK          << S2CR_TYPE_SHIFT)
+#define S2CR_NSCFG        (S2CR_NSCFG_MASK         << S2CR_NSCFG_SHIFT)
+#define S2CR_RACFG        (S2CR_RACFG_MASK         << S2CR_RACFG_SHIFT)
+#define S2CR_WACFG        (S2CR_WACFG_MASK         << S2CR_WACFG_SHIFT)
+#define S2CR_PRIVCFG      (S2CR_PRIVCFG_MASK       << S2CR_PRIVCFG_SHIFT)
+#define S2CR_INSTCFG      (S2CR_INSTCFG_MASK       << S2CR_INSTCFG_SHIFT)
+#define S2CR_TRANSIENTCFG (S2CR_TRANSIENTCFG_MASK  << S2CR_TRANSIENTCFG_SHIFT)
+#define S2CR_VMID         (S2CR_VMID_MASK          << S2CR_VMID_SHIFT)
+#define S2CR_BSU          (S2CR_BSU_MASK           << S2CR_BSU_SHIFT)
+#define S2CR_FB           (S2CR_FB_MASK            << S2CR_FB_SHIFT)
+
+/* Stream Match Register: SMR */
+#define SMR_ID            (SMR_ID_MASK    << SMR_ID_SHIFT)
+#define SMR_MASK          (SMR_MASK_MASK  << SMR_MASK_SHIFT)
+#define SMR_VALID         (SMR_VALID_MASK << SMR_VALID_SHIFT)
+
+/* Global TLB Status: TLBGSTATUS */
+#define TLBGSTATUS_GSACTIVE (TLBGSTATUS_GSACTIVE_MASK << \
+					TLBGSTATUS_GSACTIVE_SHIFT)
+/* Invalidate Hyp TLB by VA: TLBIVAH */
+#define TLBIVAH_ADDR  (TLBIVAH_ADDR_MASK << TLBIVAH_ADDR_SHIFT)
+
+/* Invalidate TLB by VMID: TLBIVMID */
+#define TLBIVMID_VMID (TLBIVMID_VMID_MASK << TLBIVMID_VMID_SHIFT)
+
+/* Context Bank Attribute Register: CBAR */
+#define CBAR_VMID       (CBAR_VMID_MASK    << CBAR_VMID_SHIFT)
+#define CBAR_CBNDX      (CBAR_CBNDX_MASK   << CBAR_CBNDX_SHIFT)
+#define CBAR_BPSHCFG    (CBAR_BPSHCFG_MASK << CBAR_BPSHCFG_SHIFT)
+#define CBAR_HYPC       (CBAR_HYPC_MASK    << CBAR_HYPC_SHIFT)
+#define CBAR_FB         (CBAR_FB_MASK      << CBAR_FB_SHIFT)
+#define CBAR_MEMATTR    (CBAR_MEMATTR_MASK << CBAR_MEMATTR_SHIFT)
+#define CBAR_TYPE       (CBAR_TYPE_MASK    << CBAR_TYPE_SHIFT)
+#define CBAR_BSU        (CBAR_BSU_MASK     << CBAR_BSU_SHIFT)
+#define CBAR_RACFG      (CBAR_RACFG_MASK   << CBAR_RACFG_SHIFT)
+#define CBAR_WACFG      (CBAR_WACFG_MASK   << CBAR_WACFG_SHIFT)
+#define CBAR_IRPTNDX    (CBAR_IRPTNDX_MASK << CBAR_IRPTNDX_SHIFT)
+
+/* Context Bank Fault Restricted Syndrome Register A: CBFRSYNRA */
+#define CBFRSYNRA_SID   (CBFRSYNRA_SID_MASK << CBFRSYNRA_SID_SHIFT)
+
+/* Performance Monitoring Register Fields */
+
+/* Stage 1 Context Bank Format Fields */
+/* Auxiliary Control Register: CB_ACTLR */
+#define CB_ACTLR_REQPRIORITY \
+		(CB_ACTLR_REQPRIORITY_MASK << CB_ACTLR_REQPRIORITY_SHIFT)
+#define CB_ACTLR_REQPRIORITYCFG \
+		(CB_ACTLR_REQPRIORITYCFG_MASK << CB_ACTLR_REQPRIORITYCFG_SHIFT)
+#define CB_ACTLR_PRIVCFG (CB_ACTLR_PRIVCFG_MASK << CB_ACTLR_PRIVCFG_SHIFT)
+#define CB_ACTLR_BPRCOSH (CB_ACTLR_BPRCOSH_MASK << CB_ACTLR_BPRCOSH_SHIFT)
+#define CB_ACTLR_BPRCISH (CB_ACTLR_BPRCISH_MASK << CB_ACTLR_BPRCISH_SHIFT)
+#define CB_ACTLR_BPRCNSH (CB_ACTLR_BPRCNSH_MASK << CB_ACTLR_BPRCNSH_SHIFT)
+
+/* Address Translation, Stage 1, Privileged Read: CB_ATS1PR */
+#define CB_ATS1PR_ADDR  (CB_ATS1PR_ADDR_MASK << CB_ATS1PR_ADDR_SHIFT)
+
+/* Address Translation, Stage 1, Privileged Write: CB_ATS1PW */
+#define CB_ATS1PW_ADDR  (CB_ATS1PW_ADDR_MASK << CB_ATS1PW_ADDR_SHIFT)
+
+/* Address Translation, Stage 1, User Read: CB_ATS1UR */
+#define CB_ATS1UR_ADDR  (CB_ATS1UR_ADDR_MASK << CB_ATS1UR_ADDR_SHIFT)
+
+/* Address Translation, Stage 1, User Write: CB_ATS1UW */
+#define CB_ATS1UW_ADDR  (CB_ATS1UW_ADDR_MASK << CB_ATS1UW_ADDR_SHIFT)
+
+/* Address Translation Status Register: CB_ATSR */
+#define CB_ATSR_ACTIVE  (CB_ATSR_ACTIVE_MASK << CB_ATSR_ACTIVE_SHIFT)
+
+/* Context ID Register: CB_CONTEXTIDR */
+#define CB_CONTEXTIDR_ASID    (CB_CONTEXTIDR_ASID_MASK << \
+				CB_CONTEXTIDR_ASID_SHIFT)
+#define CB_CONTEXTIDR_PROCID  (CB_CONTEXTIDR_PROCID_MASK << \
+				CB_CONTEXTIDR_PROCID_SHIFT)
+
+/* Fault Address Register: CB_FAR */
+#define CB_FAR_FADDR  (CB_FAR_FADDR_MASK << CB_FAR_FADDR_SHIFT)
+
+/* Fault Status Register: CB_FSR */
+#define CB_FSR_TF     (CB_FSR_TF_MASK     << CB_FSR_TF_SHIFT)
+#define CB_FSR_AFF    (CB_FSR_AFF_MASK    << CB_FSR_AFF_SHIFT)
+#define CB_FSR_PF     (CB_FSR_PF_MASK     << CB_FSR_PF_SHIFT)
+#define CB_FSR_EF     (CB_FSR_EF_MASK     << CB_FSR_EF_SHIFT)
+#define CB_FSR_TLBMCF (CB_FSR_TLBMCF_MASK << CB_FSR_TLBMCF_SHIFT)
+#define CB_FSR_TLBLKF (CB_FSR_TLBLKF_MASK << CB_FSR_TLBLKF_SHIFT)
+#define CB_FSR_SS     (CB_FSR_SS_MASK     << CB_FSR_SS_SHIFT)
+#define CB_FSR_MULTI  (CB_FSR_MULTI_MASK  << CB_FSR_MULTI_SHIFT)
+
+/* Fault Syndrome Register 0: CB_FSYNR0 */
+#define CB_FSYNR0_PLVL     (CB_FSYNR0_PLVL_MASK    << CB_FSYNR0_PLVL_SHIFT)
+#define CB_FSYNR0_S1PTWF   (CB_FSYNR0_S1PTWF_MASK  << CB_FSYNR0_S1PTWF_SHIFT)
+#define CB_FSYNR0_WNR      (CB_FSYNR0_WNR_MASK     << CB_FSYNR0_WNR_SHIFT)
+#define CB_FSYNR0_PNU      (CB_FSYNR0_PNU_MASK     << CB_FSYNR0_PNU_SHIFT)
+#define CB_FSYNR0_IND      (CB_FSYNR0_IND_MASK     << CB_FSYNR0_IND_SHIFT)
+#define CB_FSYNR0_NSSTATE  (CB_FSYNR0_NSSTATE_MASK << CB_FSYNR0_NSSTATE_SHIFT)
+#define CB_FSYNR0_NSATTR   (CB_FSYNR0_NSATTR_MASK  << CB_FSYNR0_NSATTR_SHIFT)
+#define CB_FSYNR0_ATOF     (CB_FSYNR0_ATOF_MASK    << CB_FSYNR0_ATOF_SHIFT)
+#define CB_FSYNR0_PTWF     (CB_FSYNR0_PTWF_MASK    << CB_FSYNR0_PTWF_SHIFT)
+#define CB_FSYNR0_AFR      (CB_FSYNR0_AFR_MASK     << CB_FSYNR0_AFR_SHIFT)
+#define CB_FSYNR0_S1CBNDX  (CB_FSYNR0_S1CBNDX_MASK << CB_FSYNR0_S1CBNDX_SHIFT)
+
+/* Normal Memory Remap Register: CB_NMRR */
+#define CB_NMRR_IR0        (CB_NMRR_IR0_MASK   << CB_NMRR_IR0_SHIFT)
+#define CB_NMRR_IR1        (CB_NMRR_IR1_MASK   << CB_NMRR_IR1_SHIFT)
+#define CB_NMRR_IR2        (CB_NMRR_IR2_MASK   << CB_NMRR_IR2_SHIFT)
+#define CB_NMRR_IR3        (CB_NMRR_IR3_MASK   << CB_NMRR_IR3_SHIFT)
+#define CB_NMRR_IR4        (CB_NMRR_IR4_MASK   << CB_NMRR_IR4_SHIFT)
+#define CB_NMRR_IR5        (CB_NMRR_IR5_MASK   << CB_NMRR_IR5_SHIFT)
+#define CB_NMRR_IR6        (CB_NMRR_IR6_MASK   << CB_NMRR_IR6_SHIFT)
+#define CB_NMRR_IR7        (CB_NMRR_IR7_MASK   << CB_NMRR_IR7_SHIFT)
+#define CB_NMRR_OR0        (CB_NMRR_OR0_MASK   << CB_NMRR_OR0_SHIFT)
+#define CB_NMRR_OR1        (CB_NMRR_OR1_MASK   << CB_NMRR_OR1_SHIFT)
+#define CB_NMRR_OR2        (CB_NMRR_OR2_MASK   << CB_NMRR_OR2_SHIFT)
+#define CB_NMRR_OR3        (CB_NMRR_OR3_MASK   << CB_NMRR_OR3_SHIFT)
+#define CB_NMRR_OR4        (CB_NMRR_OR4_MASK   << CB_NMRR_OR4_SHIFT)
+#define CB_NMRR_OR5        (CB_NMRR_OR5_MASK   << CB_NMRR_OR5_SHIFT)
+#define CB_NMRR_OR6        (CB_NMRR_OR6_MASK   << CB_NMRR_OR6_SHIFT)
+#define CB_NMRR_OR7        (CB_NMRR_OR7_MASK   << CB_NMRR_OR7_SHIFT)
+
+/* Physical Address Register: CB_PAR */
+#define CB_PAR_F           (CB_PAR_F_MASK      << CB_PAR_F_SHIFT)
+#define CB_PAR_SS          (CB_PAR_SS_MASK     << CB_PAR_SS_SHIFT)
+#define CB_PAR_OUTER       (CB_PAR_OUTER_MASK  << CB_PAR_OUTER_SHIFT)
+#define CB_PAR_INNER       (CB_PAR_INNER_MASK  << CB_PAR_INNER_SHIFT)
+#define CB_PAR_SH          (CB_PAR_SH_MASK     << CB_PAR_SH_SHIFT)
+#define CB_PAR_NS          (CB_PAR_NS_MASK     << CB_PAR_NS_SHIFT)
+#define CB_PAR_NOS         (CB_PAR_NOS_MASK    << CB_PAR_NOS_SHIFT)
+#define CB_PAR_PA          (CB_PAR_PA_MASK     << CB_PAR_PA_SHIFT)
+#define CB_PAR_TF          (CB_PAR_TF_MASK     << CB_PAR_TF_SHIFT)
+#define CB_PAR_AFF         (CB_PAR_AFF_MASK    << CB_PAR_AFF_SHIFT)
+#define CB_PAR_PF          (CB_PAR_PF_MASK     << CB_PAR_PF_SHIFT)
+#define CB_PAR_EF          (CB_PAR_EF_MASK     << CB_PAR_EF_SHIFT)
+#define CB_PAR_TLBMCF      (CB_PAR_TLBMCF_MASK << CB_PAR_TLBMCF_SHIFT)
+#define CB_PAR_TLBLKF      (CB_PAR_TLBLKF_MASK << CB_PAR_TLBLKF_SHIFT)
+#define CB_PAR_ATOT        (CB_PAR_ATOT_MASK   << CB_PAR_ATOT_SHIFT)
+#define CB_PAR_PLVL        (CB_PAR_PLVL_MASK   << CB_PAR_PLVL_SHIFT)
+#define CB_PAR_STAGE       (CB_PAR_STAGE_MASK  << CB_PAR_STAGE_SHIFT)
+
+/* Primary Region Remap Register: CB_PRRR */
+#define CB_PRRR_TR0        (CB_PRRR_TR0_MASK   << CB_PRRR_TR0_SHIFT)
+#define CB_PRRR_TR1        (CB_PRRR_TR1_MASK   << CB_PRRR_TR1_SHIFT)
+#define CB_PRRR_TR2        (CB_PRRR_TR2_MASK   << CB_PRRR_TR2_SHIFT)
+#define CB_PRRR_TR3        (CB_PRRR_TR3_MASK   << CB_PRRR_TR3_SHIFT)
+#define CB_PRRR_TR4        (CB_PRRR_TR4_MASK   << CB_PRRR_TR4_SHIFT)
+#define CB_PRRR_TR5        (CB_PRRR_TR5_MASK   << CB_PRRR_TR5_SHIFT)
+#define CB_PRRR_TR6        (CB_PRRR_TR6_MASK   << CB_PRRR_TR6_SHIFT)
+#define CB_PRRR_TR7        (CB_PRRR_TR7_MASK   << CB_PRRR_TR7_SHIFT)
+#define CB_PRRR_DS0        (CB_PRRR_DS0_MASK   << CB_PRRR_DS0_SHIFT)
+#define CB_PRRR_DS1        (CB_PRRR_DS1_MASK   << CB_PRRR_DS1_SHIFT)
+#define CB_PRRR_NS0        (CB_PRRR_NS0_MASK   << CB_PRRR_NS0_SHIFT)
+#define CB_PRRR_NS1        (CB_PRRR_NS1_MASK   << CB_PRRR_NS1_SHIFT)
+#define CB_PRRR_NOS0       (CB_PRRR_NOS0_MASK  << CB_PRRR_NOS0_SHIFT)
+#define CB_PRRR_NOS1       (CB_PRRR_NOS1_MASK  << CB_PRRR_NOS1_SHIFT)
+#define CB_PRRR_NOS2       (CB_PRRR_NOS2_MASK  << CB_PRRR_NOS2_SHIFT)
+#define CB_PRRR_NOS3       (CB_PRRR_NOS3_MASK  << CB_PRRR_NOS3_SHIFT)
+#define CB_PRRR_NOS4       (CB_PRRR_NOS4_MASK  << CB_PRRR_NOS4_SHIFT)
+#define CB_PRRR_NOS5       (CB_PRRR_NOS5_MASK  << CB_PRRR_NOS5_SHIFT)
+#define CB_PRRR_NOS6       (CB_PRRR_NOS6_MASK  << CB_PRRR_NOS6_SHIFT)
+#define CB_PRRR_NOS7       (CB_PRRR_NOS7_MASK  << CB_PRRR_NOS7_SHIFT)
+
+/* Transaction Resume: CB_RESUME */
+#define CB_RESUME_TNR      (CB_RESUME_TNR_MASK << CB_RESUME_TNR_SHIFT)
+
+/* System Control Register: CB_SCTLR */
+#define CB_SCTLR_M           (CB_SCTLR_M_MASK       << CB_SCTLR_M_SHIFT)
+#define CB_SCTLR_TRE         (CB_SCTLR_TRE_MASK     << CB_SCTLR_TRE_SHIFT)
+#define CB_SCTLR_AFE         (CB_SCTLR_AFE_MASK     << CB_SCTLR_AFE_SHIFT)
+#define CB_SCTLR_AFFD        (CB_SCTLR_AFFD_MASK    << CB_SCTLR_AFFD_SHIFT)
+#define CB_SCTLR_E           (CB_SCTLR_E_MASK       << CB_SCTLR_E_SHIFT)
+#define CB_SCTLR_CFRE        (CB_SCTLR_CFRE_MASK    << CB_SCTLR_CFRE_SHIFT)
+#define CB_SCTLR_CFIE        (CB_SCTLR_CFIE_MASK    << CB_SCTLR_CFIE_SHIFT)
+#define CB_SCTLR_CFCFG       (CB_SCTLR_CFCFG_MASK   << CB_SCTLR_CFCFG_SHIFT)
+#define CB_SCTLR_HUPCF       (CB_SCTLR_HUPCF_MASK   << CB_SCTLR_HUPCF_SHIFT)
+#define CB_SCTLR_WXN         (CB_SCTLR_WXN_MASK     << CB_SCTLR_WXN_SHIFT)
+#define CB_SCTLR_UWXN        (CB_SCTLR_UWXN_MASK    << CB_SCTLR_UWXN_SHIFT)
+#define CB_SCTLR_ASIDPNE     (CB_SCTLR_ASIDPNE_MASK << CB_SCTLR_ASIDPNE_SHIFT)
+#define CB_SCTLR_TRANSIENTCFG (CB_SCTLR_TRANSIENTCFG_MASK << \
+						CB_SCTLR_TRANSIENTCFG_SHIFT)
+#define CB_SCTLR_MEMATTR     (CB_SCTLR_MEMATTR_MASK << CB_SCTLR_MEMATTR_SHIFT)
+#define CB_SCTLR_MTCFG       (CB_SCTLR_MTCFG_MASK   << CB_SCTLR_MTCFG_SHIFT)
+#define CB_SCTLR_SHCFG       (CB_SCTLR_SHCFG_MASK   << CB_SCTLR_SHCFG_SHIFT)
+#define CB_SCTLR_RACFG       (CB_SCTLR_RACFG_MASK   << CB_SCTLR_RACFG_SHIFT)
+#define CB_SCTLR_WACFG       (CB_SCTLR_WACFG_MASK   << CB_SCTLR_WACFG_SHIFT)
+#define CB_SCTLR_NSCFG       (CB_SCTLR_NSCFG_MASK   << CB_SCTLR_NSCFG_SHIFT)
+
+/* Invalidate TLB by ASID: CB_TLBIASID */
+#define CB_TLBIASID_ASID     (CB_TLBIASID_ASID_MASK << CB_TLBIASID_ASID_SHIFT)
+
+/* Invalidate TLB by VA: CB_TLBIVA */
+#define CB_TLBIVA_ASID       (CB_TLBIVA_ASID_MASK   << CB_TLBIVA_ASID_SHIFT)
+#define CB_TLBIVA_VA         (CB_TLBIVA_VA_MASK     << CB_TLBIVA_VA_SHIFT)
+
+/* Invalidate TLB by VA, All ASID: CB_TLBIVAA */
+#define CB_TLBIVAA_VA        (CB_TLBIVAA_VA_MASK    << CB_TLBIVAA_VA_SHIFT)
+
+/* Invalidate TLB by VA, All ASID, Last Level: CB_TLBIVAAL */
+#define CB_TLBIVAAL_VA       (CB_TLBIVAAL_VA_MASK   << CB_TLBIVAAL_VA_SHIFT)
+
+/* Invalidate TLB by VA, Last Level: CB_TLBIVAL */
+#define CB_TLBIVAL_ASID      (CB_TLBIVAL_ASID_MASK  << CB_TLBIVAL_ASID_SHIFT)
+#define CB_TLBIVAL_VA        (CB_TLBIVAL_VA_MASK    << CB_TLBIVAL_VA_SHIFT)
+
+/* TLB Status: CB_TLBSTATUS */
+#define CB_TLBSTATUS_SACTIVE (CB_TLBSTATUS_SACTIVE_MASK << \
+						CB_TLBSTATUS_SACTIVE_SHIFT)
+
+/* Translation Table Base Control Register: CB_TTBCR */
+#define CB_TTBCR_EAE         (CB_TTBCR_EAE_MASK     << CB_TTBCR_EAE_SHIFT)
+
+#define CB_TTBR0_ADDR        (CB_TTBR0_ADDR_MASK    << CB_TTBR0_ADDR_SHIFT)
+
+/* Translation Table Base Register 0: CB_TTBR0 */
+#define CB_TTBR0_IRGN1       (CB_TTBR0_IRGN1_MASK   << CB_TTBR0_IRGN1_SHIFT)
+#define CB_TTBR0_S           (CB_TTBR0_S_MASK       << CB_TTBR0_S_SHIFT)
+#define CB_TTBR0_RGN         (CB_TTBR0_RGN_MASK     << CB_TTBR0_RGN_SHIFT)
+#define CB_TTBR0_NOS         (CB_TTBR0_NOS_MASK     << CB_TTBR0_NOS_SHIFT)
+#define CB_TTBR0_IRGN0       (CB_TTBR0_IRGN0_MASK   << CB_TTBR0_IRGN0_SHIFT)
+
+/* Translation Table Base Register 1: CB_TTBR1 */
+#define CB_TTBR1_IRGN1       (CB_TTBR1_IRGN1_MASK   << CB_TTBR1_IRGN1_SHIFT)
+#define CB_TTBR1_S           (CB_TTBR1_S_MASK       << CB_TTBR1_S_SHIFT)
+#define CB_TTBR1_RGN         (CB_TTBR1_RGN_MASK     << CB_TTBR1_RGN_SHIFT)
+#define CB_TTBR1_NOS         (CB_TTBR1_NOS_MASK     << CB_TTBR1_NOS_SHIFT)
+#define CB_TTBR1_IRGN0       (CB_TTBR1_IRGN0_MASK   << CB_TTBR1_IRGN0_SHIFT)
+
+/* Global Register Masks */
+/* Configuration Register 0 */
+#define CR0_NSCFG_MASK          0x03
+#define CR0_WACFG_MASK          0x03
+#define CR0_RACFG_MASK          0x03
+#define CR0_SHCFG_MASK          0x03
+#define CR0_SMCFCFG_MASK        0x01
+#define NSCR0_SMCFCFG_MASK      0x01
+#define CR0_MTCFG_MASK          0x01
+#define CR0_MEMATTR_MASK        0x0F
+#define CR0_BSU_MASK            0x03
+#define CR0_FB_MASK             0x01
+#define CR0_PTM_MASK            0x01
+#define CR0_VMIDPNE_MASK        0x01
+#define CR0_USFCFG_MASK         0x01
+#define NSCR0_USFCFG_MASK       0x01
+#define CR0_GSE_MASK            0x01
+#define CR0_STALLD_MASK         0x01
+#define NSCR0_STALLD_MASK       0x01
+#define CR0_TRANSIENTCFG_MASK   0x03
+#define CR0_GCFGFIE_MASK        0x01
+#define NSCR0_GCFGFIE_MASK      0x01
+#define CR0_GCFGFRE_MASK        0x01
+#define NSCR0_GCFGFRE_MASK      0x01
+#define CR0_GFIE_MASK           0x01
+#define NSCR0_GFIE_MASK         0x01
+#define CR0_GFRE_MASK           0x01
+#define NSCR0_GFRE_MASK         0x01
+#define CR0_CLIENTPD_MASK       0x01
+#define NSCR0_CLIENTPD_MASK     0x01
+
+/* ACR */
+#define ACR_SMTNMC_BPTLBEN_MASK   0x01
+#define ACR_MMUDIS_BPTLBEN_MASK   0x01
+#define ACR_S2CR_BPTLBEN_MASK     0x01
+
+/* NSACR */
+#define NSACR_SMTNMC_BPTLBEN_MASK   0x01
+#define NSACR_MMUDIS_BPTLBEN_MASK   0x01
+#define NSACR_S2CR_BPTLBEN_MASK     0x01
+
+/* Configuration Register 2 */
+#define CR2_BPVMID_MASK         0xFF
+
+/* Global Address Translation, Stage 1, Privileged Read: GATS1PR */
+#define GATS1PR_ADDR_MASK       0xFFFFF
+#define GATS1PR_NDX_MASK        0xFF
+
+/* Global Address Translation, Stage 1, Privileged Write: GATS1PW */
+#define GATS1PW_ADDR_MASK       0xFFFFF
+#define GATS1PW_NDX_MASK        0xFF
+
+/* Global Address Translation, Stage 1, User Read: GATS1UR */
+#define GATS1UR_ADDR_MASK       0xFFFFF
+#define GATS1UR_NDX_MASK        0xFF
+
+/* Global Address Translation, Stage 1, User Write: GATS1UW */
+#define GATS1UW_ADDR_MASK       0xFFFFF
+#define GATS1UW_NDX_MASK        0xFF
+
+/* Global Address Translation, Stage 1 and 2, Privileged Read: GATS1PR */
+#define GATS12PR_ADDR_MASK      0xFFFFF
+#define GATS12PR_NDX_MASK       0xFF
+
+/* Global Address Translation, Stage 1 and 2, Privileged Write: GATS1PW */
+#define GATS12PW_ADDR_MASK      0xFFFFF
+#define GATS12PW_NDX_MASK       0xFF
+
+/* Global Address Translation, Stage 1 and 2, User Read: GATS1UR */
+#define GATS12UR_ADDR_MASK      0xFFFFF
+#define GATS12UR_NDX_MASK       0xFF
+
+/* Global Address Translation, Stage 1 and 2, User Write: GATS1UW */
+#define GATS12UW_ADDR_MASK      0xFFFFF
+#define GATS12UW_NDX_MASK       0xFF
+
+/* Global Address Translation Status Register: GATSR */
+#define GATSR_ACTIVE_MASK       0x01
+
+/* Global Fault Address Register: GFAR */
+#define GFAR_FADDR_MASK         0xFFFFFFFF
+
+/* Global Fault Status Register: GFSR */
+#define GFSR_ICF_MASK           0x01
+#define GFSR_USF_MASK           0x01
+#define GFSR_SMCF_MASK          0x01
+#define GFSR_UCBF_MASK          0x01
+#define GFSR_UCIF_MASK          0x01
+#define GFSR_CAF_MASK           0x01
+#define GFSR_EF_MASK            0x01
+#define GFSR_PF_MASK            0x01
+#define GFSR_MULTI_MASK         0x01
+
+/* Global Fault Syndrome Register 0: GFSYNR0 */
+#define GFSYNR0_NESTED_MASK     0x01
+#define GFSYNR0_WNR_MASK        0x01
+#define GFSYNR0_PNU_MASK        0x01
+#define GFSYNR0_IND_MASK        0x01
+#define GFSYNR0_NSSTATE_MASK    0x01
+#define GFSYNR0_NSATTR_MASK     0x01
+
+/* Global Fault Syndrome Register 1: GFSYNR1 */
+#define GFSYNR1_SID_MASK        0x7FFF
+#define GFSYNr1_SSD_IDX_MASK    0x7FFF
+
+/* Global Physical Address Register: GPAR */
+#define GPAR_F_MASK             0x01
+#define GPAR_SS_MASK            0x01
+#define GPAR_OUTER_MASK         0x03
+#define GPAR_INNER_MASK         0x03
+#define GPAR_SH_MASK            0x01
+#define GPAR_NS_MASK            0x01
+#define GPAR_NOS_MASK           0x01
+#define GPAR_PA_MASK            0xFFFFF
+#define GPAR_TF_MASK            0x01
+#define GPAR_AFF_MASK           0x01
+#define GPAR_PF_MASK            0x01
+#define GPAR_EF_MASK            0x01
+#define GPAR_TLBMCF_MASK        0x01
+#define GPAR_TLBLKF_MASK        0x01
+#define GPAR_UCBF_MASK          0x01
+
+/* Identification Register: IDR0 */
+#define IDR0_NUMSMRG_MASK       0xFF
+#define IDR0_NUMSIDB_MASK       0x0F
+#define IDR0_BTM_MASK           0x01
+#define IDR0_CTTW_MASK          0x01
+#define IDR0_NUMIPRT_MASK       0xFF
+#define IDR0_PTFS_MASK          0x01
+#define IDR0_SMS_MASK           0x01
+#define IDR0_NTS_MASK           0x01
+#define IDR0_S2TS_MASK          0x01
+#define IDR0_S1TS_MASK          0x01
+#define IDR0_SES_MASK           0x01
+
+/* Identification Register: IDR1 */
+#define IDR1_NUMCB_MASK         0xFF
+#define IDR1_NUMSSDNDXB_MASK    0x0F
+#define IDR1_SSDTP_MASK         0x01
+#define IDR1_SMCD_MASK          0x01
+#define IDR1_NUMS2CB_MASK       0xFF
+#define IDR1_NUMPAGENDXB_MASK   0x07
+#define IDR1_PAGESIZE_MASK      0x01
+
+/* Identification Register: IDR2 */
+#define IDR2_IAS_MASK           0x0F
+#define IDR2_OAS_MASK           0x0F
+
+/* Identification Register: IDR7 */
+#define IDR7_MINOR_MASK         0x0F
+#define IDR7_MAJOR_MASK         0x0F
+
+/* Stream to Context Register: S2CR */
+#define S2CR_CBNDX_MASK         0xFF
+#define S2CR_SHCFG_MASK         0x03
+#define S2CR_MTCFG_MASK         0x01
+#define S2CR_MEMATTR_MASK       0x0F
+#define S2CR_TYPE_MASK          0x03
+#define S2CR_NSCFG_MASK         0x03
+#define S2CR_RACFG_MASK         0x03
+#define S2CR_WACFG_MASK         0x03
+#define S2CR_PRIVCFG_MASK       0x03
+#define S2CR_INSTCFG_MASK       0x03
+#define S2CR_TRANSIENTCFG_MASK  0x03
+#define S2CR_VMID_MASK          0xFF
+#define S2CR_BSU_MASK           0x03
+#define S2CR_FB_MASK            0x01
+
+/* Stream Match Register: SMR */
+#define SMR_ID_MASK             0x7FFF
+#define SMR_MASK_MASK           0x7FFF
+#define SMR_VALID_MASK          0x01
+
+/* Global TLB Status: TLBGSTATUS */
+#define TLBGSTATUS_GSACTIVE_MASK 0x01
+
+/* Invalidate Hyp TLB by VA: TLBIVAH */
+#define TLBIVAH_ADDR_MASK       0xFFFFF
+
+/* Invalidate TLB by VMID: TLBIVMID */
+#define TLBIVMID_VMID_MASK      0xFF
+
+/* Global Register Space 1 Mask */
+/* Context Bank Attribute Register: CBAR */
+#define CBAR_VMID_MASK          0xFF
+#define CBAR_CBNDX_MASK         0x03
+#define CBAR_BPSHCFG_MASK       0x03
+#define CBAR_HYPC_MASK          0x01
+#define CBAR_FB_MASK            0x01
+#define CBAR_MEMATTR_MASK       0x0F
+#define CBAR_TYPE_MASK          0x03
+#define CBAR_BSU_MASK           0x03
+#define CBAR_RACFG_MASK         0x03
+#define CBAR_WACFG_MASK         0x03
+#define CBAR_IRPTNDX_MASK       0xFF
+
+/* Context Bank Fault Restricted Syndrome Register A: CBFRSYNRA */
+#define CBFRSYNRA_SID_MASK      0x7FFF
+
+/* Implementation defined register space masks */
+#define MICRO_MMU_CTRL_RESERVED_MASK          0x03
+#define MICRO_MMU_CTRL_HALT_REQ_MASK          0x01
+#define MICRO_MMU_CTRL_IDLE_MASK              0x01
+
+/* Stage 1 Context Bank Format Masks */
+/* Auxiliary Control Register: CB_ACTLR */
+#define CB_ACTLR_REQPRIORITY_MASK    0x3
+#define CB_ACTLR_REQPRIORITYCFG_MASK 0x1
+#define CB_ACTLR_PRIVCFG_MASK        0x3
+#define CB_ACTLR_BPRCOSH_MASK        0x1
+#define CB_ACTLR_BPRCISH_MASK        0x1
+#define CB_ACTLR_BPRCNSH_MASK        0x1
+
+/* Address Translation, Stage 1, Privileged Read: CB_ATS1PR */
+#define CB_ATS1PR_ADDR_MASK     0xFFFFF
+
+/* Address Translation, Stage 1, Privileged Write: CB_ATS1PW */
+#define CB_ATS1PW_ADDR_MASK     0xFFFFF
+
+/* Address Translation, Stage 1, User Read: CB_ATS1UR */
+#define CB_ATS1UR_ADDR_MASK     0xFFFFF
+
+/* Address Translation, Stage 1, User Write: CB_ATS1UW */
+#define CB_ATS1UW_ADDR_MASK     0xFFFFF
+
+/* Address Translation Status Register: CB_ATSR */
+#define CB_ATSR_ACTIVE_MASK     0x01
+
+/* Context ID Register: CB_CONTEXTIDR */
+#define CB_CONTEXTIDR_ASID_MASK   0xFF
+#define CB_CONTEXTIDR_PROCID_MASK 0xFFFFFF
+
+/* Fault Address Register: CB_FAR */
+#define CB_FAR_FADDR_MASK       0xFFFFFFFF
+
+/* Fault Status Register: CB_FSR */
+#define CB_FSR_TF_MASK          0x01
+#define CB_FSR_AFF_MASK         0x01
+#define CB_FSR_PF_MASK          0x01
+#define CB_FSR_EF_MASK          0x01
+#define CB_FSR_TLBMCF_MASK      0x01
+#define CB_FSR_TLBLKF_MASK      0x01
+#define CB_FSR_SS_MASK          0x01
+#define CB_FSR_MULTI_MASK       0x01
+
+/* Fault Syndrome Register 0: CB_FSYNR0 */
+#define CB_FSYNR0_PLVL_MASK     0x03
+#define CB_FSYNR0_S1PTWF_MASK   0x01
+#define CB_FSYNR0_WNR_MASK      0x01
+#define CB_FSYNR0_PNU_MASK      0x01
+#define CB_FSYNR0_IND_MASK      0x01
+#define CB_FSYNR0_NSSTATE_MASK  0x01
+#define CB_FSYNR0_NSATTR_MASK   0x01
+#define CB_FSYNR0_ATOF_MASK     0x01
+#define CB_FSYNR0_PTWF_MASK     0x01
+#define CB_FSYNR0_AFR_MASK      0x01
+#define CB_FSYNR0_S1CBNDX_MASK  0xFF
+
+/* Normal Memory Remap Register: CB_NMRR */
+#define CB_NMRR_IR0_MASK        0x03
+#define CB_NMRR_IR1_MASK        0x03
+#define CB_NMRR_IR2_MASK        0x03
+#define CB_NMRR_IR3_MASK        0x03
+#define CB_NMRR_IR4_MASK        0x03
+#define CB_NMRR_IR5_MASK        0x03
+#define CB_NMRR_IR6_MASK        0x03
+#define CB_NMRR_IR7_MASK        0x03
+#define CB_NMRR_OR0_MASK        0x03
+#define CB_NMRR_OR1_MASK        0x03
+#define CB_NMRR_OR2_MASK        0x03
+#define CB_NMRR_OR3_MASK        0x03
+#define CB_NMRR_OR4_MASK        0x03
+#define CB_NMRR_OR5_MASK        0x03
+#define CB_NMRR_OR6_MASK        0x03
+#define CB_NMRR_OR7_MASK        0x03
+
+/* Physical Address Register: CB_PAR */
+#define CB_PAR_F_MASK           0x01
+#define CB_PAR_SS_MASK          0x01
+#define CB_PAR_OUTER_MASK       0x03
+#define CB_PAR_INNER_MASK       0x07
+#define CB_PAR_SH_MASK          0x01
+#define CB_PAR_NS_MASK          0x01
+#define CB_PAR_NOS_MASK         0x01
+#define CB_PAR_PA_MASK          0xFFFFF
+#define CB_PAR_TF_MASK          0x01
+#define CB_PAR_AFF_MASK         0x01
+#define CB_PAR_PF_MASK          0x01
+#define CB_PAR_EF_MASK          0x01
+#define CB_PAR_TLBMCF_MASK      0x01
+#define CB_PAR_TLBLKF_MASK      0x01
+#define CB_PAR_ATOT_MASK        0x01ULL
+#define CB_PAR_PLVL_MASK        0x03ULL
+#define CB_PAR_STAGE_MASK       0x01ULL
+
+/* Primary Region Remap Register: CB_PRRR */
+#define CB_PRRR_TR0_MASK        0x03
+#define CB_PRRR_TR1_MASK        0x03
+#define CB_PRRR_TR2_MASK        0x03
+#define CB_PRRR_TR3_MASK        0x03
+#define CB_PRRR_TR4_MASK        0x03
+#define CB_PRRR_TR5_MASK        0x03
+#define CB_PRRR_TR6_MASK        0x03
+#define CB_PRRR_TR7_MASK        0x03
+#define CB_PRRR_DS0_MASK        0x01
+#define CB_PRRR_DS1_MASK        0x01
+#define CB_PRRR_NS0_MASK        0x01
+#define CB_PRRR_NS1_MASK        0x01
+#define CB_PRRR_NOS0_MASK       0x01
+#define CB_PRRR_NOS1_MASK       0x01
+#define CB_PRRR_NOS2_MASK       0x01
+#define CB_PRRR_NOS3_MASK       0x01
+#define CB_PRRR_NOS4_MASK       0x01
+#define CB_PRRR_NOS5_MASK       0x01
+#define CB_PRRR_NOS6_MASK       0x01
+#define CB_PRRR_NOS7_MASK       0x01
+
+/* Transaction Resume: CB_RESUME */
+#define CB_RESUME_TNR_MASK      0x01
+
+/* System Control Register: CB_SCTLR */
+#define CB_SCTLR_M_MASK            0x01
+#define CB_SCTLR_TRE_MASK          0x01
+#define CB_SCTLR_AFE_MASK          0x01
+#define CB_SCTLR_AFFD_MASK         0x01
+#define CB_SCTLR_E_MASK            0x01
+#define CB_SCTLR_CFRE_MASK         0x01
+#define CB_SCTLR_CFIE_MASK         0x01
+#define CB_SCTLR_CFCFG_MASK        0x01
+#define CB_SCTLR_HUPCF_MASK        0x01
+#define CB_SCTLR_WXN_MASK          0x01
+#define CB_SCTLR_UWXN_MASK         0x01
+#define CB_SCTLR_ASIDPNE_MASK      0x01
+#define CB_SCTLR_TRANSIENTCFG_MASK 0x03
+#define CB_SCTLR_MEMATTR_MASK      0x0F
+#define CB_SCTLR_MTCFG_MASK        0x01
+#define CB_SCTLR_SHCFG_MASK        0x03
+#define CB_SCTLR_RACFG_MASK        0x03
+#define CB_SCTLR_WACFG_MASK        0x03
+#define CB_SCTLR_NSCFG_MASK        0x03
+
+/* Invalidate TLB by ASID: CB_TLBIASID */
+#define CB_TLBIASID_ASID_MASK      0xFF
+
+/* Invalidate TLB by VA: CB_TLBIVA */
+#define CB_TLBIVA_ASID_MASK        0xFF
+#define CB_TLBIVA_VA_MASK          0xFFFFF
+
+/* Invalidate TLB by VA, All ASID: CB_TLBIVAA */
+#define CB_TLBIVAA_VA_MASK         0xFFFFF
+
+/* Invalidate TLB by VA, All ASID, Last Level: CB_TLBIVAAL */
+#define CB_TLBIVAAL_VA_MASK        0xFFFFF
+
+/* Invalidate TLB by VA, Last Level: CB_TLBIVAL */
+#define CB_TLBIVAL_ASID_MASK       0xFF
+#define CB_TLBIVAL_VA_MASK         0xFFFFF
+
+/* TLB Status: CB_TLBSTATUS */
+#define CB_TLBSTATUS_SACTIVE_MASK  0x01
+
+/* Translation Table Base Control Register: CB_TTBCR */
+#define CB_TTBCR_T0SZ_MASK         0x07
+#define CB_TTBCR_T1SZ_MASK         0x07
+#define CB_TTBCR_EPD0_MASK         0x01
+#define CB_TTBCR_EPD1_MASK         0x01
+#define CB_TTBCR_IRGN0_MASK        0x03
+#define CB_TTBCR_IRGN1_MASK        0x03
+#define CB_TTBCR_ORGN0_MASK        0x03
+#define CB_TTBCR_ORGN1_MASK        0x03
+#define CB_TTBCR_NSCFG0_MASK       0x01
+#define CB_TTBCR_NSCFG1_MASK       0x01
+#define CB_TTBCR_SH0_MASK          0x03
+#define CB_TTBCR_SH1_MASK          0x03
+#define CB_TTBCR_A1_MASK           0x01
+#define CB_TTBCR_EAE_MASK          0x01
+
+#define CB_TTBR0_IRGN1_MASK        0x01
+#define CB_TTBR0_S_MASK            0x01
+#define CB_TTBR0_RGN_MASK          0x01
+#define CB_TTBR0_NOS_MASK          0x01
+#define CB_TTBR0_IRGN0_MASK        0x01
+#define CB_TTBR0_ADDR_MASK         0xFFFFFF
+
+#define CB_TTBR1_IRGN1_MASK        0x1
+#define CB_TTBR1_S_MASK            0x1
+#define CB_TTBR1_RGN_MASK          0x1
+#define CB_TTBR1_NOS_MASK          0X1
+#define CB_TTBR1_IRGN0_MASK        0X1
+
+/* Global Register Shifts */
+/* Configuration Register: CR0 */
+#define CR0_NSCFG_SHIFT            28
+#define CR0_WACFG_SHIFT            26
+#define CR0_RACFG_SHIFT            24
+#define CR0_SHCFG_SHIFT            22
+#define CR0_SMCFCFG_SHIFT          21
+#define NSCR0_SMCFCFG_SHIFT        21
+#define CR0_MTCFG_SHIFT            20
+#define CR0_MEMATTR_SHIFT          16
+#define CR0_BSU_SHIFT              14
+#define CR0_FB_SHIFT               13
+#define CR0_PTM_SHIFT              12
+#define CR0_VMIDPNE_SHIFT          11
+#define CR0_USFCFG_SHIFT           10
+#define NSCR0_USFCFG_SHIFT         10
+#define CR0_GSE_SHIFT              9
+#define CR0_STALLD_SHIFT           8
+#define NSCR0_STALLD_SHIFT         8
+#define CR0_TRANSIENTCFG_SHIFT     6
+#define CR0_GCFGFIE_SHIFT          5
+#define NSCR0_GCFGFIE_SHIFT        5
+#define CR0_GCFGFRE_SHIFT          4
+#define NSCR0_GCFGFRE_SHIFT        4
+#define CR0_GFIE_SHIFT             2
+#define NSCR0_GFIE_SHIFT           2
+#define CR0_GFRE_SHIFT             1
+#define NSCR0_GFRE_SHIFT           1
+#define CR0_CLIENTPD_SHIFT         0
+#define NSCR0_CLIENTPD_SHIFT       0
+
+/* ACR */
+#define ACR_SMTNMC_BPTLBEN_SHIFT   8
+#define ACR_MMUDIS_BPTLBEN_SHIFT   9
+#define ACR_S2CR_BPTLBEN_SHIFT     10
+
+/* NSACR */
+#define NSACR_SMTNMC_BPTLBEN_SHIFT   8
+#define NSACR_MMUDIS_BPTLBEN_SHIFT   9
+#define NSACR_S2CR_BPTLBEN_SHIFT     10
+
+/* Configuration Register: CR2 */
+#define CR2_BPVMID_SHIFT           0
+
+/* Global Address Translation, Stage 1, Privileged Read: GATS1PR */
+#define GATS1PR_ADDR_SHIFT         12
+#define GATS1PR_NDX_SHIFT          0
+
+/* Global Address Translation, Stage 1, Privileged Write: GATS1PW */
+#define GATS1PW_ADDR_SHIFT         12
+#define GATS1PW_NDX_SHIFT          0
+
+/* Global Address Translation, Stage 1, User Read: GATS1UR */
+#define GATS1UR_ADDR_SHIFT         12
+#define GATS1UR_NDX_SHIFT          0
+
+/* Global Address Translation, Stage 1, User Write: GATS1UW */
+#define GATS1UW_ADDR_SHIFT         12
+#define GATS1UW_NDX_SHIFT          0
+
+/* Global Address Translation, Stage 1 and 2, Privileged Read: GATS12PR */
+#define GATS12PR_ADDR_SHIFT        12
+#define GATS12PR_NDX_SHIFT         0
+
+/* Global Address Translation, Stage 1 and 2, Privileged Write: GATS12PW */
+#define GATS12PW_ADDR_SHIFT        12
+#define GATS12PW_NDX_SHIFT         0
+
+/* Global Address Translation, Stage 1 and 2, User Read: GATS12UR */
+#define GATS12UR_ADDR_SHIFT        12
+#define GATS12UR_NDX_SHIFT         0
+
+/* Global Address Translation, Stage 1 and 2, User Write: GATS12UW */
+#define GATS12UW_ADDR_SHIFT        12
+#define GATS12UW_NDX_SHIFT         0
+
+/* Global Address Translation Status Register: GATSR */
+#define GATSR_ACTIVE_SHIFT         0
+
+/* Global Fault Address Register: GFAR */
+#define GFAR_FADDR_SHIFT           0
+
+/* Global Fault Status Register: GFSR */
+#define GFSR_ICF_SHIFT             0
+#define GFSR_USF_SHIFT             1
+#define GFSR_SMCF_SHIFT            2
+#define GFSR_UCBF_SHIFT            3
+#define GFSR_UCIF_SHIFT            4
+#define GFSR_CAF_SHIFT             5
+#define GFSR_EF_SHIFT              6
+#define GFSR_PF_SHIFT              7
+#define GFSR_MULTI_SHIFT           31
+
+/* Global Fault Syndrome Register 0: GFSYNR0 */
+#define GFSYNR0_NESTED_SHIFT       0
+#define GFSYNR0_WNR_SHIFT          1
+#define GFSYNR0_PNU_SHIFT          2
+#define GFSYNR0_IND_SHIFT          3
+#define GFSYNR0_NSSTATE_SHIFT      4
+#define GFSYNR0_NSATTR_SHIFT       5
+
+/* Global Fault Syndrome Register 1: GFSYNR1 */
+#define GFSYNR1_SID_SHIFT          0
+
+/* Global Physical Address Register: GPAR */
+#define GPAR_F_SHIFT               0
+#define GPAR_SS_SHIFT              1
+#define GPAR_OUTER_SHIFT           2
+#define GPAR_INNER_SHIFT           4
+#define GPAR_SH_SHIFT              7
+#define GPAR_NS_SHIFT              9
+#define GPAR_NOS_SHIFT             10
+#define GPAR_PA_SHIFT              12
+#define GPAR_TF_SHIFT              1
+#define GPAR_AFF_SHIFT             2
+#define GPAR_PF_SHIFT              3
+#define GPAR_EF_SHIFT              4
+#define GPAR_TLCMCF_SHIFT          5
+#define GPAR_TLBLKF_SHIFT          6
+#define GFAR_UCBF_SHIFT            30
+
+/* Identification Register: IDR0 */
+#define IDR0_NUMSMRG_SHIFT         0
+#define IDR0_NUMSIDB_SHIFT         9
+#define IDR0_BTM_SHIFT             13
+#define IDR0_CTTW_SHIFT            14
+#define IDR0_NUMIRPT_SHIFT         16
+#define IDR0_PTFS_SHIFT            24
+#define IDR0_SMS_SHIFT             27
+#define IDR0_NTS_SHIFT             28
+#define IDR0_S2TS_SHIFT            29
+#define IDR0_S1TS_SHIFT            30
+#define IDR0_SES_SHIFT             31
+
+/* Identification Register: IDR1 */
+#define IDR1_NUMCB_SHIFT           0
+#define IDR1_NUMSSDNDXB_SHIFT      8
+#define IDR1_SSDTP_SHIFT           12
+#define IDR1_SMCD_SHIFT            15
+#define IDR1_NUMS2CB_SHIFT         16
+#define IDR1_NUMPAGENDXB_SHIFT     28
+#define IDR1_PAGESIZE_SHIFT        31
+
+/* Identification Register: IDR2 */
+#define IDR2_IAS_SHIFT             0
+#define IDR2_OAS_SHIFT             4
+
+/* Identification Register: IDR7 */
+#define IDR7_MINOR_SHIFT           0
+#define IDR7_MAJOR_SHIFT           4
+
+/* Stream to Context Register: S2CR */
+#define S2CR_CBNDX_SHIFT           0
+#define s2CR_SHCFG_SHIFT           8
+#define S2CR_MTCFG_SHIFT           11
+#define S2CR_MEMATTR_SHIFT         12
+#define S2CR_TYPE_SHIFT            16
+#define S2CR_NSCFG_SHIFT           18
+#define S2CR_RACFG_SHIFT           20
+#define S2CR_WACFG_SHIFT           22
+#define S2CR_PRIVCFG_SHIFT         24
+#define S2CR_INSTCFG_SHIFT         26
+#define S2CR_TRANSIENTCFG_SHIFT    28
+#define S2CR_VMID_SHIFT            0
+#define S2CR_BSU_SHIFT             24
+#define S2CR_FB_SHIFT              26
+
+/* Stream Match Register: SMR */
+#define SMR_ID_SHIFT               0
+#define SMR_MASK_SHIFT             16
+#define SMR_VALID_SHIFT            31
+
+/* Global TLB Status: TLBGSTATUS */
+#define TLBGSTATUS_GSACTIVE_SHIFT  0
+
+/* Invalidate Hyp TLB by VA: TLBIVAH */
+#define TLBIVAH_ADDR_SHIFT         12
+
+/* Invalidate TLB by VMID: TLBIVMID */
+#define TLBIVMID_VMID_SHIFT        0
+
+/* Context Bank Attribute Register: CBAR */
+#define CBAR_VMID_SHIFT            0
+#define CBAR_CBNDX_SHIFT           8
+#define CBAR_BPSHCFG_SHIFT         8
+#define CBAR_HYPC_SHIFT            10
+#define CBAR_FB_SHIFT              11
+#define CBAR_MEMATTR_SHIFT         12
+#define CBAR_TYPE_SHIFT            16
+#define CBAR_BSU_SHIFT             18
+#define CBAR_RACFG_SHIFT           20
+#define CBAR_WACFG_SHIFT           22
+#define CBAR_IRPTNDX_SHIFT         24
+
+/* Context Bank Fault Restricted Syndrome Register A: CBFRSYNRA */
+#define CBFRSYNRA_SID_SHIFT        0
+
+/* Implementation defined register space shift */
+#define MICRO_MMU_CTRL_RESERVED_SHIFT         0x00
+#define MICRO_MMU_CTRL_HALT_REQ_SHIFT         0x02
+#define MICRO_MMU_CTRL_IDLE_SHIFT             0x03
+
+/* Stage 1 Context Bank Format Shifts */
+/* Auxiliary Control Register: CB_ACTLR */
+#define CB_ACTLR_REQPRIORITY_SHIFT     0
+#define CB_ACTLR_REQPRIORITYCFG_SHIFT  4
+#define CB_ACTLR_PRIVCFG_SHIFT         8
+#define CB_ACTLR_BPRCOSH_SHIFT         28
+#define CB_ACTLR_BPRCISH_SHIFT         29
+#define CB_ACTLR_BPRCNSH_SHIFT         30
+
+/* Address Translation, Stage 1, Privileged Read: CB_ATS1PR */
+#define CB_ATS1PR_ADDR_SHIFT       12
+
+/* Address Translation, Stage 1, Privileged Write: CB_ATS1PW */
+#define CB_ATS1PW_ADDR_SHIFT       12
+
+/* Address Translation, Stage 1, User Read: CB_ATS1UR */
+#define CB_ATS1UR_ADDR_SHIFT       12
+
+/* Address Translation, Stage 1, User Write: CB_ATS1UW */
+#define CB_ATS1UW_ADDR_SHIFT       12
+
+/* Address Translation Status Register: CB_ATSR */
+#define CB_ATSR_ACTIVE_SHIFT       0
+
+/* Context ID Register: CB_CONTEXTIDR */
+#define CB_CONTEXTIDR_ASID_SHIFT   0
+#define CB_CONTEXTIDR_PROCID_SHIFT 8
+
+/* Fault Address Register: CB_FAR */
+#define CB_FAR_FADDR_SHIFT         0
+
+/* Fault Status Register: CB_FSR */
+#define CB_FSR_TF_SHIFT            1
+#define CB_FSR_AFF_SHIFT           2
+#define CB_FSR_PF_SHIFT            3
+#define CB_FSR_EF_SHIFT            4
+#define CB_FSR_TLBMCF_SHIFT        5
+#define CB_FSR_TLBLKF_SHIFT        6
+#define CB_FSR_SS_SHIFT            30
+#define CB_FSR_MULTI_SHIFT         31
+
+/* Fault Syndrome Register 0: CB_FSYNR0 */
+#define CB_FSYNR0_PLVL_SHIFT       0
+#define CB_FSYNR0_S1PTWF_SHIFT     3
+#define CB_FSYNR0_WNR_SHIFT        4
+#define CB_FSYNR0_PNU_SHIFT        5
+#define CB_FSYNR0_IND_SHIFT        6
+#define CB_FSYNR0_NSSTATE_SHIFT    7
+#define CB_FSYNR0_NSATTR_SHIFT     8
+#define CB_FSYNR0_ATOF_SHIFT       9
+#define CB_FSYNR0_PTWF_SHIFT       10
+#define CB_FSYNR0_AFR_SHIFT        11
+#define CB_FSYNR0_S1CBNDX_SHIFT    16
+
+/* Normal Memory Remap Register: CB_NMRR */
+#define CB_NMRR_IR0_SHIFT          0
+#define CB_NMRR_IR1_SHIFT          2
+#define CB_NMRR_IR2_SHIFT          4
+#define CB_NMRR_IR3_SHIFT          6
+#define CB_NMRR_IR4_SHIFT          8
+#define CB_NMRR_IR5_SHIFT          10
+#define CB_NMRR_IR6_SHIFT          12
+#define CB_NMRR_IR7_SHIFT          14
+#define CB_NMRR_OR0_SHIFT          16
+#define CB_NMRR_OR1_SHIFT          18
+#define CB_NMRR_OR2_SHIFT          20
+#define CB_NMRR_OR3_SHIFT          22
+#define CB_NMRR_OR4_SHIFT          24
+#define CB_NMRR_OR5_SHIFT          26
+#define CB_NMRR_OR6_SHIFT          28
+#define CB_NMRR_OR7_SHIFT          30
+
+/* Physical Address Register: CB_PAR */
+#define CB_PAR_F_SHIFT             0
+#define CB_PAR_SS_SHIFT            1
+#define CB_PAR_OUTER_SHIFT         2
+#define CB_PAR_INNER_SHIFT         4
+#define CB_PAR_SH_SHIFT            7
+#define CB_PAR_NS_SHIFT            9
+#define CB_PAR_NOS_SHIFT           10
+#define CB_PAR_PA_SHIFT            12
+#define CB_PAR_TF_SHIFT            1
+#define CB_PAR_AFF_SHIFT           2
+#define CB_PAR_PF_SHIFT            3
+#define CB_PAR_EF_SHIFT            4
+#define CB_PAR_TLBMCF_SHIFT        5
+#define CB_PAR_TLBLKF_SHIFT        6
+#define CB_PAR_ATOT_SHIFT          31
+#define CB_PAR_PLVL_SHIFT          32
+#define CB_PAR_STAGE_SHIFT         35
+
+/* Primary Region Remap Register: CB_PRRR */
+#define CB_PRRR_TR0_SHIFT          0
+#define CB_PRRR_TR1_SHIFT          2
+#define CB_PRRR_TR2_SHIFT          4
+#define CB_PRRR_TR3_SHIFT          6
+#define CB_PRRR_TR4_SHIFT          8
+#define CB_PRRR_TR5_SHIFT          10
+#define CB_PRRR_TR6_SHIFT          12
+#define CB_PRRR_TR7_SHIFT          14
+#define CB_PRRR_DS0_SHIFT          16
+#define CB_PRRR_DS1_SHIFT          17
+#define CB_PRRR_NS0_SHIFT          18
+#define CB_PRRR_NS1_SHIFT          19
+#define CB_PRRR_NOS0_SHIFT         24
+#define CB_PRRR_NOS1_SHIFT         25
+#define CB_PRRR_NOS2_SHIFT         26
+#define CB_PRRR_NOS3_SHIFT         27
+#define CB_PRRR_NOS4_SHIFT         28
+#define CB_PRRR_NOS5_SHIFT         29
+#define CB_PRRR_NOS6_SHIFT         30
+#define CB_PRRR_NOS7_SHIFT         31
+
+/* Transaction Resume: CB_RESUME */
+#define CB_RESUME_TNR_SHIFT        0
+
+/* System Control Register: CB_SCTLR */
+#define CB_SCTLR_M_SHIFT            0
+#define CB_SCTLR_TRE_SHIFT          1
+#define CB_SCTLR_AFE_SHIFT          2
+#define CB_SCTLR_AFFD_SHIFT         3
+#define CB_SCTLR_E_SHIFT            4
+#define CB_SCTLR_CFRE_SHIFT         5
+#define CB_SCTLR_CFIE_SHIFT         6
+#define CB_SCTLR_CFCFG_SHIFT        7
+#define CB_SCTLR_HUPCF_SHIFT        8
+#define CB_SCTLR_WXN_SHIFT          9
+#define CB_SCTLR_UWXN_SHIFT         10
+#define CB_SCTLR_ASIDPNE_SHIFT      12
+#define CB_SCTLR_TRANSIENTCFG_SHIFT 14
+#define CB_SCTLR_MEMATTR_SHIFT      16
+#define CB_SCTLR_MTCFG_SHIFT        20
+#define CB_SCTLR_SHCFG_SHIFT        22
+#define CB_SCTLR_RACFG_SHIFT        24
+#define CB_SCTLR_WACFG_SHIFT        26
+#define CB_SCTLR_NSCFG_SHIFT        28
+
+/* Invalidate TLB by ASID: CB_TLBIASID */
+#define CB_TLBIASID_ASID_SHIFT      0
+
+/* Invalidate TLB by VA: CB_TLBIVA */
+#define CB_TLBIVA_ASID_SHIFT        0
+#define CB_TLBIVA_VA_SHIFT          12
+
+/* Invalidate TLB by VA, All ASID: CB_TLBIVAA */
+#define CB_TLBIVAA_VA_SHIFT         12
+
+/* Invalidate TLB by VA, All ASID, Last Level: CB_TLBIVAAL */
+#define CB_TLBIVAAL_VA_SHIFT        12
+
+/* Invalidate TLB by VA, Last Level: CB_TLBIVAL */
+#define CB_TLBIVAL_ASID_SHIFT       0
+#define CB_TLBIVAL_VA_SHIFT         12
+
+/* TLB Status: CB_TLBSTATUS */
+#define CB_TLBSTATUS_SACTIVE_SHIFT  0
+
+/* Translation Table Base Control Register: CB_TTBCR */
+#define CB_TTBCR_T0SZ_SHIFT          0
+#define CB_TTBCR_T1SZ_SHIFT         16
+#define CB_TTBCR_EPD0_SHIFT          4
+#define CB_TTBCR_EPD1_SHIFT          5
+#define CB_TTBCR_NSCFG0_SHIFT       14
+#define CB_TTBCR_NSCFG1_SHIFT       30
+#define CB_TTBCR_EAE_SHIFT          31
+#define CB_TTBCR_IRGN0_SHIFT         8
+#define CB_TTBCR_IRGN1_SHIFT        24
+#define CB_TTBCR_ORGN0_SHIFT        10
+#define CB_TTBCR_ORGN1_SHIFT        26
+#define CB_TTBCR_A1_SHIFT           22
+#define CB_TTBCR_SH0_SHIFT          12
+#define CB_TTBCR_SH1_SHIFT          28
+
+/* Translation Table Base Register 0/1: CB_TTBR */
+#define CB_TTBR0_IRGN1_SHIFT        0
+#define CB_TTBR0_S_SHIFT            1
+#define CB_TTBR0_RGN_SHIFT          3
+#define CB_TTBR0_NOS_SHIFT          5
+#define CB_TTBR0_IRGN0_SHIFT        6
+#define CB_TTBR0_ADDR_SHIFT         14
+
+#define CB_TTBR1_IRGN1_SHIFT        0
+#define CB_TTBR1_S_SHIFT            1
+#define CB_TTBR1_RGN_SHIFT          3
+#define CB_TTBR1_NOS_SHIFT          5
+#define CB_TTBR1_IRGN0_SHIFT        6
+#define CB_TTBR1_ADDR_SHIFT         14
+
+#endif
diff --git a/drivers/iommu/msm_iommu_pagetable.c b/drivers/iommu/msm_iommu_pagetable.c
new file mode 100644
index 0000000..88a3df0
--- /dev/null
+++ b/drivers/iommu/msm_iommu_pagetable.c
@@ -0,0 +1,600 @@
+/* Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/scatterlist.h>
+
+#include <asm/cacheflush.h>
+
+#include <linux/qcom_iommu.h>
+#include "msm_iommu_priv.h"
+#include "msm_iommu_pagetable.h"
+
+#define NUM_FL_PTE      4096
+#define NUM_SL_PTE      256
+#define GUARD_PTE       2
+#define NUM_TEX_CLASS   8
+
+/* First-level page table bits */
+#define FL_BASE_MASK            0xFFFFFC00
+#define FL_TYPE_TABLE           (1 << 0)
+#define FL_TYPE_SECT            (2 << 0)
+#define FL_SUPERSECTION         (1 << 18)
+#define FL_AP0                  (1 << 10)
+#define FL_AP1                  (1 << 11)
+#define FL_AP2                  (1 << 15)
+#define FL_SHARED               (1 << 16)
+#define FL_BUFFERABLE           (1 << 2)
+#define FL_CACHEABLE            (1 << 3)
+#define FL_TEX0                 (1 << 12)
+#define FL_OFFSET(va)           (((va) & 0xFFF00000) >> 20)
+#define FL_NG                   (1 << 17)
+
+/* Second-level page table bits */
+#define SL_BASE_MASK_LARGE      0xFFFF0000
+#define SL_BASE_MASK_SMALL      0xFFFFF000
+#define SL_TYPE_LARGE           (1 << 0)
+#define SL_TYPE_SMALL           (2 << 0)
+#define SL_AP0                  (1 << 4)
+#define SL_AP1                  (2 << 4)
+#define SL_AP2                  (1 << 9)
+#define SL_SHARED               (1 << 10)
+#define SL_BUFFERABLE           (1 << 2)
+#define SL_CACHEABLE            (1 << 3)
+#define SL_TEX0                 (1 << 6)
+#define SL_OFFSET(va)           (((va) & 0xFF000) >> 12)
+#define SL_NG                   (1 << 11)
+
+/* Memory type and cache policy attributes */
+#define MT_SO                   0
+#define MT_DEV                  1
+#define MT_IOMMU_NORMAL         2
+#define CP_NONCACHED            0
+#define CP_WB_WA                1
+#define CP_WT                   2
+#define CP_WB_NWA               3
+
+/* Sharability attributes of MSM IOMMU mappings */
+#define MSM_IOMMU_ATTR_NON_SH		0x0
+#define MSM_IOMMU_ATTR_SH		0x4
+
+/* Cacheability attributes of MSM IOMMU mappings */
+#define MSM_IOMMU_ATTR_NONCACHED	0x0
+#define MSM_IOMMU_ATTR_CACHED_WB_WA	0x1
+#define MSM_IOMMU_ATTR_CACHED_WB_NWA	0x2
+#define MSM_IOMMU_ATTR_CACHED_WT	0x3
+
+static int msm_iommu_tex_class[4];
+
+/* TEX Remap Registers */
+#define NMRR_ICP(nmrr, n) (((nmrr) & (3 << ((n) * 2))) >> ((n) * 2))
+#define NMRR_OCP(nmrr, n) (((nmrr) & (3 << ((n) * 2 + 16))) >> ((n) * 2 + 16))
+
+#define PRRR_NOS(prrr, n) ((prrr) & (1 << ((n) + 24)) ? 1 : 0)
+#define PRRR_MT(prrr, n)  ((((prrr) & (3 << ((n) * 2))) >> ((n) * 2)))
+
+static inline void clean_pte(u32 *start, u32 *end, int redirect)
+{
+	if (!redirect)
+		dmac_flush_range(start, end);
+}
+
+int msm_iommu_pagetable_alloc(struct msm_iommu_pt *pt)
+{
+	pt->fl_table = (u32 *)__get_free_pages(GFP_KERNEL,
+							  get_order(SZ_16K));
+	if (!pt->fl_table)
+		return -ENOMEM;
+
+	pt->fl_table_shadow = (u32 *)__get_free_pages(GFP_KERNEL,
+							  get_order(SZ_16K));
+	if (!pt->fl_table_shadow) {
+		free_pages((unsigned long)pt->fl_table, get_order(SZ_16K));
+		return -ENOMEM;
+	}
+
+	memset(pt->fl_table, 0, SZ_16K);
+	memset(pt->fl_table_shadow, 0, SZ_16K);
+	clean_pte(pt->fl_table, pt->fl_table + NUM_FL_PTE, pt->redirect);
+
+	return 0;
+}
+
+void msm_iommu_pagetable_free(struct msm_iommu_pt *pt)
+{
+	u32 *fl_table;
+	u32 *fl_table_shadow;
+	int i;
+
+	fl_table = pt->fl_table;
+	fl_table_shadow = pt->fl_table_shadow;
+	for (i = 0; i < NUM_FL_PTE; i++)
+		if ((fl_table[i] & 0x03) == FL_TYPE_TABLE)
+			free_page((unsigned long) __va(((fl_table[i]) &
+							FL_BASE_MASK)));
+	free_pages((unsigned long)fl_table, get_order(SZ_16K));
+	pt->fl_table = 0;
+
+	free_pages((unsigned long)fl_table_shadow, get_order(SZ_16K));
+	pt->fl_table_shadow = 0;
+}
+
+void msm_iommu_pagetable_free_tables(struct msm_iommu_pt *pt, unsigned long va,
+				 size_t len)
+{
+	/*
+	 * Adding 2 for worst case. We could be spanning 3 second level pages
+	 * if we unmapped just over 1MB.
+	 */
+	u32 n_entries = len / SZ_1M + 2;
+	u32 fl_offset = FL_OFFSET(va);
+	u32 i;
+
+	for (i = 0; i < n_entries && fl_offset < NUM_FL_PTE; ++i) {
+		u32 *fl_pte_shadow = pt->fl_table_shadow + fl_offset;
+		void *sl_table_va = __va(((*fl_pte_shadow) & ~0x1FF));
+		u32 sl_table = *fl_pte_shadow;
+
+		if (sl_table && !(sl_table & 0x1FF)) {
+			free_pages((unsigned long) sl_table_va,
+				   get_order(SZ_4K));
+			*fl_pte_shadow = 0;
+		}
+		++fl_offset;
+	}
+}
+
+static int __get_pgprot(int prot, int len)
+{
+	unsigned int pgprot;
+	int tex;
+
+	if (!(prot & (IOMMU_READ | IOMMU_WRITE))) {
+		prot |= IOMMU_READ | IOMMU_WRITE;
+		WARN_ONCE(1, "No attributes in iommu mapping; assuming RW\n");
+	}
+
+	if ((prot & IOMMU_WRITE) && !(prot & IOMMU_READ)) {
+		prot |= IOMMU_READ;
+		WARN_ONCE(1, "Write-only unsupported; falling back to RW\n");
+	}
+
+	if (prot & IOMMU_CACHE)
+		tex = (pgprot_val(PAGE_KERNEL) >> 2) & 0x07;
+	else
+		tex = msm_iommu_tex_class[MSM_IOMMU_ATTR_NONCACHED];
+
+	if (tex < 0 || tex > NUM_TEX_CLASS - 1)
+		return 0;
+
+	if (len == SZ_16M || len == SZ_1M) {
+		pgprot = FL_SHARED;
+		pgprot |= tex & 0x01 ? FL_BUFFERABLE : 0;
+		pgprot |= tex & 0x02 ? FL_CACHEABLE : 0;
+		pgprot |= tex & 0x04 ? FL_TEX0 : 0;
+		pgprot |= FL_AP0 | FL_AP1;
+		pgprot |= prot & IOMMU_WRITE ? 0 : FL_AP2;
+	} else	{
+		pgprot = SL_SHARED;
+		pgprot |= tex & 0x01 ? SL_BUFFERABLE : 0;
+		pgprot |= tex & 0x02 ? SL_CACHEABLE : 0;
+		pgprot |= tex & 0x04 ? SL_TEX0 : 0;
+		pgprot |= SL_AP0 | SL_AP1;
+		pgprot |= prot & IOMMU_WRITE ? 0 : SL_AP2;
+	}
+
+	return pgprot;
+}
+
+static u32 *make_second_level(struct msm_iommu_pt *pt, u32 *fl_pte,
+				u32 *fl_pte_shadow)
+{
+	u32 *sl;
+
+	sl = (u32 *) __get_free_pages(GFP_KERNEL,
+			get_order(SZ_4K));
+
+	if (!sl) {
+		pr_debug("Could not allocate second level table\n");
+		goto fail;
+	}
+	memset(sl, 0, SZ_4K);
+	clean_pte(sl, sl + NUM_SL_PTE + GUARD_PTE, pt->redirect);
+
+	*fl_pte = ((((int)__pa(sl)) & FL_BASE_MASK) | FL_TYPE_TABLE);
+	*fl_pte_shadow = *fl_pte & ~0x1FF;
+
+	clean_pte(fl_pte, fl_pte + 1, pt->redirect);
+fail:
+	return sl;
+}
+
+static int sl_4k(u32 *sl_pte, phys_addr_t pa, unsigned int pgprot)
+{
+	int ret = 0;
+
+	if (*sl_pte) {
+		ret = -EBUSY;
+		goto fail;
+	}
+
+	*sl_pte = (pa & SL_BASE_MASK_SMALL) | SL_NG | SL_SHARED
+		| SL_TYPE_SMALL | pgprot;
+fail:
+	return ret;
+}
+
+static int sl_64k(u32 *sl_pte, phys_addr_t pa, unsigned int pgprot)
+{
+	int ret = 0;
+
+	int i;
+
+	for (i = 0; i < 16; i++)
+		if (*(sl_pte+i)) {
+			ret = -EBUSY;
+			goto fail;
+		}
+
+	for (i = 0; i < 16; i++)
+		*(sl_pte+i) = (pa & SL_BASE_MASK_LARGE) | SL_NG
+				| SL_SHARED | SL_TYPE_LARGE | pgprot;
+
+fail:
+	return ret;
+}
+
+static inline int fl_1m(u32 *fl_pte, phys_addr_t pa, int pgprot)
+{
+	if (*fl_pte)
+		return -EBUSY;
+
+	*fl_pte = (pa & 0xFFF00000) | FL_NG | FL_TYPE_SECT | FL_SHARED
+		| pgprot;
+
+	return 0;
+}
+
+static inline int fl_16m(u32 *fl_pte, phys_addr_t pa, int pgprot)
+{
+	int i;
+	int ret = 0;
+
+	for (i = 0; i < 16; i++)
+		if (*(fl_pte+i)) {
+			ret = -EBUSY;
+			goto fail;
+		}
+	for (i = 0; i < 16; i++)
+		*(fl_pte+i) = (pa & 0xFF000000) | FL_SUPERSECTION
+			| FL_TYPE_SECT | FL_SHARED | FL_NG | pgprot;
+fail:
+	return ret;
+}
+
+int msm_iommu_pagetable_map(struct msm_iommu_pt *pt, unsigned long va,
+			phys_addr_t pa, size_t len, int prot)
+{
+	int ret;
+	struct scatterlist sg;
+
+	if (len != SZ_16M && len != SZ_1M &&
+	    len != SZ_64K && len != SZ_4K) {
+		pr_debug("Bad size: %zd\n", len);
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = pa;
+	sg.length = len;
+
+	ret = msm_iommu_pagetable_map_range(pt, va, &sg, len, prot);
+
+fail:
+	return ret;
+}
+
+size_t msm_iommu_pagetable_unmap(struct msm_iommu_pt *pt, unsigned long va,
+				size_t len)
+{
+	msm_iommu_pagetable_unmap_range(pt, va, len);
+	return len;
+}
+
+static phys_addr_t get_phys_addr(struct scatterlist *sg)
+{
+	/*
+	 * Try sg_dma_address first so that we can
+	 * map carveout regions that do not have a
+	 * struct page associated with them.
+	 */
+	phys_addr_t pa = sg_dma_address(sg);
+
+	if (pa == 0)
+		pa = sg_phys(sg);
+	return pa;
+}
+
+/*
+ * For debugging we may want to force mappings to be 4K only
+ */
+#ifdef CONFIG_IOMMU_FORCE_4K_MAPPINGS
+static inline int is_fully_aligned(unsigned int va, phys_addr_t pa, size_t len,
+				   int align)
+{
+	if (align == SZ_4K) {
+		return  IS_ALIGNED(va, align) && IS_ALIGNED(pa, align)
+			&& (len >= align);
+	} else {
+		return 0;
+	}
+}
+#else
+static inline int is_fully_aligned(unsigned int va, phys_addr_t pa, size_t len,
+				   int align)
+{
+	return  IS_ALIGNED(va, align) && IS_ALIGNED(pa, align)
+		&& (len >= align);
+}
+#endif
+
+int msm_iommu_pagetable_map_range(struct msm_iommu_pt *pt, unsigned int va,
+		       struct scatterlist *sg, unsigned int len, int prot)
+{
+	phys_addr_t pa;
+	unsigned int start_va = va;
+	unsigned int offset = 0;
+	u32 *fl_pte;
+	u32 *fl_pte_shadow;
+	u32 fl_offset;
+	u32 *sl_table = NULL;
+	u32 sl_offset, sl_start;
+	unsigned int chunk_size, chunk_offset = 0;
+	int ret = 0;
+	unsigned int pgprot4k, pgprot64k, pgprot1m, pgprot16m;
+
+	BUG_ON(len & (SZ_4K - 1));
+
+	pgprot4k = __get_pgprot(prot, SZ_4K);
+	pgprot64k = __get_pgprot(prot, SZ_64K);
+	pgprot1m = __get_pgprot(prot, SZ_1M);
+	pgprot16m = __get_pgprot(prot, SZ_16M);
+	if (!pgprot4k || !pgprot64k || !pgprot1m || !pgprot16m) {
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	fl_offset = FL_OFFSET(va);		/* Upper 12 bits */
+	fl_pte = pt->fl_table + fl_offset;	/* int pointers, 4 bytes */
+	fl_pte_shadow = pt->fl_table_shadow + fl_offset;
+	pa = get_phys_addr(sg);
+
+	while (offset < len) {
+		chunk_size = SZ_4K;
+
+		if (is_fully_aligned(va, pa, sg->length - chunk_offset,
+				     SZ_16M))
+			chunk_size = SZ_16M;
+		else if (is_fully_aligned(va, pa, sg->length - chunk_offset,
+					  SZ_1M))
+			chunk_size = SZ_1M;
+		/* 64k or 4k determined later */
+
+		/* for 1M and 16M, only first level entries are required */
+		if (chunk_size >= SZ_1M) {
+			if (chunk_size == SZ_16M) {
+				ret = fl_16m(fl_pte, pa, pgprot16m);
+				if (ret)
+					goto fail;
+				clean_pte(fl_pte, fl_pte + 16, pt->redirect);
+				fl_pte += 16;
+				fl_pte_shadow += 16;
+			} else if (chunk_size == SZ_1M) {
+				ret = fl_1m(fl_pte, pa, pgprot1m);
+				if (ret)
+					goto fail;
+				clean_pte(fl_pte, fl_pte + 1, pt->redirect);
+				fl_pte++;
+				fl_pte_shadow++;
+			}
+
+			offset += chunk_size;
+			chunk_offset += chunk_size;
+			va += chunk_size;
+			pa += chunk_size;
+
+			if (chunk_offset >= sg->length && offset < len) {
+				chunk_offset = 0;
+				sg = sg_next(sg);
+				pa = get_phys_addr(sg);
+			}
+			continue;
+		}
+		/* for 4K or 64K, make sure there is a second level table */
+		if (*fl_pte == 0) {
+			if (!make_second_level(pt, fl_pte, fl_pte_shadow)) {
+				ret = -ENOMEM;
+				goto fail;
+			}
+		}
+		if (!(*fl_pte & FL_TYPE_TABLE)) {
+			ret = -EBUSY;
+			goto fail;
+		}
+		sl_table = __va(((*fl_pte) & FL_BASE_MASK));
+		sl_offset = SL_OFFSET(va);
+		/* Keep track of initial position so we
+		 * don't clean more than we have to
+		 */
+		sl_start = sl_offset;
+
+		/* Build the 2nd level page table */
+		while (offset < len && sl_offset < NUM_SL_PTE) {
+			/* Map a large 64K page if the chunk is large enough and
+			 * the pa and va are aligned
+			 */
+
+			if (is_fully_aligned(va, pa, sg->length - chunk_offset,
+					     SZ_64K))
+				chunk_size = SZ_64K;
+			else
+				chunk_size = SZ_4K;
+
+			if (chunk_size == SZ_4K) {
+				sl_4k(&sl_table[sl_offset], pa, pgprot4k);
+				sl_offset++;
+				/* Increment map count */
+				(*fl_pte_shadow)++;
+			} else {
+				BUG_ON(sl_offset + 16 > NUM_SL_PTE);
+				sl_64k(&sl_table[sl_offset], pa, pgprot64k);
+				sl_offset += 16;
+				/* Increment map count */
+				*fl_pte_shadow += 16;
+			}
+
+			offset += chunk_size;
+			chunk_offset += chunk_size;
+			va += chunk_size;
+			pa += chunk_size;
+
+			if (chunk_offset >= sg->length && offset < len) {
+				chunk_offset = 0;
+				sg = sg_next(sg);
+				pa = get_phys_addr(sg);
+			}
+		}
+
+		clean_pte(sl_table + sl_start, sl_table + sl_offset,
+				pt->redirect);
+		fl_pte++;
+		fl_pte_shadow++;
+		sl_offset = 0;
+	}
+
+fail:
+	if (ret && offset > 0)
+		msm_iommu_pagetable_unmap_range(pt, start_va, offset);
+
+	return ret;
+}
+
+void msm_iommu_pagetable_unmap_range(struct msm_iommu_pt *pt, unsigned int va,
+				 unsigned int len)
+{
+	unsigned int offset = 0;
+	u32 *fl_pte;
+	u32 *fl_pte_shadow;
+	u32 fl_offset;
+	u32 *sl_table;
+	u32 sl_start, sl_end;
+	int used;
+
+	BUG_ON(len & (SZ_4K - 1));
+
+	fl_offset = FL_OFFSET(va);		/* Upper 12 bits */
+	fl_pte = pt->fl_table + fl_offset;	/* int pointers, 4 bytes */
+	fl_pte_shadow = pt->fl_table_shadow + fl_offset;
+
+	while (offset < len) {
+		if (*fl_pte & FL_TYPE_TABLE) {
+			unsigned int n_entries;
+
+			sl_start = SL_OFFSET(va);
+			sl_table =  __va(((*fl_pte) & FL_BASE_MASK));
+			sl_end = ((len - offset) / SZ_4K) + sl_start;
+
+			if (sl_end > NUM_SL_PTE)
+				sl_end = NUM_SL_PTE;
+			n_entries = sl_end - sl_start;
+
+			memset(sl_table + sl_start, 0, n_entries * 4);
+			clean_pte(sl_table + sl_start, sl_table + sl_end,
+					pt->redirect);
+
+			offset += n_entries * SZ_4K;
+			va += n_entries * SZ_4K;
+
+			BUG_ON((*fl_pte_shadow & 0x1FF) < n_entries);
+
+			/* Decrement map count */
+			*fl_pte_shadow -= n_entries;
+			used = *fl_pte_shadow & 0x1FF;
+
+			if (!used) {
+				*fl_pte = 0;
+				clean_pte(fl_pte, fl_pte + 1, pt->redirect);
+			}
+
+			sl_start = 0;
+		} else {
+			*fl_pte = 0;
+			*fl_pte_shadow = 0;
+
+			clean_pte(fl_pte, fl_pte + 1, pt->redirect);
+			va += SZ_1M;
+			offset += SZ_1M;
+			sl_start = 0;
+		}
+		fl_pte++;
+		fl_pte_shadow++;
+	}
+}
+
+static int __init get_tex_class(int icp, int ocp, int mt, int nos)
+{
+	int i = 0;
+	unsigned int prrr;
+	unsigned int nmrr;
+	int c_icp, c_ocp, c_mt, c_nos;
+
+	prrr = msm_iommu_get_prrr();
+	nmrr = msm_iommu_get_nmrr();
+
+	for (i = 0; i < NUM_TEX_CLASS; i++) {
+		c_nos = PRRR_NOS(prrr, i);
+		c_mt = PRRR_MT(prrr, i);
+		c_icp = NMRR_ICP(nmrr, i);
+		c_ocp = NMRR_OCP(nmrr, i);
+
+		if (icp == c_icp && ocp == c_ocp && c_mt == mt && c_nos == nos)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static void __init setup_iommu_tex_classes(void)
+{
+	msm_iommu_tex_class[MSM_IOMMU_ATTR_NONCACHED] =
+			get_tex_class(CP_NONCACHED, CP_NONCACHED,
+			MT_IOMMU_NORMAL, 1);
+
+	msm_iommu_tex_class[MSM_IOMMU_ATTR_CACHED_WB_WA] =
+			get_tex_class(CP_WB_WA, CP_WB_WA, MT_IOMMU_NORMAL, 1);
+
+	msm_iommu_tex_class[MSM_IOMMU_ATTR_CACHED_WB_NWA] =
+			get_tex_class(CP_WB_NWA, CP_WB_NWA, MT_IOMMU_NORMAL, 1);
+
+	msm_iommu_tex_class[MSM_IOMMU_ATTR_CACHED_WT] =
+			get_tex_class(CP_WT, CP_WT, MT_IOMMU_NORMAL, 1);
+}
+
+void __init msm_iommu_pagetable_init(void)
+{
+	setup_iommu_tex_classes();
+}
diff --git a/drivers/iommu/msm_iommu_pagetable.h b/drivers/iommu/msm_iommu_pagetable.h
new file mode 100644
index 0000000..12a8d27
--- /dev/null
+++ b/drivers/iommu/msm_iommu_pagetable.h
@@ -0,0 +1,33 @@
+/* Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_ARM_MACH_MSM_IOMMU_PAGETABLE_H
+#define __ARCH_ARM_MACH_MSM_IOMMU_PAGETABLE_H
+
+struct msm_iommu_pt;
+
+void msm_iommu_pagetable_init(void);
+int msm_iommu_pagetable_alloc(struct msm_iommu_pt *pt);
+void msm_iommu_pagetable_free(struct msm_iommu_pt *pt);
+int msm_iommu_pagetable_map(struct msm_iommu_pt *pt, unsigned long va,
+			phys_addr_t pa, size_t len, int prot);
+size_t msm_iommu_pagetable_unmap(struct msm_iommu_pt *pt, unsigned long va,
+				size_t len);
+int msm_iommu_pagetable_map_range(struct msm_iommu_pt *pt, unsigned int va,
+			struct scatterlist *sg, unsigned int len, int prot);
+void msm_iommu_pagetable_unmap_range(struct msm_iommu_pt *pt, unsigned int va,
+				unsigned int len);
+phys_addr_t msm_iommu_iova_to_phys_soft(struct iommu_domain *domain,
+						phys_addr_t va);
+void msm_iommu_pagetable_free_tables(struct msm_iommu_pt *pt, unsigned long va,
+				size_t len);
+#endif
diff --git a/drivers/iommu/msm_iommu_priv.h b/drivers/iommu/msm_iommu_priv.h
new file mode 100644
index 0000000..031e6b4
--- /dev/null
+++ b/drivers/iommu/msm_iommu_priv.h
@@ -0,0 +1,55 @@
+/* Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef MSM_IOMMU_PRIV_H
+#define MSM_IOMMU_PRIV_H
+
+/**
+ * struct msm_iommu_pt - Container for first level page table and its
+ * attributes.
+ * fl_table: Pointer to the first level page table.
+ * redirect: Set to 1 if L2 redirect for page tables are enabled, 0 otherwise.
+ * unaligned_fl_table: Original address of memory for the page table.
+ * fl_table is manually aligned (as per spec) but we need the original address
+ * to free the table.
+ * fl_table_shadow: This is "copy" of the fl_table with some differences.
+ * It stores the same information as fl_table except that instead of storing
+ * second level page table address + page table entry descriptor bits it
+ * stores the second level page table address and the number of used second
+ * level page tables entries. This is used to check whether we need to free
+ * the second level page table which allows us to also free the second level
+ * page table after doing a TLB invalidate which should catch bugs with
+ * clients trying to unmap an address that is being used.
+ * fl_table_shadow will use the lower 9 bits for the use count and the upper
+ * bits for the second level page table address.
+ */
+struct msm_iommu_pt {
+	u32 *fl_table;
+	int redirect;
+	u32 *fl_table_shadow;
+};
+
+/**
+ * struct msm_iommu_priv - Container for page table attributes and other
+ * private iommu domain information.
+ * attributes.
+ * pt: Page table attribute structure
+ * list_attached: List of masters attached to this domain.
+ * client_name: Name of the domain client.
+ */
+struct msm_iommu_priv {
+	struct msm_iommu_pt pt;
+	struct list_head list_attached;
+	const char *client_name;
+};
+
+#endif
diff --git a/include/linux/qcom_iommu.h b/include/linux/qcom_iommu.h
new file mode 100644
index 0000000..e26cacd
--- /dev/null
+++ b/include/linux/qcom_iommu.h
@@ -0,0 +1,221 @@
+/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef MSM_IOMMU_H
+#define MSM_IOMMU_H
+
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/regulator/consumer.h>
+#include <linux/idr.h>
+
+extern pgprot_t     pgprot_kernel;
+extern struct msm_iommu_access_ops msm_iommu_access_ops_v1;
+
+/* Domain attributes */
+#define MSM_IOMMU_DOMAIN_PT_CACHEABLE	0x1
+#define MSM_IOMMU_DOMAIN_PT_SECURE	0x2
+
+/* Mask for the cache policy attribute */
+#define MSM_IOMMU_CP_MASK		0x03
+
+/* Maximum number of SMT entries allowed by the system */
+#define MAX_NUM_SMR	128
+
+#define MAX_NUM_BFB_REGS	32
+
+#define MAX_GLB_IRQ	2
+#define MAX_CB_IRQ	3
+#define MAX_CLKS	4
+
+/**
+ * struct msm_iommu_bfb_settings - a set of IOMMU BFB tuning parameters
+ * regs		An array of register offsets to configure
+ * data		Values to write to corresponding registers
+ * length	Number of valid entries in the offset/val arrays
+ */
+struct msm_iommu_bfb_settings {
+	unsigned int regs[MAX_NUM_BFB_REGS];
+	unsigned int data[MAX_NUM_BFB_REGS];
+	int length;
+};
+
+struct msm_iommu_master {
+	struct list_head list;
+	struct list_head attached_elm;
+	u32 sids[MAX_NUM_SMR];
+	u32 nsids;
+	struct device *dev;
+	s32 cb_num;
+	u32 irq_num;
+	s32 asid;
+	struct msm_iommu_drvdata *drvdata;
+};
+
+/**
+ * struct msm_iommu_drvdata - A single IOMMU hardware instance
+ * @base:	IOMMU config port base address (VA)
+ * @glb_base:	IOMMU config port base address for global register space (VA)
+ * @cb_base:	IOMMU config port base address for cb register space (VA)
+ * @phys_base:  IOMMU physical base address.
+ * @ncb		The number of contexts on this IOMMU
+ * @clk:	List of clocks needed for this SMMU
+ * @name:	Human-readable name of this IOMMU device
+ * @gdsc:	Regulator needed to power this HW block
+ * @alt_gdsc	Additional regulator needed to power this HW block (optional)
+ * @bfb_settings: Optional BFB performance tuning parameters
+ * @dev:	Struct device this hardware instance is tied to
+ * @list:	List head to link all iommus together
+ * @masters:	List of masters for this iommu
+ * @clk_reg_virt: Optional clock register virtual address.
+ * @halt_enabled: Set to 1 if IOMMU halt is supported in the IOMMU, 0 otherwise.
+ * @asid:         List of ASID and their usage count (index is ASID value).
+ * @ctx_attach_count: Count of how many context are attached.
+ * @powered_on: Powered status of the IOMMU. 0 means powered off.
+ * @cb_ida: Bitmap for allocating a CB
+ * @n_glb_irq : Number of global irqs
+ * @n_cb_irq : Number of CB irqs
+ * @glb_irq : Array of global interrupts
+ * @cb_irq : Array of context bank interrupt
+ *
+ * A msm_iommu_drvdata holds the global driver data about a single piece
+ * of an IOMMU hardware instance.
+ */
+struct msm_iommu_drvdata {
+	void __iomem *base;
+	void __iomem *glb_base;
+	void __iomem *cb_base;
+	phys_addr_t phys_base;
+	int ncb;
+	struct clk *clk[MAX_CLKS];
+	const char *name;
+	struct regulator *gdsc;
+	struct regulator *alt_gdsc;
+	struct msm_iommu_bfb_settings *bfb_settings;
+	struct device *dev;
+	struct list_head list;
+	struct list_head masters;
+	void __iomem *clk_reg_virt;
+	int halt_enabled;
+	int *asid;
+	unsigned int ctx_attach_count;
+	int powered_on;
+	struct ida cb_ida;
+	unsigned int n_glb_irq;
+	unsigned int n_cb_irq;
+	int glb_irq[MAX_GLB_IRQ];
+	int cb_irq[MAX_CB_IRQ];
+};
+
+/**
+ * struct msm_iommu_access_ops - Callbacks for accessing IOMMU
+ * @iommu_power_on:     Turn on power to unit
+ * @iommu_power_off:    Turn off power to unit
+ * @iommu_clk_on:       Turn on clks to unit
+ * @iommu_clk_off:      Turn off clks to unit
+ * @iommu_lock_acquire: Acquire any locks needed
+ * @iommu_lock_release: Release locks needed
+ */
+struct msm_iommu_access_ops {
+	int (*iommu_power_on)(struct msm_iommu_drvdata *);
+	void (*iommu_power_off)(struct msm_iommu_drvdata *);
+	int (*iommu_clk_on)(struct msm_iommu_drvdata *);
+	void (*iommu_clk_off)(struct msm_iommu_drvdata *);
+	void (*iommu_lock_acquire)(unsigned int need_extra_lock);
+	void (*iommu_lock_release)(unsigned int need_extra_lock);
+};
+
+int __init msm_iommu_init(void);
+void msm_iommu_add_drv(struct msm_iommu_drvdata *drv);
+void msm_iommu_remove_drv(struct msm_iommu_drvdata *drv);
+struct msm_iommu_drvdata *msm_iommu_find_iommu(struct device_node *np);
+struct msm_iommu_master *msm_iommu_find_master(struct msm_iommu_drvdata *drv,
+					       struct device *dev);
+void program_iommu_bfb_settings(void __iomem *base,
+			const struct msm_iommu_bfb_settings *bfb_settings);
+void iommu_halt(const struct msm_iommu_drvdata *iommu_drvdata);
+void iommu_resume(const struct msm_iommu_drvdata *iommu_drvdata);
+
+enum dump_reg {
+	DUMP_REG_FIRST,
+	DUMP_REG_FAR0 = DUMP_REG_FIRST,
+	DUMP_REG_FAR1,
+	DUMP_REG_PAR0,
+	DUMP_REG_PAR1,
+	DUMP_REG_FSR,
+	DUMP_REG_FSYNR0,
+	DUMP_REG_FSYNR1,
+	DUMP_REG_TTBR0_0,
+	DUMP_REG_TTBR0_1,
+	DUMP_REG_TTBR1_0,
+	DUMP_REG_TTBR1_1,
+	DUMP_REG_SCTLR,
+	DUMP_REG_ACTLR,
+	DUMP_REG_PRRR,
+	DUMP_REG_MAIR0 = DUMP_REG_PRRR,
+	DUMP_REG_NMRR,
+	DUMP_REG_MAIR1 = DUMP_REG_NMRR,
+	DUMP_REG_CBAR_N,
+	DUMP_REG_CBFRSYNRA_N,
+	MAX_DUMP_REGS,
+};
+
+enum dump_reg_type {
+	DRT_CTX_REG,
+	DRT_GLOBAL_REG,
+	DRT_GLOBAL_REG_N,
+};
+
+struct dump_regs_tbl_entry {
+	/*
+	 * To keep things context-bank-agnostic, we only store the
+	 * register offset in `reg_offset'
+	 */
+	unsigned int reg_offset;
+	const char *name;
+	int must_be_present;
+	enum dump_reg_type dump_reg_type;
+};
+extern struct dump_regs_tbl_entry dump_regs_tbl[MAX_DUMP_REGS];
+
+#define COMBINE_DUMP_REG(upper, lower) (((u64) upper << 32) | lower)
+
+struct msm_iommu_context_reg {
+	uint32_t val;
+	bool valid;
+};
+
+void print_ctx_regs(struct msm_iommu_context_reg regs[]);
+
+irqreturn_t msm_iommu_global_fault_handler(int irq, void *dev_id);
+
+#ifdef CONFIG_MSM_IOMMU
+void msm_set_iommu_access_ops(struct msm_iommu_access_ops *ops);
+struct msm_iommu_access_ops *msm_get_iommu_access_ops(void);
+#else
+static inline void msm_set_iommu_access_ops(struct msm_iommu_access_ops *ops)
+{
+
+}
+static inline struct msm_iommu_access_ops *msm_get_iommu_access_ops(void)
+{
+	return NULL;
+}
+#endif
+
+u32 msm_iommu_get_mair0(void);
+u32 msm_iommu_get_mair1(void);
+u32 msm_iommu_get_prrr(void);
+u32 msm_iommu_get_nmrr(void);
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
