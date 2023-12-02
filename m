Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28C14F65
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcM+2NIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510863; x=1733046863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CgOHdWHDwhSGt7y0GRo0NgHb+w74ehYb80zPfydmvj4=;
  b=BcM+2NIqPw8G7eJ4Y/UpOvpgeZU4nYo4nIHg1gRiHO/Fr4Mb28uo2owT
   tpxBk9JRcAe4fojvnqSRN9nTZV/XMsxpkPmLl3wX1MmzPwlHh8Dl3NZYY
   vfPbdVjueU74fwjBIV4hioxVVUQ3fdPl0ddSi/83PBrPnJwxFbiwkAsLZ
   4V8A2XdED0cnX1y4q1DZeYZvhK84GTgHSdlZJaP4N/2lg0EBkXiPCyRJk
   3hVPpJ7RrxOu/UJINaMvmGgFVg0MukTR1jizc/JG71/1xALWuHYXrsyuL
   EZEC7BHJDQz7IN/Z95KzXofB6TqNKyGiaZmzLFdQqqSLIJFtjC59LI4FG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="424756076"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="424756076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="836021580"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="836021580"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:54:19 -0800
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
Subject: [RFC PATCH 20/42] iommu/vt-d: Support attach devices to IOMMU_DOMAIN_KVM domain
Date: Sat,  2 Dec 2023 17:25:24 +0800
Message-Id: <20231202092524.14647-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

IOMMU_DOMAIN_KVM domain reuses intel_iommu_attach_device() for device
attachment. But unlike attaching to other dmar_domain, domain caps (e.g.
iommu_superpage) are not updated after device attach. Instead, IOMMU caps
are checked for compatibility before domain attachment.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/intel/iommu.c | 11 +++++++++++
 drivers/iommu/intel/iommu.h |  7 +++++++
 drivers/iommu/intel/kvm.c   |  9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index fcdee40f30ed1..9cc42b3d24f65 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -552,6 +552,13 @@ static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 /* Some capabilities may be different across iommus */
 void domain_update_iommu_cap(struct dmar_domain *domain)
 {
+	/*
+	 * No need to adjust iommu cap of kvm domain.
+	 * Instead, iommu will be checked in pre-attach phase.
+	 */
+	if (domain_type_is_kvm(domain))
+		return;
+
 	domain_update_iommu_coherency(domain);
 	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
 
@@ -4104,6 +4111,9 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if (domain_type_is_kvm(dmar_domain))
+		return prepare_kvm_domain_attach(dmar_domain, iommu);
+
 	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
 		return -EINVAL;
 
@@ -4117,6 +4127,7 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 
 	if (dmar_domain->max_addr > (1LL << addr_width))
 		return -EINVAL;
+
 	dmar_domain->gaw = addr_width;
 
 	/*
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8826e9248f6ed..801700bc7d820 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1059,6 +1059,13 @@ static inline int width_to_agaw(int width)
 #ifdef CONFIG_INTEL_IOMMU_KVM
 struct iommu_domain *
 intel_iommu_domain_alloc_kvm(struct device *dev, u32 flags, const void *data);
+int prepare_kvm_domain_attach(struct dmar_domain *domain, struct intel_iommu *iommu);
+#else
+static inline int prepare_kvm_domain_attach(struct dmar_domain *domain,
+					    struct intel_iommu *iommu)
+{
+	return 0;
+}
 #endif
 
 #endif
diff --git a/drivers/iommu/intel/kvm.c b/drivers/iommu/intel/kvm.c
index 188ec90083051..1ce334785430b 100644
--- a/drivers/iommu/intel/kvm.c
+++ b/drivers/iommu/intel/kvm.c
@@ -32,6 +32,14 @@ static bool is_iommu_cap_compatible_to_kvm_domain(struct dmar_domain *domain,
 	return true;
 }
 
+int prepare_kvm_domain_attach(struct dmar_domain *domain, struct intel_iommu *iommu)
+{
+	if (is_iommu_cap_compatible_to_kvm_domain(domain, iommu))
+		return 0;
+
+	return -EINVAL;
+}
+
 /*
  * Cache coherency is always enforced in KVM domain.
  * IOMMU hardware caps will be checked to allow the cache coherency before
@@ -43,6 +51,7 @@ static bool kvm_domain_enforce_cache_coherency(struct iommu_domain *domain)
 }
 
 static const struct iommu_domain_ops intel_kvm_domain_ops = {
+	.attach_dev		= intel_iommu_attach_device,
 	.free			= intel_iommu_domain_free,
 	.enforce_cache_coherency = kvm_domain_enforce_cache_coherency,
 };
-- 
2.17.1

