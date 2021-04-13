Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B817C43462
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CC3613B8
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 08:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CC3613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F30D94057B;
	Tue, 13 Apr 2021 08:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id haQJUJiGFqwE; Tue, 13 Apr 2021 08:55:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC834400D8;
	Tue, 13 Apr 2021 08:55:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88B4CC000C;
	Tue, 13 Apr 2021 08:55:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CCB4C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F236160B8E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0tW69hLNUCk for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:55:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA54560B3F
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 08:55:16 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FKKBK28X6z1BGYr;
 Tue, 13 Apr 2021 16:52:57 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:06 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Yi Sun
 <yi.y.sun@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Tian Kevin
 <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
Date: Tue, 13 Apr 2021 16:54:46 +0800
Message-ID: <20210413085457.25400-2-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210413085457.25400-1-zhukeqian1@huawei.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

Some types of IOMMU are capable of tracking DMA dirty log, such as
ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
dirty log tracking framework in the IOMMU base layer.

Three new essential interfaces are added, and we maintaince the status
of dirty log tracking in iommu_domain.
1. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
2. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
3. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap

A new dev feature are added to indicate whether a specific type of
iommu hardware supports and its driver realizes them.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/iommu.c | 150 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  53 +++++++++++++++
 2 files changed, 203 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..667b2d6d2fc0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1922,6 +1922,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	domain->type = type;
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
+	mutex_init(&domain->switch_log_lock);
 
 	return domain;
 }
@@ -2720,6 +2721,155 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
+int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+			   unsigned long iova, size_t size, int prot)
+{
+	const struct iommu_ops *ops = domain->ops;
+	int ret;
+
+	if (unlikely(!ops || !ops->switch_dirty_log))
+		return -ENODEV;
+
+	mutex_lock(&domain->switch_log_lock);
+	if (enable && domain->dirty_log_tracking) {
+		ret = -EBUSY;
+		goto out;
+	} else if (!enable && !domain->dirty_log_tracking) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = ops->switch_dirty_log(domain, enable, iova, size, prot);
+	if (ret)
+		goto out;
+
+	domain->dirty_log_tracking = enable;
+out:
+	mutex_unlock(&domain->switch_log_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_switch_dirty_log);
+
+int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
+			 size_t size, unsigned long *bitmap,
+			 unsigned long base_iova, unsigned long bitmap_pgshift)
+{
+	const struct iommu_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->sync_dirty_log))
+		return -ENODEV;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
+		       iova, size, min_pagesz);
+		return -EINVAL;
+	}
+
+	mutex_lock(&domain->switch_log_lock);
+	if (!domain->dirty_log_tracking) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova, size);
+
+		ret = ops->sync_dirty_log(domain, iova, pgsize,
+					  bitmap, base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+
+		pr_debug("dirty_log_sync handle: iova 0x%lx pagesz 0x%zx\n",
+			 iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+out:
+	mutex_unlock(&domain->switch_log_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sync_dirty_log);
+
+static int __iommu_clear_dirty_log(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   unsigned long *bitmap,
+				   unsigned long base_iova,
+				   unsigned long bitmap_pgshift)
+{
+	const struct iommu_ops *ops = domain->ops;
+	size_t pgsize;
+	int ret = 0;
+
+	if (unlikely(!ops || !ops->clear_dirty_log))
+		return -ENODEV;
+
+	while (size) {
+		pgsize = iommu_pgsize(domain, iova, size);
+
+		ret = ops->clear_dirty_log(domain, iova, pgsize, bitmap,
+					   base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+
+		pr_debug("dirty_log_clear handled: iova 0x%lx pagesz 0x%zx\n",
+			 iova, pgsize);
+
+		iova += pgsize;
+		size -= pgsize;
+	}
+
+	return ret;
+}
+
+int iommu_clear_dirty_log(struct iommu_domain *domain,
+			  unsigned long iova, size_t size,
+			  unsigned long *bitmap, unsigned long base_iova,
+			  unsigned long bitmap_pgshift)
+{
+	unsigned long riova, rsize;
+	unsigned int min_pagesz;
+	bool flush = false;
+	int rs, re, start, end;
+	int ret = 0;
+
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+	if (!IS_ALIGNED(iova | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx min_pagesz 0x%x\n",
+		       iova, min_pagesz);
+		return -EINVAL;
+	}
+
+	mutex_lock(&domain->switch_log_lock);
+	if (!domain->dirty_log_tracking) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	start = (iova - base_iova) >> bitmap_pgshift;
+	end = start + (size >> bitmap_pgshift);
+	bitmap_for_each_set_region(bitmap, rs, re, start, end) {
+		flush = true;
+		riova = iova + (rs << bitmap_pgshift);
+		rsize = (re - rs) << bitmap_pgshift;
+		ret = __iommu_clear_dirty_log(domain, riova, rsize, bitmap,
+					      base_iova, bitmap_pgshift);
+		if (ret)
+			break;
+	}
+
+	if (flush)
+		iommu_flush_iotlb_all(domain);
+out:
+	mutex_unlock(&domain->switch_log_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_clear_dirty_log);
+
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..7f9ed9f520e2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -87,6 +87,8 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+	bool dirty_log_tracking;
+	struct mutex switch_log_lock;
 };
 
 enum iommu_cap {
@@ -160,6 +162,7 @@ struct iommu_resv_region {
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
 	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+	IOMMU_DEV_FEAT_HWDBM,	/* Hardware Dirty Bit Management */
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
@@ -205,6 +208,9 @@ struct iommu_iotlb_gather {
  * @device_group: find iommu group for a particular device
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
+ * @switch_dirty_log: Perform actions to start|stop dirty log tracking
+ * @sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
+ * @clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
@@ -260,6 +266,18 @@ struct iommu_ops {
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
 
+	/* Track dirty log */
+	int (*switch_dirty_log)(struct iommu_domain *domain, bool enable,
+				unsigned long iova, size_t size, int prot);
+	int (*sync_dirty_log)(struct iommu_domain *domain,
+			      unsigned long iova, size_t size,
+			      unsigned long *bitmap, unsigned long base_iova,
+			      unsigned long bitmap_pgshift);
+	int (*clear_dirty_log)(struct iommu_domain *domain,
+			       unsigned long iova, size_t size,
+			       unsigned long *bitmap, unsigned long base_iova,
+			       unsigned long bitmap_pgshift);
+
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
@@ -511,6 +529,16 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern int iommu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+				  unsigned long iova, size_t size, int prot);
+extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
+				size_t size, unsigned long *bitmap,
+				unsigned long base_iova,
+				unsigned long bitmap_pgshift);
+extern int iommu_clear_dirty_log(struct iommu_domain *domain, unsigned long iova,
+				 size_t dma_size, unsigned long *bitmap,
+				 unsigned long base_iova,
+				 unsigned long bitmap_pgshift);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -901,6 +929,31 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int iommu_switch_dirty_log(struct iommu_domain *domain,
+					 bool enable, unsigned long iova,
+					 size_t size, int prot)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_sync_dirty_log(struct iommu_domain *domain,
+				       unsigned long iova, size_t size,
+				       unsigned long *bitmap,
+				       unsigned long base_iova,
+				       unsigned long pgshift)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_clear_dirty_log(struct iommu_domain *domain,
+					unsigned long iova, size_t size,
+					unsigned long *bitmap,
+					unsigned long base_iova,
+					unsigned long pgshift)
+{
+	return -EINVAL;
+}
+
 static inline int  iommu_device_register(struct iommu_device *iommu)
 {
 	return -ENODEV;
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
