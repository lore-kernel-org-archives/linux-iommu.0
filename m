From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 3/9] iommu/amd: make several functions globally seen
Date: Fri,  6 Nov 2015 20:10:45 +0800
Message-ID: <1446811851-20623-4-git-send-email-bhe@redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446811851-20623-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

They will be called later when copy old dev/irq tables. It's better to use them
then call iommu_flush_all_caches() since iommu_flush_all_caches() will
iterate many empty table entries.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 4 ++--
 drivers/iommu/amd_iommu_proto.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b01006d..48bcd83 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -995,7 +995,7 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
  */
-static int iommu_completion_wait(struct amd_iommu *iommu)
+int iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
 	volatile u64 sem = 0;
@@ -1013,7 +1013,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	return wait_on_sem(&sem);
 }
 
-static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_cmd cmd;
 
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 743e209..62d8f2f 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -101,5 +101,7 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
 /* kdump checking  */
 extern bool translation_pre_enabled(void);
 extern void clear_translation_pre_enabled(void);
+extern int iommu_completion_wait(struct amd_iommu *iommu);
+extern int iommu_flush_dte(struct amd_iommu *iommu, u16 devid);
 
 #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
-- 
2.4.0
