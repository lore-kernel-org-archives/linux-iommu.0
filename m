Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2714288
	for <iommu@lists.linux.dev>; Tue, 30 May 2023 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685438867; x=1716974867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fwx6XkwajTMSuzKO6uWLg7Ou7DkXom2s4s3Qa8sVvZ4=;
  b=mCk0zoPAfXEfuYY2lbxyF8C11muBH69vVv3bnw9d83YkEbd+whM2NB4L
   CE8gZuF+bl2J5ehu41vo8shVUdbuJLfuTL0/FsKQ2LOvOOTi4atiD97MH
   bIOFxX6CVZ9mT3oTTGBMnxsZdY1Xpi8jKTckzCIR45HufuajN4O1befdD
   9EHskiTgYBrV5YowHzyhPkfhzv2TJ12fPwB/IXQJxpIW4o1Ay0jst5wwZ
   WxQbR3Qll2bFiHpehsaBOYzsigIdS+re23SF0KGSvsjsf0fxkv8Zk229K
   AX6znjsJ+yvK4pyG1iyky3ymo4MDd2IEVjyjG1Cem6DzLW1uI9FrBP+dI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344365165"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="344365165"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="818720160"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="818720160"
Received: from tower.bj.intel.com ([10.238.157.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:27:44 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH 1/2] iommu/vt-d: Remove the dead code in init_iommu_hw()
Date: Tue, 30 May 2023 17:25:02 +0800
Message-Id: <20230530092503.152926-2-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530092503.152926-1-yanfei.xu@intel.com>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After 'commit 2a41ccee2fdc ("iommu/vt-d: Change
iommu_enable/disable_translation to return void")', init_iommu_hw() only
returns 0. If statement for return value of this function is meaningless.
Hence change init_iommu_hw() to return viod and remove the dead code of
if statement in init_iommu_hw()

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8096273b034c..e98f1b122b49 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2963,7 +2963,7 @@ static void __init init_no_remapping_devices(void)
 }
 
 #ifdef CONFIG_SUSPEND
-static int init_iommu_hw(void)
+static void init_iommu_hw(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
@@ -2988,8 +2988,6 @@ static int init_iommu_hw(void)
 		iommu_enable_translation(iommu);
 		iommu_disable_protect_mem_regions(iommu);
 	}
-
-	return 0;
 }
 
 static void iommu_flush_all(void)
@@ -3051,13 +3049,7 @@ static void iommu_resume(void)
 	struct intel_iommu *iommu = NULL;
 	unsigned long flag;
 
-	if (init_iommu_hw()) {
-		if (force_on)
-			panic("tboot: IOMMU setup failed, DMAR can not resume!\n");
-		else
-			WARN(1, "IOMMU setup failed, DMAR can not resume!\n");
-		return;
-	}
+	init_iommu_hw();
 
 	for_each_active_iommu(iommu, drhd) {
 
-- 
2.34.1

