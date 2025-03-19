Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B70224CC
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350841; cv=none; b=ECCr4Imo6WbT/y2jikjpggzW6LgBtTW4cUtmVHrZwe3HyTalydy/aamuFgohxN6Huj4jx7Ki5dMdccpsD82ubbhxLCkqavwCtz/0gkyrgLB2CboMun+1j1SI6H1FXUZCU04Zx+enaZUeZWSAF3VFmLGP6uGkC2YI/pfnWqFjjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350841; c=relaxed/simple;
	bh=GHFLziHVx7jISSHWrlNbsz5caBa/WQzjnxxSOb1Gyiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQuzQo8HCuxwz+vhgpxwwE1HrcDJc3j6grHmtWqJUeXl4oem+uszZJH7ix5dNAXfhRPfOq3SgbS+p9FPL8jF0jW/0FToTs3Hz/AI97xgZCe0bTIw01znZUXup3Pj1fY6vtWUS+iqjuFzLiI1Ly240YGzsqjXO42ICzE7Y+skqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LncDDCWx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LncDDCWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742350840; x=1773886840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GHFLziHVx7jISSHWrlNbsz5caBa/WQzjnxxSOb1Gyiw=;
  b=LncDDCWxk6ASqI7QJkw8yUek3/+JdMRIdGzb+hjCsJYbMBIW0TnAf2nu
   CtJfexDi+kDm9V/oBsEO2YMZyEM2uXBtRBJPsawCZmUFV2NEQdO8Cnl6j
   boxD81UeZATCOe4IQ5B21sfGYJRsVQL44ZOqWoyKpN96J3hb6fNWtYsdo
   NtT63Eugm5p75MITIL4UcAfwF+IcqP1f3n8lRuLCCE1nmJ3tJ6NnsuStY
   2cN0ncMMaHW5DOOynzEhOB1kiFnCMo9Axcp2kB4rCmSZ4VeuxYuEy8EsE
   PzEt096TYuvD+nwf5mQAUCQiGAoxeujdtXXLYNvQNu2TrY4yKZsLG1dBx
   A==;
X-CSE-ConnectionGUID: YEYi/atDRROBCP/A8KSnOw==
X-CSE-MsgGUID: w0XD+zwuSEeg4ngcAoDIPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42693226"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="42693226"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 19:20:39 -0700
X-CSE-ConnectionGUID: O1xD93voSO+fTy9081Gy1A==
X-CSE-MsgGUID: laTpqr3+RvGGTv3dNN1KcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123372397"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 18 Mar 2025 19:20:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.15-rc1
Date: Wed, 19 Mar 2025 10:20:58 +0800
Message-ID: <20250319022101.1053133-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fixes have been queued for the Intel iommu driver. They
aim to solve the following issues:

- Fix a lockdep warning of possible circular locking dependency
- Prevent disabled posted MSIs when IRTE reverts from vCPU to host

These fixes are non-critical for v6.14-rc. Considering the upcoming
merge window, it would be fine to include them with other patches for
v6.15.

Can you please take them?

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Fix possible circular locking dependency

Sean Christopherson (2):
  iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is
    disabled
  iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity
    changes

 drivers/iommu/intel/iommu.c         |  2 ++
 drivers/iommu/intel/irq_remapping.c | 42 ++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 15 deletions(-)

-- 
2.43.0

