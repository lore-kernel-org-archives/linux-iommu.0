Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92F33EA
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672837660; x=1704373660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JspMSxf4tOO5N5gZs/+2wzcZApAr4SYcbdCKphs0Zg=;
  b=i74u11fAx8vX0ieOZXpjnQYqaIR6OWG34MJbL4XOoXw0HIKOTBZYGtcc
   hGWiosodl/iyCyspxc1Iia5yhUlc5DXlukzE78zoPSmc4pl3uh5Kg5b00
   XHkiCPdrnn6y1gWy2TnisEFhNk+2XrhY9g5XPB+UVlihXlpox/101iI2X
   fhgHUC2dRjvCI2yS/jGoJcgP5WNizKrPZ7pThDofYyR5R/rGW8dpANxmW
   VHVnoQ0Jj06xWLazRi82v5hybxoQ2nM+F4LTHMatEjRsaMoahpEgUYZkT
   jpT283SWUFvYSQ5wGmps5098p/3e7klIriHt8JlDU/Q/eZuZQsksNa0rx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320640355"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="320640355"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 05:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797529492"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="797529492"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2023 05:07:20 -0800
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
Subject: [PATCH v4 19/19] iommu: Remove detach_dev callback
Date: Wed,  4 Jan 2023 20:57:25 +0800
Message-Id: <20230104125725.271850-20-baolu.lu@linux.intel.com>
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

The detach_dev callback of domain ops is not called in the IOMMU core.
Remove this callback to avoid dead code. The trace event for detaching
domain from device is removed accordingly.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h        |  2 --
 include/trace/events/iommu.h |  7 -------
 drivers/iommu/iommu-traces.c |  1 -
 drivers/iommu/iommu.c        | 29 +++++------------------------
 4 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0d10566b3cb2..a8063f26ff69 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -299,7 +299,6 @@ struct iommu_ops {
  * * EBUSY	- device is attached to a domain and cannot be changed
  * * ENODEV	- device specific errors, not able to be attached
  * * <others>	- treated as ENODEV by the caller. Use is discouraged
- * @detach_dev: detach an iommu domain from a device
  * @set_dev_pasid: set an iommu domain to a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
@@ -320,7 +319,6 @@ struct iommu_ops {
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid);
 
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 29096fe12623..70743db1fb75 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -76,13 +76,6 @@ DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
 	TP_ARGS(dev)
 );
 
-DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
-
-	TP_PROTO(struct device *dev),
-
-	TP_ARGS(dev)
-);
-
 TRACE_EVENT(map,
 
 	TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
diff --git a/drivers/iommu/iommu-traces.c b/drivers/iommu/iommu-traces.c
index 1e9ca7789de1..23416bf76df9 100644
--- a/drivers/iommu/iommu-traces.c
+++ b/drivers/iommu/iommu-traces.c
@@ -18,7 +18,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(remove_device_from_group);
 
 /* iommu_device_event */
 EXPORT_TRACEPOINT_SYMBOL_GPL(attach_device_to_domain);
-EXPORT_TRACEPOINT_SYMBOL_GPL(detach_device_from_domain);
 
 /* iommu_map_unmap */
 EXPORT_TRACEPOINT_SYMBOL_GPL(map);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c7bd8663f1f5..d2b3210170a8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2045,13 +2045,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return 0;
 }
 
-static void __iommu_detach_device(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	domain->ops->detach_dev(domain, dev);
-	trace_detach_device_from_domain(dev);
-}
-
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2156,15 +2149,6 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-static int iommu_group_do_detach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	__iommu_detach_device(domain, dev);
-
-	return 0;
-}
-
 static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -2185,19 +2169,16 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 		return 0;
 
 	/*
-	 * New drivers should support default domains and so the detach_dev() op
-	 * will never be called. Otherwise the NULL domain represents some
+	 * New drivers should support default domains and so set_platform_dma()
+	 * op will never be called. Otherwise the NULL domain represents some
 	 * platform specific behavior.
 	 */
 	if (!new_domain) {
 		ret = __iommu_group_for_each_dev(group, NULL,
 				iommu_group_do_set_platform_dma);
-		if (ret) {
-			if (WARN_ON(!group->domain->ops->detach_dev))
-				return -EINVAL;
-			__iommu_group_for_each_dev(group, group->domain,
-				iommu_group_do_detach_device);
-		}
+		if (ret)
+			return ret;
+
 		group->domain = NULL;
 		return 0;
 	}
-- 
2.34.1

