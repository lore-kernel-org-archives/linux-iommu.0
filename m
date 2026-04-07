Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591963890FB
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544482; cv=none; b=iUPjkhBIuyKt1jw9FZQoC/XlwTqERTbt+vDtnJrCw0m5ocKYUATk8xkZx8UckCVX8vi/gBGo/Xihx5m78i7/k2zFPuOQZ2IwIKSDtA4U62hPCYJIV0lctg2Qi7oIPFJCmoP+UwZtgSFMZj9VTbrnPOvskKFbLejv1V7lXC7ijdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544482; c=relaxed/simple;
	bh=3UU5/j30pd4fNm5+p8LNYIveHNDxLBIHz8yImu6/+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWyCCS93QWqCGBdjJih+t+456t9sr3d/T7rFSs+SkErsQMNQKFfzvs79KTVJRYBZQrQ74ldg9qdJ5W+I2KoGBaG9/h9terKbjxNSMAIT0ST2SZrDYXbwxxaRdIgn8E4QNF4+zVXpbdgOk54YqAHi8XxjOtpW8lx7Esd6yzu0BRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJSPFoFy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJSPFoFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775544482; x=1807080482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3UU5/j30pd4fNm5+p8LNYIveHNDxLBIHz8yImu6/+n8=;
  b=cJSPFoFyCbH6cdDneQupDGSCl6SQ4AsD3Jbj6ggDfy8TKZ9uAl2FhZYp
   NtBMcy5jGnEl9nKqc+DiEo5OdNbZZNtnepWPmocFE+SHLlYcrMzY9ZdH/
   T8pbOSyt/wrxkz1UMjavqsSOuXIKD10KY6sW62i3K7DKWKTvDEZ4YdW8V
   IgrrQWSFd8+vd8sXSkhFauRZBQMKVmJFxwyNwrM0HFB35surNdAM2COxC
   0EdiL1Odb3Z9qfU9Sdc2AETT5wtUpRcbKaJ7z/m2tqd3q/h6+rSZwdIMF
   vQdFRBELOIGkvPy2W02jl5y6kxFm3FhZ+wpLK8OEr6DZ0VzajjKbSTY3q
   Q==;
X-CSE-ConnectionGUID: UnP9DIgoSGiRZhKYUvmDjA==
X-CSE-MsgGUID: /2IoYi/dQeGzAiX9SfY8/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="99125916"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="99125916"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 23:48:02 -0700
X-CSE-ConnectionGUID: AumcT/44TsuxNUu95tj2rg==
X-CSE-MsgGUID: tRiwsEkzS8mJTszj5Q6jDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="266066625"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 06 Apr 2026 23:47:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] [PULL REQUEST] Intel IOMMU updates for v7.1
Date: Tue,  7 Apr 2026 14:45:21 +0800
Message-ID: <20260407064522.1814193-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following remaining change is ready for v7.1-rc1. It aims to:

- Simplify calculate_psi_aligned_address()

This patch was originally included in the v1 pull request but was
removed due to an issue identified during review. This has now been
fixed, and the patch is ready for iommu/vt-d. Please consider it for
inclusion.

Best regards,
baolu

Jason Gunthorpe (1):
  iommu/vt-d: Simplify calculate_psi_aligned_address()

 drivers/iommu/intel/cache.c | 49 ++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

-- 
2.43.0

