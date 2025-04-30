Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0B2111
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981535; cv=none; b=J/h9CSS6jTQO46OvIpNKGiLjGiEp1ltk5YViTMbF5Kcc1WMySECfQFW+DH5Y2jVEe0kYyMn7SMhx0MUoN1uTe5G8rhVEWBGdBBH8ozwSLq8u/kqOtKlwcaJ8mKaPA/DH0E+a/J649Jj+6GC+MqEju4EJWzDncQoN2pDkRrtUZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981535; c=relaxed/simple;
	bh=wRx45Eo25zW0PBYGNVMcwlHsTkB1kkO3CIiiZVB+M4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrLy8LRGjbbvZCEXZVAztAaXDeO50dZxYiZgZD99L6u1Pf7QuxZQolk9rnzBUzT7+Iw+Z8IQUeIQuCztDsSoLlf9IwNef3x3U3E6YFfR05TgkZB196dGreaEQ4MUDVynQSWMaDg4/DkWB/kEhBgpWWTBibg1/IHI9ZLkOwFax64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dy7+CHIh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dy7+CHIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745981534; x=1777517534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wRx45Eo25zW0PBYGNVMcwlHsTkB1kkO3CIiiZVB+M4U=;
  b=dy7+CHIhrWN4YUSSuW3VAvPoqvmOzPH40tG3jrGU4E9S+HMBr4vpZFiz
   bp3kkGeHzQccN90Yq2UEh3NQLUJUhNulnHnuGkAXmHZ2rC30bROmI8NL1
   DDYYU8MKJF//fxYyzVBG5nzboILIH/h+ChaYBznyZ2aQHW9eZ15m7snoe
   uoKs1CWcmWWRL+shfX8S7puNCBXv90k+f2+jRlMhV3UL3WDVHYwQj44Gc
   DhLvzoq1Y4IQw2JiJDMjaL+KKx4wLK6D/3qUOr1jsAIKHr53+VsdQlG74
   oka8vy/V6S11s/7oGixBse5nRhYlgsVj3DyURHlh4Bw1Lh6l0zzfIqFOg
   A==;
X-CSE-ConnectionGUID: MQms/nMrQ4Wj9T+uDuAgCg==
X-CSE-MsgGUID: CUG4it1kSkeoUw5FAZARpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47764410"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47764410"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:52:13 -0700
X-CSE-ConnectionGUID: pPBQKa81RpKUTSUCq3yoSQ==
X-CSE-MsgGUID: hBbuFPGbQjqdAgHmQo8CJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="133710817"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa009.jf.intel.com with ESMTP; 29 Apr 2025 19:52:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Cleanup comments for dev_enable/disable_feat
Date: Wed, 30 Apr 2025 10:52:49 +0800
Message-ID: <20250430025249.2371751-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dev_enable/disable_feat ops have been removed by commit
<f984fb09e60e> ("iommu: Remove iommu_dev_enable/disable_feature()").
Cleanup the comments to make the code clean.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1785caee5977..36df38c2d3a9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -590,8 +590,6 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
- * @dev_enable/disable_feat: per device entries to enable/disable
- *                               iommu specific features.
  * @page_response: handle page request response
  * @def_domain_type: device default domain type, return value:
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
-- 
2.43.0

