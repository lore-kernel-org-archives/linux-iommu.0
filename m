Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657057C
	for <iommu@lists.linux.dev>; Sat, 25 Jun 2022 12:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656161791; x=1687697791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S3kTFxDx/UlQ4ttkSgT0OD0LBtEA6KOASNkdzOFb+uw=;
  b=I/spmxrg1c8nAk1NTrmYFDBP872mKjhrWxzlHBEpTSySnLabaT8XHjq4
   KYrgIWK8jbQqTjMipd3zSBNM0A+D3jqkBwNTGg/L1vV0vCcolKJwN6Y8I
   1gCZ/bmefUE59GG96PMbZ6GpF4js5/pfqKi4Dc668AZ8mPFypYPUO8Ic6
   Kc+zANu5tZdyv8iDlucnWvpzvNWg106S6+XSFTvQzOq03bHE21N8BKfZ+
   V3AeDZpjm7r1VH1QWoBGNczlEBPgpDO+7z9ClYj8gQEJDb6ac20w4JAcb
   8Z5mnlfGhSncxn47DJc5vV8nyY6ygg3xLtvPJilnMTJ3fXcCt/afgfacU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261600725"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="261600725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 05:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="586890349"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Steve Wahl <steve.wahl@hpe.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Date: Sat, 25 Jun 2022 20:51:58 +0800
Message-ID: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220625125158.KkK498zkweYYi4Xz9cQzDZ34fDXTrg6OdEedAOraoYg@z>

Hi folks,

This is a follow-up series of changes proposed by this patch:

https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/

It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
the DMAR_UNITS_SUPPORTED to 1024.

Please help review and suggest.

Best regards,
baolu

Lu Baolu (6):
  iommu/vt-d: Remove unused domain_get_iommu()
  iommu/vt-d: Use IDA interface to manage iommu sequence id
  iommu/vt-d: Refactor iommu information of each domain
  iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
  iommu/vt-d: Remove global g_iommus array
  iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024

 include/linux/dmar.h        |   6 +-
 drivers/iommu/intel/iommu.h |  29 ++++--
 drivers/iommu/intel/dmar.c  |  33 ++-----
 drivers/iommu/intel/iommu.c | 188 ++++++++++++++----------------------
 drivers/iommu/intel/pasid.c |   2 +-
 drivers/iommu/intel/svm.c   |   2 +-
 6 files changed, 103 insertions(+), 157 deletions(-)

-- 
2.25.1

