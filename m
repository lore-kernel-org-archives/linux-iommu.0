Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB330F8A
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885344; x=1727421344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WOT6Nvcwlk/4tcNAsxhrAgOjJcTJ1AZiQvr9aESlkuA=;
  b=EumBOWjnhj/n85iJjlu31FjvqWTJr27hW/GyaTo96/GerkxeFbNh/GLg
   278RpxxTfAnum78u4ahi80TW4IUgWMyyQ1kHlS6YECrXZScSY7wiJR0+k
   NW9Wh2fopl3fyfdeBfmZMywaqgiIqLCmq6i1raNuerGz6aCxBaN9H75t4
   trEbjN1/MmO/aEYSeKiVZabpEZNL/PU8WycmUrWt50pOrCs3Po8BPTT+F
   LhjcBsGRJgjNFXiXJ6gYEGtDWrGX5Isnx49/ur2o1uwZxzaD0S+dAxVKH
   NQxZXa59ZRfCdzCEQhQ0iIxtoxHAGKIo/gRU7FtDqPkrrME7pxIBryzra
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914897"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784602111"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784602111"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:41 -0700
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
Subject: [PATCH v2 6/6] iommu/vt-d: Add domain_alloc_user op
Date: Thu, 28 Sep 2023 00:15:28 -0700
Message-Id: <20230928071528.26258-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
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
 drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5db283c17e0d..017aed5813d8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4074,6 +4074,33 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	return NULL;
 }
 
+static struct iommu_domain *
+intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
+{
+	struct iommu_domain *domain;
+	struct intel_iommu *iommu;
+
+	if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	iommu = device_to_iommu(dev, NULL, NULL);
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
+	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/*
+	 * domain_alloc_user op needs to fully initialize a domain
+	 * before return, so uses iommu_domain_alloc() here for
+	 * simple.
+	 */
+	domain = iommu_domain_alloc(dev->bus);
+	if (!domain)
+		domain = ERR_PTR(-ENOMEM);
+	return domain;
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain != &si_domain->domain && domain != &blocking_domain)
@@ -4807,6 +4834,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
-- 
2.34.1

