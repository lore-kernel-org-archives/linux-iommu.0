Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C23BAD84
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865487; cv=none; b=rXvW1h8P2TwMi+6gmXzcQKlkuTzRQyPAaGxAWNffRoyzcl3bokwxd8pmDArFdwgTCgBxMzaH+2YwrNoIoTw8LkgcyLufm4F1e3MBwdSJDk1XxhPM81JBqM9tsTEtleaGMXkFs/GbGTewlxzYk/B6/kIGGlkMUOMjMwTA88qg52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865487; c=relaxed/simple;
	bh=Q+qunl396kXFXB5Cvwi9Oeb21eUaoU8dWojLR4cn3m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOSIH0ZcCMpvgdOxMm/kBxmWE6XIeLBAl8PO0E9aCwqRBp2pqpPZ/1Y31VAlOKMkL/cGGyGspifBwilTgFw6FDsBucTFkx8dppAMkOhfzeEVPBooyd5XoHVSWTunDy6YBaCAAsiF6PRsfxnoY6YhHUKBpIngPeTn8viXGh9mbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiruIpr1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiruIpr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774865486; x=1806401486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+qunl396kXFXB5Cvwi9Oeb21eUaoU8dWojLR4cn3m8=;
  b=OiruIpr1wk/cFL/1ZGw1cZTJugMcrZJfh6K8C4tzJd8TrpKNmxHAPjIO
   KzvVCW6aJiUSvaU8djcuXgYLJMWEZqXMBO5r7SCZgwtUvNctb/ZALBsmx
   KEZrM9Kmlb0jwSOEpgBocSOyw+OyW2afYwMThdkLuFVVsPeDnJJSmJSvN
   T/SlH23ocGg4HvLjtUY62q/R4rvdyTR5X1A71r0HOdRwtCzqmJQhaBFRQ
   lU36rOzBC+cQBensLkRiJYJkKOOQh6eB6yjU7L4HvnF4EBNStL/abU++x
   Qk+uBPK4ergLeow9L8sR5Da32JZU/kVGP3Esnevr2sEhpxxw6TTJLoK4D
   Q==;
X-CSE-ConnectionGUID: cD6+NYgxTlW94Ru0EQBvSA==
X-CSE-MsgGUID: Q3BUnL7jToeGlMQTfb/sqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75921164"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75921164"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:25 -0700
X-CSE-ConnectionGUID: iu5QfUCfTYaja9xAK+J55g==
X-CSE-MsgGUID: qJ3KZnPWT+iz9IMOqB9biQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="225913450"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 03:11:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/4] iommupt/vtd: Rename device_set_dirty_tracking() and pass dmar_domain pointer
Date: Mon, 30 Mar 2026 06:11:05 -0400
Message-ID: <20260330101108.12594-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330101108.12594-1-zhenzhong.duan@intel.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_set_dirty_tracking() sets dirty tracking on all devices attached to
a domain, also on all PASIDs attached to same domain in subsequent patch.

So rename it as domain_set_dirty_tracking() and pass dmar_domain pointer
to better align to what it does.

No functional changes intended.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
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
2.47.3

