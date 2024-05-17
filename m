Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA0389
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906262; cv=none; b=KlyFLqsfhwP6pNXqRDAQg6+mphL3OU0zUkgcbhTtd0HKzuGcEQXWDhe53fncUMXiqRyrobOJyjB5wtnvVkPnDliSDxtucFEP4vN+dF8qqqpYLz8/S9M6y8Bu9PTvT0+DPKLMfAGhmccn0V4oBIY/auhJCJOsUju4+mMO+0ZnrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906262; c=relaxed/simple;
	bh=tndkoDzPtQvDNXxDV1mSnTTkMJDHaP78U5UqidIWjYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=himo5ZM7JFdNjobZ/xo4iYSwaUJwEaXDwkxm6v5bqCJrrbD63zgRysni964mILtPJdllb02oNp5o1QuoSr6wQ/Z1sG93nMLZTA2cHKmJ7LZY51Az1IbFx9ZsFPy5nl9EH35xLM9owzRrcNEZ9VirB4IkzJD92DsOBeP6fpUrRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QS91vYRn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QS91vYRn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715906261; x=1747442261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tndkoDzPtQvDNXxDV1mSnTTkMJDHaP78U5UqidIWjYs=;
  b=QS91vYRnxZQhOmnOqFPJKneVnDhPJGjkogTaM0g6MTSIBZ+5oRejEoY3
   TfDH8O9pxCWjDu7imoMAYoXX3W0beESCgl9gXKQJ0OW32njSD/Z8rhl4V
   X+r4oIOVc3k2639JimT93gLIuiNZ/rTKd8NRRO5+1UcOVV/etpLR4rb0S
   O7m4FmcWoTZXXhvF4kwm6XwXkg6L/5MUEqQOViYE47sgBcNR1Moq9cXBk
   xqK9NRkQvfvHzQNmJF1+S6MPSa9FeIaC5Ho9yvQvvxNlcsqNMSDr/fxuM
   ThRGwKgjOeyXFT32vgYMTniaddW1F6it5OqMSfVKgt2h7JfK0yL9y3U4h
   Q==;
X-CSE-ConnectionGUID: wkx/Zi7sQxyupp/cmaaw1Q==
X-CSE-MsgGUID: EuFuNiIQRAWv1JeFrmZlGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11902647"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="11902647"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:37:41 -0700
X-CSE-ConnectionGUID: BtiX2U+3TIWcd6a+mHE9NQ==
X-CSE-MsgGUID: vKWrfaihT5qA63g8qnzQnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="32217181"
Received: from chunleis-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.254.214.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 17:37:39 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 0/2] Batch IOTLB/dev-IOTLB invalidation
Date: Fri, 17 May 2024 08:37:26 +0800
Message-Id: <20240517003728.251115-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOTLB and dev-IOTLB invalidation operations are performance-critical.
The current implementation in the VT-d driver submits these commands
individually, leading to some inefficiencies due to the IOMMU
programming and invalidation command processing overhead for each
operation.

This patch series, based on "Consolidate domain cache invalidation"
series[1], enhances the efficiency of Queue Invalidation (QI)
operations by adding support for batch processing. Microbenchmarks
show that with a DSA device working in SVA, batching IOTLB and dev-IOTLB
invalidations can decrease the time spent in qi_submit_sync()
by roughly more than 800 cycles.

Tina Zhang (2):
  iommu/vt-d: Support batching IOTLB/dev-IOTLB invalidation commands
  iommu/vt-d: Batch IOTLB/dev-IOTLB invalidation commands

[1]: https://lore.kernel.org/linux-iommu/20240416080656.60968-1-baolu.lu@linux.intel.com/

 drivers/iommu/intel/cache.c | 89 ++++++++++++++++++++++++++++++-------
 drivers/iommu/intel/dmar.c  | 67 +++++++++++++++-------------
 drivers/iommu/intel/iommu.c | 27 ++++++-----
 drivers/iommu/intel/iommu.h | 21 ++++++---
 drivers/iommu/intel/pasid.c | 20 +++++----
 5 files changed, 152 insertions(+), 72 deletions(-)

-- 
2.39.3

