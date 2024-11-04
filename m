Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4A224FA
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726438; cv=none; b=Tma0LKeFr7FX91vKB397bwldGuSJDc3xe4NeT8gr3bbr8YLRRlrH2rbYvFXKn7ooY6EnPAbLYzrUK+AqWcHOlg6WprB7BoZnbBovs6oW2E1ayC+mojH1VrjSezKELwEmPbzUaafe2kop/9KZzSo0EFNlHnnBCdMOqbkFvFeG+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726438; c=relaxed/simple;
	bh=xkEJ7LX4Du0vjHFbotmFTpDVY1H3dZx3uqknKCSEr3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESzKArPHhfAExRqHXg8UeshGmi+Az77c037ydQJpCslMeLliX4U937ET8nQCR2tflEs2u8o3VK7jT8c2L/rVPJ61Rqcq/3TJ8uixcLJEXvvxzrb9BRgN1sG8TZ0jhPSQoLTfyhzS6ldKx3W/vKenOHqII3W2ULovQdCfnugWAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FM1HbV1B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FM1HbV1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726438; x=1762262438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xkEJ7LX4Du0vjHFbotmFTpDVY1H3dZx3uqknKCSEr3g=;
  b=FM1HbV1BFT2OSHTq76sj22sCzdkQhk5Rxf3he62mjSpje8mVk1z4nIQ6
   rZ49vlEQc2ibPTosEAhX6agrCmZX0jFisVmHcaxMxssBgdAHuIUTPnhoP
   m5PcQuFLJ50RLomnCjNstPB4McvkJ4oywkli6PcwaRIkv1glPyjrE19p1
   yzztOZRfV/i830p0dJ8ZnExk+w5K8joyI4cNL5jSMdTS3pPNfpRGAhl1u
   Vv/vir+ha1idXbmHKjnbmcyedMV3OpEK17DfL7YhGxcs9/7njmoi+Bbln
   KneU+5RaTqrsBw/uWwXxMBUsoCdGOza1+zhrsX9DEMWnYafkObJ6qw86n
   Q==;
X-CSE-ConnectionGUID: nmMHcLqTT3eV1UFin0oJkw==
X-CSE-MsgGUID: 3OyALFboQOazMi0zoIpPyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47883261"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47883261"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:20:37 -0800
X-CSE-ConnectionGUID: LBIDXiKSRn6eAT0gBvwFzQ==
X-CSE-MsgGUID: UR61g/0kTDK9fFzJKZ6Qzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84099710"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:20:36 -0800
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
	will@kernel.org
Subject: [PATCH v3 1/7] iommu: Prevent pasid attach if no ops->remove_dev_pasid
Date: Mon,  4 Nov 2024 05:20:27 -0800
Message-Id: <20241104132033.14027-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104132033.14027-1-yi.l.liu@intel.com>
References: <20241104132033.14027-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

driver should implement both set_dev_pasid and remove_dev_pasid op, otherwise
it is a problem how to detach pasid. In reality, it is impossible that an
iommu driver implements set_dev_pasid() but no remove_dev_pasid() op. However,
it is better to check it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ea6b4a96186d..866559bbc4e4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3454,11 +3454,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct iommu_attach_handle *handle)
 {
 	/* Caller must be a probed driver on dev */
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 	int ret;
 
-	if (!domain->ops->set_dev_pasid)
+	if (!domain->ops->set_dev_pasid ||
+	    !ops->remove_dev_pasid)
 		return -EOPNOTSUPP;
 
 	if (!group)
-- 
2.34.1

