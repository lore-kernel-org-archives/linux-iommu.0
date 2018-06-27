From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 3/3] iommu/amd: Add support for IOMMU XT mode
Date: Wed, 27 Jun 2018 10:31:22 -0500
Message-ID: <1530113482-85632-4-git-send-email-suravee.suthikulpanit@amd.com>
References: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

The AMD IOMMU XT mode enables interrupt remapping with 32-bit destination
APIC ID, which is required for x2APIC. The feature is available when
the XTSup bit is set in the IOMMU Extended Feature register
and/or the IVHD Type 10h IOMMU Feature Reporting field.

For more information, please see section "IOMMU x2APIC Support" of
the AMD I/O Virtualization Technology (IOMMU) Specification.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 21 ++++++++++++++++-----
 drivers/iommu/amd_iommu_init.c  | 25 +++++++++++++++++++++++--
 drivers/iommu/amd_iommu_types.h | 17 +++++++++++------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 92241ff..6b2c9e5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3843,7 +3843,8 @@ static void irte_ga_prepare(void *entry,
 	irte->lo.fields_remap.int_type    = delivery_mode;
 	irte->lo.fields_remap.dm          = dest_mode;
 	irte->hi.fields.vector            = vector;
-	irte->lo.fields_remap.destination = dest_apicid;
+	irte->lo.fields_remap.destination = APICID_TO_IRTE_DEST_LO(dest_apicid);
+	irte->hi.fields.destination       = APICID_TO_IRTE_DEST_HI(dest_apicid);
 	irte->lo.fields_remap.valid       = 1;
 }
 
@@ -3896,7 +3897,10 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 
 	if (!irte->lo.fields_remap.guest_mode) {
 		irte->hi.fields.vector = vector;
-		irte->lo.fields_remap.destination = dest_apicid;
+		irte->lo.fields_remap.destination =
+					APICID_TO_IRTE_DEST_LO(dest_apicid);
+		irte->hi.fields.destination =
+					APICID_TO_IRTE_DEST_HI(dest_apicid);
 		modify_irte_ga(devid, index, irte, NULL);
 	}
 }
@@ -4313,7 +4317,10 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		irte->lo.val = 0;
 		irte->hi.fields.vector = cfg->vector;
 		irte->lo.fields_remap.guest_mode = 0;
-		irte->lo.fields_remap.destination = cfg->dest_apicid;
+		irte->lo.fields_remap.destination =
+				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
+		irte->hi.fields.destination =
+				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 		irte->lo.fields_remap.int_type = apic->irq_delivery_mode;
 		irte->lo.fields_remap.dm = apic->irq_dest_mode;
 
@@ -4430,8 +4437,12 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	raw_spin_lock_irqsave(&table->lock, flags);
 
 	if (ref->lo.fields_vapic.guest_mode) {
-		if (cpu >= 0)
-			ref->lo.fields_vapic.destination = cpu;
+		if (cpu >= 0) {
+			ref->lo.fields_vapic.destination =
+						APICID_TO_IRTE_DEST_LO(cpu);
+			ref->hi.fields.destination =
+						APICID_TO_IRTE_DEST_HI(cpu);
+		}
 		ref->lo.fields_vapic.is_run = is_run;
 		barrier();
 	}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 7d494f2..f6dd63f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -153,6 +153,7 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
+static int amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
@@ -827,6 +828,19 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 	return ret;
 }
 
