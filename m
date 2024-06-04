Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86521411D9
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466101; cv=none; b=OX4F15ifZTOND5rUZL/CiFr/cgmqHG2gNwto+kMV/8kbpupv1ehZRkWxN6IERf1i4WIqhAiLaIWzm1RECmGcZ7FfdgGxInl925GZxwfF3OJuHIYAiZ393z66PAn0w7eC+V+x0Ux7B0+bgXHaDOdq6Irgt8Vy6VjbZmIW07hwWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466101; c=relaxed/simple;
	bh=kDJcZN33ntEvZZurzXrpsoEVgCNzk8vicnqImPO/kUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZ+SdhRYcX5cV11I1T9zXXK/6lPleF9F0VdkOz5Wx5SmswCWAZ0wgmpbHPItz0iAvhzwNNWsk35tBMk5vKNiDt5nOinNiO7Et8O20f/gRaIWOGnC34DasEUTEL9hRR0GXuvz/KVsIMnpkaXPkpUMNK2LmtciTTYnaPVnekaHzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APiSe0HP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APiSe0HP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466099; x=1749002099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kDJcZN33ntEvZZurzXrpsoEVgCNzk8vicnqImPO/kUg=;
  b=APiSe0HPdgjUnddTUsw28Gc4DXVU22j8kfMMfCW9/3BP6aX/p3AOfKqP
   oajH8D9R5usOEwWQZkL7OiW5LnfRpq+NdR+H9Ss4YWMOOZE02YkAVGhO+
   SwErEEoS8mZugV5pArY9PMIFqPgWA38af1xir3lm8DTvUD6tSVxXiSu51
   eivKRxCS8Zx7UXo7ZSe9H6qZEr4j71fr9BFHInseMbovaQoMPIQJyLyIa
   Vkm003/yzIJsfnjHroIxTB/k3aMxjhcXWL+CmHycKDuMMVYF5Ulq1i9jJ
   n/moAoBhDVTqf6PZc5dP0YoxaSdVFEIpc92cqktSmU+giyi7vWAMKTlho
   A==;
X-CSE-ConnectionGUID: TYxr3Q2rTvy1uj/4uZIR5g==
X-CSE-MsgGUID: OzsTaMs5R6uFK/ZeHDlVdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385058"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:54:59 -0700
X-CSE-ConnectionGUID: DTyXmmBOQmCNwsou/DMlhQ==
X-CSE-MsgGUID: 1cbIuYNgSouRWqxQ9G8H1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661929"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:54:55 -0700
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
Subject: [PATCH v2 13/22] remoteproc: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:25 +0800
Message-Id: <20240604015134.164206-14-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in rproc_enable_iommu() and is attached to
rproc->dev.parent in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f276956f2c5c..eb66f78ec8b7 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc *rproc)
 		return 0;
 	}
 
-	domain = iommu_domain_alloc(dev->bus);
-	if (!domain) {
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain)) {
 		dev_err(dev, "can't alloc iommu domain\n");
-		return -ENOMEM;
+		return PTR_ERR(domain);
 	}
 
 	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
-- 
2.34.1

