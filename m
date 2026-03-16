Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F6347518
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645566; cv=none; b=b/BicjO2oSwHZ1pAjXklTGmTtGiMgv100bcrWsdTmQB+Mr+TB+43wVDmqFKLsq04ZXeSi8gBslvVot/MJv8QlHQtJUyMPrbwE/7471rMc7FfdOBTmXH1B9Ah84g3wltipndmTxTqTAn8lS0pffXO6XJ6jBRH/V4pmHgO8OAy0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645566; c=relaxed/simple;
	bh=ZkQyjgCAaBSJJEWzEG1Yb23xpgsOnEGmPrAY1eUXk7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4m/+gY0oXuVyv2XerAoDy+/R7gF/x/9Uq8hQLKYEAMpyutIseTjE15/R34YVa4y/fRCMAjOgqJ13g5bj3QFhHw1NDRN6mp68XBr4bdgwZrtOVwzZZfQV2aVqxq4R8u5JDz9Vm6Z2got289B3UhEWSXpCuNMbFf87VZ3dHdIXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSdUUwdl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSdUUwdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645566; x=1805181566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZkQyjgCAaBSJJEWzEG1Yb23xpgsOnEGmPrAY1eUXk7M=;
  b=mSdUUwdlRMENUUVWIsQ82QExVRJVrLouFUEOLaRiEvDXzfHQly7UtWm6
   GzQmNF10aatJ9Vp6C1K2O716f/u6AllOp48oFcza5SpQTt8lpz9ANn8oR
   ukUyJmhGulyCAkyO2rJECVbhIneVZ1fcB4OP3fgoQGUFWfcEMJWWBa0KJ
   FjTPFZV/ePow2hJQmYFopfQg2jkiECcbag7gLbhxPlmDL+VRNR/EOCfzG
   2p9Rg6SY2wAN2dP/iDycIF6ijWI+cXc4P4OZl6+d5xKODLbzmc8zoRRIN
   xSBYAepfeynvwPX9D8/pXdEEmSoem9TcvTCpBO9Um8BG3v3svRGHbdFEZ
   w==;
X-CSE-ConnectionGUID: M/3B9C3KS/at5NnllWPRVw==
X-CSE-MsgGUID: GxFAmoKRQFKqIrWMDjRv6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92038572"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92038572"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:19:25 -0700
X-CSE-ConnectionGUID: HNLuNvH1SjOnRfnsdbvaZg==
X-CSE-MsgGUID: E/OjZ/VDT02hd8GX6YhgXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226496919"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 16 Mar 2026 00:19:23 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] [PULL REQUEST] iommu/vt-d: Fixes for v7.0-rc
Date: Mon, 16 Mar 2026 15:16:38 +0800
Message-ID: <20260316071640.347227-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fixes have been queued for v7.0-rc. They aim to fix the
following issues.

- Abort all pending requests on dev_tlb_inv timeout to avoid hardlockup
- Limit IOPF handling to PRI-capable device to avoid SVA attach failure

These patches have been reviewed and tested and are ready for merge.
Please consider them for v7.0-rc.

Best regards,
baolu

Guanghui Feng (1):
  iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry

Lu Baolu (1):
  iommu/vt-d: Only handle IOPF for SVA when PRI is supported

 drivers/iommu/intel/dmar.c |  3 +--
 drivers/iommu/intel/svm.c  | 12 ++++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.43.0

