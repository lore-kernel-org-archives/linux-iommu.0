Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB63D3AD
	for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115562; x=1726651562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3riUZjJN8lKSKgwdYFNtz+cVKj5BdWi3nncFILY6lA=;
  b=kyNglj/G5gZyHThU+OnCoN28XZ75I8zvia/m1liHQOSfe3TOAS3Tcih3
   iQ1EpcQ+xKs5FxwrR9Y+KMiDIQ0E5vj27OHtMjrA4Cj4pVbVhYrojdbja
   flVailkWjvTM50K8hR64wcxgoz7vN+esEAaG0aNON0m/7e/B9wSby5HnW
   2XIpYCSa7xZNCbWASVvgPm9uL2y8vBWEc7cWiyMlpuAFrvKcktHzzcDg4
   cOsK5sin2miQjPqeNJjTW40IEOVGmDMNycSlKAK3SzCwTCHiItDSD5/le
   WkP9n7MiruD+bf1xWxFYbi+U3lBl8yp0pdQDqMvTt1r5DY2bHhb5W4odQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368966"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368966"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804776"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804776"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:36 -0700
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
Subject: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Date: Tue, 19 Sep 2023 02:25:23 -0700
Message-Id: <20230919092523.39286-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919092523.39286-1-yi.l.liu@intel.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the domain_alloc_user op implementation. It supports allocating
domains to be used as parent under nested translation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5db283c17e0d..491bcde1ff96 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4074,6 +4074,25 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	return NULL;
 }
 
+static struct iommu_domain *
+intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
+{
+	struct iommu_domain *domain;
+	struct intel_iommu *iommu;
+
+	iommu = device_to_iommu(dev, NULL, NULL);
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
+	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = iommu_domain_alloc(dev->bus);
+	if (!domain)
+		domain = ERR_PTR(-ENOMEM);
+	return domain;
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain != &si_domain->domain && domain != &blocking_domain)
@@ -4807,6 +4826,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
-- 
2.34.1

