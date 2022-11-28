Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F039F
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618537; x=1701154537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGpxXhNOa/KRt7xgRHD7urYBt16kQhELiSo10tcOAJE=;
  b=oGPJ4l8IJ0VY4ixwR5hWtThlX8pxw8l6wxx8ZtyObSKYzS5AnAaelTeM
   y0h70yguPwqdF7YUNUQ4tZRqm27duFD3UZQB0UmoWO5gaDIisyIEMRwCy
   vZ5pU7zwLa9X596GviyG9UMG+2QuMEnlaOiREvvRhy7+LgFyPotT+CR3H
   30mBWeUcO9dJ64Er9vsRQK9qeRXCdP2QeE3vGtdMb1P8y3KaDcdIy/ABw
   5k1FmWwGtO70iTElvFw8bmuMHTXoYI+Tw8zX/NF/d+6ko7YufyXkeSuNj
   1nHXVrICxoZqWtxrHRxsokk1xWAjZr7HAmeH1F5wFqN6h2tWde7vpWM56
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="298115627"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="298115627"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121167"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121167"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:55:30 -0800
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
Subject: [PATCH v3 13/20] iommu/mtk_v1: Add set_platform_dma callback
Date: Mon, 28 Nov 2022 14:46:41 +0800
Message-Id: <20221128064648.1934720-14-baolu.lu@linux.intel.com>
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

This IOMMU driver doesn't support default domain. Add the implementation
of set_platform_dma callback so that the IOMMU core could return the
DMA control.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/mtk_iommu_v1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 69682ee068d2..6a815da8a020 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -326,6 +326,14 @@ static void mtk_iommu_v1_detach_device(struct iommu_domain *domain, struct devic
 	mtk_iommu_v1_config(data, dev, false);
 }
 
+static void mtk_iommu_v1_set_platform_dma(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain)
+		mtk_iommu_v1_detach_device(domain, dev);
+}
+
 static int mtk_iommu_v1_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			    int prot, gfp_t gfp, size_t *mapped)
@@ -585,6 +593,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.def_domain_type = mtk_iommu_v1_def_domain_type,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= MT2701_IOMMU_PAGE_SIZE,
+	.set_platform_dma = mtk_iommu_v1_set_platform_dma,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
-- 
2.34.1

