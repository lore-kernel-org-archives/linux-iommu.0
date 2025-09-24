Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2A27E056
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703046; cv=none; b=uvQ2E9l12onLTCLRrY3oJmKmhck0WA+agWVc+xCRL02IaRt5nab9F+mAbkObw51q9INpJlHuwN3muNWOl44XOFsOEHbOJAwU1ml30f1db6sqZCRdUxy92nQtWYVNrQaenoHmX5l57lVb1a9tIZ9CMUGtuOApLWnb87wQbVyIOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703046; c=relaxed/simple;
	bh=aiYWON9keCHVLc9yflSZEXEK9goh/Y/UPRDevhSJw2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imQtolCwkMwzx7CIihcLYdSfxNcnimmRSKT642vOis23cBojvxCgLHNJQ1a4UGA7ipDkYWkzRKyShiv2zPkyB2uTDPR2hpE2ns4KvWNn67nBejlp5I1X5K5Qcym2usc2JNHW4NsaD50jl3EEC3zhLfAToh9A9ptUyjAm/AR3G8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9/INM+v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9/INM+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758703045; x=1790239045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aiYWON9keCHVLc9yflSZEXEK9goh/Y/UPRDevhSJw2I=;
  b=f9/INM+vosACSTj+ewyfEMOJJarLvOcbWi6v3eDLki/4+NCx9iDqgGps
   DiqArW47kSCs/mIjBQ8pOl8gP84OPKVVGYTUUIAcSohMOPwCpAz1ETcW4
   pHQES+cCT5ypqpJDWA1pkwYZAoQOUO14eMHPaC8uf6dZz25q2Ao76UvPn
   2jAoCNnAY2AJF0aTi3dZKxQsfFv6yspP65UgrpPVogKiMpEf7LhgIN1Mg
   6veGnfUWi4ZgxaN3Zfx+KKk7BNgI4rxmWtc1UXGpUkoHAsrROgnzx0W/+
   04X4lIAM5vxI2oTOEeL096K31l25xCx54uEWejGhFSaPkPTgjnCKy6a4z
   A==;
X-CSE-ConnectionGUID: j/34jkatQzmylkgCsMoNjw==
X-CSE-MsgGUID: NbiCjaUpRlGfDWV25zm8dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61046164"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61046164"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 01:37:24 -0700
X-CSE-ConnectionGUID: ru6bNs7BT2yNJ8TgyvhTCQ==
X-CSE-MsgGUID: c2clMeV4QQan3ug7lEcuxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="207915048"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 24 Sep 2025 01:37:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Disallow dirty tracking if incoherent page walk
Date: Wed, 24 Sep 2025 16:34:46 +0800
Message-ID: <20250924083447.123224-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dirty page tracking relies on the IOMMU atomically updating the dirty bit
in the paging-structure entry. For this operation to succeed, the paging-
structure memory must be coherent between the IOMMU and the CPU. In
another word, if the iommu page walk is incoherent, dirty page tracking
doesn't work.

The Intel VT-d specification, Section 3.10 "Snoop Behavior" states:

"Remapping hardware encountering the need to atomically update A/EA/D bits
 in a paging-structure entry that is not snooped will result in a non-
 recoverable fault."

To prevent an IOMMU from being incorrectly configured for dirty page
tracking when it is operating in an incoherent mode, mark SSADS as
supported only when both ecap_slads and ecap_smpwc are supported.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d09b92871659..2c261c069001 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,7 +541,8 @@ enum {
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_pasid((iommu)->ecap))
 #define ssads_supported(iommu) (sm_supported(iommu) &&                 \
-				ecap_slads((iommu)->ecap))
+				ecap_slads((iommu)->ecap) &&           \
+				ecap_smpwc(iommu->ecap))
 #define nested_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_nest((iommu)->ecap))
 
-- 
2.43.0

