Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482FB7E
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PN2Yb2fo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700099706; x=1731635706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wT7dbjKEZPnJlKx0LG/sRI7UdmUYfosJsm3/37/KvOs=;
  b=PN2Yb2forat/avhek0PzXxIDZtUGdpEKHHTLaepTe2mND+YaJjUkFzgU
   gkhYgtGddaTD3wz/tlABo+YTtqfODRZ65Kg1aX4hXaZBXmSdTwnDqcqE+
   jJ2hFUjvLuwblmgsn78XqyY8WHEmjOCxj7m/XJTynMH/q1bloj6T2KVQW
   zs6k5eCJPxzwiHYclShWfaboHeDLR6CX75gfn4oIAhIUOXDQh102iWTX5
   0yKGlBiPe4APhfj7zs2aAxB1pNP3n4VbT9kE1mhFpl04uCPFpcGi30DBv
   9IxVkjd49ACaR7Zust0ROZ9OJ7ZokCODdU3R433GhHF/f0Nn81HxO5VnK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381387670"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381387670"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:55:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="13395413"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2023 17:55:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu/vt-d: Miscellaneous cleanups
Date: Thu, 16 Nov 2023 09:50:44 +0800
Message-Id: <20231116015048.29675-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes several miscellaneous cleanups that were discovered
during recent development. Please let me know if anything I have
overlooked. 

Best regards,
baolu

Lu Baolu (4):
  iommu/vt-d: Introduce dev_to_iommu()
  iommu/vt-d: Remove unused parameter of
    intel_pasid_setup_pass_through()
  iommu/vt-d: Remove unused vcmd interfaces
  iommu/vt-d: Move inline helpers to header files

 drivers/iommu/intel/iommu.h | 184 +++++++++++++++++++++++-
 drivers/iommu/intel/pasid.h | 213 +++++++++++++++++++++++++++-
 drivers/iommu/intel/iommu.c | 237 +++----------------------------
 drivers/iommu/intel/pasid.c | 274 +-----------------------------------
 drivers/iommu/intel/svm.c   |  20 +--
 5 files changed, 421 insertions(+), 507 deletions(-)

-- 
2.34.1

