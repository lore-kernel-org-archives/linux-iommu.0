Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3432E6B8
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046686; cv=none; b=rlG45OL3SiFT/RWKMaXSsSSwEUxywjRa7Hj2Bo/1JBeU5qxC8eCW/fYTrJRTwI2xwlfYZMRppU39cAy2vcDJ/CrbWLp1AYSc6rbm63qT+Z4z8Ki7UWRdcSBmpxAgkvl7MbXUWM+xBic/S3qiQgjOr4CeCEkmThJjappI2J5Ka3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046686; c=relaxed/simple;
	bh=+25Dt+05L0lJ3JM8xeMx6+/EQmnRjzs6N/IspftqQAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJpfMfGyFVBv+DlBHLNNOHi2j16iiYejGdTkx7P8AYfLB4iA4O/6rSlszk+sJ6L7GAb/utaAk8vjVgzUWLs8viwjuIQ54BhYtGXCDpeqBh0ca4zjx1DO+tuZ8TqkOh7NKayD19NMaekV2yztNoQIW2jwjCW4F2SbRhG3Qy3LOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OetcO1uV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OetcO1uV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769046684; x=1800582684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+25Dt+05L0lJ3JM8xeMx6+/EQmnRjzs6N/IspftqQAE=;
  b=OetcO1uVNgQy0pNPhhLbzuUlPo9m4sOtP6NpPrC1LpgIrM6axYxR7kTY
   CFaRN+SFh0dvUjFOyMMRvCyGZOBtsfvX1YFgMEGD0yh3QIGQruN0iSUwT
   FbIpXfcSS/hZ0Xm/09SuFna5/4a1eCFeConBnKSl3Ths/JcjBnz+DRy1y
   g6OExcxpY8/6ZJRTGaTufIhmaiaXJr65wdoNdvX0bgXJTHpgzARsDjP+m
   AyE7OqRjfhGXsaim+4KYW/hp/7aei4HJcIvvCrjQf7L/aYQbccIi2mEMB
   6yRsZO9r4EtL0rzzNNMxqozvsx2WRQLydyaYKYD6kyvpgtcU5bqs73YNp
   Q==;
X-CSE-ConnectionGUID: XnbQFES0R9WxO2k/CzkFbQ==
X-CSE-MsgGUID: EVboRJ4aTAaTFwjTUrlPug==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81393031"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="81393031"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:51:24 -0800
X-CSE-ConnectionGUID: aIkpS7eJRXaIo4OPKJNxhA==
X-CSE-MsgGUID: kTHH7AEaQBifa5UADb/OHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211455617"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa004.fm.intel.com with ESMTP; 21 Jan 2026 17:51:22 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for v6.20
Date: Thu, 22 Jan 2026 09:48:49 +0800
Message-ID: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.20-rc1. They are about
some non-critical fixes, including:

 - Skip dev-iotlb flush for inaccessible PCIe device
 - Flush cache for PASID table before using it
 - Use right invalidation method for SVA and NESTED domains
 - Ensure atomicity in context and PASID entry updates

These patches are based on v6.19-rc6. Please consider them for the
iommu/vt-d branch.

Best regards,
baolu

Dmytro Maluka (1):
  iommu/vt-d: Flush cache for PASID table before using it

Jinhui Guo (2):
  iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without
    scalable mode
  iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in
    scalable mode

Lu Baolu (3):
  iommu/vt-d: Clear Present bit before tearing down PASID entry
  iommu/vt-d: Clear Present bit before tearing down context entry
  iommu/vt-d: Fix race condition during PASID entry replacement

Yi Liu (1):
  iommu/vt-d: Flush piotlb for SVM and Nested domain

 drivers/iommu/intel/iommu.h  |  21 +++-
 drivers/iommu/intel/pasid.h  |  28 ++---
 drivers/iommu/intel/cache.c  |   9 +-
 drivers/iommu/intel/iommu.c  |  33 +++---
 drivers/iommu/intel/nested.c |   9 +-
 drivers/iommu/intel/pasid.c  | 212 ++++-------------------------------
 6 files changed, 83 insertions(+), 229 deletions(-)

-- 
2.43.0

