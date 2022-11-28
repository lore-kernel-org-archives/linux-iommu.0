Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B9361
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618544; x=1701154544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ff31laKxSfpGr9mFdQQubwFooU0bdzqdYVYXB0kO0dk=;
  b=nO6mryGu2cs6NBNmObkLlUl31LjuaLmQEESaAsMBsdXyDKmPtwuqnnjA
   48FeEiOYnCam1awlxa/Nc3mtSBlNVZY3O5Ju1suiVz7kI//Z7vBh/dkUj
   LAE2PrRJaEq2rxHBkKuGLCj8dzVQzbGEufi6qnCRMQAc2GYlPO9Xr8aaX
   nivJ0Iwuvfoq/pZaoT3D7j4AjAejJFaKOOivkdWdH4mMx5HCu5yLzfFha
   7Y3QjBm9MZYqXxqV9nCkCXoCu+5upBfnPwLRSrZOTwH6ISbLOnKqArhi9
   wUu8VDO+5ZSIeAVwqtMlhCFnyrqDorZy+aNe8VdmLAprSiR14vK17kYgm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="376901642"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="376901642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121224"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121224"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:55:37 -0800
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
Subject: [PATCH v3 14/20] iommu/omap: Add set_platform_dma callback
Date: Mon, 28 Nov 2022 14:46:42 +0800
Message-Id: <20221128064648.1934720-15-baolu.lu@linux.intel.com>
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
 drivers/iommu/omap-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 2fd7702c6709..aa3858a48bbf 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1566,6 +1566,14 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock(&omap_domain->lock);
 }
 
+static void omap_iommu_set_platform_dma(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain)
+		omap_iommu_detach_dev(domain, dev);
+}
+
 static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
 {
 	struct omap_iommu_domain *omap_domain;
@@ -1737,6 +1745,7 @@ static const struct iommu_ops omap_iommu_ops = {
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,
 	.device_group	= omap_iommu_device_group,
+	.set_platform_dma = omap_iommu_set_platform_dma,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= omap_iommu_attach_dev,
-- 
2.34.1

