From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Wed, 20 Mar 2019 17:36:33 +0000
Message-ID: <20190320173634.21895-4-jean-philippe.brucker@arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com
Cc: lorenzo.pieralisi@arm.com, zhongmiao@hisilicon.com, okaya@kernel.org, joro@8bytes.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

PCIe devices can implement their own TLB, named Address Translation Cache
(ATC). Enable Address Translation Service (ATS) for devices that support
it and send them invalidation requests whenever we invalidate the IOTLBs.

ATC invalidation is allowed to take up to 90 seconds, according to the
PCIe spec, so it is possible to get a SMMU command queue timeout during
normal operations. However we expect implementations to complete
invalidation in reasonable time.

We only enable ATS for "trusted" devices, and currently rely on the
pci_dev->untrusted bit. For ATS we have to trust that:

(a) The device doesn't issue "translated" memory requests for addresses
    that weren't returned by the SMMU in a Translation Completion. In
    particular, if we give control of a device or device partition to a VM
    or userspace, software cannot program the device to access arbitrary
    "translated" addresses.

(b) The device follows permissions granted by the SMMU in a Translation
    Completion. If the device requested read+write permission and only
    got read, then it doesn't write.

(c) The device doesn't send Translated transactions for an address that
    was invalidated by an ATC invalidation.

Note that the PCIe specification explicitly requires all of these, so we
can assume that implementations will cleanly shield ATCs from software.

All ATS translated requests still go through the SMMU, to walk the stream
table and check that the device is actually allowed to send translated
requests.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
Since last version:
* Refresh
* Don't enable ATS for untrusted devices, or when pci.noats is on the
  kernel command line.
---
 drivers/iommu/arm-smmu-v3.c | 221 +++++++++++++++++++++++++++++++++++-
 1 file changed, 216 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 66a29c113dbc..c605d6f1b2df 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -29,6 +29,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 
 #include <linux/amba/bus.h>
@@ -86,6 +87,7 @@
 #define IDR5_VAX_52_BIT			1
 
 #define ARM_SMMU_CR0			0x20
+#define CR0_ATSCHK			(1 << 4)
 #define CR0_CMDQEN			(1 << 3)
 #define CR0_EVTQEN			(1 << 2)
 #define CR0_PRIQEN			(1 << 1)
@@ -294,6 +296,7 @@
 #define CMDQ_ERR_CERROR_NONE_IDX	0
 #define CMDQ_ERR_CERROR_ILL_IDX		1
 #define CMDQ_ERR_CERROR_ABT_IDX		2
+#define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
 #define CMDQ_0_OP			GENMASK_ULL(7, 0)
 #define CMDQ_0_SSV			(1UL << 11)
@@ -312,6 +315,12 @@
 #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
 #define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
 
+#define CMDQ_ATC_0_SSID			GENMASK_ULL(31, 12)
+#define CMDQ_ATC_0_SID			GENMASK_ULL(63, 32)
+#define CMDQ_ATC_0_GLOBAL		(1UL << 9)
+#define CMDQ_ATC_1_SIZE			GENMASK_ULL(5, 0)
+#define CMDQ_ATC_1_ADDR_MASK		GENMASK_ULL(63, 12)
+
 #define CMDQ_PRI_0_SSID			GENMASK_ULL(31, 12)
 #define CMDQ_PRI_0_SID			GENMASK_ULL(63, 32)
 #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
@@ -365,6 +374,11 @@ module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
+static bool disable_ats_check;
+module_param_named(disable_ats_check, disable_ats_check, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_ats_check,
+	"By default, the SMMU checks whether each incoming transaction marked as translated is allowed by the stream configuration. This option disables the check.");
+
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
@@ -433,6 +447,16 @@ struct arm_smmu_cmdq_ent {
 			u64			addr;
 		} tlbi;
 
