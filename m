Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7F8BEA
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690437073; x=1721973073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ulMr9wPtn9uYcKfwqArtgtZrYZ0jBZQeJBIA/9kFdy4=;
  b=AAw+roY5cSpI5klepE/cQ0vJFTbaH6H56LC3wCNoRwBv33ruBCycn+w9
   y1Hi50X4D2oq/x16J0PBUDKUvjbFVn4Wk28xzbfmpObchH5FoYzLD70fk
   UWPFmQK4YGQaCpGITSRSoGOAU3Trk2FwF7X2oCOlj50LBpw6FUtHbU8Mk
   BUmo5/C9yTWSWuP/dHODFfaFyfThOvVVHlT3WRkDBiz3MPAHsy0/UM1+E
   ZIUqs5C3i3mglJLjJ8LEfSFpxfxXhSyXb5raNP2zFwRqVPEoVKOoB3id3
   KS4xQej/Up/brL6BuEK70B+YqOzVVRqeq2CpRez+EkvvcaRaE2pMLfhEs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399152573"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399152573"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840585300"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840585300"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2023 22:51:08 -0700
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
Subject: [PATCH v2 07/12] iommu: Remove iommu_[un]register_device_fault_handler()
Date: Thu, 27 Jul 2023 13:48:32 +0800
Message-Id: <20230727054837.147050-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727054837.147050-1-baolu.lu@linux.intel.com>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pair of interfaces are not used anywhere in the tree. Remove it to
avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      | 23 ---------
 drivers/iommu/iommu-sva.h  |  4 +-
 drivers/iommu/io-pgfault.c |  6 +--
 drivers/iommu/iommu.c      | 96 --------------------------------------
 4 files changed, 4 insertions(+), 125 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1e4390d05a8..cb12bab38365 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -130,7 +130,6 @@ struct iommu_page_response {
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
-typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -469,14 +468,10 @@ struct iommu_fault_event {
 
 /**
  * struct iommu_fault_param - per-device IOMMU fault data
- * @handler: Callback function to handle IOMMU faults at device level
- * @data: handler private data
  * @faults: holds the pending faults which needs response
  * @lock: protect pending faults list
  */
 struct iommu_fault_param {
-	iommu_dev_fault_handler_t handler;
-	void *data;
 	struct list_head faults;
 	struct mutex lock;
 };
@@ -602,11 +597,6 @@ extern int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 extern struct iommu_group *iommu_group_get(struct device *dev);
 extern struct iommu_group *iommu_group_ref_get(struct iommu_group *group);
 extern void iommu_group_put(struct iommu_group *group);
-extern int iommu_register_device_fault_handler(struct device *dev,
-					iommu_dev_fault_handler_t handler,
-					void *data);
-
-extern int iommu_unregister_device_fault_handler(struct device *dev);
 
 extern int iommu_report_device_fault(struct device *dev,
 				     struct iommu_fault_event *evt);
@@ -988,19 +978,6 @@ static inline void iommu_group_put(struct iommu_group *group)
 {
 }
 
-static inline
-int iommu_register_device_fault_handler(struct device *dev,
-					iommu_dev_fault_handler_t handler,
-					void *data)
-{
-	return -ENODEV;
-}
-
-static inline int iommu_unregister_device_fault_handler(struct device *dev)
-{
-	return 0;
-}
-
 static inline
 int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 {
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index 54946b5a7caf..de7819c796ce 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -13,7 +13,7 @@ struct iommu_fault;
 struct iopf_queue;
 
 #ifdef CONFIG_IOMMU_SVA
-int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
+int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev);
 
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
 int iopf_queue_remove_device(struct iopf_queue *queue,
@@ -26,7 +26,7 @@ enum iommu_page_response_code
 iommu_sva_handle_iopf(struct iommu_fault *fault, void *data);
 
 #else /* CONFIG_IOMMU_SVA */
-static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+static inline int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 {
 	return -ENODEV;
 }
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index e5b8b9110c13..7e6697083f9d 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -103,7 +103,7 @@ static void iopf_handler(struct work_struct *work)
 /**
  * iommu_queue_iopf - IO Page Fault handler
  * @fault: fault event
- * @cookie: struct device, passed to iommu_register_device_fault_handler.
+ * @dev: struct device.
  *
  * Add a fault to the device workqueue, to be handled by mm.
  *
@@ -140,14 +140,12 @@ static void iopf_handler(struct work_struct *work)
  *
  * Return: 0 on success and <0 on error.
  */
-int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 {
 	int ret;
 	struct iopf_group *group;
 	struct iopf_fault *iopf, *next;
 	struct iopf_device_param *iopf_param;
-
-	struct device *dev = cookie;
 	struct dev_iommu *param = dev->iommu;
 
 	lockdep_assert_held(&param->lock);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e4ff984aa85..157a28a49473 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1262,98 +1262,6 @@ void iommu_group_put(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_put);
 
-/**
- * iommu_register_device_fault_handler() - Register a device fault handler
- * @dev: the device
- * @handler: the fault handler
- * @data: private data passed as argument to the handler
- *
- * When an IOMMU fault event is received, this handler gets called with the
- * fault event and data as argument. The handler should return 0 on success. If
- * the fault is recoverable (IOMMU_FAULT_PAGE_REQ), the consumer should also
- * complete the fault by calling iommu_page_response() with one of the following
- * response code:
- * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
- * - IOMMU_PAGE_RESP_INVALID: terminate the fault
- * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
- *   page faults if possible.
- *
- * Return 0 if the fault handler was installed successfully, or an error.
- */
-int iommu_register_device_fault_handler(struct device *dev,
-					iommu_dev_fault_handler_t handler,
-					void *data)
-{
-	struct dev_iommu *param = dev->iommu;
-	int ret = 0;
-
-	if (!param)
-		return -EINVAL;
-
-	mutex_lock(&param->lock);
-	/* Only allow one fault handler registered for each device */
-	if (param->fault_param) {
-		ret = -EBUSY;
-		goto done_unlock;
-	}
-
-	get_device(dev);
-	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
-	if (!param->fault_param) {
-		put_device(dev);
-		ret = -ENOMEM;
-		goto done_unlock;
-	}
-	param->fault_param->handler = handler;
-	param->fault_param->data = data;
-	mutex_init(&param->fault_param->lock);
-	INIT_LIST_HEAD(&param->fault_param->faults);
-
-done_unlock:
-	mutex_unlock(&param->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
-
-/**
- * iommu_unregister_device_fault_handler() - Unregister the device fault handler
- * @dev: the device
- *
- * Remove the device fault handler installed with
- * iommu_register_device_fault_handler().
- *
- * Return 0 on success, or an error.
- */
-int iommu_unregister_device_fault_handler(struct device *dev)
-{
-	struct dev_iommu *param = dev->iommu;
-	int ret = 0;
-
-	if (!param)
-		return -EINVAL;
-
-	mutex_lock(&param->lock);
-
-	if (!param->fault_param)
-		goto unlock;
-
-	/* we cannot unregister handler if there are pending faults */
-	if (!list_empty(&param->fault_param->faults)) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
-	kfree(param->fault_param);
-	param->fault_param = NULL;
-	put_device(dev);
-unlock:
-	mutex_unlock(&param->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
-
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
@@ -1378,10 +1286,6 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	/* we only report device fault if there is a handler registered */
 	mutex_lock(&param->lock);
 	fparam = param->fault_param;
-	if (!fparam || !fparam->handler) {
-		ret = -EINVAL;
-		goto done_unlock;
-	}
 
 	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
 	    (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
-- 
2.34.1

