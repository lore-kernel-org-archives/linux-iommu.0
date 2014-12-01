From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v6 3/8] iommu: add new iommu_ops callback for adding an OF
	device
Date: Mon,  1 Dec 2014 16:57:09 +0000
Message-ID: <1417453034-21379-4-git-send-email-will.deacon@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417453034-21379-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds a new function to the iommu_ops structure to allow an
OF device to be added to a specific IOMMU instance using the recently
merged generic devicetree binding for IOMMUs. The callback (of_xlate)
takes a struct device representing the master and an of_phandle_args
representing the IOMMU and the correspondong IDs for the new master.

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7b83f9f8e11d..415c7613d02c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -21,6 +21,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/types.h>
 #include <trace/events/iommu.h>
 
@@ -102,6 +103,7 @@ enum iommu_attr {
  * @remove_device: remove device from iommu grouping
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
+ * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of supported page sizes
  * @priv: per-instance data private to the iommu driver
  */
@@ -133,6 +135,10 @@ struct iommu_ops {
 	/* Get the numer of window per domain */
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
+#ifdef CONFIG_OF_IOMMU
+	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+#endif
+
 	unsigned long pgsize_bitmap;
 	void *priv;
 };
-- 
2.1.1
