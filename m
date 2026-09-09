Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F474A5C4C
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941003; cv=none; b=mNyMcagncBkEZfVYtl8h11OCfFT7+VMXCty6BI/xBtBPqYbAu5738gTl7ylqZjw/0yFuKrbOYS0XepIyfpr61T8fR9uMtopvgMbjZ/83WffNjtabYEZXHjnQIarBFIG/R0Vw0xXQdSDZ4Qo3k6dADgrLCz88x8HBTeB/GMLt5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941003; c=relaxed/simple;
	bh=+NXG1XAjpq4yG7WqYbUQl5yoKq/wUrSu7mGaGBuE/GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH6/aZNGRbSkync6gWMcFlr5a8dqFZdyA+r6J+TdmkFUfMRejxafGSyEs1lYxgp26eoAbcH4KDJBYXbBzX+NsivzQ/IDA9YwwUsVgArEzTdrPf32zLbtn+Jn7VbFCLJ89j2HNIL/u33a+LD9tFfa0tpCQiQmgBVv13R+9rRYbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQXo2SOH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQXo2SOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788941003; x=1820477003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+NXG1XAjpq4yG7WqYbUQl5yoKq/wUrSu7mGaGBuE/GA=;
  b=HQXo2SOHMVRjUDyAxDOXw8C+69XF+rF8T+Huhni22oKNe0aciU2bvjzQ
   P2KsJu28kEDAcpjUiXvLnesNgdwaU2V/LnEWwjM4O8caZgo76FCA7SRpx
   SUc3DfSR79IqtOX2W3lzjh5M7isu6mWrc+ku/AFTdR/XH5hLGJacerUj2
   S3+A7h0552M023+TvFDoErlCruOruZM46z5dKIv+ohLanCMG/fi0lw0pq
   N7QB3Y1WhixK/i79jK5+ft6O21A5uIdQ6eps8TECUXXKEuKYKWOIf34KQ
   QInuAWVgZVd/TPRvi8aHK+8INXPgsWwtTkekB9UbiBF5YbSNgzZGlmxMu
   Q==;
X-CSE-ConnectionGUID: 69c1pCtZSqqiKn8UNklsMw==
X-CSE-MsgGUID: wJJOvIeJQL2mdUInJIX/hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726518"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726518"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:03:22 -0700
X-CSE-ConnectionGUID: ZXahswviQMei9snYBrN//Q==
X-CSE-MsgGUID: T45f6IYST1ywDMHajkBlLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301119289"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:03:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 6/7] iommu/vt-d: Fix iopf refcount leak in nested attach
Date: Wed,  9 Sep 2026 15:51:05 +0800
Message-ID: <20260909075106.738691-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909075106.738691-1-baolu.lu@linux.intel.com>
References: <20260909075106.738691-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_nested_attach_dev() takes an iopf reference for the new domain but
does not drop the possible reference from the old domain. This leaks
info->iopf_refcount, can keep the device permanently on the iopf queue,
and later triggers WARN_ON(info->iopf_refcount) when PRI is disabled.

Fix this by dropping the possible reference from the old domain after
the nested translation setup completes.

Fixes: 17fce9d2336d9 ("iommu/vt-d: Put iopf enablement in domain attach path")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..f84fc8b41fde 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -59,6 +59,8 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	if (ret)
 		goto disable_iopf;
 
+	iopf_for_domain_remove(old, dev);
+
 	info->domain = dmar_domain;
 	info->domain_attached = true;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
-- 
2.43.0

