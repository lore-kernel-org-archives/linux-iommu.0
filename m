Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5012F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837555; x=1704373555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Hfgn3HaMy2m0Id9NRgFBnnjXsgWJay8WBgNiBr3taA=;
  b=b/MYMRgZyZtmCCArnleia5DlapLoGetr122LBm1Tccj0UGqumPPWPIbA
   syRJGQXmyOZzOUplmuYhnR5FL369HSPahUxjCzXW3AgAjwKbOZmD/iAqq
   5u01NqszZl7sHx+mHhXQSvQmnse0uWDgrkIsNnPYgISE0bEHMoeKsfPob
   fkrTYtEjxSnawR1f2+WeIjwuH6DE8f9qPqAJpQcjI1k1Fy1VlnpUWWmdR
   oRFmVu3/RG+vDtv8t60lhFViVeVvuoN/Pil43MPNHnPt0PPEDfwN4H5k7
   RJn3YIcmWYfKZRmqYtPxcnArh/d+O1zAi5oqKzTAv4tls26EBdyPl+57y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320639739"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320639739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529050"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529050"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:05:48 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Rob Clark <robdclark@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 05/19] iommu/ipmmu: Remove detach_dev callback
Date: Wed,  4 Jan 2023 20:57:11 +0800
Message-Id: <20230104125725.271850-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104125725.271850-1-baolu.lu@linux.intel.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU driver supports default domain, so the detach_dev op will never
be called. Remove it to avoid dead code.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/ipmmu-vmsa.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index a003bd5fc65c..3112822ac7be 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -643,21 +643,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	return 0;
 }
 
-static void ipmmu_detach_device(struct iommu_domain *io_domain,
-				struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-	unsigned int i;
-
-	for (i = 0; i < fwspec->num_ids; ++i)
-		ipmmu_utlb_disable(domain, fwspec->ids[i]);
-
-	/*
-	 * TODO: Optimize by disabling the context when no device is attached.
-	 */
-}
-
 static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 		     phys_addr_t paddr, size_t pgsize, size_t pgcount,
 		     int prot, gfp_t gfp, size_t *mapped)
@@ -876,7 +861,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
-		.detach_dev	= ipmmu_detach_device,
 		.map_pages	= ipmmu_map,
 		.unmap_pages	= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
-- 
2.34.1

