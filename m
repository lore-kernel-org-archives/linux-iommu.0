Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54A1632D0
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684486; cv=none; b=E0XCgS+UxWP2PqatLpdTW6pg9TLT8ohcb5wTRcOl/t2KigRjCt6PIXgP6zGk5AWDr+AX6qvHFf0S1kkdcj98e83osGXfC73Y34Dgb0Ew6MdRk+43WyNN4F5k335UIMsqfMdfBeCFeVTx7NdMK6TyLyCzezxzXWy/lAHjdZa+vC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684486; c=relaxed/simple;
	bh=bSn3aIq3rz3LgoOGOEtpxQT0RZDOVsctXmdMeTPqMs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8BEGNBqAOCPxMq8KsCIa9dyLzfYGEWFkQCHCkY3/Tp0lA26KIMdOUhniQE6DYNhbgRnFNrpxwbFjYhbBu4oEQIqYerPIWSyEZcUsFalXc7DmPQ/35YlRDfsZMFSd8djpUJdlH14K28WvttlXa9qgNglDKRZt1F9R0aVMtNC+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ag5HP5Ye; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ag5HP5Ye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684485; x=1762220485;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bSn3aIq3rz3LgoOGOEtpxQT0RZDOVsctXmdMeTPqMs4=;
  b=Ag5HP5YeXTp++Ui/uvrtHb2D4VaUAn9pipvXmuwtuITtckWMp2eDNWXH
   FReZ9q6OIzUdCUemlY9aP6etF2YxLKcb86Vf7BITungjxi8k6MqkaolWI
   Av+MA4JhvrOR6n0uvHAyQLCFe0++eUEus9TM7sTwNzP7Xi17gV2KC4Ea/
   mHvynBF2Z2bDySrqCws73hoPOzkhXpnhunEDAo51G+6p1P7PjMM6BEZ0Y
   iyNnFDiB3ufiqF9WdFwIuuPSAc351t32sUpI++jWavNtQPvy1dS73MEm2
   ZoCfJzbH5eXnw9bmZ7AG8YBxb2/1fKB6swVOyTuY7fWCAT5O+EXPw2WU+
   w==;
X-CSE-ConnectionGUID: oRl9IXINQXSsANoiFftx0w==
X-CSE-MsgGUID: e7YshyahSQOkyOg6/7zAXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221908"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221908"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:24 -0800
X-CSE-ConnectionGUID: 7/y1Gui9Rm2ARZzP3bCjew==
X-CSE-MsgGUID: Ug4VVJ3LSl+sNXVfddrRCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020867"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] [PULL REQUEST] Intel IOMMU updates for v6.13
Date: Mon,  4 Nov 2024 09:40:20 +0800
Message-ID: <20241104014040.106100-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.13-rc1. They are about new
features and code refactoring, including:

 - Add domain_alloc_paging support
 - Enable user space IOPFs in non-PASID and non-svm cases
 - Small code refactoring and cleanups

These patches are based on v6.12-rc6. The complete patches are also
available at:

https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.13

Please consider them for iommu next.

Best regards,
baolu

Andy Shevchenko (1):
  iommu/vt-d: Increase buffer size for device name

Dr. David Alan Gilbert (1):
  iommu/vt-d: Remove unused dmar_msi_read

Jinjie Ruan (1):
  iommu/vt-d: Use PCI_DEVID() macro

Joel Granados (3):
  iommu/vt-d: Separate page request queue from SVM
  iommu/vt-d: Move IOMMU_IOPF into INTEL_IOMMU
  iommufd: Enable PRI when doing the iommufd_hwpt_alloc

Klaus Jensen (2):
  iommu/vt-d: Remove the pasid present check in prq_event_thread
  iommu/vt-d: Drop pasid requirement for prq initialization

Lu Baolu (8):
  iommu/vt-d: Add domain_alloc_paging support
  iommu/vt-d: Remove unused domain_alloc callback
  iommu/vt-d: Enhance compatibility check for paging domain attach
  iommu/vt-d: Remove domain_update_iommu_cap()
  iommu/vt-d: Remove domain_update_iommu_superpage()
  iommu/vt-d: Refactor first_level_by_default()
  iommu/vt-d: Refine intel_iommu_domain_alloc_user()
  iommu/vt-d: Drain PRQs when domain removed from RID

Yi Liu (1):
  iommu/vt-d: Drop s1_pgtbl from dmar_domain

Zhenzhong Duan (2):
  iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
  iommu/vt-d: Fix checks and print in pgtable_walk()

 drivers/iommu/intel/Kconfig          |   2 +-
 drivers/iommu/intel/Makefile         |   2 +-
 drivers/iommu/intel/dmar.c           |  15 +-
 drivers/iommu/intel/iommu.c          | 404 +++++++--------------------
 drivers/iommu/intel/iommu.h          |  22 +-
 drivers/iommu/intel/irq_remapping.c  |   4 +-
 drivers/iommu/intel/nested.c         |   3 +-
 drivers/iommu/intel/pasid.c          |  34 +--
 drivers/iommu/intel/prq.c            | 396 ++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c            | 397 --------------------------
 drivers/iommu/iommufd/hw_pagetable.c |   3 +-
 include/linux/dmar.h                 |   1 -
 12 files changed, 517 insertions(+), 766 deletions(-)
 create mode 100644 drivers/iommu/intel/prq.c

-- 
2.43.0

