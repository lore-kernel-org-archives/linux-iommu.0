Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A71B218D
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315375; cv=none; b=fz+ahai8AWDKaswE6Qxn9a8qlPeBV22SDSXw8A7qaQx9kwxs+z8SOCz6lwTp5VswVJbC+JS+3gaQ67uLnncini9P3OMRu2xkWQdj6mPujm2/WusF+RU77WRJTLEzEedoNt8B4KgVrJSY7k6R1B5B/kd6BECB/kHu7yO/lKValQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315375; c=relaxed/simple;
	bh=6PUXI+3NsTHsfAL2o1cIt8/S23ikcs+UsrxO1KYisNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmEiIZOJxdVoHqMkBaKpM4ZLx1s29ZX8FBulMUk2xjpbkFtc93f3zTO5mypsiLyT2eddDvRrUuMM2FuS8uzGcDdGeh5UHymF0cavuzcJWCcjNpEPcLhICnp8kAFyuEDp2MMIAmAOw7JtTbzC5GcA80cwFojOphj8XHy3i039svY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z84rW8VG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z84rW8VG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733315373; x=1764851373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6PUXI+3NsTHsfAL2o1cIt8/S23ikcs+UsrxO1KYisNQ=;
  b=Z84rW8VG4IWESRyMJ5vB3swSAaoRtuaOOx1ZmFBgs5S/3NnbMm/s+kT4
   dIpM5OVnVwc5U6WxO910vFIJ0e4XR3Y+pdwQ0jvMhWpp7RG4kaMzVDTAV
   9L4GoclUwcqZdNCcD/v3f+C6HQGdNBQkNkMGeqwbimWXfpPzDgugW26Px
   zlunQ+twm5IGp1KTS/8LiqXmobk0Gw1JE8NbHm0ONF4BLNOwrkyULd9rV
   1HMf5kJKLU8XdD7YoXyoxCOpr65moE8LjC5X253Qx1d2Ae6Cj19rne8En
   7WcprltBf5MO6C1QX/yrecjhZKtJadVYvnOym3bzSb1AGgcZJqv6wgCP1
   w==;
X-CSE-ConnectionGUID: Hj/fD+TeS1C8yDhIh2vTlg==
X-CSE-MsgGUID: Vb4I9dq9S7u99AFZdBl2Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32937878"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32937878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:29:32 -0800
X-CSE-ConnectionGUID: DyUOY3OOQ/GzbGdPILecOA==
X-CSE-MsgGUID: sM8NdmSDSQuavqRraIpWFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93599065"
Received: from unknown (HELO 984fee00a4c6.jf.intel.com) ([10.165.58.231])
  by orviesa010.jf.intel.com with ESMTP; 04 Dec 2024 04:29:31 -0800
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
Subject: [PATCH v6 1/7] iommu: Prevent pasid attach if no ops->remove_dev_pasid
Date: Wed,  4 Dec 2024 04:29:22 -0800
Message-Id: <20241204122928.11987-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204122928.11987-1-yi.l.liu@intel.com>
References: <20241204122928.11987-1-yi.l.liu@intel.com>
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

Move the group check to be the first as dev_iommu_ops() may fail when there
is no valid group. Also take the chance to remove the dev_has_iommu() check
as it is duplicated to the group check.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9bc0c74cca3c..38c3f67e441f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3368,16 +3368,19 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
+	const struct iommu_ops *ops;
 	int ret;
 
-	if (!domain->ops->set_dev_pasid)
-		return -EOPNOTSUPP;
-
 	if (!group)
 		return -ENODEV;
 
-	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
-	    pasid == IOMMU_NO_PASID)
+	ops = dev_iommu_ops(dev);
+
+	if (!domain->ops->set_dev_pasid ||
+	    !ops->remove_dev_pasid)
+		return -EOPNOTSUPP;
+
+	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-- 
2.34.1

