Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133774435
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668778336; x=1700314336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s/w7ewn2Z2fzzXVOi/5St6iNlwdnhB5gDm3EIe34F8c=;
  b=f7ddYPz0vW+feMCWo0iMGBjBH8nej6eP+ow1mQt97gX3HRFoR8lXb1sy
   Acx1zWSs4IfH4Kr3AaajOsySoo6vRzc2nX0lirhe1EOC5ZsXY33GwYKEr
   jA5kU5AMCT+u1rjtY+i/DvMtT2Wz0hc/QEbmkPamYqvzQnCPbDHiGzOzZ
   0Bl+1kONLzvZivLjFo8ymikX88u9rci9tT9F57GppIL6P1F4Q/U+em/Cc
   okJCZ0W6CPKpXkrfppK7GXFTb7CAAs1e8OxR+6rUWV0dJ2TfiwjV4JNaE
   L1RF0GbSMLmO7SuWvUEwl1biSZfBE8c0BotCJ49qNf+5t/FvInjMZ5zTL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313146043"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="313146043"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 05:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642512033"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="642512033"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2022 05:32:13 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 4/7] iommu/vt-d: Rename iommu_disable_dev_iotlb()
Date: Fri, 18 Nov 2022 21:24:48 +0800
Message-Id: <20221118132451.114406-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118132451.114406-1-baolu.lu@linux.intel.com>
References: <20221118132451.114406-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename iommu_disable_dev_iotlb() to iommu_disable_pci_caps() to pair with
iommu_enable_pci_caps().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 25c772e8106f..a5885665ccef 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1441,7 +1441,7 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	}
 }
 
-static void iommu_disable_dev_iotlb(struct device_domain_info *info)
+static void iommu_disable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -4099,7 +4099,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
 
-		iommu_disable_dev_iotlb(info);
+		iommu_disable_pci_caps(info);
 		domain_context_clear(info);
 	}
 
@@ -4122,7 +4122,7 @@ static void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
-	iommu_disable_dev_iotlb(info);
+	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
-- 
2.34.1

