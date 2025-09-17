Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EC2222A9
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077575; cv=none; b=t7V+bM14aerhp80CR07yJLaEK90uoafxY550OyVRDL7Va/Q9iKDeo5U/5HRpfmh1C1BsULAXhS7BLYtPp1fRkjW+inVm5UvZYoswxsjSpb88MNNpF3mGFIi2scsb/trEzZ5e7Egs/q9djfPQBfWxkee9TYPc02vpj/bF74LTv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077575; c=relaxed/simple;
	bh=1FB3YJWHrHEy0BFfKNEW+nSFvDTuEpjtae+Le0DpCl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ax0tr+gKGztO+XI+cOZV76J3UrK8XRlM5jT5MIqYZR31PLwRjiGrddYSSKoMDcjLrZRTdLHYbNptX2QSP92mXx8F3KVDFeC9TfsvDWUB0gILeVaKeUa0DuPcwqQg6F6hMTzhwZf4kb54H4UwVi2jDMdsrxm8bD+JKjDDceKgrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKRyVuow; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKRyVuow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758077574; x=1789613574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1FB3YJWHrHEy0BFfKNEW+nSFvDTuEpjtae+Le0DpCl8=;
  b=MKRyVuowjIHfvKVdI8nw7p5AGKLPgAWMrellragfuMfppxzQ70YfyF8D
   STp8unlEncqosVgpa0+aw5yFOTY53CehDqMX+V7L+rSEczhdro3iiNKbm
   DdMRDbSoNc1P9MrxzNxeKtQetfociFeF8tenxHx4hRNt2rvmTpZb0Jim3
   MgKUa1GBQtHelpf0iWihdN8oHW3D5Yuri1xCDz0S9rwIoEZ9TaV+NdFqu
   l9XaLBSEBY+sfeC3KBNrcVPBb0Bi++HIz1zkAgtLoi7UhrZmRW9hS52Ok
   Gjm9FCo4pcVOs8YfFoQcMYENlyir96GP7WiV9WwmI7fbKtgdciiB1Hxyh
   A==;
X-CSE-ConnectionGUID: lCrqp1kyRo2RZC5FO34H3Q==
X-CSE-MsgGUID: zyEDdRrRRZ+7EIl0m4SNlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60430069"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60430069"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 19:52:53 -0700
X-CSE-ConnectionGUID: 3SxhjaHRQZCQQ69Ch9cmcw==
X-CSE-MsgGUID: uO8khN6nTE6gVhzDelG31A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="175204686"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 16 Sep 2025 19:52:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: debugfs: Avoid dumping context command register
Date: Wed, 17 Sep 2025 10:50:51 +0800
Message-ID: <20250917025051.143853-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The register-based cache invalidation interface is in the process of being
replaced by the queued invalidation interface. The VT-d architecture
allows hardware implementations with a queued invalidation interface to
not implement the registers used for cache invalidation. Currently, the
debugfs interface dumps the Context Command Register unconditionally,
which is not reasonable.

Remove it to avoid potential access tonon-present registers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 765edb3740e2..617fd81a80f0 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -62,7 +62,6 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(CAP),
 	IOMMU_REGSET_ENTRY(ECAP),
 	IOMMU_REGSET_ENTRY(RTADDR),
-	IOMMU_REGSET_ENTRY(CCMD),
 	IOMMU_REGSET_ENTRY(PHMBASE),
 	IOMMU_REGSET_ENTRY(PHMLIMIT),
 	IOMMU_REGSET_ENTRY(IQH),
-- 
2.43.0

