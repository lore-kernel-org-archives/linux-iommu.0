Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3F39F
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618531; x=1701154531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9D0XyFvFSOhAEwulu1xI29MelRcePwGMxUZNH4H/TSo=;
  b=eDz5xP8yEOKNuv1OPVr6KroEJQ75ORz2xGTxE5yfu3/4eCgaEzCow455
   T05996D04qWhpJhHVfngEXFg6BuhpZuCE4iOuuBE6gU2ksW2fC3C/Z6+z
   JT0mUVICoprqrxDoq/MGMm/dpgRxIUi9aKiheLKbAsKbeNQxAwyiKbzsj
   0Lq7YqrmmSpID8FlsH/MQxsi+CwHAvZN3EAzUgCG9LtfZdkuB2uB+138v
   QL+//kKjczgfqQfvnvjZ+BpjxPFSyQtjkKTJ2ZLRb2EhSe8mL0QrnTFIM
   8bx79gDpoZ+7rTgLczN6hZnLinSD/RxaorQ1yxBygxjSBAeytf7b71ExO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="294462548"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="294462548"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121106"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121106"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:55:22 -0800
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
Subject: [PATCH v3 12/20] iommu/msm: Add set_platform_dma callback
Date: Mon, 28 Nov 2022 14:46:40 +0800
Message-Id: <20221128064648.1934720-13-baolu.lu@linux.intel.com>
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
 drivers/iommu/msm_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index c60624910872..3eb1bc668cad 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -470,6 +470,14 @@ static void msm_iommu_detach_dev(struct iommu_domain *domain,
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 }
 
+static void msm_iommu_set_platform_dma(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain)
+		msm_iommu_detach_dev(domain, dev);
+}
+
 static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t pa, size_t pgsize, size_t pgcount,
 			 int prot, gfp_t gfp, size_t *mapped)
@@ -678,6 +686,7 @@ static struct iommu_ops msm_iommu_ops = {
 	.domain_alloc = msm_iommu_domain_alloc,
 	.probe_device = msm_iommu_probe_device,
 	.device_group = generic_device_group,
+	.set_platform_dma = msm_iommu_set_platform_dma,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 	.of_xlate = qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.34.1

