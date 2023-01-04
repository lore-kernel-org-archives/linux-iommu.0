Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0E2F49
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837581; x=1704373581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FAqxiLeKTjC5EQBIkZoPJaAUfpQlzWcuzFJW+dcWDQ=;
  b=cKbaUosIVxQJlhUfHm+bLYaylBqQpBfnuiraFRM7tox6eUL9HaXWu4nN
   i7bvH30DzYWHo9VcOKWUUeU8gg5pT8HesyRGra7enjT9JciSSCGwnsqSB
   H7AuKg7iuaMR/ekauiNYlo5S0LZkRtSvpp8VyDJN6Cx2VCg9EuyZevNzs
   CwggdyNSBVwo8+CiXz7fbFIZjLz+LN9X3/reTog1CTBBKIvzcjfEf0Wvs
   AQHpVDSzkjKgu1reXHSkT+Z/CSTAJfQS1Ug7WIWfOd98p9giye4OtoXLY
   fXAaV5FjT8ji0UqeLFTF1EMIlqOTV1TF0g9eDm8XccY1GLSZDaAssftgw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320639909"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320639909"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529095"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529095"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:06:14 -0800
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
Subject: [PATCH v4 09/19] iommu/sun50i: Remove detach_dev callback
Date: Wed,  4 Jan 2023 20:57:15 +0800
Message-Id: <20230104125725.271850-10-baolu.lu@linux.intel.com>
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
 drivers/iommu/sun50i-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 5b585eace3d4..2d993d0cea7d 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -834,7 +834,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.probe_device	= sun50i_iommu_probe_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sun50i_iommu_attach_device,
-		.detach_dev	= sun50i_iommu_detach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
-- 
2.34.1

