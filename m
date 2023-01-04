Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9262F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837542; x=1704373542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ly1CFFQsdha64HGKM2XxpjbOlFYepHT9+afzlH0HDzc=;
  b=BjQ54+0snMrgndXDoGEmY//s9CmOtYlRGo+Hoh+eKELcNGyEJHz64Dpy
   sM3oKJCJ00X0GX8LSfWUzQmJBNczGQV9ORbrNWf0FyihbTNBAFfxxcYft
   HpmwQ6s3/DY7fd3VbOGlglbdcf1IyEw9/5e2FRUF/UfGnaw3LAGCfLzuP
   AZRinBX+iSjdPFYk4nso6GaHzc9wSqFxt7nE4rBneapx1LU4FuT7dDwvz
   qXO25Jvr2i7XO5vWnPLfTLVXDrgiRpIYrSaU++FLREvFnmiYOuddtETjI
   Mv7uFD3oU9ctf83JD0YobPWC2ctrfMy4aE0QPUTi/V5yg/kVIE1tdRTM9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320639661"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320639661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529035"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529035"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:05:35 -0800
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
Subject: [PATCH v4 03/19] iommu/qcom: Remove detach_dev callback
Date: Wed,  4 Jan 2023 20:57:09 +0800
Message-Id: <20230104125725.271850-4-baolu.lu@linux.intel.com>
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
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 270c3d9128ba..d7be3adee426 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -387,28 +387,6 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 	return 0;
 }
 
-static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
-{
-	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
-	unsigned i;
-
-	if (WARN_ON(!qcom_domain->iommu))
-		return;
-
-	pm_runtime_get_sync(qcom_iommu->dev);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
-
-		/* Disable the context bank: */
-		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
-
-		ctx->domain = NULL;
-	}
-	pm_runtime_put_sync(qcom_iommu->dev);
-}
-
 static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			  int prot, gfp_t gfp, size_t *mapped)
@@ -583,7 +561,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
-		.detach_dev	= qcom_iommu_detach_dev,
 		.map_pages	= qcom_iommu_map,
 		.unmap_pages	= qcom_iommu_unmap,
 		.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
-- 
2.34.1

