Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E4523F
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mi01HYUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295349; x=1729831349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6rYDQz/MWEAW+IS0pl99symy0Ie0OKVXnjfTmOy5Xes=;
  b=Mi01HYUBAmxz5+r4OE7WH0qEY76A6MOnhGR/WPhyOqTEkvfehg+SrrRX
   3qQciRq810pgW/25lmwMtxBTf2PkpRK+upLfB8TGl5/lnk+ZqrrhIsRer
   709LfHIMhcXS8PseSd24ydkTTAE6gyOsB361TWJhmxFkpBFc5ji6db4oC
   9VOsNOIVyvZKN1AR+/mrOyaIppBUE98Ew+P3A2Yq8J0m9cI5qS/+ECm0b
   9Addcy/cdCZBuJArHek/Fs5oteYx6LzYhSrF3E6wiESizz4BxppfnqnaS
   flo1mv1nA+fXC4u8b1RPWrs5QDIdtOWq9oW0RRBJw219z9AB06azLAzZa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367670792"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="367670792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829478589"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829478589"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 21:42:27 -0700
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
	joao.m.martins@oracle.com,
	xin.zeng@intel.com
Subject: [PATCH v8 7/8] iommu/vt-d: Add nested domain allocation
Date: Wed, 25 Oct 2023 21:42:15 -0700
Message-Id: <20231026044216.64964-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026044216.64964-1-yi.l.liu@intel.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds the support for IOMMU_HWPT_DATA_VTD_S1 type. And 'nested_parent'
is added to mark the nested parent domain to sanitize the input parent domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c  | 39 ++++++++++++++++++------------------
 drivers/iommu/intel/iommu.h  |  1 +
 drivers/iommu/intel/nested.c |  3 ++-
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 292baa64188b..4ce372d5d4f3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4077,38 +4077,39 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
+	struct intel_iommu *iommu = info->iommu;
 	struct iommu_domain *domain;
-	struct intel_iommu *iommu;
-	bool dirty_tracking;
+
+	/* Must be NESTING domain */
+	if (parent) {
+		if (!nested_supported(iommu) || flags)
+			return ERR_PTR(-EOPNOTSUPP);
+		return intel_nested_domain_alloc(parent, user_data);
+	}
 
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
-
-	if (parent || user_data)
-		return ERR_PTR(-EOPNOTSUPP);
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
-
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !nested_supported(iommu))
+	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
-
-	dirty_tracking = (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
-	if (dirty_tracking && !ssads_supported(iommu))
+	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	/*
-	 * domain_alloc_user op needs to fully initialize a domain
-	 * before return, so uses iommu_domain_alloc() here for
-	 * simple.
+	 * domain_alloc_user op needs to fully initialize a domain before
+	 * return, so uses iommu_domain_alloc() here for simple.
 	 */
 	domain = iommu_domain_alloc(dev->bus);
 	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
+
+	if (nested_parent)
+		to_dmar_domain(domain)->nested_parent = true;
 
-	if (!IS_ERR(domain) && dirty_tracking) {
+	if (dirty_tracking) {
 		if (to_dmar_domain(domain)->use_first_level) {
 			iommu_domain_free(domain);
 			return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6a97711f947a..ba9be915eb84 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -601,6 +601,7 @@ struct dmar_domain {
 					 * level.
 					 */
 	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
+	u8 nested_parent:1;		/* Has other domains nested on it */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index b560ab76e126..b5a5563ab32c 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -89,7 +89,8 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 	/* Must be nested domain */
 	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
 		return ERR_PTR(-EOPNOTSUPP);
-	if (parent->ops != intel_iommu_ops.default_domain_ops)
+	if (parent->ops != intel_iommu_ops.default_domain_ops ||
+	    !s2_domain->nested_parent)
 		return ERR_PTR(-EINVAL);
 
 	ret = iommu_copy_struct_from_user(&vtd, user_data,
-- 
2.34.1