+static void iommu_enable_xt(struct amd_iommu *iommu)
+{
+#ifdef CONFIG_IRQ_REMAP
+	/*
+	 * XT mode (32-bit APIC destination ID) requires
+	 * GA mode (128-bit IRTE support) as a prerequisite.
+	 */
+	if (AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir) &&
+	    amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+		iommu_feature_enable(iommu, CONTROL_XT_EN);
+#endif /* CONFIG_IRQ_REMAP */
+}
+
 static void iommu_enable_gt(struct amd_iommu *iommu)
 {
 	if (!iommu_feature(iommu, FEATURE_GT))
@@ -1507,6 +1521,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+		if (((h->efr_attr & (0x1 << IOMMU_FEAT_XTSUP_SHIFT)) == 0))
+			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 		break;
 	case 0x11:
 	case 0x40:
@@ -1516,6 +1532,8 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+		if (((h->efr_reg & (0x1 << IOMMU_EFR_XTSUP_SHIFT)) == 0))
+			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 		break;
 	default:
 		return -EINVAL;
@@ -1832,6 +1850,8 @@ static void print_iommu_info(void)
 		pr_info("AMD-Vi: Interrupt remapping enabled\n");
 		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 			pr_info("AMD-Vi: virtual APIC enabled\n");
+		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+			pr_info("AMD-Vi: X2APIC enabled\n");
 	}
 }
 
@@ -2168,6 +2188,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
 	iommu_enable_ga(iommu);
+	iommu_enable_xt(iommu);
 	iommu_enable(iommu);
 	iommu_flush_all_caches(iommu);
 }
@@ -2212,6 +2233,7 @@ static void early_enable_iommus(void)
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
 			iommu_enable_ga(iommu);
+			iommu_enable_xt(iommu);
 			iommu_set_device_table(iommu);
 			iommu_flush_all_caches(iommu);
 		}
@@ -2691,8 +2713,7 @@ int __init amd_iommu_enable(void)
 		return ret;
 
 	irq_remapping_enabled = 1;
-
-	return 0;
+	return amd_iommu_xt_mode;
 }
 
 void amd_iommu_disable(void)
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 986cbe0..aa892fd 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -161,6 +161,7 @@
 #define CONTROL_GAM_EN          0x19ULL
 #define CONTROL_GALOG_EN        0x1CULL
 #define CONTROL_GAINT_EN        0x1DULL
+#define CONTROL_XT_EN           0x32ULL
 
 #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
 #define CTRL_INV_TO_NONE	0
@@ -378,9 +379,11 @@
 #define IOMMU_CAP_EFR     27
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
+#define IOMMU_FEAT_XTSUP_SHIFT	0
 #define IOMMU_FEAT_GASUP_SHIFT	6
 
 /* IOMMU Extended Feature Register (EFR) */
+#define IOMMU_EFR_XTSUP_SHIFT	2
 #define IOMMU_EFR_GASUP_SHIFT	7
 
 #define MAX_DOMAIN_ID 65536
@@ -437,7 +440,6 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define APERTURE_RANGE_INDEX(a)	((a) >> APERTURE_RANGE_SHIFT)
 #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
 
-
 /*
  * This struct is used to pass information about
  * incoming PPR faults around.
@@ -810,6 +812,9 @@ union irte {
 	} fields;
 };
 
+#define APICID_TO_IRTE_DEST_LO(x)    (x & 0xffffff)
+#define APICID_TO_IRTE_DEST_HI(x)    ((x >> 24) & 0xff)
+
 union irte_ga_lo {
 	u64 val;
 
@@ -823,8 +828,8 @@ union irte_ga_lo {
 		    dm		: 1,
 		    /* ------ */
 		    guest_mode	: 1,
-		    destination	: 8,
-		    rsvd	: 48;
+		    destination	: 24,
+		    ga_tag	: 32;
 	} fields_remap;
 
 	/* For guest vAPIC */
@@ -837,8 +842,7 @@ union irte_ga_lo {
 		    is_run	: 1,
 		    /* ------ */
 		    guest_mode	: 1,
-		    destination	: 8,
-		    rsvd2	: 16,
+		    destination	: 24,
 		    ga_tag	: 32;
 	} fields_vapic;
 };
@@ -849,7 +853,8 @@ union irte_ga_hi {
 		u64 vector	: 8,
 		    rsvd_1	: 4,
 		    ga_root_ptr	: 40,
-		    rsvd_2	: 12;
+		    rsvd_2	: 4,
+		    destination : 8;
 	} fields;
 };
 
-- 
2.7.4
