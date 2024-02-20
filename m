Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8D5A0F0
	for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412741; cv=none; b=W0iP/Lcc+06nvHaK2s/pA/Gu9xxdM75jx/pem4wvFJyHE4dbyvrAOprUwKK9eYf0Lo8YHrYW1w6J3F4+bN27ByPmMvG71a89wq6k5//gUBpSHIdZlgckE+pjV+tdbzK4aArupfHX3wx6sLVDTTB40G8HvbApZ5Z66UB9ed5/Tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412741; c=relaxed/simple;
	bh=60XgXlzmTdfmXfbSSOkuTQTtCpdaSANzXNt5Yathy4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fNiYdk1HkzKt9DAoY6bhY5cCgUoxFoHKZ7FIO+HJnAqUpfdZj3cTikASNjDaa1um2LA7Q/IGuY8Sn3YuATc2u4IJO2RUqxMdsItfkVehyk8iQW93+FfsEJSEYCu9zkupG9vvVuA+XIwjhFPQp9FtH5RKvhRJH0i8nSkjogc3aKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYnJcqJv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYnJcqJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708412738; x=1739948738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=60XgXlzmTdfmXfbSSOkuTQTtCpdaSANzXNt5Yathy4A=;
  b=KYnJcqJvS2usyVilTgOk6/+G04EKeL0+V3+DDmpOXgm6tT19NKDE5YQC
   tmr06Zp0D4NvOm/Lll7eMJRB2RuVKOKbsih0xnuEq5KehusGAMFJNtd9z
   9i5tEVnfVAzpP8s36kAdOS0GK+EXuClgUYibyQoNeV3wjFDUw4uQ2spHf
   q8Dy0HZpgSac78VfkBB5AyeLwrty8JPoU2ulW4KmrPORuTZBsmbVJgisF
   KdUiG0PKXDFExcCVvZiP3uNDnL8oG16yqp0CCH9iRe++oRmC5/almzECy
   5NYbhQ0bKwMV8etcsW/G79fsbjbG9ao1GKpw/2XecPXqX+mmo01htppO+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2366565"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2366565"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4683772"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2024 23:05:35 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Introduce rbtree for probed devices
Date: Tue, 20 Feb 2024 14:59:37 +0800
Message-Id: <20240220065939.121116-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to the discussion thread here:

https://lore.kernel.org/linux-iommu/20240201193427.GQ50608@ziepe.ca/

This proposes a per-IOMMU red-black tree for iommu probed devices. It
benefits fault handling paths, where the VT-d hardware reports the
Source ID of the related device, and software needs to retrieve the
corresponding device pointer based on this ID.

This is also available at github:

https://github.com/LuBaolu/intel-iommu/commits/rbtree-for-device-info-v2

Change log:

v2:
 - Drop get/put_device() in device_rbtree_find();
 - Add a mutex to synchronize iopf report and device release paths.

v1: https://lore.kernel.org/linux-iommu/20240215072249.4465-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu/vt-d: Use rbtree to track iommu probed devices
  iommu/vt-d: Use device rbtree in iopf reporting path

 drivers/iommu/intel/iommu.h | 10 ++++
 drivers/iommu/intel/dmar.c  |  4 +-
 drivers/iommu/intel/iommu.c | 91 ++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel/svm.c   | 17 +++----
 4 files changed, 111 insertions(+), 11 deletions(-)

-- 
2.34.1

