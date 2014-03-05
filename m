From: <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: Fix logics to determine and checking max PASID
Date: Wed, 5 Mar 2014 13:01:08 -0600
Message-ID: <1394046068-3858-1-git-send-email-suravee.suthikulpanit@amd.com>
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
Cc: jay.cornwall-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kim.naru-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

According to IOMMUv2, max PASID is defined as ((2^(PASmax+1)) - 1)
using the value from MMIOx30[PASmax] register.  The current does not
determine this correctly. Also the PASID_MASK should be determined by
max PASID instead of hardcoding value of 0xfffff.

Adding logic to check the number of bits used for PASID before issuing
CMD_INV_IOTLB_PAGES and CMD_COMPLETE_PPR since they only support 16-bit
PASID. However, this should not affect the currently available
hardware since they only implement 16-bit PASID.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Tested-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>

---
 drivers/iommu/amd_iommu.c       |   26 +++++++++++++++++++++++---
 drivers/iommu/amd_iommu_init.c  |   15 ++++++++-------
 drivers/iommu/amd_iommu_types.h |    6 ++----
 drivers/iommu/amd_iommu_v2.c    |    2 +-
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index faf0da4..d9d64ce 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -963,7 +963,7 @@ static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int pasid,
 
 	address &= ~(0xfffULL);
 
-	cmd->data[0]  = pasid & PASID_MASK;
+	cmd->data[0]  = pasid & amd_iommu_max_pasid;
 	cmd->data[1]  = domid;
 	cmd->data[2]  = lower_32_bits(address);
 	cmd->data[3]  = upper_32_bits(address);
@@ -977,6 +977,16 @@ static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int pasid,
 static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
 				  int qdep, u64 address, bool size)
 {
+	/* Note:
+	 * This command supports only 16-bit PASID.
+	 * Currently, hardware only implement upto 16-bit PASID
+	 * even though the spec says it could have upto 20 bits.
+	 * This is likely to be updated in the future revision of
+	 * IOMMU specs when the hardware with PASID > 16 bits
+	 * become available.
+	 */
+	BUG_ON(pasid > 0xFFFF);
+
 	memset(cmd, 0, sizeof(*cmd));
 
 	address &= ~(0xfffULL);
@@ -997,11 +1007,21 @@ static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
 static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, int pasid,
 			       int status, int tag, bool gn)
 {
+	/* Note:
+	 * This command supports only 16-bit PASID.
+	 * Currently, hardware only implement upto 16-bit PASID
+	 * even though the spec says it could have upto 20 bits.
+	 * This is likely to be updated in the future revision of
+	 * IOMMU specs when the hardware with PASID > 16 bits
+	 * become available.
+	 */
+	BUG_ON(pasid > 0xFFFF);
+
 	memset(cmd, 0, sizeof(*cmd));
 
 	cmd->data[0]  = devid;
 	if (gn) {
-		cmd->data[1]  = pasid & PASID_MASK;
+		cmd->data[1]  = pasid & amd_iommu_max_pasid;
 		cmd->data[2]  = CMD_INV_IOMMU_PAGES_GN_MASK;
 	}
 	cmd->data[3]  = tag & 0x1ff;
@@ -3570,7 +3590,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	unsigned long flags;
 	int levels, ret;
 
-	if (pasids <= 0 || pasids > (PASID_MASK + 1))
+	if (pasids <= 0 || pasids > (amd_iommu_max_pasid + 1))
 		return -EINVAL;
 
 	/* Number of GCR3 table levels required */
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 28b4bea..ce2a3b3 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -150,7 +150,8 @@ int amd_iommus_present;
 bool amd_iommu_np_cache __read_mostly;
 bool amd_iommu_iotlb_sup __read_mostly = true;
 
-u32 amd_iommu_max_pasids __read_mostly = ~0;
+u32 amd_iommu_max_pasid __read_mostly = ~0;
+EXPORT_SYMBOL(amd_iommu_max_pasid);
 
 bool amd_iommu_v2_present __read_mostly;
 bool amd_iommu_pc_present __read_mostly;
@@ -1231,14 +1232,14 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 
 	if (iommu_feature(iommu, FEATURE_GT)) {
 		int glxval;
-		u32 pasids;
-		u64 shift;
+		u32 max_pasid;
+		u64 pasmax;
 
-		shift   = iommu->features & FEATURE_PASID_MASK;
-		shift >>= FEATURE_PASID_SHIFT;
-		pasids  = (1 << shift);
+		pasmax = iommu->features & FEATURE_PASID_MASK;
+		pasmax >>= FEATURE_PASID_SHIFT;
+		max_pasid  = (1 << (pasmax + 1)) - 1;
 
-		amd_iommu_max_pasids = min(amd_iommu_max_pasids, pasids);
+		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
 
 		glxval   = iommu->features & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e400fbe..f7ab2d2 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -98,8 +98,6 @@
 #define FEATURE_GLXVAL_SHIFT	14
 #define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
 
-#define PASID_MASK		0x000fffff
-
 /* MMIO status bits */
 #define MMIO_STATUS_EVT_INT_MASK	(1 << 1)
 #define MMIO_STATUS_COM_WAIT_INT_MASK	(1 << 2)
@@ -696,8 +694,8 @@ extern unsigned long *amd_iommu_pd_alloc_bitmap;
  */
 extern u32 amd_iommu_unmap_flush;
 
-/* Smallest number of PASIDs supported by any IOMMU in the system */
-extern u32 amd_iommu_max_pasids;
+/* Smallest max PASID supported by any IOMMU in the system */
+extern u32 amd_iommu_max_pasid;
 
 extern bool amd_iommu_v2_present;
 
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 5208828..cd328e9 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -760,7 +760,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (!amd_iommu_v2_supported())
 		return -ENODEV;
 
-	if (pasids <= 0 || pasids > (PASID_MASK + 1))
+	if (pasids <= 0 || pasids > (amd_iommu_max_pasid + 1))
 		return -EINVAL;
 
 	devid = device_id(pdev);
-- 
1.7.10.4
