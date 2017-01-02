From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 RESEND 06/12] iommu: Add is_attach_deferred call-back to
	iommu-ops
Date: Mon,  2 Jan 2017 15:39:52 +0800
Message-ID: <1483342798-6542-7-git-send-email-bhe@redhat.com>
References: <1483342798-6542-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483342798-6542-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This new call-back will be used to check if the domain attach need be
deferred for now. If yes, the domain attach/detach will return directly.

Suggested-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c | 8 ++++++++
 include/linux/iommu.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dbe7f65..e5cb9b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1096,6 +1096,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	int ret;
+	if ((domain->ops->is_attach_deferred != NULL) &&
+	    domain->ops->is_attach_deferred(domain, dev))
+		return 0;
+
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
@@ -1137,6 +1141,10 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
+	if ((domain->ops->is_attach_deferred != NULL) &&
+	    domain->ops->is_attach_deferred(domain, dev))
+		return;
+
 	if (unlikely(domain->ops->detach_dev == NULL))
 		return;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0ff5111..5aa3742 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -200,6 +200,7 @@ struct iommu_ops {
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
 	unsigned long pgsize_bitmap;
 };
-- 
2.5.5
