Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFC382
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689037750; x=1720573750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+AYwr3bKWy7rpxtl+3/vsQbCiRF0Z5vJWyLMxV8Tnsg=;
  b=C9A91m9DJZJJYq2xaglXbsKxhM9o/xyLAhRzqXJZ+fet8uaLSwyzZq12
   KsbIqnObELJ8hvXpQ1xf5ICEfYsWlqFa8fPe/p+cppiBrEXB3rNTk19MI
   J1YwwYkTV40MsdYdQbMV/TrmiXOKbKiBU8OB8kYr4+j9MWUiGThSgFlUe
   dqqWSJ8b7+bgGLrZ9vzfF5guNg2tMQbZWp7FqUJs/wChVf6NVVB6I2pbr
   rbcwwEsYSzqS9e+k/6eDg/udDdDiZKECcINIDm11aecYiHvKelJERbU9v
   icLa3cBBB4Uj60IWeInUitgOzZL539Sb2olSRBKVQlkO388Y6sTartL+D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344816169"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="344816169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="810999967"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="810999967"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 18:09:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 9/9] iommu: Use fault cookie to store iopf_param
Date: Tue, 11 Jul 2023 09:06:42 +0800
Message-Id: <20230711010642.19707-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711010642.19707-1-baolu.lu@linux.intel.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the static iopf_param pointer from struct iommu_fault_param to
save memory.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  2 --
 drivers/iommu/io-pgfault.c | 47 +++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ffd6fe1317f4..5fe37a7c5a55 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -551,7 +551,6 @@ struct iommu_fault_param {
  * struct dev_iommu - Collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
- * @iopf_param:	 I/O Page Fault queue and data
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
@@ -564,7 +563,6 @@ struct iommu_fault_param {
 struct dev_iommu {
 	struct mutex lock;
 	struct iommu_fault_param	*fault_param;
-	struct iopf_device_param	*iopf_param;
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1749e0869f2e..6a3a4e08e67e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -158,7 +158,7 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 	 * As long as we're holding param->lock, the queue can't be unlinked
 	 * from the device and therefore cannot disappear.
 	 */
-	iopf_param = param->iopf_param;
+	iopf_param = iommu_get_device_fault_cookie(dev, 0);
 	if (!iopf_param)
 		return -ENODEV;
 
@@ -235,7 +235,7 @@ int iopf_queue_flush_dev(struct device *dev)
 		return -ENODEV;
 
 	mutex_lock(&param->lock);
-	iopf_param = param->iopf_param;
+	iopf_param = iommu_get_device_fault_cookie(dev, 0);
 	if (iopf_param)
 		flush_workqueue(iopf_param->queue->wq);
 	else
@@ -286,9 +286,9 @@ EXPORT_SYMBOL_GPL(iopf_queue_discard_partial);
  */
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
 {
-	int ret = -EBUSY;
-	struct iopf_device_param *iopf_param;
+	struct iopf_device_param *iopf_param, *curr;
 	struct dev_iommu *param = dev->iommu;
+	int ret;
 
 	if (!param)
 		return -ENODEV;
@@ -303,16 +303,27 @@ int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
 
 	mutex_lock(&queue->lock);
 	mutex_lock(&param->lock);
-	if (!param->iopf_param) {
-		list_add(&iopf_param->queue_list, &queue->devices);
-		param->iopf_param = iopf_param;
-		ret = 0;
+	curr = iommu_set_device_fault_cookie(dev, 0, iopf_param);
+	if (IS_ERR(curr)) {
+		ret = PTR_ERR(curr);
+		goto err_free;
 	}
+
+	if (curr) {
+		ret = -EBUSY;
+		goto err_restore;
+	}
+	list_add(&iopf_param->queue_list, &queue->devices);
 	mutex_unlock(&param->lock);
 	mutex_unlock(&queue->lock);
 
-	if (ret)
-		kfree(iopf_param);
+	return 0;
+err_restore:
+	iommu_set_device_fault_cookie(dev, 0, curr);
+err_free:
+	mutex_unlock(&param->lock);
+	mutex_unlock(&queue->lock);
+	kfree(iopf_param);
 
 	return ret;
 }
@@ -329,7 +340,6 @@ EXPORT_SYMBOL_GPL(iopf_queue_add_device);
  */
 int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 {
-	int ret = -EINVAL;
 	struct iopf_fault *iopf, *next;
 	struct iopf_device_param *iopf_param;
 	struct dev_iommu *param = dev->iommu;
@@ -339,16 +349,17 @@ int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 
 	mutex_lock(&queue->lock);
 	mutex_lock(&param->lock);
-	iopf_param = param->iopf_param;
-	if (iopf_param && iopf_param->queue == queue) {
-		list_del(&iopf_param->queue_list);
-		param->iopf_param = NULL;
-		ret = 0;
+	iopf_param = iommu_get_device_fault_cookie(dev, 0);
+	if (!iopf_param || iopf_param->queue != queue) {
+		mutex_unlock(&param->lock);
+		mutex_unlock(&queue->lock);
+		return -EINVAL;
 	}
+
+	list_del(&iopf_param->queue_list);
+	iommu_set_device_fault_cookie(dev, 0, NULL);
 	mutex_unlock(&param->lock);
 	mutex_unlock(&queue->lock);
-	if (ret)
-		return ret;
 
 	/* Just in case some faults are still stuck */
 	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list)
-- 
2.34.1

