Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766D224FA
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244282; cv=none; b=HnfaV77x9oc7v0sRZwvwT4+EQH+w1EV89rzM4Df1KKqf4mm68h3gGUNmUgU8HS93FGviPUx6DU/O0QmJMzAtC/VVTPZGXGXsR1jPStQtw/EOXBGF7l/mhgtRBmZuAjrLWQ56ja4hA/x1tbNtitqJ8jewXVaMVr6BdAj2utaYvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244282; c=relaxed/simple;
	bh=GJBwXkuBXRO0+hDrlr8fy8F/xx75g1f+B7qSZxlSa7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HQ82CfHa4rpzwOc7TlpLuXQMG+TH2EgOJcj5+FQFflCKaeL7mblXHHmRh6iACje47LlUHX2SzvYRgo5pyQXT37s953K+6/DZmz+U6d94jVD9n1S2+d6Tk11BfOIZkwlVRza/7klK999oo5coONNOc+TR/aiBbw1KlCziG3+cvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRBW7Svl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRBW7Svl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244280; x=1756780280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GJBwXkuBXRO0+hDrlr8fy8F/xx75g1f+B7qSZxlSa7s=;
  b=KRBW7Svl4T1hKhTWB/TvJZUMsZrgyhhNIXuLh/LWDHCDzCphEaE3YVEC
   7haKW3KmTBdpzCbvMlBw4apzrBVUMq8+7TPV5rw4ARMwNGcNQjplSIG1o
   EvysAzL+9eYocnz1d091Z7iOz0sqb+AcFWTain13kFC7HFzgAWBpZYJJw
   JKmOb5oyRl//XQgSJXZIit350b/hmGE4w0uzrOcVjOuGrLR5JWapkUCdM
   y+k9YiTqy2ceI0iiJk8Mf8/w9YAZM2u5q3zcgKeEhkDCcWKfRp0exM4dy
   EMEPPrvjPKfWwwUxO3IQhmiFVuCxJLwG33hYWDWYixfNdkfojVYGBnd1c
   g==;
X-CSE-ConnectionGUID: 2uKAHLlxTYqHiU5mSlHOCA==
X-CSE-MsgGUID: R0hTzWUATu+a6JGtbS2DNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994263"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994263"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:19 -0700
X-CSE-ConnectionGUID: YnMbspOlTu2KGFiJ4HWpjw==
X-CSE-MsgGUID: FleOv/28RI6W+dX0NwI6Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359258"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] [PULL REQUEST] Intel IOMMU updates for v6.12
Date: Mon,  2 Sep 2024 10:27:10 +0800
Message-Id: <20240902022724.67059-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.12-rc1. They are about new
features and code refactoring, including:

 - Retire si_domain and convert to use static identity domain
 - Batched IOTLB/dev-IOTLB invalidation
 - Small code refactoring and cleanups

These patches are based on v6.11-rc6. The complete patches are also
available at:

https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.12

Please consider them for iommu next.

Best regards,
baolu

Lu Baolu (10):
  iommu/vt-d: Require DMA domain if hardware not support passthrough
  iommu/vt-d: Remove identity mappings from si_domain
  iommu/vt-d: Always reserve a domain ID for identity setup
  iommu/vt-d: Remove has_iotlb_device flag
  iommu/vt-d: Factor out helpers from domain_context_mapping_one()
  iommu/vt-d: Add support for static identity domain
  iommu/vt-d: Cleanup si_domain
  iommu/vt-d: Move PCI PASID enablement to probe path
  iommu/vt-d: Unconditionally flush device TLB for pasid table updates
  iommu/vt-d: Add qi_batch for dmar_domain

Sanjay K Kumar (1):
  iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count

Tina Zhang (3):
  iommu/vt-d: Factor out invalidation descriptor composition
  iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush for batching
  iommu/vt-d: Introduce batched cache invalidation

 drivers/iommu/intel/iommu.h  | 128 ++++++++-
 drivers/iommu/intel/cache.c  | 239 ++++++++++++-----
 drivers/iommu/intel/dmar.c   | 109 ++------
 drivers/iommu/intel/iommu.c  | 503 +++++++++++++++--------------------
 drivers/iommu/intel/nested.c |   3 +-
 drivers/iommu/intel/pasid.c  |  12 +-
 drivers/iommu/intel/svm.c    |   7 +-
 7 files changed, 547 insertions(+), 454 deletions(-)

-- 
2.34.1

