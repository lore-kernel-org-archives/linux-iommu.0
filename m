Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACF1F12FB
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728089; cv=none; b=D777Mzo3LljdjYtsBpzQ8PvoNqvscrLPn+xrIf2bF9oNFJTJ+2I2GldXcYCwFPeuxe5icK6bu7nYCVK7MFlK9mXCRZl28Km+2oDxtwhmJpjdM3m6VElgv/jcrXOVGOZTjiLHLPndDwBZ0zlMychQuxhuE/0PkBsG/FOiJcV6BLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728089; c=relaxed/simple;
	bh=LaiWjx3hTb6Th/EihTa9jdCHV/ntKJQvs/k+9SaZYS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ov3xIp8zBT8Nq3w4k6StjpKMSF8kD28cvB18HyCzYK7aQSPeazijY1UmOf1Kf5gyUSIpz6kkwkboLKDxo0NWNblvC7SGF1kWrSG+drm3s+2dhhf9DQqUgmQT7WIXSp0x6sV/e8DH5GoM6w9lhuQKUVawDS9EppHK6LchAqc/Ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfoTT5+Y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfoTT5+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747728085; x=1779264085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LaiWjx3hTb6Th/EihTa9jdCHV/ntKJQvs/k+9SaZYS0=;
  b=gfoTT5+Y0XB+kj7LaSbsDJUI3XX6tMwUOjUszRt1lP9+ftlY6qgGzOas
   ffwAt5bD5pQOioeFobd/FY62t1pWrpwAiSrzSoPDRiGtMoQyjkq/s9UzD
   rH2qf9rVOIichUk5mPdq6R3ogJRkd/HNJFLo/VOO6VqGdbUFxnsfyz5yt
   /3xU29tQU5kSVihkApR79Wc+oeyUkU7w0/727GhICcBby8d+Kl1T2dFa6
   yBGZiYiTv3qw3SRSHUt2Ym1eRV4YNX0cTsZTIh258655Yb5LVhmmnqHON
   pjD+JiXVzIfVAW0nAul1SohlGru2ef0T8CLfF09ywxTP0EZ0+zRVk1DjB
   Q==;
X-CSE-ConnectionGUID: MrxEadxKTmuM7+do9myK5Q==
X-CSE-MsgGUID: VFTHNmXmTiGWAujWiEKUBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48763127"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48763127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 01:01:25 -0700
X-CSE-ConnectionGUID: 3WPXLGIZSCKVdpqXnAqu8g==
X-CSE-MsgGUID: vhPPT1zvSS6kObQln6tdcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144474226"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 20 May 2025 01:01:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1][PULL REQUEST] iommu/vt-d: Fixes for v6.16-rc1
Date: Tue, 20 May 2025 15:58:48 +0800
Message-ID: <20250520075849.755012-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for the Intel iommu driver. It aims to
solve the following problem:

- Keyboard and touchpad stopped working on several Apple Macbooks

This fix is not so critical for v6.15-rc. Considering the upcoming merge
window, it would be fine to include them with other patches for v6.16.

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Restore context entry setup order for aliased devices

 drivers/iommu/intel/iommu.c  | 11 +++++++++++
 drivers/iommu/intel/iommu.h  |  1 +
 drivers/iommu/intel/nested.c |  4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.43.0

