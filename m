Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4008BC43461
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA44961055
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA44961055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A36328487B;
	Fri,  9 Apr 2021 03:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id adnXLSZv2ivy; Fri,  9 Apr 2021 03:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F9888490C;
	Fri,  9 Apr 2021 03:44:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E61CC0016;
	Fri,  9 Apr 2021 03:44:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64BF3C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60F5860E4A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zeTGzpSZ3oFz for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 03:44:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BF1F60E47
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:44 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGkTF2QDmznZ7g;
 Fri,  9 Apr 2021 11:41:53 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 11:44:33 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v3 1/8] iommu: Evolve the device fault reporting framework
Date: Fri, 9 Apr 2021 11:44:13 +0800
Message-ID: <20210409034420.1799-2-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210409034420.1799-1-lushenming@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Cc: Kevin Tian <kevin.tian@intel.com>, Christoph Hellwig <hch@infradead.org>,
 lushenming@huawei.com, wanghaibin.wang@huawei.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch follows the discussion here:

https://lore.kernel.org/linux-acpi/YAaxjmJW+ZMvrhac@myrica/

Besides SVA/vSVA, such as VFIO may also enable (2nd level) IOPF to remove
pinning restriction. In order to better support more scenarios of using
device faults, we extend iommu_register_fault_handler() with flags and
introduce FAULT_REPORT_ to describe the device fault reporting capability
under a specific configuration.

Note that we don't further distinguish recoverable and unrecoverable faults
by flags in the fault reporting cap, having PAGE_FAULT_REPORT_ +
UNRECOV_FAULT_REPORT_ seems not a clean way.

In addition, still take VFIO as an example, in nested mode, the 1st level
and 2nd level fault reporting may be configured separately and currently
each device can only register one iommu dev fault handler, so we add a
handler update interface for this.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 18 ++++--
 drivers/iommu/iommu.c                         | 56 ++++++++++++++++++-
 include/linux/iommu.h                         | 19 ++++++-
 include/uapi/linux/iommu.h                    |  4 ++
 5 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index ee66d1f4cb81..e6d766fb8f1a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -482,7 +482,8 @@ static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
 	if (ret)
 		return ret;
 
-	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf,
+						  FAULT_REPORT_FLAT, dev);
 	if (ret) {
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 53abad8fdd91..51843f54a87f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1448,10 +1448,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (evt[1] & EVTQ_1_RnW)
 		perm |= IOMMU_FAULT_PERM_READ;
 	else
@@ -1469,26 +1465,36 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
 			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
 			.perm = perm,
-			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
 		};
 
 		if (ssid_valid) {
 			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
 			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
 		}
+
+		if (evt[1] & EVTQ_1_S2) {
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_L2;
+			flt->prm.addr = FIELD_GET(EVTQ_3_IPA, evt[3]);
+		} else
+			flt->prm.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]);
 	} else {
 		flt->type = IOMMU_FAULT_DMA_UNRECOV;
 		flt->event = (struct iommu_fault_unrecoverable) {
 			.reason = reason,
 			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID,
 			.perm = perm,
-			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
 		};
 
 		if (ssid_valid) {
 			flt->event.flags |= IOMMU_FAULT_UNRECOV_PASID_VALID;
 			flt->event.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
 		}
+
+		if (evt[1] & EVTQ_1_S2) {
+			flt->event.flags |= IOMMU_FAULT_UNRECOV_L2;
+			flt->event.addr = FIELD_GET(EVTQ_3_IPA, evt[3]);
+		} else
+			flt->event.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]);
 	}
 
 	mutex_lock(&smmu->streams_mutex);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..b50b526b45ac 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1056,6 +1056,40 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
+/*
+ * iommu_update_device_fault_handler - Update the device fault handler via flags
+ * @dev: the device
+ * @mask: bits(not set) to clear
+ * @set: bits to set
+ *
+ * Update the device fault handler installed by
+ * iommu_register_device_fault_handler().
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_update_device_fault_handler(struct device *dev, u32 mask, u32 set)
+{
+	struct dev_iommu *param = dev->iommu;
+	int ret = 0;
+
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->lock);
+
+	if (param->fault_param) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	param->fault_param->flags = (param->fault_param->flags & mask) | set;
+
+out_unlock:
+	mutex_unlock(&param->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_update_device_fault_handler);
+
 /**
  * iommu_register_device_fault_handler() - Register a device fault handler
  * @dev: the device
@@ -1076,11 +1110,16 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
  */
 int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
