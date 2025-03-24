Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE41DC985
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817642; cv=none; b=FPTSmHPqTJx3Ypm6J2ZJu0GuDLTGhnagIS47BDYa/guzIdC6qYQ0HqNLWce9EpKCutuiMPO5ImjDSA3QoEejZAkgJTOcDXL3vsUfKzkwHN180jV7NgjRBIrMOXhrsOb8UcLgt5LIEjmOsGH51ab8xLn5ckEh/j3NFHTREDMStSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817642; c=relaxed/simple;
	bh=IjaYQ1X3z1026XnxD9BnxoqQvu8bn2AeFoNdFEcS8qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHHwulrY4XfKg1keiRrq5pLixIP/PDi9/8TK2R2RHufrO0nJUuEv2VOHTVY1H7RS7B7SLs92A7YGnb06Hv3oa8F8gdRXBBlqOOw97yQapoeRwUeR4JYr2RGATNvTP1a1V0eK/xitOTbL+fh/Td+lIf65e+NXnuyZ0KHUEb733Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSzw0bv5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSzw0bv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742817640; x=1774353640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IjaYQ1X3z1026XnxD9BnxoqQvu8bn2AeFoNdFEcS8qE=;
  b=SSzw0bv5CqsqaHiDrTzFi+XgyYUCevnP4a2UgGRh87AsJpEKltJbhwPV
   IqlyqpVkzfHuXHp9g9EP9wnCw/FWlfc1iunfLRzM/yQ+Lp0txnxvztX0Z
   p+yZMQA2dEwsT0UizPKsV7oczuv2mjoYQNMyenwU4ypkEs3dyNOCrWVFQ
   IVQdz0qmm0WCk3zKsgxF3FKOnlLrJyYf3Ar0ZGVtlxcRM6EVvZEmJd436
   w5JyyS8HLPKTb/yM3XVBPZWwvTBK+otjAJV/PhZ1vvighiyAJn4avLte/
   w0pc4rjcuA6rbgpKPu0zXFFwN/UyVGFH8x20YmJY6L65LI2aCsHkSM9rw
   A==;
X-CSE-ConnectionGUID: Ai4zRrr1SPu2zDDpjl220g==
X-CSE-MsgGUID: DWlOs9OFTvWbQb6OrPG4+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="44031315"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="44031315"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:00:36 -0700
X-CSE-ConnectionGUID: TL1oh598T5iZeFrdhf7xMQ==
X-CSE-MsgGUID: HC2LvgR1T+q7LLOvbNEGFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123753930"
Received: from unknown (HELO 984fee00a4c6.jf.intel.com) ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 24 Mar 2025 05:00:36 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: jgg@nvidia.com,
	kevin.tian@intel.com
Cc: nicolinc@nvidia.com,
	yi.l.liu@intel.com,
	baolu.lu@linux.intel.com,
	iommu@lists.linux.dev
Subject: [PATCH 2/2] iommufd: Balance veventq->num_events inc/dec
Date: Mon, 24 Mar 2025 05:00:34 -0700
Message-Id: <20250324120034.5940-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324120034.5940-1-yi.l.liu@intel.com>
References: <20250324120034.5940-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_veventq_fops_read() decrements veventq->num_events when a vevent
is read out. However, the report path ony increments veventq->num_events
for normal events. To be balanced, make the read path decrement num_events
only for normal vevents.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/eventq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 4c43ace8c725..f39cf0797347 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -385,7 +385,8 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 			break;
 		}
 		spin_lock(&eventq->lock);
-		veventq->num_events--;
+		if (!vevent_for_lost_events_header(cur))
+			veventq->num_events--;
 		spin_unlock(&eventq->lock);
 		done += cur->data_len;
 		kfree(cur);
-- 
2.34.1

