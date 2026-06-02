Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5C280CE5
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443408; cv=none; b=OwRinPIV+BZcfksrwV4r0ilLmPHaEBAnkGBBO4HtbxJt6ag/8WoRcvHdVfUOgbTxEZx2X6rCF4hDVaOpuTfHCAYz5+4HnTSEujmZc3Q2hn0k+c7x+8cUrWPD+9j3ElU5hVRTLz6uq2rQi7+e4V4Ys9iy2LEnFEPZHHk4CWSS/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443408; c=relaxed/simple;
	bh=e/rF7M4/+Du4SL8fncXheIk22zgdzntGnK0k60dEWpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mPRrr0GiPQoes7V2XC5VJ04vtGuA4h2A3jJVajN71pvQ6h54L/QYrmAjTlXRRP+udELH0bj/g9bQfLwM15hmnS4YsLF1JlafO1EBp9Afy5PmVd1VOt/A1MIHz1QftERI6w5ZUjNnNdFtpqqcAMHxGxAkr9aBTn5ped9edv967aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/gpKlIx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/gpKlIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780443407; x=1811979407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e/rF7M4/+Du4SL8fncXheIk22zgdzntGnK0k60dEWpc=;
  b=N/gpKlIxXVvYvRdde4yOhPF5xvNiWwJwy7mgb2YFWDZSxkL7unDNYK7V
   BPErvkRVMRJO9AdOWuo8xzRUxNRpQp7X41+PSahoLnuW+OQV5VBoXrVMq
   q3Rnt7g+Obe4kgRCSHg7tGUDWg9HeEsNq1C2JGR61C9shykpWsnctOQWr
   2nBWvRQ3vUe+KiZG8kyaaqQTTjoZQ818TNqb/tOtiQbcnckm4o5J6mfSo
   tcvqBrn+ENZ9u2BavESqNaz5hEUsEggHModwtt30ppE5T1X56DC/LP3XY
   RtEn65uYQGhgqXTLLDM6+P7sDPEPH9CDyyfXiPxU6gnuxjfKjUzzrKBYC
   w==;
X-CSE-ConnectionGUID: 1V0NtAGXSMWlN5cFXehw/Q==
X-CSE-MsgGUID: qezamZt3RSmk4pf23WXg3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81369700"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81369700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:36:47 -0700
X-CSE-ConnectionGUID: pbyCBbk8R9Kgj14cJ2mX0Q==
X-CSE-MsgGUID: WqPaTTAdT6WMiNGeZrDcCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241068738"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 02 Jun 2026 16:36:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for v7.2
Date: Wed,  3 Jun 2026 07:34:19 +0800
Message-ID: <20260602233426.357499-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes are queued for v7.2-rc1. This update introduces 
a few quick fixes and several refactorings, including:

- Add the PCI segment number to DMA fault messages.
- Improve support for non-PRI mode SVA.
- Ensure atomicity during context entry teardown.
- Fix RB-tree corruption and a UAF error in the probe error path.

These patches are based on v7.1-rc6. Please consider pulling them for 
the iommu/vt-d branch.

Best regards,
baolu

Guanghui Feng (1):
  iommu/vt-d: Improve IOMMU fault information

Lu Baolu (1):
  iommu/vt-d: Avoid WARNING in sva unbind path

Michael Bommarito (1):
  iommu/vt-d: Clear Present bit before tearing down scalable-mode
    context entry

Michał Grzelak (1):
  iommu/vt-d: Remove typo from pasid_pte_config_nested()

Pranjal Shrivastava (2):
  iommu/vt-d: Fix RB-tree corruption in probe error path
  iommu/vt-d: Fix Use-After-Free in probe error path

 drivers/iommu/intel/iommu.h | 11 +++++++++++
 drivers/iommu/intel/dmar.c  |  9 ++++++---
 drivers/iommu/intel/iommu.c |  7 ++++++-
 drivers/iommu/intel/pasid.c | 16 +++++++++-------
 drivers/iommu/intel/svm.c   | 12 ++++--------
 5 files changed, 36 insertions(+), 19 deletions(-)

-- 
2.43.0

