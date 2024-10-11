Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EE2AE7F
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621126; cv=none; b=IwUvfBXe3DUMC1uDQKUWdhAazG8wnvumYk1n/KKyhtYHSU+iDHFK8jblyJg8AsVlL+tYLGu6JISpMv7AWAHPTiaiKSNFddT7yC94DfoBX6o9QA5jzDyTJEAO7eKNNVRVpidRTTpBswL+LnVGgU09Wia2V9phV77xJYVWrRV7B0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621126; c=relaxed/simple;
	bh=x24d2yfjLjyEXuZOmJAs4Z6fgXbcH4xlfQutgYDByDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3L5dWw+10byH/e3DIbEJWPLC+NvVoYlts2uOa5G9/zULME3J8UUO/16VuI8vsuS59UDvgFJptFNRH0fpUG7RM5G7BuaIj6zwUogMaCXpT2/7MC1gbWEqaNWls0RRQ9UgKCgBOjhiYIJEhglIjucLAAv/ZHVpBeGPZGzP+2TX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVpwCUmR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVpwCUmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621125; x=1760157125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x24d2yfjLjyEXuZOmJAs4Z6fgXbcH4xlfQutgYDByDU=;
  b=MVpwCUmRpkeBzfdPKB4SKoeeZNjiBNSLvzJrUukyAUramFsGgjwBJ0XT
   XAEVk3higpdL+jS79CdIgQ5hWBzryYuD2GvCS80CN4zK/aAt5DD72YWxA
   18JIc/oxESGBhrOWaivdiQZlKiZtVhGRoKJQBuUWVjgKSfWmpFCxEqENi
   opHIsi7aYInaNiEx4f/3/F536u85m1wTD8pGfbIfJiww1kQH+OJaQ/9Tk
   WUDwNIBQU29TsXZALTomPbX6czCzXSUEDIY83hK/lBDNwH/pXr0faEGqo
   3ZTzkfRn+dWPghaenx/I8+yi9yPdfZ24V+gwWJEbUGFYWDyrdiBLY/SB/
   g==;
X-CSE-ConnectionGUID: Ak0+ooAQTJOMs2hxWulTSg==
X-CSE-MsgGUID: fPahWZiAQKKneQ4EbGJmow==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101741"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:04 -0700
X-CSE-ConnectionGUID: W8FYvVvpScyCv3P08okv1w==
X-CSE-MsgGUID: orUDZ86fQpSCGwRhcUBWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412143"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:01 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/7] iommu/vt-d: Add domain_alloc_paging support
Date: Fri, 11 Oct 2024 12:27:15 +0800
Message-ID: <20241011042722.73930-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel iommu driver will now use the domain_alloc_paging callback and
remove the legacy domain_alloc callback. This ensures that a valid
device pointer is provided whenever a paging domain is allocated, and
all dmar_domain attributes can be set up at the time of allocation.

Both first-stage and second-stage page tables can be used for a paging
domain. Unless IOMMU_HWPT_ALLOC_NEST_PARENT or
IOMMU_HWPT_ALLOC_DIRTY_TRACKING is specified during paging domain
allocation, this driver will try to use first-stage page tables if the
hardware is capable. This is assuming that the first-stage page table is
compatible with both the host and guest kernels.

The whole series is also available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/vtd-domain_alloc_paging-v1

Please help review and comment.

Lu Baolu (7):
  iommu/vt-d: Add domain_alloc_paging support
  iommu/vt-d: Remove unused domain_alloc callback
  iommu/vt-d: Enhance compatibility check for paging domain attach
  iommu/vt-d: Remove domain_update_iommu_cap()
  iommu/vt-d: Remove domain_update_iommu_superpage()
  iommu/vt-d: Refactor first_level_by_default()
  iommu/vt-d: Refine intel_iommu_domain_alloc_user()

 drivers/iommu/intel/iommu.h |   1 -
 drivers/iommu/intel/iommu.c | 328 +++++++-----------------------------
 drivers/iommu/intel/pasid.c |  28 +--
 3 files changed, 62 insertions(+), 295 deletions(-)

-- 
2.43.0

