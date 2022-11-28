Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E9361
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618489; x=1701154489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=foe9CYLv4t/yayK/wv2PdURR8PHQrrf3ntMgKPrhGNg=;
  b=QPt1W/VyTDfg0NgK1EcL08/CXsc7uTmgzhdREfmS7Ugs4ZHMOgDUS8VB
   +PxH8eKIYSq+/iecATtRDfOQ/uWJ3sNKuiP5aNQeybBE5RYu/+sufykoh
   SaVeqHByiZ26wW00Zo3Q9ZM7tDWrTvUGZWtghVVa0Yt6+rzoad71/UqHj
   vBax6wykLppUP0V0mIlJDxl13leoxrWUp8/eSn0fwqPYOmZNN+ibQEvry
   teH4RB+uM5PnSeQfw81x556HAsX+iOQrpypy1hiP19qH59PioVWUMV69n
   JUIiLfP1WCFxqLCFKw7Awo2rWypKVc8GQufQ166XvOsina8d4mKBqrr8i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="312395008"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="312395008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674120803"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674120803"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:54:41 -0800
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
Subject: [PATCH v3 06/20] iommu/mtk: Remove detach_dev callback
Date: Mon, 28 Nov 2022 14:46:34 +0800
Message-Id: <20221128064648.1934720-7-baolu.lu@linux.intel.com>
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
 drivers/iommu/mtk_iommu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5dc1009a19ed..2022f47529c1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -713,14 +713,6 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	return ret;
 }
 
-static void mtk_iommu_detach_device(struct iommu_domain *domain,
-				    struct device *dev)
-{
-	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
-
-	mtk_iommu_config(data, dev, false, 0);
-}
-
 static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			 int prot, gfp_t gfp, size_t *mapped)
@@ -949,7 +941,6 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_attach_device,
-		.detach_dev	= mtk_iommu_detach_device,
 		.map_pages	= mtk_iommu_map,
 		.unmap_pages	= mtk_iommu_unmap,
 		.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
-- 
2.34.1

