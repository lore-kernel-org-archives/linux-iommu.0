Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCF1F7095
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737093490; cv=none; b=A3XJSsPxYD3Yb6X9dHmlaTupG/gw2O9AlLbxCFB8sTEV7F6qdKsAMUYX4w785sBwUR6LeGPtRx8wNPNpOtmMPry/16EpcoXsumT/ujkTjQCKHNmK99LpoRJsXkUCWk/PlPWfdw+pgFpwB46hxFXccFd/2r180XEmrsEr02GLRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737093490; c=relaxed/simple;
	bh=+kcoySkgROkhJ4tv29JfS+a6mLoaYbXqsYJmh8hg158=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7HgjRKYQbnwfAw7ZQAvFEN8LrLI+iWnTglvQJmbTGgpsQBpm776WyQMn/8XdhlxPhsJTtcDOc4hoVTQ3MfHsDqyNyeUYTaX4MmradkD/2xfb0ROpcECpK9OHgNvOjdfPdtpDNczFwl5yvwY3HVx6cCzoQs1XcOyGrqY7g/CcHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTFtUjYO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTFtUjYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737093488; x=1768629488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+kcoySkgROkhJ4tv29JfS+a6mLoaYbXqsYJmh8hg158=;
  b=DTFtUjYO4i7F1e/JPl2oAmk7jEDspZMJJiLTdWfVhNx7LO8lZDfwjWV8
   jyLKkthiSaSMI0xwtKhqavH3HsuwAJU8KcvZJD21hItcuN6r73lx8n7aR
   Tn7ycMs6o97Yv99b5ngfZB8/y/DOjhtNgyGxAwVUtGy004a7tISD++RXK
   208nIUncnjtZ7YBZOv2RhSBmjeAuU0AO55rvmWHf0e8pZsCQvAcmeI+NI
   tY7G13ydT/UM0OO9K+rVfB13+OuZcNGEP1gK/9pnM85XWPEPvqlTaDFa+
   Px3h+tLQA54KzYAwwJ2YYT/axv/wQAU3+pAL9zzW4x5pXXX7Wsmf+J8kt
   Q==;
X-CSE-ConnectionGUID: c3SbIFYPRsuLFhmqgXLVOw==
X-CSE-MsgGUID: qzf++0oVS5OUMZuvw3gYHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37208546"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="37208546"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 21:58:08 -0800
X-CSE-ConnectionGUID: kX3c7vIqS5amtb1bYzcWnw==
X-CSE-MsgGUID: M2U8d5+7Tpu0UxpHQix4cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105554768"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 16 Jan 2025 21:58:05 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu: Fix potential memory leak in iopf_queue_remove_device()
Date: Fri, 17 Jan 2025 13:58:00 +0800
Message-ID: <20250117055800.782462-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iopf_queue_remove_device() helper removes a device from the per-iommu
iopf queue when PRI is disabled on the device. It responds to all
outstanding iopf's with an IOMMU_PAGE_RESP_INVALID code and detaches the
device from the queue.

However, it fails to release the group structure that represents a group
of iopf's awaiting for a response after responding to the hardware. This
can cause a memory leak if iopf_queue_remove_device() is called with
pending iopf's.

Fix it by calling iopf_free_group() after the iopf group is responded.

Fixes: 199112327135 ("iommu: Track iopf group instead of last fault")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/io-pgfault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 4674e618797c..8b5926c1452e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -478,6 +478,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 
 		ops->page_response(dev, iopf, &resp);
 		list_del_init(&group->pending_node);
+		iopf_free_group(group);
 	}
 	mutex_unlock(&fault_param->lock);
 
-- 
2.43.0

