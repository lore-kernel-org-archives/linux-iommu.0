Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA22BE02A
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258861; cv=none; b=ay0KRPr447bo2hPOCtkPoL+gdGQGzBqjVKYpjHC67cVDkQ2rlp67x+xgfx2R9SlYqxhj/5xYe061ZiK7uQCuBOlcdtca3xci0UmFETOss+yBwpkXs+3yBW1HIz+IFvA9XODh4YeqY7bur+nKfaqph1INtF9kAoyh0YlwWHQp3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258861; c=relaxed/simple;
	bh=n5sm8CS+WQv1rbRYTvvCBmaf7sN0eqry4c5chWZubdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7472JMVI9R5ZveMy86ocCclDvFEkRILIz09jik71bJBgZtze0htqoaVd7GZ329+wTHg493/jM3l+yy3N73YrQo6l7jsjbCV177rOjhH/5ToNPmD26YWg9AewCQnA2NhDPB/MxOfhQisbQAULuYmyy/ds2iJiBAR2/iYpUp92P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8tYc/z+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8tYc/z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770258861; x=1801794861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n5sm8CS+WQv1rbRYTvvCBmaf7sN0eqry4c5chWZubdo=;
  b=h8tYc/z+gR1wgn2euH3t0Gwh+IAufCnQLBSCjK8SKtcNSUd8GIoqX37y
   8GXBA8SAvUk7LlgyEU9EPoaVHL/dt4ZxDQnJbxOxmM6hWyjZhmIx9N7uK
   guLdQe+j97VtOjwmiYVl7jOgUMcyFJcfkttRk7bHfNqF3QVA2y85yyNgI
   TIRgScNSBkGtPNc7VXAm+kFDmkwstx3cKnr/0u9pieoKF34LqiiBYm8gK
   Kz5On24GKwEdO5zLdrAh6aJ/IKHGIa70mDaSAF0ACL7ZXsj2j8vsqAjKX
   Xp6Xb3pf/UeY3JenHEDMcsNFyjPHJoKDUTmSoGRni6ecjIPU45x2kA9oR
   Q==;
X-CSE-ConnectionGUID: nu1wwqwcSEyiTn6wBAk/Mg==
X-CSE-MsgGUID: y+df1tbWS6KF9NryFrU5fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74057946"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="74057946"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:21 -0800
X-CSE-ConnectionGUID: xObtWwZoRquoCqQvCbO65w==
X-CSE-MsgGUID: pRf/Uyx0RxOTHtZfDTCZkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="214872069"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:19 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/3] iommupt/vtd: Support dirty tracking on PASID
Date: Wed,  4 Feb 2026 21:34:03 -0500
Message-ID: <20260205023405.41583-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205023405.41583-1-zhenzhong.duan@intel.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support passthrough device with PASID capability in QEMU,
e.g., DSA device, kernel needs to support attaching PASID to a domain.

But attaching is not allowed if the domain is a second stage domain with
dirty tracking, this is the use case when guest configures 'iommu=pt'.

The reason is kernel lacking support for dirty tracking on such domain
attached to PASID. Same for nested domain even though there is no such
checking.

By adding dirty tracking on PASID, the check can be removed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index acaa6eaf7e2f..5a9ed91109a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3621,9 +3621,6 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
-	if (domain->dirty_ops)
-		return -EINVAL;
-
 	if (context_copied(iommu, info->bus, info->devfn))
 		return -EBUSY;
 
@@ -3691,6 +3688,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
 static int device_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 {
 	struct device_domain_info *info;
+	struct dev_pasid_info *dev_pasid;
 	int ret = 0;
 
 	lockdep_assert_held(&domain->lock);
@@ -3698,6 +3696,14 @@ static int device_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 	list_for_each_entry(info, &domain->devices, link) {
 		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
 						       IOMMU_NO_PASID, enable);
+		if (ret)
+			return ret;
+	}
+
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
+						       dev_pasid->pasid, enable);
 		if (ret)
 			break;
 	}
-- 
2.47.3

