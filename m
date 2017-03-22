From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v12 05/10] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Wed, 22 Mar 2017 02:02:37 -0500
Message-ID: <1490166162-10002-6-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1490166162-10002-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490166162-10002-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Introduce amd_iommu_get_num_iommus(), which returns the value of
amd_iommus_present. The function is used to replace direct access to
the variable, which is now declared as static.

This function will also be used by Perf AMD IOMMU driver.

Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.h     |  2 ++
 drivers/iommu/amd_iommu.c       |  6 +++---
 drivers/iommu/amd_iommu_init.c  | 11 +++++++++--
 drivers/iommu/amd_iommu_proto.h |  1 +
 drivers/iommu/amd_iommu_types.h |  3 ---
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index 845d173..5c5c932 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -28,6 +28,8 @@
 #define IOMMU_BASE_DEVID			0x0000
 
 /* amd_iommu_init.c external support functions */
+extern int amd_iommu_get_num_iommus(void);
+
 extern bool amd_iommu_pc_supported(void);
 
 extern u8 amd_iommu_pc_get_max_banks(u16 devid);
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 98940d1..5d4dd94 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1234,7 +1234,7 @@ static void __domain_flush_pages(struct protection_domain *domain,
 
 	build_inv_iommu_pages(&cmd, address, size, domain->id, pde);
 
-	for (i = 0; i < amd_iommus_present; ++i) {
+	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
 		if (!domain->dev_iommu[i])
 			continue;
 
@@ -1278,7 +1278,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 {
 	int i;
 
-	for (i = 0; i < amd_iommus_present; ++i) {
+	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
 		if (domain && !domain->dev_iommu[i])
 			continue;
 
@@ -3363,7 +3363,7 @@ static int __flush_pasid(struct protection_domain *domain, int pasid,
 	 * IOMMU TLB needs to be flushed before Device TLB to
 	 * prevent device TLB refill from IOMMU TLB
 	 */
-	for (i = 0; i < amd_iommus_present; ++i) {
+	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
 		if (domain->dev_iommu[i] == 0)
 			continue;
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index ce65a47..d3ec9c3 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -167,7 +167,9 @@ struct ivmd_header {
 
 /* Array to assign indices to IOMMUs*/
 struct amd_iommu *amd_iommus[MAX_IOMMUS];
-int amd_iommus_present;
+
+/* Number of IOMMUs present in the system */
+static int amd_iommus_present;
 
 /* IOMMUs have a non-present cache? */
 bool amd_iommu_np_cache __read_mostly;
@@ -272,6 +274,11 @@ static inline unsigned long tbl_size(int entry_size)
 	return 1UL << shift;
 }
 
+int amd_iommu_get_num_iommus(void)
+{
+	return amd_iommus_present;
+}
+
 /* Access to l1 and l2 indexed register spaces */
 
 static u32 iommu_read_l1(struct amd_iommu *iommu, u16 l1, u8 address)
@@ -1336,7 +1343,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
-	iommu->index             = amd_iommus_present++;
+	iommu->index = amd_iommus_present++;
 
 	if (unlikely(iommu->index >= MAX_IOMMUS)) {
 		WARN(1, "AMD-Vi: System has more IOMMUs than supported by this driver\n");
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 7eb60c1..e8f0710 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -21,6 +21,7 @@
 
 #include "amd_iommu_types.h"
 
+extern int amd_iommu_get_num_iommus(void);
 extern int amd_iommu_init_dma_ops(void);
 extern int amd_iommu_init_passthrough(void);
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 003f3ce..4de8f41 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -611,9 +611,6 @@ struct devid_map {
  */
 extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
 
-/* Number of IOMMUs present in the system */
-extern int amd_iommus_present;
-
 /*
  * Declarations for the global list of all protection domains
  */
-- 
1.8.3.1
