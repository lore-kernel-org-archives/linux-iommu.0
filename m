From: <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V4] IOMMU, AMD Family15h Model10-1Fh erratum 746 Workaround
Date: Thu, 24 Jan 2013 13:17:53 -0600
Message-ID: <1359055073-29732-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

The IOMMU may stop processing page translations due to a perceived lack
of credits for writing upstream peripheral page service request (PPR)
or event logs. If the L2B miscellaneous clock gating feature is enabled
the IOMMU does not properly register credits after the log request has
completed, leading to a potential system hang.

BIOSes are supposed to disable L2B micellaneous clock gating by setting
L2_L2B_CK_GATE_CONTROL[CKGateL2BMiscDisable](D0F2xF4_x90[2]) = 1b. This
patch corrects that for those which do not enable this workaround.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
Changelog:
v4:
      * Fix style and spacing

v3:
      * Add proper commit message
      * Change logic to avoid unnecessary indentaion

v2:
      * Fix logic that check the processor model.
      * Clear write enable bit after apply workaround
      * Change function name

 drivers/iommu/amd_iommu_init.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 81837b0..ed3539b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -975,6 +975,38 @@ static void __init free_iommu_all(void)
 }
 
 /*
+ * Family15h Model 10h-1fh erratum 746 (IOMMU Logging May Stall Translations)
+ * Workaround:
+ *     BIOS should disable L2B micellaneous clock gating by setting
+ *     L2_L2B_CK_GATE_CONTROL[CKGateL2BMiscDisable](D0F2xF4_x90[2]) = 1b
+ */
+static void __init amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
+{
+	u32 value;
+
+	if ((boot_cpu_data.x86 != 0x15) ||
+	    (boot_cpu_data.x86_model < 0x10) ||
+	    (boot_cpu_data.x86_model > 0x1f))
+		return;
+
+	pci_write_config_dword(iommu->dev, 0xf0, 0x90);
+	pci_read_config_dword(iommu->dev, 0xf4, &value);
+
+	if (value & BIT(2))
+		return;
+
+	/* Select NB indirect register 0x90 and enable writing */
+	pci_write_config_dword(iommu->dev, 0xf0, 0x90 | (1 << 8));
+
+	pci_write_config_dword(iommu->dev, 0xf4, value | 0x4);
+	pr_info("AMD-Vi: Applying erratum 746 workaround for IOMMU at %s\n",
+		dev_name(&iommu->dev->dev));
+
+	/* Clear the enable writing bit */
+	pci_write_config_dword(iommu->dev, 0xf0, 0x90);
+}
+
+/*
  * This function clues the initialization function for one IOMMU
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
@@ -1172,6 +1204,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 			iommu->stored_l2[i] = iommu_read_l2(iommu, i);
 	}
 
+	amd_iommu_erratum_746_workaround(iommu);
+
 	return pci_enable_device(iommu->dev);
 }
 
-- 
1.7.10.4
