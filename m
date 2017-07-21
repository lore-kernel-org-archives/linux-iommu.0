From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 08/13] iommu: Add is_attach_deferred call-back to iommu-ops
Date: Fri, 21 Jul 2017 16:59:06 +0800
Message-ID: <1500627551-12930-9-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

This new call-back will be used to check if the domain attach need be
deferred for now. If yes, the domain attach/detach will return directly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/iommu.c | 8 ++++++++
 include/linux/iommu.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f6ea160afed..86581b115b92 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1283,6 +1283,10 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	int ret;
+	if ((domain->ops->is_attach_deferred != NULL) &&
+	    domain->ops->is_attach_deferred(domain, dev))
+		return 0;
+
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
@@ -1324,6 +1328,10 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
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
index 2cb54adc4a33..63983c9e6c3a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -225,6 +225,7 @@ struct iommu_ops {
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
 	unsigned long pgsize_bitmap;
 };
-- 
2.5.5
