Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E480D8F48
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282894; x=1726818894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t9shzln1aiQ0VVrVLLLhztKgUvVIxQF/AjCqw0E9eAk=;
  b=kRXjUC6Y4jWhoga45VLpS0e4XES5G6gPOHBrBvRdi3Y9ORBD87jmodW0
   sFi78OS4eWZ/qwYs5/RWP6UDGcLdZfmSl7QP1mNO4/tqHVCa3CzfEhNVm
   6jKVKWSpA82eSCy+DkqPXzZBe4kC7jcTga0nXCM8Na0dCzBSPcjCWDh4p
   dgpnnkssb/Gx095gHbo05/NPaRkX3r6sFVdquY7Gq9fjeraNnhZdwobvr
   K5XV/siH/P3a1B2srUTmLcvy+ibvcrzT+llWueMAyQCiemxExK059PZcV
   O0JsrlGwrEP8ZYVZQdWKZLN+XsMyXwHIY1ooCjx5N35Jzx98R4Fc3V2Uq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764495"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764495"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523184"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523184"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:53 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH v5 10/11] iommu/vt-d: Add nested domain allocation
Date: Thu, 21 Sep 2023 00:54:30 -0700
Message-Id: <20230921075431.125239-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds the support for IOMMU_HWPT_TYPE_VTD_S1 type.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c93c91ed4ee2..9b10e4b1d400 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4077,19 +4077,35 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data)
 {
+	bool request_nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 
+	if (hwpt_type != IOMMU_HWPT_TYPE_DEFAULT &&
+	    hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
+		return ERR_PTR(-EINVAL);
+
+	if ((hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) == !!parent)
+		return ERR_PTR(-EINVAL);
+
+	if (parent && request_nest_parent)
+		return ERR_PTR(-EINVAL);
+
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
+	if ((parent || request_nest_parent) && !ecap_nest(iommu->ecap))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
+	if (parent) {
+		domain = intel_nested_domain_alloc(parent, user_data);
+	} else {
+		domain = iommu_domain_alloc(dev->bus);
+		if (!domain)
+			domain = ERR_PTR(-ENOMEM);
+	}
+
 	return domain;
 }
 
-- 
2.34.1

