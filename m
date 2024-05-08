Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86D127B4B
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181378; cv=none; b=fzaTC7gG6fCn1HJccSP5LbRgBiehpVLohrdRHqUQtvFtqURrMuwXP92luwmfPlroUIGUiotChL8zu5cFSZkgUaR26CTugt4VrTY0ZNi4wbF+uNzXv+wftpubBuCTPPC893r17Mi7Z1H8kl0sq7OMEUZC7ZVfSEJsMY/0/QnNqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181378; c=relaxed/simple;
	bh=GJHyfriAJ+2dh/Ob1lOUkuQOQ46DKIhb28y6AMB6bOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0YxCSlHO2D8c1uCUIKxIZrglxhUOozD82+vpyBVyUOsidaLK/Ah/G4yV+cSulPtZsjddv0dtd0r7J//ehf060PITn1HAREZDVDXWk4IuLM2dFlyLu9XNE3zazSVgwzUzMX1kC/TOwOeqEThlBKT9jfjt5S7yqSIpwP2mgGYVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjwYpUQ2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjwYpUQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715181376; x=1746717376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GJHyfriAJ+2dh/Ob1lOUkuQOQ46DKIhb28y6AMB6bOs=;
  b=QjwYpUQ2yedKWKhZ7SrPUKo7mQeHkK5Rv4V4cRN6zfEMee4201D3B7t9
   xVCMS2XX/1pHGzicmgY2Bjo261ClAajJ/AzzuDrISlJvCxnLSPkRdF26A
   cjHlZlt6J83qAt7+WrOAswLC3+oiL+XCxlItnI0LBg8ejWTsQkm99RTEb
   BG9VnJhPSXb2IdaGpZ0KOxCRA+NGYzcHO/ofCQN9LVgcaDs0VPfvKLKpf
   2C3nZpJYU755sceMgBSO1faomqfi9fhJHl+G+D4MFayaKPcpr4kcIuTN2
   1vEM1DJHwNOGfIyr7h+wab9ulOGrlZHTh35cj3JEfwAQ0rWzOiUDjx4Rz
   A==;
X-CSE-ConnectionGUID: m8MzcZbPT96/HIOFtAQ3+g==
X-CSE-MsgGUID: +Vt6SfW+RUinJgJwyZW4Qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="36428854"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36428854"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:16:16 -0700
X-CSE-ConnectionGUID: R/TiqnD2RSiq69yyjRRV7g==
X-CSE-MsgGUID: lD/Jjg2oRBihEhH86y3AxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28802995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 08:16:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8BA9411F; Wed, 08 May 2024 18:16:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v1 1/1] iommu/arm-smmu-v3: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 18:15:55 +0300
Message-ID: <20240508151611.1444352-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Note, the original approach is weirdest from the existing.
Only a few drivers use this (-objs-y) one most likely by mistake.

 drivers/iommu/arm/arm-smmu-v3/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 0b97054b3929..a5601b97f296 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
-arm_smmu_v3-objs-y += arm-smmu-v3.o
-arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
-arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
-arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
+arm_smmu_v3-y := arm-smmu-v3.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
-- 
2.43.0.rc1.1336.g36b5255a03ac

