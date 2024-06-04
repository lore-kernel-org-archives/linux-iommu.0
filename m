Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114041419BC
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466106; cv=none; b=rjh3nVf4t4lcMB3172ELGNJm9RjuwFPvAwTnt/nTT0CCgFbbsw40OJt9UmLd9vmVMCXWA7cMIivxHoMyKfu1QAqTslQtrh5vC7JIDw0qrgMNcyX84vCUZQrJwrO1Z778SN2n2x/xNM+g3k+PjzstpFvBKVDwtasXxW6aC4cpS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466106; c=relaxed/simple;
	bh=sM71nWFg3cNfoT7YtYLr4iW7aTMKAR3F9pN2mUDECnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuYOGswq4HHTJCZaYFohW2n8lSNmj0BzeRTZJFMysFlnQcFY/KYj1p6MLLIgyFEtyim+Yjy0DXYa/ix69YgzdJhpa55NsacObT9wXrr13z44/65E8s9K9vgle6LWe+q9jQnuXlVSwYdxku0R4/P+iqpAtoAdd6SI+KbxPqYkUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDUzqcIQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDUzqcIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466105; x=1749002105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sM71nWFg3cNfoT7YtYLr4iW7aTMKAR3F9pN2mUDECnk=;
  b=ZDUzqcIQBbDNSST6JwZUsLzcU9juCPB4/pYyMT9S5NULFPPHwcm8G58g
   YjEhHyMJ8JvyAeg5jTYHN9YeShuatM6zMrY+w3cRyjJoZLTbmDsnBOmqD
   DSx63CSPVGtmeSGX3vXlR3FfUZ3qWjVp3SeBjM0XnDcIHM+bTE0mjtk13
   HSILhsRAkQo670FKXN/ETXqe7MMMus9D7iaxcy45A0z5ksS1WmuxxAmUy
   3o7L3DgYxn9HiTvAp5awy4KeSyeS4FIY2/l6IstHr/qrNHeHzwoy1/HAP
   XYY2Q/6DV+LcIoXok9FCRT7XN0NyJ1GCdr+91oUvdzCOD4s0dfjc/0UN3
   Q==;
X-CSE-ConnectionGUID: c0S3YzpORWWjtE3cv0/sSA==
X-CSE-MsgGUID: wIi1ghRATpOJSNB/fTv0zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385080"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385080"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:55:04 -0700
X-CSE-ConnectionGUID: LPeuwZRTQwS7l9EikmKgHA==
X-CSE-MsgGUID: FcmlMLbDT6S4m+oC2yOaQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661974"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:55:00 -0700
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
Subject: [PATCH v2 14/22] soc/fsl/qbman: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:26 +0800
Message-Id: <20240604015134.164206-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommu domain is allocated in portal_set_cpu() and is attached to
pcfg->dev in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e23b60618c1a..456ef5d5c199 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -48,9 +48,10 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
 	struct device *dev = pcfg->dev;
 	int ret;
 
-	pcfg->iommu_domain = iommu_domain_alloc(&platform_bus_type);
-	if (!pcfg->iommu_domain) {
+	pcfg->iommu_domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(pcfg->iommu_domain)) {
 		dev_err(dev, "%s(): iommu_domain_alloc() failed", __func__);
+		pcfg->iommu_domain = NULL;
 		goto no_iommu;
 	}
 	ret = fsl_pamu_configure_l1_stash(pcfg->iommu_domain, cpu);
-- 
2.34.1

