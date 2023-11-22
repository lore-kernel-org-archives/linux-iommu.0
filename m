Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1BA8BE2
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoCXRkn3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623841; x=1732159841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l8mKiuMBoMj92zKyDcAwd723ed3hnwwboBhJ8sse7us=;
  b=KoCXRkn3I3jEqOHOpuBkxmPX6V5YgMQxaowr6X8F7mP8XbHStGHpSv6w
   EvMMVBccFXUVq7FdrMaepP0iiT2ScvYO0mtimnEk+4dciEUzHsgwLTlXU
   h9IjqqFv4JXuUchsm6KG689XFFfQq3RXE5Lou3QEr2ZA7lG4iDt42xJLl
   whCkcYayCo1DlnRGdhA0ba8LYqEP2HkzvaYESpPPWyC777e1OERj96ojW
   fsX48WSL+GGA7bqx+eCkl32F84mOU/+MrfxdIouCHemVfVZDBzuGoiZtz
   YKM7opJUeMYM0glMRk/1T9FnuLnbIQTB3/jZhKLleWctl8NTKNoHaNb82
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742810"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742810"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090194"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: mohd.syazwan.abdul.halim@intel.com,
	Kunwu Chan <chentao@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] iommu/vt-d: Set variable intel_dirty_ops to static
Date: Wed, 22 Nov 2023 11:26:08 +0800
Message-Id: <20231122032608.165144-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122032608.165144-1-baolu.lu@linux.intel.com>
References: <20231122032608.165144-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

Fix the following warning:
drivers/iommu/intel/iommu.c:302:30: warning: symbol
 'intel_dirty_ops' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Fixes: f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20231120101025.1103404-1-chentao@kylinos.cn
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 68f121c28fbf..897159dba47d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -299,7 +299,7 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_AZALIA		4
 
 const struct iommu_ops intel_iommu_ops;
-const struct iommu_dirty_ops intel_dirty_ops;
+static const struct iommu_dirty_ops intel_dirty_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
 {
@@ -4929,7 +4929,7 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	return 0;
 }
 
-const struct iommu_dirty_ops intel_dirty_ops = {
+static const struct iommu_dirty_ops intel_dirty_ops = {
 	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
 	.read_and_clear_dirty = intel_iommu_read_and_clear_dirty,
 };
-- 
2.34.1

