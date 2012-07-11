From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 18/27] iommu/amd: Add IRTE invalidation routine
Date: Wed, 11 Jul 2012 15:39:03 +0200
Message-ID: <1342013952-10174-19-git-send-email-joerg.roedel@amd.com>
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

Add routine to invalidate the IOMMU cache for interupt
translations. Also include the IRTE caches when flushing all
IOMMU caches.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |   27 +++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |    1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b02db09..26ebd28 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -834,6 +834,13 @@ static void build_inv_all(struct iommu_cmd *cmd)
 	CMD_SET_TYPE(cmd, CMD_INV_ALL);
 }
 
+static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->data[0] = devid;
+	CMD_SET_TYPE(cmd, CMD_INV_IRT);
+}
+
 /*
  * Writes the command to the IOMMUs command buffer and informs the
  * hardware about the new command.
@@ -955,12 +962,32 @@ static void iommu_flush_all(struct amd_iommu *iommu)
 	iommu_completion_wait(iommu);
 }
 
+static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
+{
+	struct iommu_cmd cmd;
+
+	build_inv_irt(&cmd, devid);
+
+	iommu_queue_command(iommu, &cmd);
+}
+
+static void iommu_flush_irt_all(struct amd_iommu *iommu)
+{
+	u32 devid;
+
+	for (devid = 0; devid <= 0xffff; ++devid)
+		iommu_flush_irt(iommu, devid);
+
+	iommu_completion_wait(iommu);
+}
+
 void iommu_flush_all_caches(struct amd_iommu *iommu)
 {
 	if (iommu_feature(iommu, FEATURE_IA)) {
 		iommu_flush_all(iommu);
 	} else {
 		iommu_flush_dte_all(iommu);
+		iommu_flush_irt_all(iommu);
 		iommu_flush_tlb_all(iommu);
 	}
 }
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index ceaa499..7827bb8 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -152,6 +152,7 @@
 #define CMD_INV_DEV_ENTRY       0x02
 #define CMD_INV_IOMMU_PAGES	0x03
 #define CMD_INV_IOTLB_PAGES	0x04
+#define CMD_INV_IRT		0x05
 #define CMD_COMPLETE_PPR	0x07
 #define CMD_INV_ALL		0x08
 
-- 
1.7.9.5
