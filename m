From: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeout
Date: Mon, 24 Apr 2017 17:29:36 +0530
Message-ID: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>
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
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

When large memory is being unmapped, huge no of tlb invalidation cmds are
submitted followed by a SYNC command. This sometimes hits CMD queue full and
poll on queue drain is being timedout throwing error message 'CMD_SYNC timeout'.

Although there is no functional issue, error message confuses user. Hence increased
poll timeout to 500us

Signed-off-by: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 591bb96..1dcd154 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -407,7 +407,7 @@
 #define PRIQ_1_ADDR_MASK		0xfffffffffffffUL
 
 /* High-level queue structures */
-#define ARM_SMMU_POLL_TIMEOUT_US	100
+#define ARM_SMMU_POLL_TIMEOUT_US	500
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
-- 
1.9.1