-					void *data)
+					u32 flags, void *data)
 {
 	struct dev_iommu *param = dev->iommu;
 	int ret = 0;
 
+	/* Only under one configuration. */
+	if (flags & FAULT_REPORT_FLAT &&
+	    flags & (FAULT_REPORT_NESTED_L1 | FAULT_REPORT_NESTED_L2))
+		return -EINVAL;
+
 	if (!param)
 		return -EINVAL;
 
@@ -1099,6 +1138,7 @@ int iommu_register_device_fault_handler(struct device *dev,
 		goto done_unlock;
 	}
 	param->fault_param->handler = handler;
+	param->fault_param->flags = flags;
 	param->fault_param->data = data;
 	mutex_init(&param->fault_param->lock);
 	INIT_LIST_HEAD(&param->fault_param->faults);
@@ -1177,6 +1217,20 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 		goto done_unlock;
 	}
 
+	if (!(fparam->flags & FAULT_REPORT_FLAT)) {
+		bool l2;
+
+		if (evt->fault.type == IOMMU_FAULT_PAGE_REQ)
+			l2 = evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_L2;
+		if (evt->fault.type == IOMMU_FAULT_DMA_UNRECOV)
+			l2 = evt->fault.event.flags & IOMMU_FAULT_UNRECOV_L2;
+
+		if (l2 && !(fparam->flags & FAULT_REPORT_NESTED_L2))
+			return -EOPNOTSUPP;
+		if (!l2 && !(fparam->flags & FAULT_REPORT_NESTED_L1))
+			return -EOPNOTSUPP;
+	}
+
 	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
 	    (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
 		evt_pending = kmemdup(evt, sizeof(struct iommu_fault_event),
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 86d688c4418f..28dbca3c6d60 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -352,12 +352,19 @@ struct iommu_fault_event {
 /**
  * struct iommu_fault_param - per-device IOMMU fault data
  * @handler: Callback function to handle IOMMU faults at device level
+ * @flags: FAULT_REPORT_ indicates the fault reporting capability under
+ *	   a specific configuration (1st/2nd-level-only(FLAT), or nested).
+ *	   Nested mode needs to specify which level/stage is concerned.
  * @data: handler private data
  * @faults: holds the pending faults which needs response
  * @lock: protect pending faults list
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
+#define FAULT_REPORT_FLAT			(1 << 0)
+#define FAULT_REPORT_NESTED_L1			(1 << 1)
+#define FAULT_REPORT_NESTED_L2			(1 << 2)
+	u32 flags;
 	void *data;
 	struct list_head faults;
 	struct mutex lock;
@@ -509,9 +516,11 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
+extern int iommu_update_device_fault_handler(struct device *dev,
+					     u32 mask, u32 set);
 extern int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
-					void *data);
+					u32 flags, void *data);
 
 extern int iommu_unregister_device_fault_handler(struct device *dev);
 
@@ -873,10 +882,16 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
 	return 0;
 }
 
+static inline int iommu_update_device_fault_handler(struct device *dev,
+						    u32 mask, u32 set)
+{
+	return -ENODEV;
+}
+
 static inline
 int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
-					void *data)
+					u32 flags, void *data)
 {
 	return -ENODEV;
 }
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index e1d9e75f2c94..f6db9c8c970c 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -71,6 +71,7 @@ struct iommu_fault_unrecoverable {
 #define IOMMU_FAULT_UNRECOV_PASID_VALID		(1 << 0)
 #define IOMMU_FAULT_UNRECOV_ADDR_VALID		(1 << 1)
 #define IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID	(1 << 2)
+#define IOMMU_FAULT_UNRECOV_L2			(1 << 3)
 	__u32	flags;
 	__u32	pasid;
 	__u32	perm;
@@ -85,6 +86,8 @@ struct iommu_fault_unrecoverable {
  *         When IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID is set, the page response
  *         must have the same PASID value as the page request. When it is clear,
  *         the page response should not have a PASID.
+ *         If IOMMU_FAULT_PAGE_REQUEST_L2 is set, the fault occurred at the
+ *         second level/stage, otherwise, occurred at the first level.
  * @pasid: Process Address Space ID
  * @grpid: Page Request Group Index
  * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
@@ -96,6 +99,7 @@ struct iommu_fault_page_request {
 #define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
 #define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
 #define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 3)
+#define IOMMU_FAULT_PAGE_REQUEST_L2		(1 << 4)
 	__u32	flags;
 	__u32	pasid;
 	__u32	grpid;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
