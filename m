Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCA17C9
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 01:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657847996; x=1689383996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ah6PND1BxSCx3aUAfM5nAhsQZ1u1LGPIMXCR5CXrLJI=;
  b=j6KybR4+kF8X21JfloJ/p9QsOPsQmyLL3rELLidav165ELalJsF9baOc
   s0sNy8InDBABSi+itfkWIUNRry77aLEvUtLzYZwdoJCZEBaQM1nGVlxzw
   /7TEy2GBapURtHqEVriDrpRUvMh4ZgMKAm8R9BojlTYKymEvx2g7u7B7l
   sK1XhCu+cvSBluUZycBO7rAsxtlgF+ujhKBhOCxU8lL6pIvEl7racEoBG
   lMulBdW1KR/RGpLnQZ16FA0w1M6PZ7QU1/UWC+r/y4ZZFz7GThkgRFyue
   MPHxlAmVvWRP9Pn90sV1tZP54qYBhAd7H7DK/XRBXOYbmQZ7fVKUGHB3P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285696727"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="285696727"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571323498"
Received: from tina-desktop.bj.intel.com ([10.238.154.66])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 18:19:54 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	will@kernel.org,
	kevin.tian@intel.com,
	jean-philippe@linaro.org,
	baolu.lu@linux.intel.com,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2] iommu/virtio: Add map/unmap_pages() callbacks implementation
Date: Mon,  6 Jun 2022 00:11:52 +0800
Message-Id: <20220605161152.3171-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map/unmap_pags() allows map and unmap multiple pages of the same size
in one call, which can improve performance by reducing the numbers of
vmexits. With map/unmap_pages() implemented, the prior map/unmap()
callbacks are deprecated.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/virtio-iommu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..3c943dbd9fd0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -788,11 +788,13 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
-static int viommu_map(struct iommu_domain *domain, unsigned long iova,
-		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
+			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			    int prot, gfp_t gfp, size_t *mapped)
 {
 	int ret;
 	u32 flags;
+	size_t size = pgsize * pgcount;
 	u64 end = iova + size - 1;
 	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
@@ -823,17 +825,21 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
 	if (ret)
 		viommu_del_mappings(vdomain, iova, end);
+	else if (mapped)
+		*mapped = size;
 
 	return ret;
 }
 
-static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			   size_t size, struct iommu_iotlb_gather *gather)
+static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
+				 size_t pgsize, size_t pgcount,
+				 struct iommu_iotlb_gather *gather)
 {
 	int ret = 0;
 	size_t unmapped;
 	struct virtio_iommu_req_unmap unmap;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	size_t size = pgsize * pgcount;
 
 	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
 	if (unmapped < size)
@@ -1018,8 +1024,8 @@ static struct iommu_ops viommu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
-		.map			= viommu_map,
-		.unmap			= viommu_unmap,
+		.map_pages		= viommu_map_pages,
+		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.free			= viommu_domain_free,
-- 
2.34.1

