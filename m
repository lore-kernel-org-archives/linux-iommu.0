Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9913B5B2
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804940; cv=none; b=JxfdCznCm41lVBJYH7qRR5Zx46qvwwAdxvL92bNs07I5e2NNAGcKcZZ4yPGT4vUfPSQoVtl6tmFB0mfuBpw1fnDkv+2v9X76xUu76kIOvBa+6Bi4ZtyTpVoYa2LUY8VPaj4n4wnKOesidF7CuMbAHu6lKpN8JgP0ceqkT2Qf0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804940; c=relaxed/simple;
	bh=CrCQveiZdwYAH0mjaVPcjR6DITjQEl30tKTsxVaY4M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SctefmHvMy0Rl9uwCummftbJY0TzKDxzVfyOuIEFusJlS8g5ud7vt/5MMbVwIXMCn/GlY02Bxl2Quet1+OsyDWt2eAefdXniggYn+hAln2V3rxCkS4hZhHdZb84KvLRQnCnFN9BB9aVo0yFQAduNAVzmgiAbEtZsdLdwk+3xIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRyKRaQS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRyKRaQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804940; x=1744340940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CrCQveiZdwYAH0mjaVPcjR6DITjQEl30tKTsxVaY4M0=;
  b=GRyKRaQSyI0JIockxFlNIh7R7vxnsTGbdd0S8N+PJlNHhyYOWFAJEhJy
   3sSmXZJjb/Il489d5Rgz7kpgms/4SqksIGEsn6K+MMLfPA5+pcfSWANii
   1xXO/Zv4HjfLgWtruOznpAvTO7zHVNO6WqTEFW/ObL8IFv+bYWYNOw7WV
   uEm/BX8K8HZOLpbcVfX6390zfSh5WMm4XyBNRBHz+4GXtZ+6ShAykvz1Q
   yw0Mm9xfOaFzY2sECANVyvzXsmDq2b9F8mKXvOCl/Alz9L5/M62dhCKkn
   WzQlZtarKyHSf9srvL3Yur01AiTmXFLFbKqxElT4TguKNy7tfJ9QGImaT
   w==;
X-CSE-ConnectionGUID: texqzh1ST2iARv+ip7SCTQ==
X-CSE-MsgGUID: o+rNJmdHRMWPFcsQVPjYwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30681440"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="30681440"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:08:59 -0700
X-CSE-ConnectionGUID: 6U1REfodQoa03XAI2YHA1Q==
X-CSE-MsgGUID: Q0hxQO99SRKIYxHMhqIDTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20822964"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 10 Apr 2024 20:08:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Xuchun Shang <xuchun.shang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/vt-d: Fix wrong use of pasid config
Date: Thu, 11 Apr 2024 11:07:42 +0800
Message-Id: <20240411030744.273460-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411030744.273460-1-baolu.lu@linux.intel.com>
References: <20240411030744.273460-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuchun Shang <xuchun.shang@linux.alibaba.com>

The commit "iommu/vt-d: Add IOMMU perfmon support" introduce IOMMU
PMU feature, but use the wrong config when set pasid filter.

Fixes: 7232ab8b89e9 ("iommu/vt-d: Add IOMMU perfmon support")
Signed-off-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240401060753.3321318-1-xuchun.shang@linux.alibaba.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index cf43e798eca4..44083d01852d 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -438,7 +438,7 @@ static int iommu_pmu_assign_event(struct iommu_pmu *iommu_pmu,
 	iommu_pmu_set_filter(domain, event->attr.config1,
 			     IOMMU_PMU_FILTER_DOMAIN, idx,
 			     event->attr.config1);
-	iommu_pmu_set_filter(pasid, event->attr.config1,
+	iommu_pmu_set_filter(pasid, event->attr.config2,
 			     IOMMU_PMU_FILTER_PASID, idx,
 			     event->attr.config1);
 	iommu_pmu_set_filter(ats, event->attr.config2,
-- 
2.34.1

