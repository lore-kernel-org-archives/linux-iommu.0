Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965C34BA21
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645567; cv=none; b=VM+bafp3IhCqmMdReAd8X/Z4G0SeQoeNQRAkg3d6GQzEh8u57yQ9zVBl/zEYYbyIDoDQLZnc44oEm4maOjW3XE/6fG/qhzh8LXtUbtQnhmKjJkX8t7G0Njl6emsdsPAJJX4dk9MMLC+u7L6KiTm88KPtMr6eP4BmkW9HZ3nRNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645567; c=relaxed/simple;
	bh=KcrkEcAHRJGoEZcd0jSIO3ktYh4GA0Y9wKxIbHTPAGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDpHbxMQr2TvBlnItFomwnw+/3ybqjFTfp6LbvRFqH+ygPYx8TDGmbwfp3AGT6MvLI81Y6KG9aapAc2Yxij7m+w+3VX6yWhE842a8xyI4ks4veMTb1J7noe0z5NcAKClqS+Hqtb3IqkgotGvLUax8yvY9VSjV9jajkQKNnBqszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3zcTMIT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3zcTMIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773645566; x=1805181566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KcrkEcAHRJGoEZcd0jSIO3ktYh4GA0Y9wKxIbHTPAGE=;
  b=B3zcTMITtcOx3DcUyvpp8jdk47OEvzPpSH4seTTFA+NZqS7z2P/N2iaD
   uDvd7EawXLyjfvPVgz1VGI3DH5+JkCMSYOAg72sOoqbHMMAzrGU2wGxR+
   9p7Ojacu48HCxvKQrcz5XbNIdyA7FPEAUF0LHSGYkX89DtYko8y4VuL8/
   EorfTCVimukEemEmTHXAFfTOZjn57+xa9lpl0a4hOrvBq9WCU9KhCR05i
   Dvb+zp7Wo6yOM9IC1gmxjaMU2m6wisyXZTs1zDXSD6bW8xPpR0ZRY1+Jq
   5pu9z4DcW5rdM3GdcTrVqqRB54xcEqpPKDyb+2v6GxDJmghPrQ3ucnGvb
   Q==;
X-CSE-ConnectionGUID: UHOULSFxSImp9lfQZ/6Cdg==
X-CSE-MsgGUID: fIVmjVr7T+6GyE6pjqVNzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92038582"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92038582"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:19:26 -0700
X-CSE-ConnectionGUID: Agf/ehajRI+OzkAxDs6cqw==
X-CSE-MsgGUID: SfKe6tiyTECkMkP8ZrF1sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226496920"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 16 Mar 2026 00:19:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry
Date: Mon, 16 Mar 2026 15:16:39 +0800
Message-ID: <20260316071640.347227-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316071640.347227-1-baolu.lu@linux.intel.com>
References: <20260316071640.347227-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Feng <guanghuifeng@linux.alibaba.com>

During the qi_check_fault process after an IOMMU ITE event, requests at
odd-numbered positions in the queue are set to QI_ABORT, only satisfying
single-request submissions. However, qi_submit_sync now supports multiple
simultaneous submissions, and can't guarantee that the wait_desc will be
at an odd-numbered position. Therefore, if an item times out, IOMMU can't
re-initiate the request, resulting in an infinite polling wait.

This modifies the process by setting the status of all requests already
fetched by IOMMU and recorded as QI_IN_USE status (including wait_desc
requests) to QI_ABORT, thus enabling multiple requests to be resubmitted.

Fixes: 8a1d82462540 ("iommu/vt-d: Multiple descriptors per qi_submit_sync()")
Cc: stable@vger.kernel.org
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Link: https://lore.kernel.org/r/20260306101516.3885775-1-guanghuifeng@linux.alibaba.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d68c06025cac..69222dbd2af0 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1314,7 +1314,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	if (fault & DMA_FSTS_ITE) {
 		head = readl(iommu->reg + DMAR_IQH_REG);
 		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
-		head |= 1;
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
@@ -1331,7 +1330,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		do {
 			if (qi->desc_status[head] == QI_IN_USE)
 				qi->desc_status[head] = QI_ABORT;
-			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
+			head = (head - 1 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
 		/*
-- 
2.43.0