+		#define CMDQ_OP_ATC_INV		0x40
+		#define ATC_INV_SIZE_ALL	52
+		struct {
+			u32			sid;
+			u32			ssid;
+			u64			addr;
+			u8			size;
+			bool			global;
+		} atc;
+
 		#define CMDQ_OP_PRI_RESP	0x41
 		struct {
 			u32			sid;
@@ -516,6 +540,8 @@ struct arm_smmu_strtab_ent {
 	bool				assigned;
 	struct arm_smmu_s1_cfg		*s1_cfg;
 	struct arm_smmu_s2_cfg		*s2_cfg;
+
+	bool				ats_enabled;
 };
 
 struct arm_smmu_strtab_cfg {
@@ -828,6 +854,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_S12_VMALL:
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		break;
+	case CMDQ_OP_ATC_INV:
+		cmd[0] |= FIELD_PREP(CMDQ_0_SSV, ent->substream_valid);
+		cmd[0] |= FIELD_PREP(CMDQ_ATC_0_GLOBAL, ent->atc.global);
+		cmd[0] |= FIELD_PREP(CMDQ_ATC_0_SSID, ent->atc.ssid);
+		cmd[0] |= FIELD_PREP(CMDQ_ATC_0_SID, ent->atc.sid);
+		cmd[1] |= FIELD_PREP(CMDQ_ATC_1_SIZE, ent->atc.size);
+		cmd[1] |= ent->atc.addr & CMDQ_ATC_1_ADDR_MASK;
+		break;
 	case CMDQ_OP_PRI_RESP:
 		cmd[0] |= FIELD_PREP(CMDQ_0_SSV, ent->substream_valid);
 		cmd[0] |= FIELD_PREP(CMDQ_PRI_0_SSID, ent->pri.ssid);
@@ -872,6 +906,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
 		[CMDQ_ERR_CERROR_ILL_IDX]	= "Illegal command",
 		[CMDQ_ERR_CERROR_ABT_IDX]	= "Abort on command fetch",
+		[CMDQ_ERR_CERROR_ATC_INV_IDX]	= "ATC invalidate timeout",
 	};
 
 	int i;
@@ -891,6 +926,14 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		dev_err(smmu->dev, "retrying command fetch\n");
 	case CMDQ_ERR_CERROR_NONE_IDX:
 		return;
+	case CMDQ_ERR_CERROR_ATC_INV_IDX:
+		/*
+		 * ATC Invalidation Completion timeout. CONS is still pointing
+		 * at the CMD_SYNC. Attempt to complete other pending commands
+		 * by repeating the CMD_SYNC, though we might well end up back
+		 * here since the ATC invalidation may still be pending.
+		 */
+		return;
 	case CMDQ_ERR_CERROR_ILL_IDX:
 		/* Fallthrough */
 	default:
@@ -1166,15 +1209,16 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
-#ifdef CONFIG_PCI_ATS
-			 FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS) |
-#endif
 			 FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_NSEL1));
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
+		if (ste->ats_enabled)
+			dst[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
+							 STRTAB_STE_1_EATS_TRANS));
+
 		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
 	}
@@ -1398,6 +1442,98 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 	return IRQ_WAKE_THREAD;
 }
 
