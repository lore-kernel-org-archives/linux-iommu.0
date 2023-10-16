Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E592572
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAKTMd0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697427132; x=1728963132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7iMKDRCvqp9vX9k3vsWvlopQYAJfIXTN0uAtyli9Xik=;
  b=cAKTMd0XIlrSv+ns5BIuBc4MDQXpM2i3vozqRYVDbaKVEYHpypGtimLM
   ryi4l6lTTBmb/ll3RYSg/otlXJGMbJIeeYjfP0W4MRijFMRwYwtkFl7SA
   WMVE8a/B+6FLN98VpReCE8i/oXidIWzP7AG1WWYRqWrEC6hxO+kp1Xojr
   /biFtmcxu9Yj9RVx7bdmzlQNM1cmgli4o46wH0bXdKmtkvytdlOXVU/fp
   q+YqKiPKRhVjoQe6K/qT5jmfJ/+TCV4IIxvN9XbPsgb70/c9oJUJdJABs
   Abff6fmLRLckTWTUiaLAnJPEahh/PT/+Qdnr2jvk2XdvW0ZjRjGFLVqSf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365701125"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365701125"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705444251"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="705444251"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2023 20:32:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jingqi Liu <Jingqi.liu@intel.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/vt-d: Remove unused function
Date: Mon, 16 Oct 2023 11:28:27 +0800
Message-Id: <20231016032830.101321-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016032830.101321-1-baolu.lu@linux.intel.com>
References: <20231016032830.101321-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The function are defined in the pasid.c file, but not called
elsewhere, so delete the unused function.

drivers/iommu/intel/pasid.c:342:20: warning: unused function 'pasid_set_wpe'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6185
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230818091603.64800-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 8f92b92f3d2a..06ddb3c927f5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,15 +335,6 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
-/*
- * Setup the WPE(Write Protect Enable) field (Bit 132) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_wpe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
-}
-
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
-- 
2.34.1

