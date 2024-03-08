Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745053E01
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894435; cv=none; b=NRIzmaqAbRxSXsPVQSnS9yj7Bro/7iUjG/egJO9eB8mXkS83DBcbCL+f8GID458RszFs6gxrqSr6wBLCjR/Q2Lxd0UK4SAgIvgwj3d52WGS27o60v6/6SuUm0dAPfGDQCWqbQxjrWL8n/jgGIu8q30pMfkx93sSVFXtvOhiF0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894435; c=relaxed/simple;
	bh=in4SeSX4WV3iibikWdGrUbDE7VavIflEbC1lEbO6Q+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rm8ysBLw0xR/gyiKYcN/FCIpYpWReGzoqs00FN/dIo5sT/Rvd05BLJu6KQh5dkiacWeI06zprBhO1d6VurU2bx0NUO16/jN3fYspQZ27DyolEGo/XR+R64V6ocEeC9tAqHhus+CcwfInrjCtQfQt96t2sHa8Mw2WodyQbD/SRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsIHSABM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsIHSABM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709894434; x=1741430434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=in4SeSX4WV3iibikWdGrUbDE7VavIflEbC1lEbO6Q+0=;
  b=jsIHSABM82PsfP0BaAhffD+pDtut5q3XxjXOwb0V2hS3m30N3ovcXziu
   v8i7+Ju0Uv+4POsr/IyZVaawIxAkRfCrhzRBudnJqelsYbumcH8EBq5Sw
   TDL3825ukalx4u1zuneJcIVNsMtvFVz5cnVS/8BJW7U6ylnSqHr5DTToc
   Zv54AnburMQn5e1egk02OUfB2nDDFjk5D5wdtj7tz9d1jC/5flnBp6hwV
   nk//IHXNKAjVB3tcXrK0HCuBBNFjjqFvcQd3sJKqxSlW8x4RDBdn5idwe
   NTHPeFdBjYd/bRhWBlN0s0FMydR0HAEjuVXFqcaE5GKiL9PBY+zTKA4Dl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4468238"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4468238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10327727"
Received: from cascade.sh.intel.com ([10.239.48.141])
  by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 02:40:31 -0800
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Remove use of private data field
Date: Fri,  8 Mar 2024 18:38:09 +0800
Message-Id: <20240308103811.76744-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Private Data" field has been removed from Page Request/Response in
Intel VT-d specification revision 4.0.

Since the private data field has been removed, it's fine to remove the
entire private data handling from the driver as the specification
has been deprecated and Intel hasn't shipped any products which
support private data in the page request message.

Jingqi Liu (2):
  iommu/vt-d: Remove debugfs use of private data field
  iommu/vt-d: Remove private data use in fault message

 drivers/iommu/intel/debugfs.c |  7 ---
 drivers/iommu/intel/iommu.h   |  1 -
 drivers/iommu/intel/perf.h    |  1 -
 drivers/iommu/intel/svm.c     | 84 +++++++----------------------------
 include/linux/iommu.h         |  3 +-
 5 files changed, 16 insertions(+), 80 deletions(-)

-- 
2.21.3

