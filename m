Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65A2582
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097631; x=1711633631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ze+P/jCeStEoXlFymkbQzwvhBlVD/1D1Zt3CCXdAZb4=;
  b=XNfNa+5QQJGTPdQ7j/25gBY0iUcd5JQfNiJdereF5knkFqepGBfK3CY1
   ORk4tnLyL9b1qZ9RyHGlwnBrQ7223FQtHTmt4Y/iapoFimA6R8gkdTq/V
   yWTB81IZOU56Z6O4JcNCgJ47fTfDk7ANfHXzXAWCm4JtTP8znk4Sqz4Ve
   L5h+Irg0OgVR9yZ8eODQQ5sX35b6sY1g5APnCq9W2iF2b7JWOw4igYhqJ
   YU9LtQdHROdybYd/xxr2z6Vw/uxZaJ9NwYr4DHq8ZDagy0jjWBrE6Ob1c
   7MZWaUDAfXBM8PNX3tNFdIWg2ObbjTpIB8yJvu2AJFHDaHef8/GcZmtFp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403506223"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403506223"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677783322"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677783322"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 06:47:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.3-rc4
Date: Wed, 29 Mar 2023 21:47:18 +0800
Message-Id: <20230329134721.469447-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Some fixes have been queued for v6.3. They aim to:

- Fix a lockdep splat
- Fix a supplement of the specification
- Fix a warning in perfmon code

This series is also available at github.
https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.3-rc4

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Kan Liang (1):
  iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug

Lu Baolu (2):
  iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()
  iommu/vt-d: Allow zero SAGAW if second-stage not supported

 include/linux/cpuhotplug.h          |  1 -
 drivers/iommu/intel/iommu.h         |  2 +
 drivers/iommu/intel/dmar.c          |  3 +-
 drivers/iommu/intel/irq_remapping.c |  6 ---
 drivers/iommu/intel/perfmon.c       | 68 +++++++++++++++++++----------
 5 files changed, 48 insertions(+), 32 deletions(-)

-- 
2.34.1

