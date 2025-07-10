Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37E26A1DD
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154958; cv=none; b=rjFWajtumG06IX6p53aTrBq+sK7/wvR0daNueJwA439oAxaqIQmzkmGogxS02IOKbg0m8Xy499w/D4on36hl1D70mpfPKvhpWlpp7tehDzBLEIbMj4ZWqtGAFYadeNMPpq0s28BNhcz73aSqB0JHIXHSSQt5FtrWjjUPXmeFZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154958; c=relaxed/simple;
	bh=VQ8Am7+heAcHjPU5GdN2mMOsTJHb5LEzXq0oE4vZtJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BG34e2wWNJtGceEpt5BX7i+XlrLolSPus/EGmgQ8Nx2RXWG0gHzIYhQfdMyW+QWIIa9qzsxvRsxFS23PunlEn8H4XhdndHuhjthq4loukjsiQQZ0oiR9Bm0d5JilvKXoUe8NK/EiUC1Di8UmiqfJj8RY0Dia/aDpA+gvRQws/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9L7fsBW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9L7fsBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154957; x=1783690957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VQ8Am7+heAcHjPU5GdN2mMOsTJHb5LEzXq0oE4vZtJw=;
  b=W9L7fsBWjpT7Jq4A+GvdK4cVnHEPNo8b4oXpH/hSRVrfXZ3S1cJNEIlx
   DM1JEojgCX3buJyZxUZlnaah37bobdjY4nf8qpZNXrqBUPxL+FWCatjNM
   ZFEHhQzoUWnymjp5VQlJdsRaOHFUXcpQ6+Dn7ZTYZCvEDZJqNq55QS9Yn
   HBPRZD6/sHDNEv47ppqePGgfrXZuJmzNvRG3NP33o8rZLMh9g8wWO6Rct
   Rw1GwfpVAtUm+Yy77ST7Kif+A5vzszcritQDn8rxA4rNcmy2YAhhCBzyb
   NuOYtFG9u3W6YGq5ARxYIaU/yIKokqrvBPKrEtT5MhvzR3hKNku9UoPJb
   w==;
X-CSE-ConnectionGUID: 54nILBiqR3Gwij1C+2xgIA==
X-CSE-MsgGUID: Uknf4/rMRG2DWC6tjoD+gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65787674"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65787674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:42:36 -0700
X-CSE-ConnectionGUID: KfYVX4zpR7iGNkvrlQS/xw==
X-CSE-MsgGUID: 3SQMCOxoSXuNnWiqWGqflA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156809432"
Received: from gnrd8.igk.intel.com ([10.123.232.137])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 06:42:34 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] iommu: Pass the Requester ID in the fault parameter structure
Date: Thu, 10 Jul 2025 13:42:12 +0000
Message-ID: <20250710134215.97840-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the Requester ID in the fault parameter structure to facilitate
requester notifications on IOMMU faults.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/intel/prq.c | 1 +
 include/linux/iommu.h     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 52570e42a14c..d88385adc3cb 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -181,6 +181,7 @@ static void intel_prq_report(struct intel_iommu *iommu, struct device *dev,
 	/* Fill in event data for device specific processing */
 	event.fault.type = IOMMU_FAULT_PAGE_REQ;
 	event.fault.prm.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
+	event.fault.prm.rid = desc->rid;
 	event.fault.prm.pasid = desc->pasid;
 	event.fault.prm.grpid = desc->prg_index;
 	event.fault.prm.perm = prq_to_iommu_prot(desc);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 156732807994..4ddb63a3f2cf 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -65,6 +65,7 @@ enum iommu_fault_type {
  *         When IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID is set, the page response
  *         must have the same PASID value as the page request. When it is clear,
  *         the page response should not have a PASID.
+ * @rid: Requester ID
  * @pasid: Process Address Space ID
  * @grpid: Page Request Group Index
  * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
@@ -76,6 +77,7 @@ struct iommu_fault_page_request {
 #define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
 #define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 2)
 	u32	flags;
+	u32	rid;
 	u32	pasid;
 	u32	grpid;
 	u32	perm;
-- 
2.43.0

