From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/5] iommu: remove unused priv field from struct iommu_ops
Date: Thu,  7 Apr 2016 18:42:04 +0100
Message-ID: <8ff9d80f39489b283f168afbf92971631788ae0c.1460048991.git.robin.murphy@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

The priv field from iommu_ops is a hangover from the of_dma_configure
series and isn't actually used. Remove it before it has chance to
spread.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 include/linux/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 62a5eae..45b055d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -157,7 +157,6 @@ struct iommu_dm_region {
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of supported page sizes
- * @priv: per-instance data private to the iommu driver
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -199,7 +198,6 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 
 	unsigned long pgsize_bitmap;
-	void *priv;
 };
 
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
-- 
2.7.3.dirty
