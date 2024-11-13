Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87B1FF035
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505579; cv=none; b=LLyRrMiV5HJdl8q5iOWzt0LJfXHNhlX3PTwAFxZHoiMtmpRHSEHkjzcR4ktdvF2tEr+vr7atTHcsAL6CMDcJybAzwN5aF8HFdjEDkeZr2khe1QI1hL7cGDkRImK2Sbowmni29N7X3yD+36GVOsTG4yeOKa+xlnOfm7eRJC1GwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505579; c=relaxed/simple;
	bh=BRPI8MlZdOA8RXy54BH0Uwx9Ljveb1udubzfe8kZZsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MiLFN5zwdn8f17ACWexTsiYSj7RibyceSpV0TPWg6y7DQ6rc8mSMwZmo7F6hk9OyaTHMv9ti1K5QN6SvgrLrYmw8+2B8iLWv/hv33bi1X20YOZEvj76iBNDPTB4+Kzso5UESZdRKNLzgtmT+lwU2deObMVHkLFdmEGjSvO4a44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbl/x96x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbl/x96x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731505578; x=1763041578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BRPI8MlZdOA8RXy54BH0Uwx9Ljveb1udubzfe8kZZsQ=;
  b=fbl/x96xOfgXs8zyv737qDAZBGhbYleW6Fe3XFGaJtuPoK/C7fcWp58s
   aPZWgj3WxUgihDNIrPpNJA1+vEgph/zEKqxo2TkNfIA87Pm0rc6RPbESw
   mj/eCcUgDdAHZk0qNb5vBf2M246RBm7pyx59iLV8jxwDQUMZg4C93cilJ
   0+NtZalY4jZOcLy0ZbFMgx01EQu1DVeh5ULzu7bPD32Pu0dE4dbf8VKOA
   2x6890Y77GQ/2To2xtLtDPbWq8J7rZqrUw2NgW/SjXms+O+nTSBnE0KHl
   uMW9fZjwaI+rdynaLzxEI4x1X6evHNtef80SjEcZ3soczIp1Z1TMof59/
   w==;
X-CSE-ConnectionGUID: GPO89Hv/RV+VWjftIhuhXg==
X-CSE-MsgGUID: A3OMPjQhQQmrGKy996u+nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42025704"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42025704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 05:46:16 -0800
X-CSE-ConnectionGUID: Rrjd+kILRMqDgiTvmo/Ofw==
X-CSE-MsgGUID: WL2lfrJHRyS7Sqp7QJdUOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87445594"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 05:46:15 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v5 3/7] iommu: Detaching pasid by attaching to the blocked_domain
Date: Wed, 13 Nov 2024 05:46:09 -0800
Message-Id: <20241113134613.7173-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113134613.7173-1-yi.l.liu@intel.com>
References: <20241113134613.7173-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu drivers are on the way to detach pasid by attaching to the blocked
domain. However, this cannot be done in one shot. During the transition, iommu
core would select between the remove_dev_pasid op and the blocked domain.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c1ab42ff5c4b..25d170de76fe 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3302,8 +3302,18 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *domain)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *blocked_domain = ops->blocked_domain;
+	int ret = 1;
 
-	ops->remove_dev_pasid(dev, pasid, domain);
+	if (blocked_domain && blocked_domain->ops->set_dev_pasid) {
+		ret = blocked_domain->ops->set_dev_pasid(blocked_domain,
+							 dev, pasid, domain);
+	} else {
+		ops->remove_dev_pasid(dev, pasid, domain);
+		ret = 0;
+	}
+
+	WARN_ON(ret);
 }
 
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
@@ -3366,7 +3376,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	ops = dev_iommu_ops(dev);
 
 	if (!domain->ops->set_dev_pasid ||
-	    !ops->remove_dev_pasid)
+	    (!ops->remove_dev_pasid &&
+	     (!ops->blocked_domain ||
+	      !ops->blocked_domain->ops->set_dev_pasid)))
 		return -EOPNOTSUPP;
 
 	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
-- 
2.34.1

