Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5392F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837614; x=1704373614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gxJLHmezjsBYFySYnAyva9RMyCE4Jcahplt9m+F0/+g=;
  b=mOkMvFMFAg1bUa1AgSKSU76fHiWPrPawFFHE4NQp6hSM4713XBhG9mjk
   Wmr+MDF6djrvsFcrCAqn3c6y3uQg9B/YpaPXpXlRg8chzekS4G8QAdeif
   7jfIGY34eU1ZjKeAX0g2wZ/lt33IQz5jsTigLDiwSLpk+UofLJN+oYAUH
   kBc2S7ZxfTyUefanK8Xr4MJN0rqTA6PIpXSVw2ZqGUInNyq8gDLeO0CD6
   h2MlmT/1lgKsBs1J71RYJ4fBEGHco0sa5taV86tLW/7D7hpn3IUKEqcP/
   pCp5obFvSHZETvvRpbckZwA7wjnCHilFBhGnWoZsQZdmKc3iVeiVuteoE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320640132"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320640132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529142"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529142"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:06:47 -0800
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
Subject: [PATCH v4 14/19] iommu/omap: Add set_platform_dma_ops callback
Date: Wed,  4 Jan 2023 20:57:20 +0800
Message-Id: <20230104125725.271850-15-baolu.lu@linux.intel.com>
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

This IOMMU driver doesn't support default domain. Add the implementation
of set_platform_dma_ops callback so that the IOMMU core could return the
DMA control. With the set_platform_dma implemented, there's no need for
detach_dev. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/omap-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 2fd7702c6709..3ab078112a7c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1556,9 +1556,9 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 	omap_domain->dev = NULL;
 }
 
-static void omap_iommu_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
+static void omap_iommu_set_platform_dma(struct device *dev)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 
 	spin_lock(&omap_domain->lock);
@@ -1737,10 +1737,10 @@ static const struct iommu_ops omap_iommu_ops = {
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,
 	.device_group	= omap_iommu_device_group,
+	.set_platform_dma_ops = omap_iommu_set_platform_dma,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= omap_iommu_attach_dev,
-		.detach_dev	= omap_iommu_detach_dev,
 		.map		= omap_iommu_map,
 		.unmap		= omap_iommu_unmap,
 		.iova_to_phys	= omap_iommu_iova_to_phys,
-- 
2.34.1

