Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A207E4
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663569082; x=1695105082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dVdgBkbGUl4BGMdHCf+Lq0avz2hGOi0xJ/PV314U0jA=;
  b=JF/3rt/JtpSaeNGeTravto9P6ub73nIezKqCJPa45Zi6qBwk/QACcnQK
   lFBGG1GHxXY+G/tRNuEbT8htOVbz7eLkxJWkddKvSc5vywMFJtKfaz5V0
   6Rv486PQu6CZwwmBc+yUmyOo/WCwXSEqHwbQhL9lVG91JKnIMnmQHqdlq
   VfzkVty3ma7GSmH5IF1/tK9l2EXAibTdQs5IyD8GuyxWTSp7+sSeZozJv
   GyBBvgPCRPvZANfuRtqIuMBUeiDUQbzu0qLt6isx8d8rJaNAZkppiUaWn
   fuBPHi0nQBNBmRvqnggIxHE/v+n2YBWHe3x7EkK3qafXQZdTczmRUqWZ5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="279699701"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279699701"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="680715154"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2022 23:31:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Add ESRTPS & ESIRTPS check
Date: Mon, 19 Sep 2022 14:25:21 +0800
Message-Id: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

Some VT-d hardware implementations invalidates all DMA remapping
or interrupt remapping hardware translation caches as part of SRTP or
SIRTPS flow. The VT-d spec introduced two capability bits for these
hardware behaviors. This series fine tuned the VT-d driver to avoid
unnecessary global cache validations.

Best regards,
baolu

Lu Baolu (2):
  iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
  iommu/vt-d: Avoid unnecessary global DMA cache invalidation

 drivers/iommu/intel/iommu.h         | 2 ++
 drivers/iommu/intel/iommu.c         | 7 +++++++
 drivers/iommu/intel/irq_remapping.c | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.34.1

