Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409208820
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8oAyK/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623830; x=1732159830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4RFN6C5anem5Gt5zf3iTGGH/gQovytqONM6TO/5w4I=;
  b=E8oAyK/bblvndlo0Hst4tj7DLib72KpcSuUmaPB7vAFOCKdEStblbY7a
   AUel8M45RL1uhyT2iKMpnPJNfnoa0F2TzQ9MaH/Ev7UUPHdhb3P4GG/0o
   QJ20hjy8H1YidJF+daboBydzntkQrMB8ocxqyF/AeYihtKdrT7BPmOz+P
   UujvGUAY5Jy8tTZ4UKOfY/guerfd8CIia4cjDyjZiFWFAFYv4xHt8qZmo
   TWRQEt8YLZTGpf1ziho16JLqifr48qoesCiRJ6utbvLLNcjZ3F6eDAmk2
   TmUzp4FWqwO4iITuBbbPx7fXxldSN/61x5LXNMCpuFwrMqd+kiQW1zCXc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742767"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742767"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090158"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: mohd.syazwan.abdul.halim@intel.com,
	Kunwu Chan <chentao@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] [PULL REQUEST] iommu/vt-d: Fixes for v6.7-rc3
Date: Wed, 22 Nov 2023 11:26:01 +0800
Message-Id: <20231122032608.165144-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fixes have been queued for v6.7. They aim to:

- Do not support enforcing cache coherency for non-empty domains
- Avoid devTLB invalidation if iommu is off
- Disable PCI ATS in legacy passthrough mode
- Support non-PCI devices when clearing context
- Fix incorrect cache invalidation for mm notification
- Add MTL to quirk list to skip TE disabling
- Set variable intel_dirty_ops to static

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Abdul Halim, Mohd Syazwan (1):
  iommu/vt-d: Add MTL to quirk list to skip TE disabling

Kunwu Chan (1):
  iommu/vt-d: Set variable intel_dirty_ops to static

Lu Baolu (5):
  iommu/vt-d: Support enforce_cache_coherency only for empty domains
  iommu/vt-d: Omit devTLB invalidation requests when TES=0
  iommu/vt-d: Disable PCI ATS in legacy passthrough mode
  iommu/vt-d: Make context clearing consistent with context mapping
  iommu/vt-d: Fix incorrect cache invalidation for mm notification

 drivers/iommu/intel/iommu.h |  3 +++
 drivers/iommu/intel/dmar.c  | 18 ++++++++++++++++++
 drivers/iommu/intel/iommu.c | 18 +++++++++++-------
 drivers/iommu/intel/svm.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.34.1

