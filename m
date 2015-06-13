From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/19] iommu/vt-d: Don't copy translation tables if RTT bit
	needs to be changed
Date: Sat, 13 Jun 2015 08:47:18 +0200
Message-ID: <1434178047-17809-11-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

We can't change the RTT bit when translation is enabled, so
don't copy translation tables when we would change the bit
with our new root entry.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 39bc3d6..e23d5b4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2914,10 +2914,20 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	unsigned long flags;
 	u64 rtaddr_reg;
 	int bus, ret;
-	bool ext;
+	bool new_ext, ext;
 
 	rtaddr_reg = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
 	ext        = !!(rtaddr_reg & DMA_RTADDR_RTT);
+	new_ext    = !!ecap_ecs(iommu->ecap);
+
+	/*
+	 * The RTT bit can only be changed when translation is disabled,
+	 * but disabling translation means to open a window for data
+	 * corruption. So bail out and don't copy anything if we would
+	 * have to change the bit.
+	 */
+	if (new_ext != ext)
+		return -EINVAL;
 
 	old_rt_phys = rtaddr_reg & VTD_PAGE_MASK;
 	if (!old_rt_phys)
-- 
1.9.1
