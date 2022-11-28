Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91C361
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618461; x=1701154461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8akeC95ae32s8n7uxnpCOPX3I9yHcltUgN/OgADfsrI=;
  b=ICtYrWjCTWmyc8I37dVy7WfFE9vm32m+kWd4dKNqQMfa04/l3PuOGIqe
   NRt/3m9uMCPF6PEhKdUmDK4VgJK9loS8DitkhtIpPquuH99j6PAHyWfwt
   ZEHRfVhCXlE3VxV+Shgwro+qakVxEkSfmMTyprGbyJ1ckv9TsCYuys8Pt
   CWDDBhiV5Z1diFovkjKiyIDRVFPhNu7pVdtwimy4KrzjM0ZNQritJAqY+
   aOgQXvOWHVAqIastUR2eX+PSPmOx2jRNo445H3zLnxq3bcovNYYOe2lQt
   5oqtNXMKT0pEWBa0yzbLjfmtdda/a06/dyMVQl7Tv2bAhe9/pOXO30mDc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401050210"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="401050210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:54:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120721"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120721"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:54:13 -0800
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
Subject: [PATCH v3 02/20] iommu/apple-dart: Remove detach_dev callback
Date: Mon, 28 Nov 2022 14:46:30 +0800
Message-Id: <20221128064648.1934720-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU driver supports default domain, so the detach_dev op will never
be called. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/apple-dart.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4f4a323be0d0..6fbe6b275c79 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -535,22 +535,6 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
 	return ret;
 }
 
-static void apple_dart_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	int i;
-	struct apple_dart_stream_map *stream_map;
-	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
-	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
-
-	for_each_stream_map(i, cfg, stream_map)
-		apple_dart_hw_disable_dma(stream_map);
-
-	if (domain->type == IOMMU_DOMAIN_DMA ||
-	    domain->type == IOMMU_DOMAIN_UNMANAGED)
-		apple_dart_domain_remove_streams(dart_domain, cfg);
-}
-
 static struct iommu_device *apple_dart_probe_device(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
@@ -780,7 +764,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= apple_dart_attach_dev,
-		.detach_dev	= apple_dart_detach_dev,
 		.map_pages	= apple_dart_map_pages,
 		.unmap_pages	= apple_dart_unmap_pages,
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
-- 
2.34.1

