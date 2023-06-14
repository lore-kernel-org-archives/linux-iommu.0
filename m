Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C3381
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 02:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710895; x=1718246895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mgs7bQooIc7YQi0mgkJidjbrzzjdiVIVlaG9S+z9HvY=;
  b=biNYeItbXjmMf6LJRPFPNkAMyUgpPkzeU3apPeaY3FvTHxn5r/4UAlMq
   oaRy7FFCBNrQkYDEyqFzCrL6m1FYFPLXgNNjFy85jTqd3vNbjbIALYfjb
   at0Caz/jvMEsnr3bPYLYVtqHjU66EMS3MW7WWTYRNBR4puI1rG4ONOczP
   XFRagG8BazmOI8KyxITLoYtZjC2Xg/VHUV4bG1flUsRD+4n3lT/x55Gg8
   A0M0A1rFOmgH5mJW74kbIRq9LKu1fbYDrdq9lCXq07F97fXTtnjAM2Jc0
   FbxDX7UI+YaKEj1l6DJ4+dMqA1qqOGMSH0Tjf8jFcw2yBkm/IWksfNkrc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348164441"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348164441"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711884180"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711884180"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 19:48:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yanfei Xu <yanfei.xu@intel.com>,
	Suhui <suhui@nfschina.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.5
Date: Wed, 14 Jun 2023 10:47:01 +0800
Message-Id: <20230614024705.88878-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

This includes patches queued for v6.5. They are:

 - Small and misc cleanups

The whole series is based on v6.4-rc6 and also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.5

Please pull them for x86/vt-d branch.

Best regards,
Baolu

Lu Baolu (1):
  iommu/vt-d: Remove commented-out code

Suhui (1):
  iommu/vt-d: Remove unnecessary (void*) conversions

Yanfei Xu (2):
  iommu/vt-d: Handle the failure case of dmar_reenable_qi()
  iommu/vt-d: Remove two WARN_ON in domain_context_mapping_one()

 drivers/iommu/intel/iommu.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

-- 
2.34.1

