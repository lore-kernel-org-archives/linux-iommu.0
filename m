Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274F18C22
	for <iommu@lists.linux.dev>; Sun,  8 Sep 2024 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795780; cv=none; b=UmximPJpO38oHqFA/b8iPs30jlnbGUi0PqLQIQI6gNCx9/euprJjPvn6+EFSNMgmRgK3Jg9a/FzdcPCVCeQfK+IQB6nIx4YzIWaaj0KsmLUyuQJ99i5K9i5ahche4Sykamc5qazde3FH1MNNUs5sYI1TDF26eZo5zoreepK3ZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795780; c=relaxed/simple;
	bh=t2sLnkInQWUKNBGiID4AD2togWX10HSlRhLqej6PRdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kr9h5Gl5ZDhqKlhtHZl4+hzqQtoOZ4/8UCe6HcjNIq0TJSM6W4tl/dT8tycY/z8NSRiu9K3ecL1Kz58Ga7z0UhUGrPfv+g95cayJKh7Vw6v9g628oR3wgTVHRB7xLUJjTRHiIprQxH4p/IEGF6lt8x+XbcCXZuOZfqEIHeXkVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9s0byn1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9s0byn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725795778; x=1757331778;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t2sLnkInQWUKNBGiID4AD2togWX10HSlRhLqej6PRdM=;
  b=C9s0byn1djIEwfqNw1qLfTSV/t2SRRqwdiZnnetpO1KYVOWEKUPKT5AK
   ch3VGtLEBMZ5pQLRgPxwaEQUhtVgV00QipEYwTTMm5ylDTtUrweqv1YZZ
   rVHeMn0T9s7HY4CrdOT0gdWEA8EJU7eY3A32Z+R++If+S/zxJ1cQQTKAy
   WVb4X39g3Vv9rH9fWNnEJn3Xgk9bU9BHSgh4uhi6xNF2s8xdnJXMpc7cz
   2Ju2o8e3uBbaFW690ihdM+JY6hDup/4TOpw0gkNoF3uodISI/uqCh2Evj
   YUTZAf+XPsC0kYTcVZSm+wgdFW77xRSi7wgxgKoPgeut/J3Vxoo+4lci7
   A==;
X-CSE-ConnectionGUID: UE+r7XH4QCuTiWzmVk1U/w==
X-CSE-MsgGUID: 3ni8e3PhRBeRcvS9dD8zKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="27418268"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="27418268"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 04:42:58 -0700
X-CSE-ConnectionGUID: z+zkYa8NTmeLIAV4cQu1IA==
X-CSE-MsgGUID: Wn6TD4u6R7SeBhRWM+nDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="89668161"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa002.fm.intel.com with ESMTP; 08 Sep 2024 04:42:57 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com
Cc: nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: [PATCH 0/2] iommufd: Misc cleanups per iommufd iopf merging
Date: Sun,  8 Sep 2024 04:42:54 -0700
Message-Id: <20240908114256.979518-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Two misc patches per the iommufd iopf merging. Please feel free comment.

Regards,
	Yi Liu

Yi Liu (2):
  iommufd: Avoid duplicated __iommu_group_set_core_domain() call
  iommu: Set iommu_attach_handle->domain in core

 drivers/iommu/iommu.c                   | 1 +
 drivers/iommu/iommufd/fault.c           | 1 -
 drivers/iommu/iommufd/iommufd_private.h | 4 +++-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.34.1

