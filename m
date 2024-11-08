Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACE1E7C3E
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067485; cv=none; b=u7RJAYl6BJxXHTFkjxRkn9EMpRin2ITpjXr0NY/CtEX+ZsnmbEhKGiUt+j/6GiLztBO822HHLHYJQsymLUKkMerlsSyKvwXH+obdH7RGzINQzcR9pD2wn+7kKcLfVLVruSf1W1DG+KGGSaQvZ/YanofqmgjqVouYH7kzCVG+c8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067485; c=relaxed/simple;
	bh=V4RugJTuvyGaHxwOKya60LQUcMi6hhRYO69X0PS1uPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7ZQkxmy/O6puG0ZBvEihi92doxoksPac2b+QGDYegZniB+sfeWF7zV6NS/k4vmlWIyQJkIf5UHgq5FzsK/WUWcaeYvP5t4gUZl6fZQIhxe0xD60068csZ7BZZxWEPcvqz6TYflnqhVyvXrUJRYv2KdaiJi7xW9lUR0rU0APCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlouWIpO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlouWIpO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067484; x=1762603484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4RugJTuvyGaHxwOKya60LQUcMi6hhRYO69X0PS1uPo=;
  b=QlouWIpOkjKSyU1XMmzpqsmjG8IerJd5Bwi/Q//v97ikE4OUO7ulVX6Y
   FXrVTCfjMzQxGRBORAe1qxuusu1+1B/q/KRiaTCMhGyChYACK78tEblcv
   ZHq+lHea+3lC7/Fexk34zqz9O0a51fEDNfUujYb+S1e6RSZx9Uu0cn+XE
   qDDaNTF0ZyTpXso6FlpPO4t9AtZka2n8xtwUjojXDPwWJVTQdExDqsY0I
   CekfOBq+6Zpb+jJu7n+Sg7BLDEn9ovR07Ob8WJ9QOeABzmhumwUb++gIf
   +dtDNuc2CyCXumFdn73uwvj938ZAzzrRsT0N7tjA3Y+sMJ6HnS9O/g0A5
   w==;
X-CSE-ConnectionGUID: 12l/BHrRQ6qOPJccQ2xmsw==
X-CSE-MsgGUID: QmzxSDGvSn2vW2Rx4gMWYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31116442"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31116442"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:04:33 -0800
X-CSE-ConnectionGUID: vl5OxtZAQguZD0FznzMI6Q==
X-CSE-MsgGUID: hrEr16b5Q4+Cx7B3TlXy+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85679042"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2024 04:04:32 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v4 5/7] iommu/vt-d: Make the blocked domain support PASID
Date: Fri,  8 Nov 2024 04:04:25 -0800
Message-Id: <20241108120427.13562-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108120427.13562-1-yi.l.liu@intel.com>
References: <20241108120427.13562-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocked domain can be extended to park PASID of a device to be the
DMA blocking state. By this the remove_dev_pasid() op is dropped.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 527f6f89d8a1..b08981bbd5ca 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3248,10 +3248,15 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 	return 0;
 }
 
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old);
+
 static struct iommu_domain blocking_domain = {
 	.type = IOMMU_DOMAIN_BLOCKED,
 	.ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= blocking_domain_attach_dev,
+		.set_dev_pasid	= blocking_domain_set_dev_pasid,
 	}
 };
 
@@ -4105,13 +4110,16 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 	kfree(dev_pasid);
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
-	domain_remove_dev_pasid(domain, dev, pasid);
+	domain_remove_dev_pasid(old, dev, pasid);
+
+	return 0;
 }
 
 struct dev_pasid_info *
@@ -4483,7 +4491,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
-	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
 	.page_response		= intel_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.34.1

