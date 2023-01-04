Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE42F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837601; x=1704373601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iko82bs3XyVMHXHooIhs56+RqC7yt7lL9TP+oKjcj1Y=;
  b=TebHpuv5TyEW/i9NprGRBdC+w0dFbYu42k8LMNV9LT0GNrKf1IMyMhXS
   rlXVVc3lRtQZWc5NH7Azfd08Qgsp85Vj7haqiTl+rqDzIyO5RmCB9Qsjm
   y/JAPidrAj2w28JFGNOeUY/nWpHSkYa2OH76IaVops+Dw8WYWImt4ZjX9
   XXmVe60UUq/KV7LQCkYOBgM2KGor/Rd38RO/e2dgnteC3iZsPdbJ3DU1Q
   LrCjuH30/jlGcSw6VpnbuGah23FNNNd1Z/XSOrfEdr6baKRKazb6N+oZS
   LWo//Aop9KLcC8jg4u7Rzvcf5Rc/AZWlsvh9RVIUgfm/cS3tMJGb87dIP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320640056"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320640056"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529125"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529125"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:06:34 -0800
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
Subject: [PATCH v4 12/19] iommu/msm: Add set_platform_dma_ops callback
Date: Wed,  4 Jan 2023 20:57:18 +0800
Message-Id: <20230104125725.271850-13-baolu.lu@linux.intel.com>
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
DMA control. With the set_platform_dma_ops implemented, there's no need
for detach_dev. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/msm_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index c60624910872..454f6331c889 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -443,9 +443,9 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
-static void msm_iommu_detach_dev(struct iommu_domain *domain,
-				 struct device *dev)
+static void msm_iommu_set_platform_dma(struct device *dev)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
 	struct msm_iommu_dev *iommu;
@@ -678,11 +678,11 @@ static struct iommu_ops msm_iommu_ops = {
 	.domain_alloc = msm_iommu_domain_alloc,
 	.probe_device = msm_iommu_probe_device,
 	.device_group = generic_device_group,
+	.set_platform_dma_ops = msm_iommu_set_platform_dma,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
-		.detach_dev	= msm_iommu_detach_dev,
 		.map_pages	= msm_iommu_map,
 		.unmap_pages	= msm_iommu_unmap,
 		/*
-- 
2.34.1

