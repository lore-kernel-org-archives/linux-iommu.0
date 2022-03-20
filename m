Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFAFC433EF
	for <iommu@archiver.kernel.org>; Sun, 20 Mar 2022 06:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 223C781A18;
	Sun, 20 Mar 2022 06:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFBt96nrOfe3; Sun, 20 Mar 2022 06:43:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1420A81A50;
	Sun, 20 Mar 2022 06:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC71CC001A;
	Sun, 20 Mar 2022 06:43:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4802C000B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93DC640198
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9bi024sIi1-d for <iommu@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 06:43:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F22F4016B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647758591; x=1679294591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vKdoL7uiyvYLFOvydHSnd0GHZVBK2y8vbn3OihTxHw0=;
 b=nqCGi444pyeWO6g24bc6yMg4qXV7L4cszBaTvcfhwJ46RkUCH6dOUSjF
 3SObeCjcda8IVxDNsVgkpKMICY2IZ54mGS0L3bHshXkBD6HPFclnfECKb
 5AcjPcvcEGR2Qen16V8RJ1nXMM7zV9A2LD7a9JvLGWPhk2MFmg6eit+ns
 MNzlVs/nSUNgbZdH80Jfhgxbx1Dp9DxKqKByKEifekFu4wK0v0qxm03F+
 KiMBfEd/KcoktJ5CFeXz1braPod9OD2NO0EpXPC9+UR5GD1uTnuwlvu3b
 K1CzGSITR0OTt+aODclN2cVCgFpctQf96CqG6OwvGILwJQA2pwRU9Go36 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237961423"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="237961423"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2022 23:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="691839965"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:43:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC 09/11] iommu: Add iommu_get_domain_for_dev_pasid()
Date: Sun, 20 Mar 2022 14:40:28 +0800
Message-Id: <20220320064030.2936936-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

This adds a helper to retrieve the iommu_domain which has been attached to
a {device, pasid}. One usage scenario of this helper exists in the I/O page
fault handling framework, where {device, pasid} was reported by hardware,
and software needs to retrieve the attached domain for further routing.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  8 ++++++++
 drivers/iommu/iommu.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 47c9aa5aa9c8..803e7b07605e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -676,6 +676,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -1041,6 +1043,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 					     struct device *dev, ioasid_t pasid)
 {
 }
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f90b71c6f6e..508fdcabda5c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -40,6 +40,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -632,6 +633,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -3086,6 +3088,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 {
 	struct iommu_group *group;
 	int ret = -EINVAL;
+	void *curr;
 
 	if (!domain->ops->attach_dev_pasid)
 		return -EINVAL;
@@ -3098,7 +3101,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
+	xa_lock(&group->pasid_array);
+	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
+			    domain, GFP_KERNEL);
+	xa_unlock(&group->pasid_array);
+	if (curr)
+		goto out_unlock;
+
 	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
+	if (ret)
+		xa_erase(&group->pasid_array, pasid);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -3118,6 +3130,25 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	domain->ops->detach_dev_pasid(domain, dev, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+
+	mutex_lock(&group->mutex);
+	domain = xa_load(&group->pasid_array, pasid);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
+
+	return domain;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
