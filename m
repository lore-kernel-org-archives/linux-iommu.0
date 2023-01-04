Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0332F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837536; x=1704373536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TB3vMqIiPfgVVIrkJxZ1YwxXb13IM9MbEZds9ge+394=;
  b=H/xSXUqr0P1RwCo0goCR69E8PiL0PFVEHYh2uGcHYenksc4smizffhSF
   xrhy/xVpRaoBNUjYekkoVJtelCqtME1f1hLKq1vojihzB4WO5cSHFvbqT
   YU+lyVFFF2RPXjQP27koZ3S1RxKHEbzqi9i/CmuelUWmguTg2Io3lucBC
   wFo+YhKnfHSFMLGYmReCfMH9I67g/bKNqcGV4gj3Ojmtd171K38miK/XA
   d39JHQHuEFs9/Wy7ZTzmMXTdzW5204843PBuBd2EhS4g5t4kKZW4hNsoV
   3+BQ/z022ykVPLchNahCWjrLvdTiEJQQmgP7ksalTFce1SbEqGRZbanoE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320639623"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320639623"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:05:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529027"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529027"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:05:28 -0800
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
Subject: [PATCH v4 02/19] iommu/apple-dart: Remove detach_dev callback
Date: Wed,  4 Jan 2023 20:57:08 +0800
Message-Id: <20230104125725.271850-3-baolu.lu@linux.intel.com>
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
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/apple-dart.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4f4a323be0d0..96843d468801 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -486,13 +486,6 @@ static int apple_dart_domain_add_streams(struct apple_dart_domain *domain,
 				      true);
 }
 
-static int apple_dart_domain_remove_streams(struct apple_dart_domain *domain,
-					    struct apple_dart_master_cfg *cfg)
-{
-	return apple_dart_mod_streams(domain->stream_maps, cfg->stream_maps,
-				      false);
-}
-
 static int apple_dart_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -535,22 +528,6 @@ static int apple_dart_attach_dev(struct iommu_domain *domain,
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
@@ -780,7 +757,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= apple_dart_attach_dev,
-		.detach_dev	= apple_dart_detach_dev,
 		.map_pages	= apple_dart_map_pages,
 		.unmap_pages	= apple_dart_unmap_pages,
 		.flush_iotlb_all = apple_dart_flush_iotlb_all,
-- 
2.34.1

