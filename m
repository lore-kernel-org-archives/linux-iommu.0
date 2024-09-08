Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF981586E7
	for <iommu@lists.linux.dev>; Sun,  8 Sep 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795782; cv=none; b=uuabtYD5sFlHhku8nBwUfCsIRGZV9ipL3bheOC509ASmlZnCbeJ5XQhMj3GlDHJL9XhWrIaeopA1PQgWmW+/mX09se8Vli3I8QvzoCxhq8xXK6Ia2B17wachvBRraOjFibBE1176bbr/nQJ3cRym9CVPboNeBzg4+HQz6HLpYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795782; c=relaxed/simple;
	bh=6D32PgrLosIh6OCfg0v2IHbZTTFBABwzW9sc9tl2E9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4fuleSadPhvcq9E+YWigQb0lEngZjDDl57duCA0Z6nDuY8OAFupF9F/jdf2ADCAXwTo75O6f3VMXisPRXIjhAf6B5W2rjOgqsh/DTRWqlXjTyrswzJbq7uswD/lkhVFeyk8i+5ANcg/wT98zAcYcllr3hxXn0RmJzZjH8u6Lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3ZhiH6z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3ZhiH6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725795781; x=1757331781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6D32PgrLosIh6OCfg0v2IHbZTTFBABwzW9sc9tl2E9s=;
  b=Z3ZhiH6zpeErVw3mA01aFEnB2nVOnWGMyRPraSLy5WtCSmSHaba00saL
   TZjGOtIkYBcuefM/tsYiFTfLyFqlX/cCV4hAI0XfLJrlYE3G5bpbvz1BL
   xA5WFS1bYvgJue407a7z6PxegLphBv0T547No5e6fKrttJ/OX+Zq8DYzr
   WWI9px7C67mMP7fMZqcVx2t0xmTWQxJFzefXRzBLR4JOxvJpQGnU1j7En
   fqcu4g3fYzXlgstIwQpfHM9mEp0B3Md9wO32L1ZiC/D5RxSpUDl6+Mu2W
   3cmhKl6dwV8yZ2Eze78VOX603MjHy93ZHyqmbaEQfVO/JwHqYsHSfGGZ8
   A==;
X-CSE-ConnectionGUID: Soa9w7IxSGi6TTyUwVJpng==
X-CSE-MsgGUID: 4ERSRwnWTTOjUfy8i+WfEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="27418277"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="27418277"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 04:42:59 -0700
X-CSE-ConnectionGUID: b3L7dxTWQXG7yM1C1n4FVA==
X-CSE-MsgGUID: S6ibyVC8Q5S2dKesRJIsVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="89668168"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa002.fm.intel.com with ESMTP; 08 Sep 2024 04:42:59 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com
Cc: nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: [PATCH 2/2] iommu: Set iommu_attach_handle->domain in core
Date: Sun,  8 Sep 2024 04:42:56 -0700
Message-Id: <20240908114256.979518-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240908114256.979518-1-yi.l.liu@intel.com>
References: <20240908114256.979518-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU core sets the iommu_attach_handle->domain for the
iommu_attach_group_handle() path, while the iommu_replace_group_handle()
sets it on the caller side. Make the two paths aligned on it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c         | 1 +
 drivers/iommu/iommufd/fault.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..83c8e617a2c5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3578,6 +3578,7 @@ int iommu_replace_group_handle(struct iommu_group *group,
 		ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
 		if (ret)
 			goto err_unlock;
+		handle->domain = new_domain;
 	}
 
 	ret = __iommu_group_set_domain(group, new_domain);
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index a643d5c7c535..c4715261f2c7 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -161,7 +161,6 @@ static int __fault_domain_replace_dev(struct iommufd_device *idev,
 		if (!handle)
 			return -ENOMEM;
 
-		handle->handle.domain = hwpt->domain;
 		handle->idev = idev;
 		ret = iommu_replace_group_handle(idev->igroup->group,
 						 hwpt->domain, &handle->handle);
-- 
2.34.1

