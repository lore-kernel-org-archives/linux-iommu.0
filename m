Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4B7C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 02:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663728411; x=1695264411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vDtcpAIxO1Hg32fIYnZCpOhyOIneyfklxCE7E+vUyZw=;
  b=gDgCVsDHvwwFKktIsQSH7QB6lzwNhBUrKuShQRqx+DnAJHK4WL1bCbHR
   6qfbu5sN51IG5CBjzdG7Z3hRRgJ/8KZEpeVZdvwQNpZ+MR2UxoLErR0oS
   CQd8gOz/jmSRxeayivlfZTfC3u5850GAuaz4i8jmgoa38TWTrUj+0Cj19
   l5FCqXFKF/uFQsb8T8wfYhwKDHUFwmjLkFBY0qPM4T8iyjxDJdZYsQ6YD
   bm50WJwKQpGEhlFxM6HmkRkwk8UEqeGz/kBpTN6Hib5huYrtEihwBfXMV
   4guIgvTSVV2YLFUtSyGhH3S8HUbgy69LfSpSIrDiTRT3yd2eoC9zt5QMp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301277917"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="301277917"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="681573930"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2022 19:46:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	George Hilliard <thirtythreeforty@gmail.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org
Subject: [PATCH 0/2] iommu/vt-d: Fixes for v6.0-rc7
Date: Wed, 21 Sep 2022 10:40:52 +0800
Message-Id: <20220921024054.3570256-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below fixes are queued for v6.0. They aim to fix:

- Check the right capability bit for 5-level page table support.
- Revert a previous patch to avoid regression.

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Lu Baolu (1):
  Revert "iommu/vt-d: Fix possible recursive locking in
    intel_iommu_init()"

Yi Liu (1):
  iommu/vt-d: Check correct capability for sagaw determination

 include/linux/dmar.h        |  4 +---
 drivers/iommu/intel/dmar.c  |  7 -------
 drivers/iommu/intel/iommu.c | 29 ++++++++++++++++++++++++++---
 3 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.34.1

