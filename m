Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB717F
	for <iommu@lists.linux.dev>; Sun, 11 Sep 2022 03:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662866670; x=1694402670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ofe5y9BBOqrYwUYsF5dXMEj3Xp6HQ21SkDyfi+2e6ko=;
  b=mINaCkkHJVOCS9UaiubAR10FZjRO7qv3JtdGQDmgb14HbkVk139ANql+
   1Xy+IQVM1GChoHdcm2AkRJ29yra0A7TSsbzzj5fQy+FhSx6fKvfo/0dnJ
   HhcRyTtRpIt24zKnw2xjZraQVRaS0M3ifV0USLS57fePUEdbpzQD8pqWo
   B7Vj1tPxxY+QpVv1JnL5B7us5DznahkHp743syJEhjyqt+bhfVZ6o2z7o
   +IHl26zbpfUo6lyM6HPMVzoS7KFvHsMqHiL+VDG+P205agkwQbj4qYNET
   fFwUD5DbtwnzTa4qB5YtRGgHzESHyo4ZB+0fcc4TcS0q5/ZUWZQZdDTe5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="299027396"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="299027396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 20:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="611431553"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 10 Sep 2022 20:24:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 0/1] iommu/vt-d: Fixes for v6.0-rc5
Date: Sun, 11 Sep 2022 11:18:44 +0800
Message-Id: <20220911031845.893192-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below fix is queued for v6.0-rc5. It aim to fix:

- Fix possible recursive locking in intel_iommu_init().

It also eliminates the issue highlighted in commit c919739ce4721
("iommu/vt-d: Handle race between registration and device probe"),
which has been pushed to linux next.

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Lu Baolu (1):
  iommu/vt-d: Fix possible recursive locking in intel_iommu_init()

 include/linux/dmar.h        |  4 +++-
 drivers/iommu/intel/dmar.c  |  7 +++++++
 drivers/iommu/intel/iommu.c | 27 ++-------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

-- 
2.25.1

