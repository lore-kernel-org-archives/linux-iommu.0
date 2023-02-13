Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162671FA8
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676275099; x=1707811099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AazWd96xxOSoSDyvZpaQLi9s44x2C1YOu7YcySHmaWw=;
  b=njK/FKk/1ET1BQz9vbmL0Z9czc4Xl6Cj4ohlu9cQZRun3c42H+mEwGZO
   tbC4L231KL63zRk3GsWhskmEoIzHekbV0YMr65T4dtV13KWjQDLfUefpO
   2k7lOlSV6rNuVbqQ/MEfb3o1CONqlalImg2TVtXBtM226OFCpBRiSLQN2
   N64nSFY12Am8dRZ6Ew+JfsLsRjzgaWXhWrNMU5AR1OkezFKsBfB7CyWe6
   zomoY8RIZOAlT/soDH83ywrIWhQVo8G5w3IqTwSTNesdIXckrFaYcDxKM
   1dayHrQsIDIDD6f7mYGtO46+uaAPWEdoYtfTSLs9bMq1mLab0jO/n7VLC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="417058768"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="417058768"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="842684807"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="842684807"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 23:58:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Date: Mon, 13 Feb 2023 15:49:39 +0800
Message-Id: <20230213074941.919324-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213074941.919324-1-baolu.lu@linux.intel.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu_group_store_type() requires the devices in the iommu group are
not bound to any device driver during the whole operation. The existing
code locks the device with device_lock(dev) and use device_is_bound() to
check whether any driver is bound to device.

In fact, this can be achieved through the DMA ownership helpers. Replace
them with iommu_group_claim/release_dma_owner() helpers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f71dcd2621b..6547cb38480c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2807,12 +2807,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 
 	mutex_lock(&group->mutex);
 
-	if (group->default_domain != group->domain) {
-		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
 	/*
 	 * iommu group wasn't locked while acquiring device lock in
 	 * iommu_group_store_type(). So, make sure that the device count hasn't
@@ -2971,6 +2965,7 @@ static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
+	bool group_owner_claimed = false;
 	struct group_device *grp_dev;
 	struct device *dev;
 	int ret, req_type;
@@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	else
 		return -EINVAL;
 
+	if (req_type != IOMMU_DOMAIN_DMA_FQ ||
+	    group->default_domain->type != IOMMU_DOMAIN_DMA) {
+		ret = iommu_group_claim_dma_owner(group, (void *)buf);
+		if (ret)
+			return ret;
+		group_owner_claimed = true;
+	}
+
 	/*
 	 * Lock/Unlock the group mutex here before device lock to
 	 * 1. Make sure that the iommu group has only one device (this is a
@@ -3001,6 +3004,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	mutex_lock(&group->mutex);
 	if (iommu_group_device_count(group) != 1) {
 		mutex_unlock(&group->mutex);
+		if (group_owner_claimed)
+			iommu_group_release_dma_owner(group);
 		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
 		return -EINVAL;
 	}
@@ -3038,22 +3043,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	iommu_group_freeze_dev_ops(group);
 
-	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
-	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
-		pr_err_ratelimited("Device is still bound to driver\n");
-		ret = -EBUSY;
-		goto out;
-	}
 
 	ret = iommu_change_dev_def_domain(group, dev, req_type);
 	ret = ret ?: count;
 
-out:
 	device_unlock(dev);
 	iommu_group_unfreeze_dev_ops(group);
 	put_device(dev);
+	if (group_owner_claimed)
+		iommu_group_release_dma_owner(group);
 
 	return ret;
 }
-- 
2.34.1

