From: <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/1] AMD Family15h Model10-1Fh erratum 746 Workaround
Date: Tue, 22 Jan 2013 17:19:10 -0600
Message-ID: <1358896750-5199-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, joro@8bytes.org
Cc: bp@alian8.de, linux-kernel@vger.kernel.org, udovdh@xs4all.nl, ssg.sos.patches@amd.com, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This patch implements workaround for the AMD Family15h Model10-1Fh erratum 746.

(http://support.amd.com/us/Processor_TechDocs/48931_15h_Mod_10h-1Fh_Rev_Guide.pdf)

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 81837b0..26c0448 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -975,6 +975,30 @@ static void __init free_iommu_all(void)
 }
 
 /*
+ * AMD family15h Model 10h-1fh  erratum 746 (IOMMU Logging May Stall Translations)
+ * Workaround:
+ *     BIOS should disable L2B micellaneous clock gating by setting
+ *     L2_L2B_CK_GATE_CONTROL[CKGateL2BMiscDisable](D0F2xF4_x90[2]) = 1b
+ */
+static void __init amd_iommu_apply_erratum_746(struct amd_iommu *iommu)
+{
+	u32 value;
+
+	if ((boot_cpu_data.x86 != 0x15) || !(boot_cpu_data.x86_model & 0x10))
+		return;
+	
+	/* Select Northbridge indirect register 0x90 and enable writing */
+	pci_write_config_dword(iommu->dev, 0xf0, 0x90 | (1 << 8));
+	pci_read_config_dword(iommu->dev, 0xf4, &value); 
+
+	if (!(value & 0x4)) {
+		pci_write_config_dword(iommu->dev, 0xf4, value | 0x4);
+		pr_info("AMD-Vi: Applying erratum 746 for IOMMU at %s\n",
+		 dev_name(&iommu->dev->dev));
+	}
+}
+
+/*
  * This function clues the initialization function for one IOMMU
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
@@ -1171,6 +1195,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 		for (i = 0; i < 0x83; i++)
 			iommu->stored_l2[i] = iommu_read_l2(iommu, i);
 	}
+	
+	amd_iommu_apply_erratum_746(iommu);
 
 	return pci_enable_device(iommu->dev);
 }
-- 
1.7.10.4
