Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42E13D8B5
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466111; cv=none; b=u3G6WBZgGD0h7iokQRltIMTan8gLRiABTT2lnLeNF+FA7FJaEjg9qU5uBV4OWEn8nEGMktniI/ldDLjBpq1Kzj6DSV58uWrQvQE1KDDm4sTk755lIBvFK/YIoP+Ap9KnhRjxWKSLY0/+4xLrV7l+rlWaWDE0ZHUguHqesJ330zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466111; c=relaxed/simple;
	bh=Q9WtpwCC02vx2ybK55ip8mbKEJ1zuaBDftnxsc6ieIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV7c8Li0cNCbBKPMbIL4PoCWJ1fcEb8zm31lo3C+3m38aKwrKXwle7RwF9/d6cHS6VgooBfC0HyoWYrem7pqfWReAzYRHcnXl9uw7hKdM/FSh6444wkB2h2KgBamwadRGV5MT4EdrWDURfKIpNSRlIVYV35gBkMLQmJfxVOWiKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cv+PDNX1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cv+PDNX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466110; x=1749002110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q9WtpwCC02vx2ybK55ip8mbKEJ1zuaBDftnxsc6ieIQ=;
  b=cv+PDNX1p09gG2SgUoDWOnhcFPM9qGpbLN4q6zJJ5oob/hIPuVRnPErx
   lVEbpHFj4ejhgyPqzF5b8QwjniyA8E6zF/V7wjWhoD0fMMGYmwEbBVhdQ
   Bnn/mtlbz4G1+aYrN4Fl6UCm67/fRZVa92oynCISHgtHpd6TkKqvhrp+H
   PVVAoPYHNgYxLgUP6ZB8wdO95yOS2ZQReF+8NMvHOBNtFIEUuAHrn7eM4
   1I92eboU6jRn/Z0ccP87+KnaniwffSeb5V9+lKE44NoSAc+3Xbir2MmtU
   K+Ud2qh7GCr1WLLI5JFMakfVv2ZfIlzkQ7ooOsBsoRWS3RtangAkJiewu
   A==;
X-CSE-ConnectionGUID: HDQZOZnAQpqMnFgYCy72mQ==
X-CSE-MsgGUID: cgUQ4holRhCQYT37fLW4hA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25385102"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25385102"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:55:09 -0700
X-CSE-ConnectionGUID: e1r3ChScReqqwQzmKW9O+Q==
X-CSE-MsgGUID: hie+PAaPSB6kc851S6gIgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661993"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:55:05 -0700
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
Subject: [PATCH v2 15/22] RDMA/usnic: Use iommu_paging_domain_alloc()
Date: Tue,  4 Jun 2024 09:51:27 +0800
Message-Id: <20240604015134.164206-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604015134.164206-1-baolu.lu@linux.intel.com>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usnic_uiom_alloc_pd() allocates a paging domain for a given device.
In this case, iommu_domain_alloc(dev->bus) is equivalent to 
iommu_paging_domain_alloc(dev). Replace it as iommu_domain_alloc()
has been deprecated.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 84e0f41e7dfa..f948b76f984d 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -443,11 +443,11 @@ struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev)
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	pd->domain = domain = iommu_domain_alloc(dev->bus);
-	if (!domain) {
+	pd->domain = domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain)) {
 		usnic_err("Failed to allocate IOMMU domain");
 		kfree(pd);
-		return ERR_PTR(-ENOMEM);
+		return ERR_CAST(domain);
 	}
 
 	iommu_set_fault_handler(pd->domain, usnic_uiom_dma_fault, NULL);
-- 
2.34.1

