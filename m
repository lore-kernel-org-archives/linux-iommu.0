Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD11E2603
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500985; cv=none; b=W2TqovG/Yoq+t6vwXC/7bUnNHmQcqaMQVNDX73wQO1HjsRa8YSNQk7lFTriHFDpc5SCyPU9wXGwtC0nBJRPeK7yAmR2XmWzg9UyIX7u6bUWrL+PGR7z0MMDdL0/6d/okwHZUKDPrJrj99pVIySdgbtZGVKbzxXt7+I5clAiXLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500985; c=relaxed/simple;
	bh=Rpe2Bmi9GBIWmSjY0Uca0kWikIc6QccAZcI5FDF+nls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFQcfSqZh7F/IGjV4XMJvjrtnU062F3x5eyZofB0eqUiXKSa/xtid8UASNEnJvQxLcQ/Oh7uOpq74ermbBPUv2cC9YcbwzjpCqp4AkCTbDIh49qVfVvKVCZmNhWd30k/KlnhHEjybuYuzdo9Vm2YcW/YWjYLQbwFTYakIwljqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qnyoc3SF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qnyoc3SF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500984; x=1761036984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rpe2Bmi9GBIWmSjY0Uca0kWikIc6QccAZcI5FDF+nls=;
  b=Qnyoc3SFtx1CJQP7aVdtdOTI4V4vVhgFGuKZD1C9fhUjqEKS5bPhCl7a
   g5YZeBbvN9s4oBPZl28GQhczb/RoWPuVWkCaocPTrLjjEEyPgKv6RRxK/
   41QhwldOnrhN6CeLcvNjuPocLzlNAFr0eU2RTWiiyLSR1GHfLoadzUHJf
   lkdCwHHVbDamZtnWsJnefypYGS8nmwChEeiwgunC+YNsaHhEdArbeYEFm
   AkR/n6a8IbRc2CJYHMAiHp99iPthLAWTCse1nFXx7ihHTmR2LOJzBGM6D
   Rf2CF6YvK8/kYp+u/pQex+FmoZlc4l3byOG4oV0Nlnhl/EG/A6YZjCfUK
   A==;
X-CSE-ConnectionGUID: IKT0K5TDS1ylfiCOXf/bUQ==
X-CSE-MsgGUID: MhkDh+axRsy8PvdmHJrF6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32780320"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32780320"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:56:24 -0700
X-CSE-ConnectionGUID: U55vAQldT4m5jUcRESMe8A==
X-CSE-MsgGUID: R3A7XOy1SKKyFW/wYJ6iWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79812712"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:56:21 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/7] iommu/vt-d: Add domain_alloc_paging support
Date: Mon, 21 Oct 2024 16:51:18 +0800
Message-ID: <20241021085125.192333-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021085125.192333-1-baolu.lu@linux.intel.com>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the domain_alloc_paging callback for domain allocation using the
iommu_paging_domain_alloc() interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..4803e0cb8279 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4590,6 +4590,19 @@ static struct iommu_domain identity_domain = {
 	},
 };
 
+static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
+{
+	struct dmar_domain *dmar_domain;
+	bool first_stage;
+
+	first_stage = first_level_by_default(0);
+	dmar_domain = paging_domain_alloc(dev, first_stage);
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+
+	return &dmar_domain->domain;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
@@ -4599,6 +4612,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
+	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
 	.probe_device		= intel_iommu_probe_device,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-- 
2.43.0

