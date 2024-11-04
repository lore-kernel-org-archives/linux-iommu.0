Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1F17BD9
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726328; cv=none; b=ldMcLuS4/HC+dO8PVtSq1gurT6M3Tzym1B2OGgrGrX25b3vDBWDPunCEgj/D2in4COQJtZZz4IllqGS3pIqCEbk1F0I6HOjzBc/teGCgC7fP9bnWWRIWt5xcJP7olD1UGhtODkMJsQqW9TkQEsrXvMNjM1pD6NoMnn3QFBFcljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726328; c=relaxed/simple;
	bh=ex4Om9fad/v+LS38u5dL5eAurC92Q3cu+eJ3PQ8HqY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj+HHdByyCmPqEuDq1nxaXjy+xK6XHhFJrwR6yCWB2yd8sJ0UanBaLNP3eixlgsQAwz8BA4VvH1eKHIwsXgH7DKcNkPKC1Di7caBki2TAYWDZfAXzkT/y6jigrRR//Mfp6pGzPvyqLKScGgXfopBVJAOAZ0FZrIKttpqlYSoqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvTpw0qS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvTpw0qS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726327; x=1762262327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ex4Om9fad/v+LS38u5dL5eAurC92Q3cu+eJ3PQ8HqY4=;
  b=gvTpw0qSQFM/uIbR/np5AlrRAHEUxPRJ1We2bJlgmuXRM5/JIYfJV+07
   C+0dWpzLsWrDooVVyjR4XbR+7Kgc/5PGo6H3nzvTNei/Hu1VJNBRbog7p
   GW7gBcva0qE/RQOY8Uarj1C+wcxuI6Shik9D4AF8OMy+6T0AfmgWwTlN8
   ntsmJqDAT3NyVKmJkmuqfRZ4gza4CA/qFcRmZkLCN/0Rq8wbatSgaumPw
   cFZrf6F3TcrJ5zZYPhMZuB1GQMbje6Tkctn+1VAI6vqfFymEA+WDXBjUb
   ctgB/AbWrhTyWJI9jjhBUiM/d0bDtFUfT2x8d4xKGe9JiX1LoQ3tmXow0
   A==;
X-CSE-ConnectionGUID: prMZXQGfSTmFsQp5RRbVlg==
X-CSE-MsgGUID: Dax/i+YmTQOf+yWOYWRN2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41003709"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="41003709"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:18:46 -0800
X-CSE-ConnectionGUID: +MNcs6OHSjqJdRBlNyuRDA==
X-CSE-MsgGUID: 3lnhEF8BQQmjSZpATbRN6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83999470"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 04 Nov 2024 05:18:45 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v4 02/13] iommu/vt-d: Add a helper to flush cache for updating present pasid entry
Date: Mon,  4 Nov 2024 05:18:31 -0800
Message-Id: <20241104131842.13303-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104131842.13303-1-yi.l.liu@intel.com>
References: <20241104131842.13303-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are more paths that need to flush cache for present pasid entry
after adding pasid replacement. Hence, add a helper for it. Per the
VT-d spec, the changes to the fields other than SSADE and P bit can
share the same code. So intel_pasid_setup_page_snoop_control() is the
first user of this helper.

No functional change is intended.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/pasid.c | 54 ++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 977c4ac00c4c..81d038222414 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -286,6 +286,41 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 	}
 }
 
+/*
+ * This function is supposed to be used after caller updates the fields
+ * except for the SSADE and P bit of a pasid table entry. It does the
+ * below:
+ * - Flush cacheline if needed
+ * - Flush the caches per the guidance of VT-d spec 5.0 Table 28.
+ *   ”Guidance to Software for Invalidations“
+ *
+ * Caller of it should not modify the in-use pasid table entries.
+ */
+static void intel_pasid_flush_present(struct intel_iommu *iommu,
+				      struct device *dev,
+				      u32 pasid, u16 did,
+				      struct pasid_entry *pte)
+{
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	/*
+	 * VT-d spec 5.0 table28 states guides for cache invalidation:
+	 *
+	 * - PASID-selective-within-Domain PASID-cache invalidation
+	 * - PASID-selective PASID-based IOTLB invalidation
+	 * - If (pasid is RID_PASID)
+	 *    - Global Device-TLB invalidation to affected functions
+	 *   Else
+	 *    - PASID-based Device-TLB invalidation (with S=1 and
+	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
+	 */
+	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+}
+
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -551,24 +586,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	did = pasid_get_domain_id(pte);
 	spin_unlock(&iommu->lock);
 
-	if (!ecap_coherent(iommu->ecap))
-		clflush_cache_range(pte, sizeof(*pte));
-
-	/*
-	 * VT-d spec 3.4 table23 states guides for cache invalidation:
-	 *
-	 * - PASID-selective-within-Domain PASID-cache invalidation
-	 * - PASID-selective PASID-based IOTLB invalidation
-	 * - If (pasid is RID_PASID)
-	 *    - Global Device-TLB invalidation to affected functions
-	 *   Else
-	 *    - PASID-based Device-TLB invalidation (with S=1 and
-	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
-	 */
-	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
-	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
-
-	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	intel_pasid_flush_present(iommu, dev, pasid, did, pte);
 }
 
 /**
-- 
2.34.1

