Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CC2F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837529; x=1704373529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xeeuRQM/dsTN33VxOfF8H61kIE4esUx5TqB4kEEMhw=;
  b=aIwBL3pf2XPyL+4HbMs7O/HcSqkkTOHyFv5+i77IT7I2Zp84h7fJZJ2V
   2r5BaZxMqlyB/XyHyWu7GCcPfDWVNuqbok2T7IhE1RRnc8vhbFJqeZqSd
   s7LgBzJDJ5e2hfniGmnCD8lftC1tDKnX7pMy8CjDaNzNfSXBNNmbfBv2w
   rXH6mluIExeNSLemJ2xqlvqxAImRdvgZ6ElsiaJVwWJkJx5EPenlomWWw
   MvMz/dNMoSnjZxKQbrNYldNyXurm68HFNKiURfONhVdFPGB0yQJ4wsuqr
   N8AEggx7boXqeyOlGcolm9eX0A0VXpoUh0QJ9WU22uizQJ5kfH6LGW9yP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320639591"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320639591"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:05:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529016"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529016"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:05:21 -0800
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
Subject: [PATCH v4 01/19] iommu/amd: Remove detach_dev callback
Date: Wed,  4 Jan 2023 20:57:07 +0800
Message-Id: <20230104125725.271850-2-baolu.lu@linux.intel.com>
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

The AMD IOMMU supports default domain, so the detach_dev op will never
be called. Remove it to avoid dead code.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/iommu.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..92319c9b877c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2126,31 +2126,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	protection_domain_free(domain);
 }
 
-static void amd_iommu_detach_device(struct iommu_domain *dom,
-				    struct device *dev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct amd_iommu *iommu;
-
-	if (!check_device(dev))
-		return;
-
-	if (dev_data->domain != NULL)
-		detach_device(dev);
-
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return;
-
-#ifdef CONFIG_IRQ_REMAP
-	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
-	    (dom->type == IOMMU_DOMAIN_UNMANAGED))
-		dev_data->use_vapic = 0;
-#endif
-
-	iommu_completion_wait(iommu);
-}
-
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
@@ -2416,7 +2391,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
-		.detach_dev	= amd_iommu_detach_device,
 		.map_pages	= amd_iommu_map_pages,
 		.unmap_pages	= amd_iommu_unmap_pages,
 		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
-- 
2.34.1

