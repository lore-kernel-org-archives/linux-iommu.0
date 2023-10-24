Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A814ABF
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcAWy/V4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698161158; x=1729697158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bknCuaXgjYm3S8328FfTMjKxCUCRzktFyfoYpNNj9c=;
  b=UcAWy/V4nDBy8S/33Z6NYs09kSiLdAECr8rptNmgfnDa1STpq8jpiZU4
   UOsLTpJHJyAlJtygeTi/rsrcuCbwbsnuCSy8JWnlbXQMOlJoYu0y8rPFM
   h8QJAkiCCxciaYNliqP480Y32ClOkOJmcz+lPr1gk8zzsJ1SHCIyo23LW
   zZTYc88KvD5H0f0CqcjO0H1rMs0nJOU2k+1gkqu4GnexzhazF14pruEsI
   DBg4G0BKoAaFt8Rm1VpXAA6OwjRqRgPJGKv/sCqbC6TxhlN2QGE1+fFRf
   xRUP6ezI5t2M7h6maG1VB2pq4NDWZC1WeECgkWA3hhcXe2p4rheBs5Cqg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418212211"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418212211"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005688928"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="1005688928"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2023 08:14:17 -0700
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
Subject: [PATCH v7 7/8] iommu/vt-d: Add nested domain allocation
Date: Tue, 24 Oct 2023 08:14:11 -0700
Message-Id: <20231024151412.50046-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024151412.50046-1-yi.l.liu@intel.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
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
---
 drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++------------
 drivers/iommu/intel/iommu.h |  1 +
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 292baa64188b..85366862fb5e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4077,46 +4077,69 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data)
 {
-	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	bool dirty_tracking;
+	bool nested_parent;
 
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (parent || user_data)
-		return ERR_PTR(-EOPNOTSUPP);
-
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !nested_supported(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
-
+	nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 	dirty_tracking = (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
-	if (dirty_tracking && !ssads_supported(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
 
-	/*
-	 * domain_alloc_user op needs to fully initialize a domain
-	 * before return, so uses iommu_domain_alloc() here for
-	 * simple.
-	 */
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
+	if (!user_data) { /* Must be PAGING domain */
+		struct iommu_domain *domain;
 
-	if (!IS_ERR(domain) && dirty_tracking) {
-		if (to_dmar_domain(domain)->use_first_level) {
-			iommu_domain_free(domain);
+		if (nested_parent && !nested_supported(iommu))
 			return ERR_PTR(-EOPNOTSUPP);
+		if (dirty_tracking && !ssads_supported(iommu))
+			return ERR_PTR(-EOPNOTSUPP);
+		if (parent)
+			return ERR_PTR(-EINVAL);
+
+		/*
+		 * domain_alloc_user op needs to fully initialize a domain
+		 * before return, so uses iommu_domain_alloc() here for
+		 * simple.
+		 */
+		domain = iommu_domain_alloc(dev->bus);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+
+		if (nested_parent)
+			to_dmar_domain(domain)->nested_parent = true;
+
+		if (dirty_tracking) {
+			if (to_dmar_domain(domain)->use_first_level) {
+				iommu_domain_free(domain);
+				return ERR_PTR(-EOPNOTSUPP);
+			}
+			domain->dirty_ops = &intel_dirty_ops;
 		}
-		domain->dirty_ops = &intel_dirty_ops;
+
+		return domain;
 	}
 
-	return domain;
+	/* Must be nested domain */
+	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!nested_supported(iommu))
+		return ERR_PTR(-EOPNOTSUPP);
+	if (!parent || parent->ops != intel_iommu_ops.default_domain_ops)
+		return ERR_PTR(-EINVAL);
+	if (!to_dmar_domain(parent)->nested_parent)
+		return ERR_PTR(-EINVAL);
+	if (nested_parent)
+		return ERR_PTR(-EINVAL);
+	if (dirty_tracking)
+		return ERR_PTR(-EINVAL);
+
+	return intel_nested_domain_alloc(parent, user_data);
 }
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d5aaaedf2094..65e660eb1f47 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -601,6 +601,7 @@ struct dmar_domain {
 					 * level.
 					 */
 	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
+	u8 nested_parent:1;		/* Has other domains nested on it */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
-- 
2.34.1

