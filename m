Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD714F65
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmSY8Hq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510930; x=1733046930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BZYTTtyQtvoxZgxXT0A+sCWE4cIHFzWJmMiUL2ynGlI=;
  b=fmSY8Hq2i8q9xrxydoL4xerbN+mKvspYeLQiJ3aWyKVmZPA7B9e8SqhN
   c9DftQZZX2TikIjmfYNT8ThjRIhrzpw6vzjXHmp6wZPoOCZquPOV6Jz0p
   8aJMMDg5vUIS4Yswf75+mqgwWI5BVWR4Ragm2hPU0SkzBmLL7VlY65D23
   KGBPxf0X/XUjkMVSsHWv6mKiB559BXK74yLJZguTZGv6lBetiSIXCOGG9
   GI7F5xLPeAhtNQ4DF08QXUCoUMun6pR8COFCqXAGeZjr3Qy9gOHvM8dTO
   XvMsVzqYjUJuW20V/5q2Qq030TLSWxaak21M21kISyAg2ZwVWth4bTZ1B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="393322193"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="393322193"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="804337094"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="804337094"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:55:24 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com,
	jgg@nvidia.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	yi.l.liu@intel.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 22/42] iommu/vt-d: Support cache invalidate of IOMMU_DOMAIN_KVM domain
Date: Sat,  2 Dec 2023 17:26:30 +0800
Message-Id: <20231202092630.14764-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Support invalidation of hardware TLBs on KVM invalidates mappings on
domain of type IOMMU_DOMAIN_KVM.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/intel/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/intel/kvm.c b/drivers/iommu/intel/kvm.c
index 998d6daaf7ea1..56cb8f9bf1da0 100644
--- a/drivers/iommu/intel/kvm.c
+++ b/drivers/iommu/intel/kvm.c
@@ -62,10 +62,41 @@ static bool kvm_domain_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+static void domain_flush_iotlb_psi(struct dmar_domain *domain,
+				   unsigned long iova, unsigned long size)
+{
+	struct iommu_domain_info *info;
+	unsigned long i;
+
+	if (!IS_ALIGNED(size, VTD_PAGE_SIZE) ||
+	    !IS_ALIGNED(iova, VTD_PAGE_SIZE)) {
+		pr_err("Invalid KVM domain invalidation: iova=0x%lx, size=0x%lx\n",
+		       iova, size);
+		return;
+	}
+
+	xa_for_each(&domain->iommu_array, i, info)
+		iommu_flush_iotlb_psi(info->iommu, domain,
+				      iova >> VTD_PAGE_SHIFT,
+				      size >> VTD_PAGE_SHIFT, 1, 0);
+}
+
+static void kvm_domain_cache_invalidate(struct iommu_domain *domain,
+					unsigned long iova, unsigned long size)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (iova == 0 && size == -1UL)
+		intel_flush_iotlb_all(domain);
+	else
+		domain_flush_iotlb_psi(dmar_domain, iova, size);
+}
+
 static const struct iommu_domain_ops intel_kvm_domain_ops = {
 	.attach_dev		= intel_iommu_attach_device,
 	.free			= intel_iommu_domain_free,
 	.enforce_cache_coherency = kvm_domain_enforce_cache_coherency,
+	.cache_invalidate_kvm	= kvm_domain_cache_invalidate,
 };
 
 struct iommu_domain *
-- 
2.17.1

