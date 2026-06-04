Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5833B993F
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553132; cv=none; b=IRhUcijEsUmdLMnng7IVbMeHVCh9opNv3SNNGXcpsh88xnMLX8EbwkA0qEr+FMUwqMA2jOORvldKqvlw4DmbGgNjhLp47OA1uIxfLD96TqtgtAKUPG8mmgbL4M6MT51Q0MiHWSPOS+BfGAOprnSBOLmMn4Yq+yI93S0WbxKR610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553132; c=relaxed/simple;
	bh=IkWyGI7sOn8ysaQzmuYlVpc+Q61NMfBGyuDHERaiHK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvatCWokOpKOmXT1YF45Lx+XKbfAKhqIdjA3YRD+PdFzZWky6+7fzYvNYVDsskuvzQ5NAbvSifJGAGVI5DECuPrdiVSoyO/KPjIVTz4bH+B2f7UwjMVKFKUM/yo2iV4mQn03MwunK20YWWXmsCgo5jm2mfCreZbEjQexlpBeuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFpcWQJQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFpcWQJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780553132; x=1812089132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IkWyGI7sOn8ysaQzmuYlVpc+Q61NMfBGyuDHERaiHK4=;
  b=QFpcWQJQTtfQ6agmtBzcu4+R5vESOoNeeENXAh+gPo+gAwbQUu2PJMuS
   S9C6Q+8iu2E3yjid5XSbGLoQVSth1/V5XOEmoZDxCHTJTUdcnIa2kiyEF
   kbK7wbt5cv1d2bcniIH8dx4OTCaAyOp191X5fXa6bnHsWLfCPLNsu65gv
   Q5ieLi19fAM/mOb+metrjG2HXzRKQBPmDbnEW9+zLGg81js5kUjNaKTjv
   v1huJNXMUylz6qq5bRRAUVsQvwl9dj8R4Bf2L+/IyuMLjGE46BsziyHNz
   fZbgMB2kf/O4Vczahm8SgVmzvBQqobTm+yFN+sPYXgYnQc9RiUL+rwBYR
   Q==;
X-CSE-ConnectionGUID: kYs9TiIDQPC6tKbMk06L+A==
X-CSE-MsgGUID: DNvR8mFYS1u23P5GCY8JHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81554231"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81554231"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:05:31 -0700
X-CSE-ConnectionGUID: fO7u54FFRJqFVh9u5TppgQ==
X-CSE-MsgGUID: n7DeCWZMRTCLY13iFz6Vnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268112140"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2026 23:05:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] [PULL REQUEST] Intel IOMMU updates for v7.2
Date: Thu,  4 Jun 2026 14:03:05 +0800
Message-ID: <20260604060311.365074-1-baolu.lu@linux.intel.com>
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
- Fix RB-tree corruption in the probe error path.

These patches are based on v7.1-rc6. Please consider pulling them for
the iommu/vt-d branch.

Best regards,
baolu

Change log:
v2:
 - Dropped "iommu/vt-d: Fix Use-After-Free in probe error path".

v1: https://lore.kernel.org/linux-iommu/20260602233426.357499-1-baolu.lu@linux.intel.com/

Guanghui Feng (1):
  iommu/vt-d: Improve IOMMU fault information

Lu Baolu (1):
  iommu/vt-d: Avoid WARNING in sva unbind path

Michael Bommarito (1):
  iommu/vt-d: Clear Present bit before tearing down scalable-mode
    context entry

Michał Grzelak (1):
  iommu/vt-d: Remove typo from pasid_pte_config_nested()

Pranjal Shrivastava (1):
  iommu/vt-d: Fix RB-tree corruption in probe error path

 drivers/iommu/intel/iommu.h | 11 +++++++++++
 drivers/iommu/intel/dmar.c  |  9 ++++++---
 drivers/iommu/intel/iommu.c |  6 +++++-
 drivers/iommu/intel/pasid.c | 16 +++++++++-------
 drivers/iommu/intel/svm.c   | 12 ++++--------
 5 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.43.0

