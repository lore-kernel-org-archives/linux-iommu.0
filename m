Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECB39F
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618522; x=1701154522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAYy0JUpin+OfoNJn9WkR2B9kCOfW+EhBpCdyTnxdnM=;
  b=Jp1Cz+LDq0gVrY3mNc084BwzVFpO24oWKHJ38mYedOXDqszDcK0dBh3g
   e+03b/RrqdhdtJsPAMifyufUsfT0eJXZDu7NK4IFK9aP46tHuCoFd6NUF
   CmmxwyE4GnidPTzxfjRnPj2BGBskhHl9/zDSKAoHIhIrlvXp2XAQp206i
   QS7eoEgsQfOPLSDphwowunmnR/PXSaFzIZXs5imNtr+aTRuni7EesxTI8
   qLnrmvZ3qvkB3p48lN2jkQP63+6A9m6qzu3E5LaBxpQhupg2KlpdkYxrT
   LcxgGNp2buOWU1TO+QzoaDomRPq8w6F6LKXgjxpYWJxF/LrGRQOJ3ZTKM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="315916163"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="315916163"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121024"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121024"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:55:15 -0800
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
Subject: [PATCH v3 11/20] iommu/fsl_pamu: Add set_platform_dma callback
Date: Mon, 28 Nov 2022 14:46:39 +0800
Message-Id: <20221128064648.1934720-12-baolu.lu@linux.intel.com>
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
 drivers/iommu/fsl_pamu_domain.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 4408ac3c49b6..b8c716e7c424 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -314,6 +314,14 @@ static void fsl_pamu_detach_device(struct iommu_domain *domain,
 		pr_debug("missing fsl,liodn property at %pOF\n", dev->of_node);
 }
 
+static void fsl_pamu_set_platform_dma(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain)
+		fsl_pamu_detach_device(domain, dev);
+}
+
 /* Set the domain stash attribute */
 int fsl_pamu_configure_l1_stash(struct iommu_domain *domain, u32 cpu)
 {
@@ -452,6 +460,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.domain_alloc	= fsl_pamu_domain_alloc,
 	.probe_device	= fsl_pamu_probe_device,
 	.device_group   = fsl_pamu_device_group,
+	.set_platform_dma = fsl_pamu_set_platform_dma;
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
 		.detach_dev	= fsl_pamu_detach_device,
-- 
2.34.1

