Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E157C
	for <iommu@lists.linux.dev>; Sat, 25 Jun 2022 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656164322; x=1687700322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ShCcjEiIWTp1WOPFUN/yyEN1to8mx/823nND7TpXSes=;
  b=bIiPl2ZWfC0bvLiZOSeHmeZf260KetYjvxgLR6FP5KgqVtaggdop+mcm
   Wsd16cjU8Kt0TDMy45E6UJhLF9YjZPoUlFNuZRAdXP5ANgfzHA1UP1P5M
   4kqp1IQL+KNrfSDvp97GTQ8UCJt29PArANFke+JXuMHhmHRQkbWEVY32+
   nUeuEPV+rYTxZEmFFi10jZmS7t/Xb/KOSPl8DEJYnTcDjVJjyNoKxZnoy
   nvsvaaj8f/a5kia31G+NKm69Zb5CKCQD/u4HM0k+igGlrvYNlo9EI5TPu
   bCrYo9O8koDnCQ3vc/Hpds3HPyotBlN9Fdrox0GgH9novzZCe6OAdQx1+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="260996140"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="260996140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 06:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645692698"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2022 06:38:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 0/1] iommu/vt-d: Fixes for v5.19-rc4
Date: Sat, 25 Jun 2022 21:34:29 +0800
Message-ID: <20220625133430.2200315-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220625133429.rcFre_ndnGkbLwy53TGAXs17CqNS8Hj3vXW7pKtEJH8@z>

Hi Joerg,

One fix is queued for v5.19. It aims to fix:

- RID2PASID setup/teardown failures for pci alias devices

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Lu Baolu (1):
  iommu/vt-d: Fix RID2PASID setup/teardown failure

 include/linux/intel-iommu.h |  3 --
 drivers/iommu/intel/pasid.h |  1 -
 drivers/iommu/intel/iommu.c | 24 -------------
 drivers/iommu/intel/pasid.c | 69 ++-----------------------------------
 4 files changed, 3 insertions(+), 94 deletions(-)

-- 
2.25.1

