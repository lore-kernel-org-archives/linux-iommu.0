Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1B1537CB
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034894; cv=none; b=VLPhxVv3xKTECnvYuPT9oRfhT72sev//+kKmHyAXyk7j+NuR2lh+ladmWKhMQJ/DCiMAyY+/3WeXSEPiGK30CbqM6RsnEqGsbT0J9XW2T/swX+R0vA9un3WfrqVWzVRfKI1cbQdestvhiOk9gzBlRtvWDIokiZVjiJY+3opRC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034894; c=relaxed/simple;
	bh=n4KF3dBjJucW5uKA3f4JXugGchbXk/nbttaph2dNEeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGZso5/3Nazojkx5XYX7/BW34qbIW6r0xTWgq5YuF2agXoFrzUpXxkEVTzKVFsTfCq4U7DN6B6MBZjv4zANWtTT2gGfu9S3VccJhxI5w6Y5Cu8TKa8NP1dmZbX0IbLwSjkXu6spWEz8fZT4LolX2gmFXB7K7XrZzFSydZ0V0EGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqbpC1Yi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqbpC1Yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034893; x=1759570893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n4KF3dBjJucW5uKA3f4JXugGchbXk/nbttaph2dNEeU=;
  b=VqbpC1YilYbxjKYQGUFBm0eDK6iNFRFgAR9oiCTaLZBG839SbiAwRSbY
   GgdEavC/ZdVSbBRDLmbcD5KBIe/n8scW9lcbLFqO+hxtND7vNwc5kvnSh
   XsBi33QWksgMILiMFkTBrSdktsqr3ssANjmpGnJQT3b8hvJK3dlOJga+s
   IMBfRSk2ukVCUds/LjP9zZrXDp6nsVfWunn+PFZUPwrMlLkhuLWIvZHKG
   5HDSiuD8mD/K7K4uMTOwuptTzbGkrhJ+oU+Ivo8ZTN+eEUG2ssL9hpyGl
   1tb4awVvjYqGrF/Lldl73KetxB38+x27JnXXU7MA50yjt7UMJLTDwFrGq
   g==;
X-CSE-ConnectionGUID: uDsxOHMQTSKfYrTEfvxGrg==
X-CSE-MsgGUID: gm9cgjlCRT6xX3VQSbkoQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37856288"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37856288"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:31 -0700
X-CSE-ConnectionGUID: Otx8UPjeS0WU/6ygcjZ9hQ==
X-CSE-MsgGUID: nyDUhajAS4aDSGF+jSAM8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74331943"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:28 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 45283120F46;
	Fri,  4 Oct 2024 12:41:23 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoN-000TaV-0r;
	Fri, 04 Oct 2024 12:41:23 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Pranjal Shrivastava <praan@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH 22/51] iommu/arm-smmu: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:23 +0300
Message-Id: <20241004094123.113725-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8321962b3714..cad02d5dc6d2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -79,7 +79,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	if (pm_runtime_enabled(smmu->dev))
-		pm_runtime_put_autosuspend(smmu->dev);
+		__pm_runtime_put_autosuspend(smmu->dev);
 }
 
 static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
-- 
2.39.5

