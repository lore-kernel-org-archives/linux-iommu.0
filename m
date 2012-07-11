From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/27] iommu/amd: Move informational prinks out of iommu_enable
Date: Wed, 11 Jul 2012 15:38:51 +0200
Message-ID: <1342013952-10174-7-git-send-email-joerg.roedel@amd.com>
References: <1342013952-10174-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342013952-10174-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This function will be called before the PCI subsystem is
initialized. Therefore dev_name doen't work and IOMMU
information can't be printed to the klog as before. Move the
code to print that information to a later point where PCI
initializtion has already happened.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   44 ++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index fa6ca8b..bcdcaac 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -312,23 +312,6 @@ static void iommu_set_inv_tlb_timeout(struct amd_iommu *iommu, int timeout)
 /* Function to enable the hardware */
 static void iommu_enable(struct amd_iommu *iommu)
 {
-	static const char * const feat_str[] = {
-		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
-		"IA", "GA", "HE", "PC", NULL
-	};
-	int i;
-
-	printk(KERN_INFO "AMD-Vi: Enabling IOMMU at %s cap 0x%hx",
-	       dev_name(&iommu->dev->dev), iommu->cap_ptr);
-
-	if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-		printk(KERN_CONT " extended features: ");
-		for (i = 0; feat_str[i]; ++i)
-			if (iommu_feature(iommu, (1ULL << i)))
-				printk(KERN_CONT " %s", feat_str[i]);
-	}
-	printk(KERN_CONT "\n");
-
 	iommu_feature_enable(iommu, CONTROL_IOMMU_EN);
 }
 
@@ -1096,6 +1079,31 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	return pci_enable_device(iommu->dev);
 }
 
+static void print_iommu_info(void)
+{
+	static const char * const feat_str[] = {
+		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
+		"IA", "GA", "HE", "PC"
+	};
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		int i;
+
+		pr_info("AMD-Vi: Found IOMMU at %s cap 0x%hx\n",
+			dev_name(&iommu->dev->dev), iommu->cap_ptr);
+
+		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
+			pr_info("AMD-Vi:  Extended features: ");
+			for (i = 0; ARRAY_SIZE(feat_str); ++i) {
+				if (iommu_feature(iommu, (1ULL << i)))
+					pr_cont(" %s", feat_str[i]);
+			}
+		}
+		pr_cont("\n");
+	}
+}
+
 static int amd_iommu_init_pci(void)
 {
 	struct amd_iommu *iommu;
@@ -1112,6 +1120,8 @@ static int amd_iommu_init_pci(void)
 
 	ret = amd_iommu_init_devices();
 
+	print_iommu_info();
+
 	return ret;
 }
 
-- 
1.7.9.5
