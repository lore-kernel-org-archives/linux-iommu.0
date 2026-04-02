Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B537DEAA
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113219; cv=none; b=gOEWbL27RloVXnCax7/cTnXLor9FNqwcbBZN9W3xb8ZJM+/MhFzPw7oe6J4WOE2/XzIyUc+g8Rar7xmcN1wAWDa36S5TRJpXzfk1yjgYsp3dfhT8fnh8pQt300HvEvPmAWlVTC95Qc461USMP08R61qkPkVLcCUHnbB7BesXXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113219; c=relaxed/simple;
	bh=OW+PrEwsLVEU0efOoj7WtDoXBUo87EItuQU8Q9Pt4BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ln5BmyLhihX2JNPEd3742oQQQ3AW9TsSXvG5Vqp/wsE0LEd3gIQMkt+oeCRHfuSf+GhnCpzO+ZO0H5Pkj18Vc7o19Elh/m6QQp+PcyGCDc4Zkif3bYwX71l5iAIym8l8aF4DgbZHjQcNpYkVfFIrEogF6rZ3vybCqIyMOyT1xrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZ5Tyc99; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZ5Tyc99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113217; x=1806649217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OW+PrEwsLVEU0efOoj7WtDoXBUo87EItuQU8Q9Pt4BA=;
  b=DZ5Tyc99ytWgDLcC9c0TFCcE2InOogo23/8rqm9G8W3LVQrscMARrRIE
   J1ncgSRdcp1awUuJoO2oQvOHlpkJXZ57GOOJNzFTar+ByRfW7IHc9LBn3
   RG8oKcKBmINddLTi7cQLt7++6wDQ3AI08td0KBqu1gkkVXEAiTp5QgfoY
   /Y7+9yGwibu/5ka7FupG9Fwlpt9r463GMweMTmiPON9vGNCAvPlRGADOn
   psK6PdfutLJ6rnktRacD8vvxz8qHG3urqS1tDF53h852250srR6R5cF6A
   h5bkfPm66gkXydZKm/luLIHH7TAZ5+qDEOhR9CR8iaOOxYB7K2enitStq
   w==;
X-CSE-ConnectionGUID: aQDn61eJRhWcvwo1YVb/wg==
X-CSE-MsgGUID: M1wWWqimQ1210X7WQScUfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053627"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053627"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:17 -0700
X-CSE-ConnectionGUID: 5slHzRZrTiu7DHvqOFhLIg==
X-CSE-MsgGUID: OzNk9ko2TqiiKU5gY0UZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847780"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] iommu/vt-d: Rename device_set_dirty_tracking() and pass dmar_domain pointer
Date: Thu,  2 Apr 2026 14:57:25 +0800
Message-ID: <20260402065734.1687476-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
References: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

device_set_dirty_tracking() sets dirty tracking on all devices attached to
a domain, also on all PASIDs attached to same domain in subsequent patch.

So rename it as domain_set_dirty_tracking() and pass dmar_domain pointer
to better align to what it does.

No functional changes intended.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260330101108.12594-3-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ef7613b177b9..965e0330ec4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3684,16 +3684,15 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
 	return vtd;
 }
 
-/*
- * Set dirty tracking for the device list of a domain. The caller must
- * hold the domain->lock when calling it.
- */
-static int device_set_dirty_tracking(struct list_head *devices, bool enable)
+/* Set dirty tracking for the devices that the domain has been attached. */
+static int domain_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 {
 	struct device_domain_info *info;
 	int ret = 0;
 
-	list_for_each_entry(info, devices, link) {
+	lockdep_assert_held(&domain->lock);
+
+	list_for_each_entry(info, &domain->devices, link) {
 		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
 						       IOMMU_NO_PASID, enable);
 		if (ret)
@@ -3713,7 +3712,7 @@ static int parent_domain_set_dirty_tracking(struct dmar_domain *domain,
 	spin_lock(&domain->s1_lock);
 	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
 		spin_lock_irqsave(&s1_domain->lock, flags);
-		ret = device_set_dirty_tracking(&s1_domain->devices, enable);
+		ret = domain_set_dirty_tracking(s1_domain, enable);
 		spin_unlock_irqrestore(&s1_domain->lock, flags);
 		if (ret)
 			goto err_unwind;
@@ -3724,8 +3723,7 @@ static int parent_domain_set_dirty_tracking(struct dmar_domain *domain,
 err_unwind:
 	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
 		spin_lock_irqsave(&s1_domain->lock, flags);
-		device_set_dirty_tracking(&s1_domain->devices,
-					  domain->dirty_tracking);
+		domain_set_dirty_tracking(s1_domain, domain->dirty_tracking);
 		spin_unlock_irqrestore(&s1_domain->lock, flags);
 	}
 	spin_unlock(&domain->s1_lock);
@@ -3742,7 +3740,7 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	if (dmar_domain->dirty_tracking == enable)
 		goto out_unlock;
 
-	ret = device_set_dirty_tracking(&dmar_domain->devices, enable);
+	ret = domain_set_dirty_tracking(dmar_domain, enable);
 	if (ret)
 		goto err_unwind;
 
@@ -3759,8 +3757,7 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 
 err_unwind:
-	device_set_dirty_tracking(&dmar_domain->devices,
-				  dmar_domain->dirty_tracking);
+	domain_set_dirty_tracking(dmar_domain, dmar_domain->dirty_tracking);
 	spin_unlock(&dmar_domain->lock);
 	return ret;
 }
-- 
2.43.0

