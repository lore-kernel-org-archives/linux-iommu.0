Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF11B274
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695643663; x=1727179663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EiFYvJBANXRWei66/+2vn5xdrrHtRl9Ccl5+XMV9cds=;
  b=NoYASujFyJeyHpAyN5/gxW28gT099fBVfVxmQ5S1AsT6Lx4Nm7kbxdyE
   GQbSPKtY4Ntb/TVM3yM4MtyGznGS/WELZx+4//Us+qTEUxvAj1Or0Y7B+
   yiWObi6bKFIhc1wmTp0pFpqx5eyFUj78wA2zoh5pIP17u+VDJPl3PkBXK
   uRjEMsY/+fiGc8jXconTqadlu0Hp2PFtujqQTuC0hLuGU2weTaN9DLQQD
   KqjTpH+Ys5ou+ysOcN5foE/9h+OuLaiJLUKxafzeF85knEgIVk8QZtP/6
   lY/GDTVUTw44l5LF2KXaIrrWipUInuZFmEv27Mc5JpD144Zh+ud2v4y/N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380110406"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="380110406"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741907331"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="741907331"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2023 05:07:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.6-rc4
Date: Mon, 25 Sep 2023 20:04:16 +0800
Message-Id: <20230925120417.55977-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

A quick fix has been queued for v6.6. It aims to:

- Fix a suspend/hibernation problem in iommu_suspend()

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Zhang Rui (1):
  iommu/vt-d: Avoid memory allocation in iommu_suspend()

 drivers/iommu/intel/iommu.h |  2 +-
 drivers/iommu/intel/iommu.c | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

-- 
2.34.1

