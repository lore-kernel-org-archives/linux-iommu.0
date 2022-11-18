Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BD33ED
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668778339; x=1700314339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFINOeY0qWVoM/bkOJT0DrDVTz+kLKxbWYnAUaePQp0=;
  b=YbeDF8wWJAoxb4l5RlNWUVArP+v72m8+L0dsMPTdJTbacdRV0XLmsnjC
   kN5O4lE5eZtHdFZYXmPR6BjYP0wi6rUtjJW8zzquGJWzb2Mi/r8BHq94X
   M5MfC0ee7etUCNZYaG1WjNAqBAhBittJDKwERX4FsgX4r2egFJzGKbEqC
   VlCi7IyAINzpNVUGpQ8x3Xqs/akj8o3tNuz3fGBuatudGEsSX8T+0yaRQ
   G8VILKnbpOQ7zx8nmgfSI/7V2BK9E7S4GIm0AFr2GVMAMUgLmnCKtrKis
   yLQhOnf8dC+LWM40t+OUXPSU1OhuAyDCzB6ChEnutlrlFWLP5TiROwgJr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313146054"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="313146054"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 05:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642512043"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="642512043"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2022 05:32:16 -0800
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
Subject: [PATCH v4 5/7] iommu/vt-d: Rename domain_add_dev_info()
Date: Fri, 18 Nov 2022 21:24:49 +0800
Message-Id: <20221118132451.114406-6-baolu.lu@linux.intel.com>
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

dmar_domain_attach_device() is more meaningful according to what this
helper does.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a5885665ccef..3bd79ae238f2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2453,7 +2453,8 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
+static int dmar_domain_attach_device(struct dmar_domain *domain,
+				     struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
@@ -4288,7 +4289,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	return domain_add_dev_info(to_dmar_domain(domain), dev);
+	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
-- 
2.34.1

