From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] iommu/amd: Fallback to dma_direct_ops when fail to enable IOMMU
Date: Tue, 19 Jun 2018 11:45:34 -0500
Message-ID: <1529426734-20639-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1529426734-20639-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529426734-20639-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

In case the AMD IOMMU driver fails to enable interrupt, it currently
results in failure to boot due to invalid dma_ops for buses and devices
previously set when they were added to the IOMMU.

Therefore, fix this by unsetting the bus's iommu, and setup end-point
devices to use dma_direct_ops.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 14 +++++++++++++-
 drivers/iommu/amd_iommu_init.c  | 19 +++++++++++++++++--
 drivers/iommu/amd_iommu_proto.h |  2 ++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5337fb2..3446763 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -381,6 +381,9 @@ static bool check_device(struct device *dev)
 {
 	int devid;
 
+	if (amd_iommu_failed_initialize())
+		return false;
+
 	if (!dev || !dev->dma_mask)
 		return false;
 
@@ -486,7 +489,7 @@ static void iommu_uninit_device(struct device *dev)
 	iommu_group_remove_device(dev);
 
 	/* Remove dma-ops */
-	dev->dma_ops = NULL;
+	dev->dma_ops = &dma_direct_ops;
 
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
@@ -2722,6 +2725,15 @@ static int init_reserved_iova_ranges(void)
 	return 0;
 }
 
+void __init amd_iommu_uninit_api(void)
+{
+	bus_unset_iommu(&pci_bus_type, &amd_iommu_ops);
+#ifdef CONFIG_ARM_AMBA
+	bus_unset_iommu(&amba_bustype, &amd_iommu_ops);
+#endif
+	bus_unset_iommu(&platform_bus_type, &amd_iommu_ops);
+}
+
 int __init amd_iommu_init_api(void)
 {
 	int ret, err = 0;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 09d271e..d3f9cb3 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -245,6 +245,7 @@ enum iommu_init_state {
 	IOMMU_INITIALIZED,
 	IOMMU_NOT_FOUND,
 	IOMMU_INIT_ERROR,
+	IOMMU_RESOURCE_FREE,
 	IOMMU_CMDLINE_DISABLED,
 };
 
@@ -307,6 +308,11 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
+bool amd_iommu_failed_initialize(void)
+{
+	return init_state == IOMMU_RESOURCE_FREE;
+}
+
 /* Access to l1 and l2 indexed register spaces */
 
 static u32 iommu_read_l1(struct amd_iommu *iommu, u16 l1, u8 address)
@@ -2331,10 +2337,14 @@ static void __init free_iommu_resources(void)
 
 	free_iommu_all();
 
+	/*
+	 * We failed to initialize the AMD IOMMU driver,
+	 * and all resources are freed.
+	 */
+	init_state = IOMMU_RESOURCE_FREE;
 #ifdef CONFIG_GART_IOMMU
 	/*
-	 * We failed to initialize the AMD IOMMU - try fallback to GART
-	 * if possible.
+	 * try fallback to GART if possible.
 	 */
 	gart_iommu_init();
 
@@ -2583,6 +2593,8 @@ static int amd_iommu_enable_interrupts(void)
 	}
 
 out:
+	if (ret)
+		pr_err("AMD-Vi: Failed to enable IOMMU interrupts.\n");
 	return ret;
 }
 
@@ -2665,6 +2677,7 @@ static int __init state_next(void)
 		break;
 	case IOMMU_NOT_FOUND:
 	case IOMMU_INIT_ERROR:
+	case IOMMU_RESOURCE_FREE:
 	case IOMMU_CMDLINE_DISABLED:
 		/* Error states => do nothing */
 		ret = -EINVAL;
@@ -2684,6 +2697,7 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 	while (init_state != state) {
 		if (init_state == IOMMU_NOT_FOUND         ||
 		    init_state == IOMMU_INIT_ERROR        ||
+		    init_state == IOMMU_RESOURCE_FREE     ||
 		    init_state == IOMMU_CMDLINE_DISABLED)
 			break;
 		ret = state_next();
@@ -2747,6 +2761,7 @@ static int __init amd_iommu_init(void)
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
 	if (ret) {
+		amd_iommu_uninit_api();
 		free_dma_resources();
 		if (!irq_remapping_enabled) {
 			disable_iommus();
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 640c286..7d81254 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -32,6 +32,8 @@ extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
+extern void amd_iommu_uninit_api(void);
+extern bool amd_iommu_failed_initialize(void);
 
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
-- 
2.7.4
