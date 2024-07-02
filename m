Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15651A0723
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925891; cv=none; b=azZuyZBVHfC0IjbaLZ1ZCR7nJtJ2ZuWb3dJjMlz9aRymk2QapEw9MW5JZjTTXPaUXCqzmZEyZActWRGSApQ4rJYMP1S6jt6LgGiZvic7nq1w7dr0AaSyOQcLgdonAj+738935yTHlYFiNwKpghiA0516wR3DvwqQ5W581OCrW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925891; c=relaxed/simple;
	bh=s/TAqPjVQvCtm889EzSlvOJz3/QJr3ABkY1wqGJTDTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JjM9ySCGfEIWbAoXdWLClC2Kpb6nzTy7J7gSROvexuzq/nD7p+O3xGGkWkJ8xJD1a65jTldG65qZ0LSCinjnzzGv0d58ZQ6CTvSIGCVW2K9AhvxxatDolcH/goyPsp8Vjcnk5/6ufz96mq3lDS+44aaB6nMGc34vdctUHnfwIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSi9sUW8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSi9sUW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925890; x=1751461890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s/TAqPjVQvCtm889EzSlvOJz3/QJr3ABkY1wqGJTDTc=;
  b=GSi9sUW8YOFMUCRKLohupx9bZNxUQCM1v9DdTrbF6yFIEAuyx+GK9cRK
   JvrOQgohAMJa1ZwNwJ99JGuuTLxq1q6aF9+2STa0yHMYazsmP9k1CcY2H
   pDnz2wTAwB+pYU3opxZ7ZYsabmGAUE3GWTa0JI9hEGEEXsHZDT4jFF/dr
   wlyj8dDrzTGQ8aDpmtf3sapqEBT7FVzG6Vtb3bio/XiCK2qlohpT/holt
   uSLs8zA2iWbAweEYNQcmEjX3rCVMFhHxNq0ewIgYhG1H0EpA1vPLEzoVX
   HzTu6G9c5mrreDrC3xCCLnpxla17dpdWM9q84zJoSrNX8W0aPL90kEZTO
   Q==;
X-CSE-ConnectionGUID: 4ZyciAuVTCOiw3oFURyP6Q==
X-CSE-MsgGUID: L9/KJ9Z2SA6jOc2w3y6QQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27700022"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27700022"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:30 -0700
X-CSE-ConnectionGUID: 3IQ/xsymR+uNK7moAq5DeA==
X-CSE-MsgGUID: t1Iz1HeAQNCstEh9CuTRjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250848"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iommu/vt-d: Downgrade warning for pre-enabled IR
Date: Tue,  2 Jul 2024 21:08:36 +0800
Message-Id: <20240702130839.108139-5-baolu.lu@linux.intel.com>
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

Emitting a warning is overkill in intel_setup_irq_remapping() since the
interrupt remapping is pre-enabled. For example, there's no guarantee
that kexec will explicitly disable interrupt remapping before booting a
new kernel. As a result, users are seeing warning messages like below
when they kexec boot a kernel, though there is nothing wrong:

 DMAR-IR: IRQ remapping was enabled on dmar18 but we are not in kdump mode
 DMAR-IR: IRQ remapping was enabled on dmar17 but we are not in kdump mode
 DMAR-IR: IRQ remapping was enabled on dmar16 but we are not in kdump mode
 ... ...

Downgrade the severity of this message to avoid user confusion.

CC: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lore.kernel.org/linux-iommu/5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240625043912.258036-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/irq_remapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index e4a70886678c..e090ca07364b 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -597,8 +597,8 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 	if (ir_pre_enabled(iommu)) {
 		if (!is_kdump_kernel()) {
-			pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
-				iommu->name);
+			pr_info_once("IRQ remapping was enabled on %s but we are not in kdump mode\n",
+				     iommu->name);
 			clear_ir_pre_enabled(iommu);
 			iommu_disable_irq_remapping(iommu);
 		} else if (iommu_load_old_irte(iommu))
-- 
2.34.1

