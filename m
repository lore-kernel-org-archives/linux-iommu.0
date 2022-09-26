Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497032F3C
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198492; x=1695734492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l33uKlRVnUDCKGSfBJTiII0eIXph9lfvKj0L97VJdbk=;
  b=GW33Eg233wsWh2gNJflCQ3qB8MRwjThqA699dMhBltCyENY6GUVE4gKr
   O33rxaheaRoeMs9wz9NfyNMORbiW8ANhrPLBlLBXWF3wmnbujfaj3e6bC
   Apr2194XXANtR0mgl/D15M50Y/QtNvtFzyDnMArnXODQ54nL5Wj+Wc+iy
   8h/DjuPlOqrrEiL4oVGu7j/syyH3vhlv7lcZf5PDwwgoSqgIBEzYAjT9a
   tXnFmj2vik9QeASI1xjFrMnFaGxVkiID99KGnmgSIFe+WqHaSADtrIjW/
   NZ0LKit47FhNyEKiMQPxAIJdrIp/RbAYVzHHt6WEMghlf73YpsvoQgaPv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288162532"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="288162532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683525645"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683525645"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 06:21:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Date: Mon, 26 Sep 2022 21:15:23 +0800
Message-Id: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

This is a resent pull request. It's based on v6.0-rc7. The original pull
request was posted here:

https://lore.kernel.org/linux-iommu/20220923004206.3630441-1-baolu.lu@linux.intel.com/

Please pull.

Best regards,
Baolu


Lu Baolu (5):
  iommu/vt-d: Remove unnecessary SVA data accesses in page fault path
  iommu/vt-d: Decouple PASID & PRI enabling from SVA
  iommu/vt-d: Remove pasid_set_eafe()
  iommu/vt-d: Avoid unnecessary global IRTE cache invalidation
  iommu/vt-d: Avoid unnecessary global DMA cache invalidation

Yi Liu (1):
  iommu/vt-d: Rename cap_5lp_support to cap_fl5lp_support

 drivers/iommu/intel/iommu.h         |  7 ++-
 drivers/iommu/intel/cap_audit.c     |  4 +-
 drivers/iommu/intel/iommu.c         | 87 ++++++++---------------------
 drivers/iommu/intel/irq_remapping.c |  6 +-
 drivers/iommu/intel/pasid.c         | 12 +---
 drivers/iommu/intel/svm.c           | 62 +++-----------------
 drivers/iommu/intel/Kconfig         |  5 +-
 7 files changed, 45 insertions(+), 138 deletions(-)

-- 
2.34.1

