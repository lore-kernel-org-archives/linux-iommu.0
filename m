Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566F2AE66
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574860; cv=none; b=f5oqXbMqntvzWTWS7VmOE5bMgy40q2Knn0HmdXVveGICV33XMo0AmazjP0LRv/Sx9L0uwHETtNvJChFruj9gj/E/IXPhJVgsGeYRpOEQCROPZOh/mq7pdELt9LajGEUWFCrt6J0SJmVb3utr4WapZNApN+aCIBbOJVR+j+cUYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574860; c=relaxed/simple;
	bh=uWl8lEs66r2zt6UYtOrOYf0q0rOgE1dREivc2Z1GCd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgBmHQoX8aWP4mJzvgBojwxn2SItvQsJZwGw/Bino9Jw5gcE8wZzeSev8NDvDXsNKAdLTAkFkNtfaLIbNEOP+DMS8phXafuceixNjpOCY9LSqb0wOgsNtGyHQB3VxPmYqfTqnBYSa9AMurNshhUhLNgaJfI7FMOVx+BaD85cJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClYqhjyR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClYqhjyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574859; x=1773110859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uWl8lEs66r2zt6UYtOrOYf0q0rOgE1dREivc2Z1GCd0=;
  b=ClYqhjyRSqt3942oz2Z9QOVwvZNZZR4OHvuY9oTOW3XCLp5gPTfkETTl
   asDPqwwpqliFNikJAEqFs/UGWlE9ITmyg+Z5bDT/xzrIAGGxC9Hkmo3uL
   1tLZoGE5+UOu9R2YLgujWenPbdh3OY+OFligAlOP9A/cEmXZKBLNki5Ym
   1gRw2+zwO0/WGUpqq/f53kwnGHcnlFYt/KvY6AueMZ8gjPtB/6E3RbJIX
   FKRXcWMFE//B1aR7bCZZ+b9huHJoJg9qMnuQEzeaJbmIHS6fihTqQ7jWF
   7UEVbrCV/DgCyUt6Uwxa5yqGIM2u9zgLfhREYJz8Xae3pCctKmD2S93gl
   Q==;
X-CSE-ConnectionGUID: BIMhmDk+QuOE2nAcV030DA==
X-CSE-MsgGUID: 04W81gvuREmUMqu0cR7ZUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42401584"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42401584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:47:38 -0700
X-CSE-ConnectionGUID: 9bls0p6TTdyZIQjcriywhA==
X-CSE-MsgGUID: biCQtQOOTeyDIdg2jKDt7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143079224"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 19:47:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for v6.15
Date: Mon, 10 Mar 2025 10:47:43 +0800
Message-ID: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.15-rc1. They are about new
features and code refactoring, including:

 - Checking for SVA support in domain allocation and attach paths
 - Move PCI ATS and PRI configuration into probe paths
 - Fix a pentential hang on reboot -f
 - Miscellaneous cleanups

These patches are based on v6.14-rc6. Please consider them for the
iommu/vt-d branch.

Best regards,
baolu

Jason Gunthorpe (2):
  iommu/vt-d: Use virt_to_phys()
  iommu/vt-d: Check if SVA is supported when attaching the SVA domain

Lu Baolu (3):
  iommu/vt-d: Move scalable mode ATS enablement to probe path
  iommu/vt-d: Move PRI enablement in probe path
  iommu/vt-d: Cleanup intel_context_flush_present()

Yunhui Cui (1):
  iommu/vt-d: Fix system hang on reboot -f

 drivers/iommu/intel/iommu.c | 237 +++++++++++++-----------------------
 drivers/iommu/intel/iommu.h |  28 +----
 drivers/iommu/intel/pasid.c |  43 ++-----
 drivers/iommu/intel/prq.c   |   2 +-
 drivers/iommu/intel/svm.c   |  43 +++++++
 5 files changed, 143 insertions(+), 210 deletions(-)

-- 
2.43.0

