Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39A363
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 02:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710898; x=1718246898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Kwv1UQHKRHrV8kbWrew4OGtdP1EEr6az2+Laq0Cs7w=;
  b=Yv/MKVYWAxZ0+YkyQN7ZeCT/rnCWa7K3S3XY6ttzm3lKSXtVIQXPbC4g
   q4CBI8JfRoSuxDLa3hUPwTqhUx7i8p7Bvax945nHNb9Tu0Y8X3y6W0gIu
   Kgj24gbecuadYOUhXeilQBxOWE7yIObE/LB+X9LgTr6AhkEV9Li4xodgo
   AtdW5q+9olwhM1maMsBIFOUacLlXG1L1Bxf+LvP1WYE2wBOecLjVvQBxw
   hB6RRdElsVPrMg8wiiPAJFKMGzt8+xobhWsOfT/rUAiSUyPuZ5ok3MsNV
   J2N27OunedLYikTHiJiXmIBEFFrVeTCJL9+YYi/E3cGkr6EZI7EY3kreE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348164458"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348164458"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711884198"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="711884198"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2023 19:48:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yanfei Xu <yanfei.xu@intel.com>,
	Suhui <suhui@nfschina.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/vt-d: Handle the failure case of dmar_reenable_qi()
Date: Wed, 14 Jun 2023 10:47:03 +0800
Message-Id: <20230614024705.88878-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614024705.88878-1-baolu.lu@linux.intel.com>
References: <20230614024705.88878-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yanfei Xu <yanfei.xu@intel.com>

dmar_reenable_qi() may not succeed. Check and return when it fails.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
Link: https://lore.kernel.org/r/20230605112659.308981-2-yanfei.xu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 323fa1a93765..e83fe243680b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2967,10 +2967,15 @@ static int init_iommu_hw(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
+	int ret;
 
-	for_each_active_iommu(iommu, drhd)
-		if (iommu->qi)
-			dmar_reenable_qi(iommu);
+	for_each_active_iommu(iommu, drhd) {
+		if (iommu->qi) {
+			ret = dmar_reenable_qi(iommu);
+			if (ret)
+				return ret;
+		}
+	}
 
 	for_each_iommu(iommu, drhd) {
 		if (drhd->ignored) {
-- 
2.34.1

