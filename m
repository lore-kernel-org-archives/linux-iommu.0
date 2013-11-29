From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu: add IOMMU_EXEC flag for safely allowing XN mappings
Date: Fri, 29 Nov 2013 12:15:49 +0000
Message-ID: <1385727350-20032-4-git-send-email-will.deacon@arm.com>
References: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1385727350-20032-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Whilst most IOMMU mappings should probably be non-executable, there
may be cases (HSA?) where executable mappings are required.

This patch introduces a new mapping flag, IOMMU_EXEC, to indicate that
the mapping should be mapped as executable.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 include/linux/iommu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a444c790fa72..709a697c4e02 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -24,9 +24,10 @@
 #include <linux/types.h>
 #include <trace/events/iommu.h>
 
-#define IOMMU_READ	(1)
-#define IOMMU_WRITE	(2)
-#define IOMMU_CACHE	(4) /* DMA cache coherency */
+#define IOMMU_READ	(1 << 0)
+#define IOMMU_WRITE	(1 << 1)
+#define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
+#define IOMMU_EXEC	(1 << 3)
 
 struct iommu_ops;
 struct iommu_group;
-- 
1.8.2.2
