Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80815D5AF
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961001; cv=none; b=nIHkr+FNXMvz/okzbaBnm5w5Saavy9n+g825QxvbvFrE3J27mjRE24Ofhpa/SiAgCRKx8eUIR/3ytI5wEoIWgxFj2SPIBWdDhxjhe8S44DLQqBN9E71moyYhmTJCd1tFgWiFJVb3wfqR/PCPBicbqRlhjRimf8iDrG0lw4wI8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961001; c=relaxed/simple;
	bh=uZ18e0DpTIgHLOpzfBuHcXvVKSj+fUz+S5osI7EsSTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWreP5MXrZKjozNKZ9Kgx1ThOVY2nMi7uW51Jyk+2eFAbGNxNuyEKsRL/2Lf1rpamG7DeQsd05AoI2Npo2WiUo49AIiS3CbzP+diY7lwjxzizI4YL+GeW7SjKd+N/n8ml7EkN5SEbwJ+Qwzz+2jLQChfC/e64FxhpH+cWnSyXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etnxgRdC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etnxgRdC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716961000; x=1748497000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uZ18e0DpTIgHLOpzfBuHcXvVKSj+fUz+S5osI7EsSTY=;
  b=etnxgRdCdBAZ0rS5+wwT1VHoAjjM+K0fXh5g2P5c+MJvha3sDYCvXrSQ
   zXKVDyD7LowG3j9ND4v8+Y7e2ySrh3E+lIFj2yY9QcthVoUdm+UeV6MFM
   3QVpTQRQVY41+3h7IOnkCOPWWOixXla79nCb4A/1/DLpls41D7TxGxOhW
   0chuWSd4CctsGp+58VXtw95Za1d0J6wPhPM+8RVwm8MEWOxga2K1ZPel4
   5xVCVL72twkyAqB09HsTQ0dfGEMRMkFILfB6/OypMUAnK4ssf/KwCf8Pl
   lz6f5DqhUqpf92uJoFJnuumd7okLsmb+WJUz0wtdfVy2Ol7MQjWZej+EL
   A==;
X-CSE-ConnectionGUID: pSQuqTEvQMKljybCR1Tl5w==
X-CSE-MsgGUID: 4MRfb8rNRCGuepBeRhGOIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13569133"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13569133"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:36:37 -0700
X-CSE-ConnectionGUID: X+RiNsarRtKW3lpRtSJ0IA==
X-CSE-MsgGUID: nvefUVcKRTqj8DSSs+S92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257811"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:36:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 20/20] iommu/vt-d: Remove domain_update_iommu_superpage()
Date: Wed, 29 May 2024 13:32:50 +0800
Message-Id: <20240529053250.91284-21-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529053250.91284-1-baolu.lu@linux.intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requirement for consistent super page support across all the IOMMU
hardware in the system has been removed. In the past, if a new IOMMU
was hot-added and lacked consistent super page capability, the hot-add
process would be aborted. However, with the updated attachment semantics,
it is now permissible for the super page capability to vary among
different IOMMU hardware units.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 39 +------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 74e005b1c4b4..660d2b6c531b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -366,36 +366,6 @@ static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
 }
 
-static int domain_update_iommu_superpage(struct dmar_domain *domain,
-					 struct intel_iommu *skip)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	int mask = 0x3;
-
-	if (!intel_iommu_superpage)
-		return 0;
-
-	/* set iommu_superpage to the smallest common denominator */
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (iommu != skip) {
-			if (domain && domain->use_first_level) {
-				if (!cap_fl1gp_support(iommu->cap))
-					mask = 0x1;
-			} else {
-				mask &= cap_super_page_val(iommu->cap);
-			}
-
-			if (!mask)
-				break;
-		}
-	}
-	rcu_read_unlock();
-
-	return fls(mask);
-}
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -2845,8 +2815,8 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
-	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
+	int ret;
 
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
@@ -2858,13 +2828,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		return -ENXIO;
 	}
 
-	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
-	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
-		pr_warn("%s: Doesn't support large page.\n",
-			iommu->name);
-		return -ENXIO;
-	}
-
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
-- 
2.34.1

