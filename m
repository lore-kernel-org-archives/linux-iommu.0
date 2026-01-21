Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49931282F
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000579; cv=none; b=OYkhY2+glfN+O5H/8snfEsMjMPBawc3DSDFh0A12arXYHZIU5C/sGx94L82u/6aLoOk/M1NM94dPIxNxoJIrTo2OMF6MDvGZdGxQniCzAaO0pyr0LDsxi3CXb+/Zt0z2VCZUdnWzq+dOqMLVGMILNFdkf6VFC3PZn+D1+CXz/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000579; c=relaxed/simple;
	bh=06HnCxUF8RH/TuxV13Wuyjw9IUeyczz66ygRpiulYHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F522tBdVKjSkRGeOt7u88S+TqBKhp+en8OAROtpCMWgXfVrWCJTBrOFrcDuSNhFexSMaz+NrNNnVbVHvrLU/5oju8Kq5Epg9iX6IfibG9tplOHmkmfX+MWIZjQpNRmwj51VrqeOxQ6wgEaK96Ozg5b8i5we4o34RldwsqaUl2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBD3LKuP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBD3LKuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769000577; x=1800536577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=06HnCxUF8RH/TuxV13Wuyjw9IUeyczz66ygRpiulYHU=;
  b=VBD3LKuPH81eZyrDVm+1bm3U5Qxax6fk/+r6wNsQLheTCHhTXdudSbkl
   7yPmlUxtD+ot/EW4po7pN+j84sgqSCwtxPzyCXJPsGs5fRqSkiRxyzk+E
   53bucue/4IBziF+4u5z40z5dfLPDrZ/nVeqe7Py6ov3gNnDVVOuTyQPvy
   is4tIZ4tJTfG97zok97kRTqKppTHGp4HhP6fR3hYGjDWSihx0oKCWqxjo
   JfJs0usm7rShu24RXWtTKn9r/PScnBOWYcdXi0FsDw0KqOr1e1PzxJJEt
   mzwqNt02iWIFDvdF4R5x0jvcxXNekBEwYg8wyF9+TFFQZtMnLmyHutyFG
   Q==;
X-CSE-ConnectionGUID: +Ida3sajRBi1aOoo1TgSag==
X-CSE-MsgGUID: ijCFuB5FQmCV3CT6+zV3Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80944499"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80944499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:02:56 -0800
X-CSE-ConnectionGUID: FR01gN1ETx6CctIuUQyAPA==
X-CSE-MsgGUID: yK/R4wqkSRKeSwj3gquUog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211452180"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO fdugast-desk.home) ([10.245.245.68])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:02:53 -0800
From: Francois Dugast <francois.dugast@intel.com>
To: iommu@lists.linux.dev
Cc: intel-xe@lists.freedesktop.org,
	Francois Dugast <francois.dugast@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Calvin Owens <calvin@wbinvd.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Xe performance regression with recent IOMMU changes
Date: Wed, 21 Jan 2026 14:02:16 +0100
Message-ID: <20260121130233.257428-1-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I am reporting a slowdown in Xe caused by a couple of IOMMU changes. It
can be observed during DMA mappings/unmappings required to issue copies
between system memory and the device, when handling GPU faults. Not sure
how other use cases or vendors are affected but below is the impact on
execution times for BMG:

Before changes:
  4KB
    drm_pagemap_migrate_map_pages: 0.4 us
    drm_pagemap_migrate_unmap_pages: 0.4 us
  64KB
    drm_pagemap_migrate_map_pages: 2.5 us
    drm_pagemap_migrate_unmap_pages: 3.5 us
  2MB
    drm_pagemap_migrate_map_pages: 88 us
    drm_pagemap_migrate_unmap_pages: 108 us

After changes:
  4KB
    drm_pagemap_migrate_map_pages: 0.7 us
    drm_pagemap_migrate_unmap_pages: 0.7 us
  64KB
    drm_pagemap_migrate_map_pages: 3.5 us
    drm_pagemap_migrate_unmap_pages: 10.5 us
  2MB
    drm_pagemap_migrate_map_pages: 102 us
    drm_pagemap_migrate_unmap_pages: 330 us

Bisecting points to these commits:
  d373449d8e97 iommu/vt-d: Use the generic iommu page table
  d856f9d27885 iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires

Simply reverting them brings back performance.

Any idea about why and how to fix it?

Thanks,
Francois

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>
Cc: Calvin Owens <calvin@wbinvd.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>

-- 
2.43.0

