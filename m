Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA013FFC
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342524; cv=none; b=UmrY1O3UyfjhEKXCs75JpIO6q9sjeAZRCW13Wd+o9Km7Jyrauriyj3ms3OpKcNLZ7jwc9xQoRbaGlQjpGTNZCb/JSFJP48G5VqrO++Eh6yAZhA5IQ7+eZMsxj+n+qmteSlQXvF3iMtoCZ6IkqgEURW38KeUmZuvHzbBEcrGQw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342524; c=relaxed/simple;
	bh=2GkDe6t0SvX71gsi2RUqPnsVGTgVfZxaK0MZCH2FcDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BVIqDD/743BLRx3Obi933XrmbQbNNG4Owgy9gLk34q3693Hs2MinOFQv3VtAWMKPF27gLlUJC7z9mmRlxFPmDEmBFXNaFMXpS5xUp6cbMumqfpg/UVn59ZIUsseij/Jrm4ICJLhvxUXP/2XYSMAZXuX05B0Ey0/N/ab/fzliTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFZEeolD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFZEeolD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737342523; x=1768878523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GkDe6t0SvX71gsi2RUqPnsVGTgVfZxaK0MZCH2FcDo=;
  b=XFZEeolDizr3p9a5z0+jwKsuBg06J3QqmDG8Eap3AygLibCvivHo4jv4
   mUm/XFiA21cS6u5GxvW+ZexryGN2eMrucF3gpt9Msfey4xz90ODRCngta
   LClCrQMpKoEhMLIxXYM5O729TRvFI178TpgTxx+E2bChCYCPP7EGr/bsR
   m9G5JtDpUNxvS5fgHFEKzDiJtBl3FspYRR2FMNdP0dFU6UFbFK8mvO7sU
   fwmYO7pohZajMKtKMiqwP2utSP29IBAZnh90ZoLkQP4D27IPI/2Ym4HsK
   4/mqq9mjMn+vXqEBIspf4q+XLvJIY1eypIhF9QhWnlMo1uVCzFE/vP4Gv
   w==;
X-CSE-ConnectionGUID: Ysipv89dT+Or6uSMSwmQGw==
X-CSE-MsgGUID: AfJNqfm+StGrr4mQz28uHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="55104332"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="55104332"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 19:08:42 -0800
X-CSE-ConnectionGUID: XkvHr0yhRdCNNMVfMuw5Xg==
X-CSE-MsgGUID: kYZRMWtXSymJu4ETw02pug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143634382"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 19 Jan 2025 19:08:42 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	jacob.pan@linux.microsoft.com,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH 0/2] Two enhancements to iommu_attach_device_pasid()
Date: Sun, 19 Jan 2025 19:08:38 -0800
Message-Id: <20250120030840.4171-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's spotted during the review process of iommufd pasid series [1]. The
first one is about storing entry to group->pasid_array, and the second
one is to avoid the potential PRIs anchored on the failed domain. Details
can be found in the individial patch.

[1] https://lore.kernel.org/linux-iommu/20241219132746.16193-2-yi.l.liu@intel.com/

Yi Liu (2):
  iommu: Store either domain or handle in group->pasid_array
  iommu: Swap the order of setting group->pasid_array and
    __iommu_set_group_pasid()

 drivers/iommu/iommu.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

-- 
2.34.1

