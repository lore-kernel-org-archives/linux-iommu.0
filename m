Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9663A
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669618573; x=1701154573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2u7/GIfAe0DIonm/0hJIJlmbZhf+CBwAyKoVx4wlxOs=;
  b=d46b1zuY9xJ9RwHfZ7OIeV+lfscmCC0x9uEwUfAsi7vOgzkbJzNverlV
   tWHJUfPPRdSMIEg4mCGxjXVUdC5KgXgqbgk9ykRrIOUfHy1SHgSMMAKnc
   1cbC54dhme0NpKfqGgYXgKwthB0zmwKBExL/OPwjgtSBm0MIGWFhGGbla
   S2YFLQvVTFKYbl0IjGshq7AX2UVXh5lMLsGYpN8/f1Osr/0kRAVui7Wwc
   Kuyx613KLFAzjQz86M0ozPG/gfblfkvfmkvXrLp65uVhYRgQV60qKCAQh
   +YZI9+N4AF22SsyEnN9ERUsKb+3Ol3qOpCE3GRLfQgR965RD3JCZiF1zC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="302338387"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="302338387"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 22:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="674121303"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="674121303"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2022 22:56:05 -0800
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
Subject: [PATCH v3 18/20] iommu: Call set_platform_dma if default domain is unavailable
Date: Mon, 28 Nov 2022 14:46:46 +0800
Message-Id: <20221128064648.1934720-19-baolu.lu@linux.intel.com>
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

If the IOMMU driver has no default domain support, call set_platform_dma
explicitly to return the kernel DMA control back to the platform DMA ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7c99d8eb3182..e4966f088184 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2040,16 +2040,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return 0;
 }
 
-static void __iommu_detach_device(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	if (iommu_is_attach_deferred(dev))
-		return;
-
-	domain->ops->detach_dev(domain, dev);
-	trace_detach_device_from_domain(dev);
-}
-
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2154,11 +2144,12 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-static int iommu_group_do_detach_device(struct device *dev, void *data)
+static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
 {
-	struct iommu_domain *domain = data;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	__iommu_detach_device(domain, dev);
+	if (!WARN_ON(!ops->set_platform_dma))
+		ops->set_platform_dma(dev);
 
 	return 0;
 }
@@ -2172,15 +2163,12 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 		return 0;
 
 	/*
-	 * New drivers should support default domains and so the detach_dev() op
-	 * will never be called. Otherwise the NULL domain represents some
-	 * platform specific behavior.
+	 * New drivers should support default domains. Otherwise the NULL
+	 * domain represents returning control back to the platform DMA.
 	 */
 	if (!new_domain) {
-		if (WARN_ON(!group->domain->ops->detach_dev))
-			return -EINVAL;
-		__iommu_group_for_each_dev(group, group->domain,
-					   iommu_group_do_detach_device);
+		__iommu_group_for_each_dev(group, NULL,
+					   iommu_group_do_set_platform_dma);
 		group->domain = NULL;
 		return 0;
 	}
-- 
2.34.1