+static void
+arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+			struct arm_smmu_cmdq_ent *cmd)
+{
+	size_t log2_span;
+	size_t span_mask;
+	/* ATC invalidates are always on 4096 bytes pages */
+	size_t inval_grain_shift = 12;
+	unsigned long page_start, page_end;
+
+	*cmd = (struct arm_smmu_cmdq_ent) {
+		.opcode			= CMDQ_OP_ATC_INV,
+		.substream_valid	= !!ssid,
+		.atc.ssid		= ssid,
+	};
+
+	if (!size) {
+		cmd->atc.size = ATC_INV_SIZE_ALL;
+		return;
+	}
+
+	page_start	= iova >> inval_grain_shift;
+	page_end	= (iova + size - 1) >> inval_grain_shift;
+
+	/*
+	 * Find the smallest power of two that covers the range. Most
+	 * significant differing bit between start and end address indicates the
+	 * required span, ie. fls(start ^ end). For example:
+	 *
+	 * We want to invalidate pages [8; 11]. This is already the ideal range:
+	 *		x = 0b1000 ^ 0b1011 = 0b11
+	 *		span = 1 << fls(x) = 4
+	 *
+	 * To invalidate pages [7; 10], we need to invalidate [0; 15]:
+	 *		x = 0b0111 ^ 0b1010 = 0b1101
+	 *		span = 1 << fls(x) = 16
+	 */
+	log2_span	= fls_long(page_start ^ page_end);
+	span_mask	= (1ULL << log2_span) - 1;
+
+	page_start	&= ~span_mask;
+
+	cmd->atc.addr	= page_start << inval_grain_shift;
+	cmd->atc.size	= log2_span;
+}
+
+static void arm_smmu_atc_inv_master(struct arm_smmu_master_data *master,
+				    struct arm_smmu_cmdq_ent *cmd)
+{
+	int i;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+
+	if (!master->ste.ats_enabled)
+		return;
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		cmd->atc.sid = fwspec->ids[i];
+		arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
+	}
+
+	arm_smmu_cmdq_issue_sync(master->smmu);
+
+	return;
+}
+
+static void arm_smmu_atc_inv_master_all(struct arm_smmu_master_data *master,
+				       int ssid)
+{
+	struct arm_smmu_cmdq_ent cmd;
+
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
+	arm_smmu_atc_inv_master(master, &cmd);
+}
+
+static void arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+				    int ssid, unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_master_data *master;
+
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
+		return;
+
+	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head)
+		arm_smmu_atc_inv_master(master, &cmd);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_sync(void *cookie)
 {
@@ -1728,6 +1864,8 @@ static void arm_smmu_detach_dev(struct device *dev)
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (smmu_domain) {
+		arm_smmu_atc_inv_master_all(master, 0);
+
 		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 		list_del(&master->domain_head);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
@@ -1817,12 +1955,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t
 arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
-	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	int ret;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
 
 	if (!ops)
 		return 0;
 
-	return ops->unmap(ops, iova, size);
+	ret = ops->unmap(ops, iova, size);
+	if (ret)
+		arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
+
+	return ret;
 }
 
 static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
@@ -1881,6 +2025,58 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
+{
+	size_t stu;
+	int ret, pos;
+	struct pci_dev *pdev;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev) ||
+	    (fwspec->flags & IOMMU_FWSPEC_PCI_NO_ATS) || pci_ats_disabled())
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+	if (pdev->untrusted)
+		return -EPERM;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS);
+	if (!pos)
+		return -ENOSYS;
+
+	/* Smallest Translation Unit: log2 of the smallest supported granule */
+	stu = __ffs(smmu->pgsize_bitmap);
+
+	ret = pci_enable_ats(pdev, stu);
+	if (ret) {
+		dev_err(&pdev->dev, "could not enable ATS: %d\n", ret);
+		return ret;
+	}
+
+	master->ste.ats_enabled = true;
+	dev_dbg(&pdev->dev, "enabled ATS (STU=%zu, QDEP=%d)\n", stu,
+		pci_ats_queue_depth(pdev));
+
+	return 0;
+}
+
+static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->ats_enabled)
+		return;
+
+	pci_disable_ats(pdev);
+	master->ste.ats_enabled = false;
+}
+
 static struct iommu_ops arm_smmu_ops;
 
 static int arm_smmu_add_device(struct device *dev)
@@ -1929,10 +2125,14 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 	}
 
+	arm_smmu_enable_ats(master);
+
 	group = iommu_group_get_for_dev(dev);
 	if (!IS_ERR(group)) {
 		iommu_group_put(group);
 		iommu_device_link(&smmu->iommu, dev);
+	} else {
+		arm_smmu_disable_ats(master);
 	}
 
 	return PTR_ERR_OR_ZERO(group);
@@ -1953,6 +2153,7 @@ static void arm_smmu_remove_device(struct device *dev)
 		arm_smmu_detach_dev(dev);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_disable_ats(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
@@ -2575,6 +2776,16 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		}
 	}
 
+	if (smmu->features & ARM_SMMU_FEAT_ATS && !disable_ats_check) {
+		enables |= CR0_ATSCHK;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable ATS check\n");
+			return ret;
+		}
+	}
+
 	ret = arm_smmu_setup_irqs(smmu);
 	if (ret) {
 		dev_err(smmu->dev, "failed to setup irqs\n");
-- 
2.21.0
