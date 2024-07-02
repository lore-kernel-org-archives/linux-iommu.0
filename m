Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC919DF86
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925887; cv=none; b=ESU37iRXMXCK4B/OEFzLmma2rCdHIgCOuZvL2rLTYQFnyj3p6Mj2pNtXrCMmi/fl+mnYflCO3euuPTbqAxaDQrRoqTHZdrrq1BMQLY99HOs0+xlAKoFC1Gy8hNxiWVrMY9/Yfv+kg8/iQR2NrKQu/udISW4N5E5ETayz3fJVYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925887; c=relaxed/simple;
	bh=As/Aykdbt4v6c2/zxur0icfFP/KzwqKu7AKzmNTPDcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lvj9/XnlEvav4giP62t27Y1u8xbUvkWtse8t61gLu0CQ0UL66HYCt7cVa4s52Ehk0EE+411A2HeHmMIUpCBzyvNQhx6O70DaQDHf7ZfUMCtFFiW2SkV8DJBQQUBOCfp/3gw9fyOjVCEv2tRckkY3Xm2rk2rH/ebxVCn6mpLso/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alNJDMZ5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alNJDMZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925887; x=1751461887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=As/Aykdbt4v6c2/zxur0icfFP/KzwqKu7AKzmNTPDcw=;
  b=alNJDMZ56com2/WlphFtcGaJlyYK32DlATLbG0kAP9Bp4xgIjdLrar3I
   4mjEbSEG7PROImybLEVXe389tbz0mC3b10PgXru04xDlHNy7I/2Jy1Jau
   nrEUKpOm9xRWt+5qM8C5/cAeSYf4RzRpRMqLs/P6T1ajct1h/XwG9PYYX
   9QYdbxNqY3cwd0ym65zaA3OUemHh2RDsMUX22Lf+0B360StgjoS+q5Lxr
   V7I7kjttuDyR9AJ35163iD+dBPNOCtWxu9TxkXPfxXntmGRqzJXB9AOEM
   eWHxZ8Sjo9VpQ3L8AF/P2D5gJiefuTsB+isL0vflCcoZs9LxjtEQttt4+
   A==;
X-CSE-ConnectionGUID: 8rXJirx/RyKEYTtVRWDumg==
X-CSE-MsgGUID: ZTIVKhMdQKihwDnOZXCinA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27700008"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27700008"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:26 -0700
X-CSE-ConnectionGUID: GjlT4eamQJypxR+LYADpHA==
X-CSE-MsgGUID: MoMOyer4Q1uXsxLw/Dkazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250835"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iommu/vt-d: Remove comment for def_domain_type
Date: Tue,  2 Jul 2024 21:08:34 +0800
Message-Id: <20240702130839.108139-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702130839.108139-1-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for def_domain_type is outdated. Part of it is irrelevant.
Furthermore, it could just be deleted since the iommu_ops::def_domain_type
callback is properly documented in iommu.h, so individual implementations
shouldn't need to repeat that. Remove it to avoid confusion.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240624024327.234979-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e9811bf2a4e..abf0097f899d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2177,17 +2177,6 @@ static bool device_rmrr_is_relaxable(struct device *dev)
 		return false;
 }
 
-/*
- * Return the required default domain type for a specific device.
- *
- * @dev: the device in query
- * @startup: true if this is during early boot
- *
- * Returns:
- *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
- *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
- *  - 0: both identity and dynamic domains work for this device
- */
 static int device_def_domain_type(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
-- 
2.34.1

