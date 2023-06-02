Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148121118
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 02:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685671714; x=1717207714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JEJ1L3fbLIKfs8vDviE5ZoWgHo3ib3dTNshAkV9bzsg=;
  b=dD2+DE43glOU2v60VtliM9RKDNJPBjKfk8a+7bKcN8HoR46fcsiQzYX+
   VCY/yD7KQJS1tOjCKWUO4iNuSNUDU/gvrShQ3cRtcJn/MlthZkpXXc9Bh
   ccCAdEG0GkGFidZn4dJwjwZICXh1DPSAZIV640iGymZl+uipp8zNmCbeF
   El+3QODnN7+uO+bKpR682wq5bK1B/wKtbA/TyG3NxPY3EvdVG5geEJ09T
   k7TUkRVpIgsC2fn5FATZnklPnKnngng/PrASj8iJusDxJnkRp+1Wd9Lrm
   k0Yh8vNpGfbrN1X7ytLhQlJrugAPrG5kfzXRKlLuWHyACqEtY1fOnhz3D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="359039379"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="359039379"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777457812"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="777457812"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:08:22 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH v2 1/2] iommu/vt-d: Handle the failure case of dmar_reenable_qi()
Date: Fri,  2 Jun 2023 10:05:19 +0800
Message-Id: <20230602020520.224465-2-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602020520.224465-1-yanfei.xu@intel.com>
References: <20230602020520.224465-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmar_reenable_qi() may not succeed. Check and return when it fails.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8096273b034c..e9188d045609 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2967,10 +2967,14 @@ static int init_iommu_hw(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
+	int ret;
 
-	for_each_active_iommu(iommu, drhd)
+	for_each_active_iommu(iommu, drhd) {
 		if (iommu->qi)
-			dmar_reenable_qi(iommu);
+			ret = dmar_reenable_qi(iommu);
+		if (ret)
+			return ret;
+	}
 
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
-- 
2.34.1

