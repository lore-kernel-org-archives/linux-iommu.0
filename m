Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E732C90
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347475; cv=none; b=a46P8OAFLd4mycg6Z3GyatTC0hwZN0q7HMIfytvo5aworU3Y3IdnibFejG1p4h0KWZMDcczeUTijq65hQMMHI742AIEtnMA2vbi16suhDjgPWAMgv2tEvKT2k5gsinhiUktkex6/2idr0+kho2s9QYKOlXrhpK8PrrFYWHJdKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347475; c=relaxed/simple;
	bh=qPwmVrLdfvdc+YP3bkpEF6vaxHDaKxr2NDl6t+a+k4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lt81ux0GXeMbWgUpnG8yiTAlxwSYJvFL2wPUwLL77EJ7SYfXH9C0sTGqAmV083EYg7PNs6u9pM6T8o1qI3yV4VTL9Mv/ftGMCnReYULYZjqVNxowJQUjmxsaDiCwaIKENCNXePh7hqh6nN8YeasKU9X8iz1gbZknkB1Jw7/icQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAyNmK0n; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAyNmK0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347474; x=1739883474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPwmVrLdfvdc+YP3bkpEF6vaxHDaKxr2NDl6t+a+k4Q=;
  b=EAyNmK0nIxQgPY9H2Gysi9uMMIMbJk8a+xgk4b/8SRMMssfIjeGiG1Qo
   yEnXJ+OIWFqGUcjaWJUCcHKa6MNaYfU9yuaUhnMmtCJiiUZQIjgWYkahm
   w04RNl7FQORuFtRNmVm7NzoTOncJSSembV8teIr/u9iwq/0/gKEkqMbJN
   ofv3ZhtY9Ne0yY+pQFwwljy6DtZkQyZwiFqvRlTBq5qXf9bRae2jkKq8B
   uM5Y6sjEo+yc20ZgkWKTIRFznOhBWAO8hrQHEl2IiYpRxjkgW4yptf+/g
   Tm16c3HccbrB0z6RGhXmF0IFVhlemF3cnrWNafL9ZrRSg1rn6dzfebUwX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296458"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296458"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449297"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:51 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 08/13] iommu/vt-d: Add domain_type_is_sva helper function
Date: Mon, 19 Feb 2024 20:57:18 +0800
Message-Id: <20240219125723.1645703-9-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper function to tell if the type of a dmar_domain is sva
or not. In general, comparing with normal iommu_domain, a sva domain
shouldn't be special other than having a different source for the page
table. Thus, this helper function should be used as little as possible
(i.e. only in the cases related to handling page table source).

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b7e1f0be880b..07ca7cfd86c0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -245,6 +245,11 @@ static int domain_type_is_si(struct dmar_domain *domain)
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
+static inline bool domain_type_is_sva(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_SVA;
+}
+
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -4560,7 +4565,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	 * notification. Before consolidating that code into iommu core, let
 	 * the intel sva code handle it.
 	 */
-	if (domain->type == IOMMU_DOMAIN_SVA) {
+	if (domain_type_is_sva(dmar_domain)) {
 		intel_svm_remove_dev_pasid(dev, pasid);
 		goto out_tear_down;
 	}
-- 
2.34.1

