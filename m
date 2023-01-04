Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0EB2F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837608; x=1704373608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/1FMqG3xZJDtfDShWWRJkd9e9miluKjPk+ZSlf8fww=;
  b=b7T9SKezvLUl2YPgkXla8GdFcPU/aWaPLvbh6nkM08Z7JnBia95aG/zn
   ignWV5rSdI8lHgk6+q9FpOmYBOuS7Q46vVWCuHpqqcRkbaX5Rg+9+gnhf
   vss6T46PS+nzzFLj7zPtH+kc0ei+tEyIfC9V1INdD8QA+H193z9sCYlsH
   hKpCt68ovbGzKjZcAGOqwxz/6w4LW0WWi4RyABkc/mQvkCpnF9C8WByJT
   YS+Y+rKbG9nHPeyhwN2vz0ZohNeO1qH0JrpyDIO5746OtGNUtG235QO6V
   5itBpXNGHlf43pzXYWg9oIkhHnSObRnu/2o+M922qU4DiTMvTYhf0c4AF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320640095"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320640095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529136"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529136"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:06:40 -0800
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
Subject: [PATCH v4 13/19] iommu/mtk_v1: Add set_platform_dma_ops callback
Date: Wed,  4 Jan 2023 20:57:19 +0800
Message-Id: <20230104125725.271850-14-baolu.lu@linux.intel.com>
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
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 69682ee068d2..78d0a84c704f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -319,7 +319,7 @@ static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device
 	return 0;
 }
 
-static void mtk_iommu_v1_detach_device(struct iommu_domain *domain, struct device *dev)
+static void mtk_iommu_v1_set_platform_dma(struct device *dev)
 {
 	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
 
@@ -585,10 +585,10 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.def_domain_type = mtk_iommu_v1_def_domain_type,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= MT2701_IOMMU_PAGE_SIZE,
+	.set_platform_dma_ops = mtk_iommu_v1_set_platform_dma,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
-		.detach_dev	= mtk_iommu_v1_detach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
 		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
-- 
2.34.1

