Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F792C2E9
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912200; cv=none; b=oAMDA2+OWIQcIrat3lY8vJhM4TH47p+QhXRneu6m6xcC7nFL33lNQ1LBCkWbEgVUtFoBwkbC/oLuQEREZLp5+8GxdS31lxpyGeFXh8QjOJPIaLxnEFHwT+u62zm0PCMBBUs6GZGeoG5S7tjdYwZZ8awB4ZaMDsPfOIzlOH3GjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912200; c=relaxed/simple;
	bh=xxfqT0qNL14nNG0EUpV3NkFQXJRIeyYHuEM9FexqDo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Crp4GPufntDbCkQlzArbexeVIJdtWt/5Syo/rJPEY9DdM5MiIP3PHF/9KrsWXCm6mAhObytW6/E+PpzVvQcjtyd0CcXUjg4vcTyrF/OSTzmm3x91ZlqLonIwo/eB7mmNSmqr9yU7tr86imq8QSKvKlDHa+c9GsZinz4k69amULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jm9IO5qV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jm9IO5qV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722912199; x=1754448199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xxfqT0qNL14nNG0EUpV3NkFQXJRIeyYHuEM9FexqDo4=;
  b=jm9IO5qVqvAhDrm+eKkWes5/VXELrtT36yI2SZS3F5vHd095deN8welf
   huww/DgJ+l/3yyw9Y0cuSs92cJiUpK9vT8YEW7X4XfA13sECLycMXuLyU
   zi/RGJFV4/tj/VBvATYy26VKyGCaVqWROg4AHJbLf767JIDxBroHL9mmZ
   mEZGt3NN32AlYs6MxL93osj9laF9+lnbEJkqUUzgy3qTFlK1fslS33lYe
   VcFBxbOQ+pu+2M1142lzEU6hLSKOruTvh+D5VkNP4oJ70jvd68F66vj36
   wRxrIEBELrE9CO+8o2GEwU+VrMkL9+ngJq/ltk9XGbiy2BsqgUHueGqPO
   Q==;
X-CSE-ConnectionGUID: lt0C9fWlT0qNFL9aRetwlg==
X-CSE-MsgGUID: 9V/RRCm4TQiaEmiwntjuFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20756276"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20756276"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 19:43:19 -0700
X-CSE-ConnectionGUID: /1agKx6MQLiGItPn6qZLkQ==
X-CSE-MsgGUID: Sq7BaKgIRnSmAZwxKyiZQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56572526"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2024 19:43:17 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Tue,  6 Aug 2024 10:39:37 +0800
Message-Id: <20240806023941.93454-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806023941.93454-1-baolu.lu@linux.intel.com>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use a global static identity domain. Reserve a static domain ID
for it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 723ea9f3f501..c019fb3b3e78 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * entry for first-level or pass-through translation modes should
 	 * be programmed with a domain id different from those used for
 	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose.
+	 * this purpose. This domain id is also used for identity domain
+	 * in legacy mode.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
-- 
2.34.1

