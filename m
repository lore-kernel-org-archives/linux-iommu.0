Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36413777E
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840118; cv=none; b=EtWd7icdYCMW29o1oNe7iF4ypvQhrWpkU7wprRpFpgTQNUTPoFe9dIZjz5ijX/MfmCKCEm8ZxBJdqtJ2odOMBeYZlUwwTX7/2fgG95JE1edQccYQMrgjWKfs0qCKxOv0v+00o0Y+NE5idmllnNEHv39kT6EvDJjqM1ZfMeX+4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840118; c=relaxed/simple;
	bh=mcEVOJ2LG3KT7zONZb6BF8om4Uq2uTeYaEizPU+/NBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhirC79MJzp4/hWLbSqq9O4l3pe5BWCE4rNxcG2dZAmWavxhKfVroDuPn3eFWFJfMUTIg6vZcTsnIWzJYt/b3ESnxpCgjDiXVFltpzkabV4uy3e/pufbeNTqOcYGPYiTVdP5lqlmc4cfn6OZcd8/helkAo/jaVAryQuSwtNQskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACPiVoY2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACPiVoY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774840116; x=1806376116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mcEVOJ2LG3KT7zONZb6BF8om4Uq2uTeYaEizPU+/NBE=;
  b=ACPiVoY20nZCi22gtkY/fKFVBE7XVah7onbo8BlM07gvIzm7IyJsJYuT
   xrVr3UVhmuYfuOEuRCxqkf5prYWpJAt+9jVWHOW7jccdFfyzPIQtoKVrE
   Yq2ILzndu1ZFSliz49Cp02lE6sQMCH3xyG8ip9lRd79kBHRj9xYFaY52r
   Ho2XancGeZnIFnpyz5hpeEnQjcD2vK+thRJhBPdUfw6L+3rvcLJj92mXx
   jwDLy0vquDSbAViXp6ROLEhGFkacTYuOuzDF5kiQU9kfNYThmt7YW8jmQ
   yySpSHvIRxRGTWsxQZsEz5dMhd8nIqGX18wULeiDa23H/urYQbD/yO+F+
   A==;
X-CSE-ConnectionGUID: kALwuEc5TxOUkT6L0KwHbg==
X-CSE-MsgGUID: y8pl+wCYR4eOVRNfNnCiBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86517933"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="86517933"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 20:08:35 -0700
X-CSE-ConnectionGUID: 4letKbCoRZecnFtED8Tt2Q==
X-CSE-MsgGUID: zdxweSVWTpK9Z6OblDc3nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="221052606"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 20:08:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Date: Sun, 29 Mar 2026 23:07:55 -0400
Message-ID: <20260330030755.12856-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copy_from_user() may return number of bytes failed to copy, we should
not pass over this number to user space to cheat that write() succeed.
Instead, -EFAULT should be returned.

Cc: stable@vger.kernel.org
Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/eventq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f1e686b3a265..710eef0b6004 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -187,9 +187,10 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 
 	mutex_lock(&fault->mutex);
 	while (count > done) {
-		rc = copy_from_user(&response, buf + done, response_size);
-		if (rc)
+		if (copy_from_user(&response, buf + done, response_size)) {
+			rc = -EFAULT;
 			break;
+		}
 
 		static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
 			      (int)IOMMU_PAGE_RESP_SUCCESS);
-- 
2.47.3

