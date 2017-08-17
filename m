From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/13] iommu/amd: Rename a few flush functions
Date: Thu, 17 Aug 2017 14:56:24 +0200
Message-ID: <1502974596-23835-2-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Rename a few iommu cache-flush functions that start with
iommu_ to start with amd_iommu now. This is to prevent name
collisions with generic iommu code later on.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 354cbd6..5469457 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1165,7 +1165,7 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 	return iommu_queue_command(iommu, &cmd);
 }
 
-static void iommu_flush_dte_all(struct amd_iommu *iommu)
+static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
 
@@ -1179,7 +1179,7 @@ static void iommu_flush_dte_all(struct amd_iommu *iommu)
  * This function uses heavy locking and may disable irqs for some time. But
  * this is no issue because it is only called during resume.
  */
-static void iommu_flush_tlb_all(struct amd_iommu *iommu)
+static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 {
 	u32 dom_id;
 
@@ -1193,7 +1193,7 @@ static void iommu_flush_tlb_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
-static void iommu_flush_all(struct amd_iommu *iommu)
+static void amd_iommu_flush_all(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
 
@@ -1212,7 +1212,7 @@ static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
 	iommu_queue_command(iommu, &cmd);
 }
 
-static void iommu_flush_irt_all(struct amd_iommu *iommu)
+static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 {
 	u32 devid;
 
@@ -1225,11 +1225,11 @@ static void iommu_flush_irt_all(struct amd_iommu *iommu)
 void iommu_flush_all_caches(struct amd_iommu *iommu)
 {
 	if (iommu_feature(iommu, FEATURE_IA)) {
-		iommu_flush_all(iommu);
+		amd_iommu_flush_all(iommu);
 	} else {
-		iommu_flush_dte_all(iommu);
-		iommu_flush_irt_all(iommu);
-		iommu_flush_tlb_all(iommu);
+		amd_iommu_flush_dte_all(iommu);
+		amd_iommu_flush_irt_all(iommu);
+		amd_iommu_flush_tlb_all(iommu);
 	}
 }
 
-- 
2.7.4
