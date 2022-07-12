Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF701FC8
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584867; x=1689120867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P4gYB+84y2MPIxSa53ZGkHcAK9t8GT0kmT5bXXwNBjs=;
  b=X5kb1xZGHRIsfo+3RQ+udfXCxXB90axSiYXfBET3lByX11W0ZR/pFvtz
   I6RhbFqelC7+MKC4xbhg1dyulNbmXjZcW8Uiaedc2ju4xFrkVlwKD+Ttn
   +piMR+zo5EYXEMGz8VJUfIoT6jFQpialoHJe4tRiR7WlnLl51rlj6wInJ
   Yz3LUM5Ysl3nKjFlpv4W9M9VMK/d/36lT42ALHWhXtO+q52SwDndNqIv7
   0WbdOuktfZt0bZJ3SvT8KRlkVwxV8dS0NimEuCeKRNCWOods+bTrVBnMM
   3TBnFFIJ4+JjWvdEoAPuiQPBZ9V5fIb7Zfr3ymTuKSydl1Qlqx0vHgm+5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310412982"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="310412982"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445841"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/25] iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
Date: Tue, 12 Jul 2022 08:09:00 +0800
Message-Id: <20220712000908.3431936-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fold __dmar_remove_one_dev_info() into dmar_remove_one_dev_info() which
is its only caller. Make the spin lock critical range only cover the
device list change code and remove some unnecessary checks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220706025524.2904370-10-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a94fb69e1f9a..ccddf634fae9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -295,7 +295,6 @@ static LIST_HEAD(dmar_satc_units);
 static int g_num_of_iommus;
 
 static void dmar_remove_one_dev_info(struct device *dev);
-static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -4137,20 +4136,12 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void __dmar_remove_one_dev_info(struct device_domain_info *info)
+static void dmar_remove_one_dev_info(struct device *dev)
 {
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-
-	assert_spin_locked(&device_domain_lock);
-
-	if (WARN_ON(!info))
-		return;
-
-	iommu = info->iommu;
-	domain = info->domain;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
 
-	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
+	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
@@ -4160,19 +4151,12 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 		intel_pasid_free_table(info->dev);
 	}
 
-	list_del(&info->link);
-	domain_detach_iommu(domain, iommu);
-}
-
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info;
-
 	spin_lock(&device_domain_lock);
-	info = dev_iommu_priv_get(dev);
-	if (info)
-		__dmar_remove_one_dev_info(info);
+	list_del(&info->link);
 	spin_unlock(&device_domain_lock);
+
+	domain_detach_iommu(info->domain, iommu);
+	info->domain = NULL;
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
-- 
2.25.1

