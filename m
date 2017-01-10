From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v7 6/7] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Mon, 9 Jan 2017 21:33:46 -0600
Message-ID: <1484019227-11473-7-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

This patch introduces amd_iommu_get_num_iommus(). This is intended for
Perf AMD IOMMU driver.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.h    | 2 ++
 drivers/iommu/amd_iommu_init.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index 342716e..381f1c4 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -25,6 +25,8 @@
 #define PC_MAX_SPEC_CNTRS			16
 
 /* amd_iommu_init.c external support functions */
+extern int amd_iommu_get_num_iommus(void);
+
 extern bool amd_iommu_pc_supported(void);
 
 extern u8 amd_iommu_pc_get_max_banks(uint idx);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index c993c77..c3740cb 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1329,7 +1329,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
-	iommu->index             = amd_iommus_present++;
+	iommu->index = amd_iommus_present++;
 
 	if (unlikely(iommu->index >= MAX_IOMMUS)) {
 		WARN(1, "AMD-Vi: System has more IOMMUs than supported by this driver\n");
@@ -2717,6 +2717,11 @@ static struct amd_iommu *get_amd_iommu(uint idx)
 	return iommu;
 }
 
+int amd_iommu_get_num_iommus(void)
+{
+	return amd_iommus_present;
+}
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
-- 
1.8.3.1
