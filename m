Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658415AC
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657672971; x=1689208971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BwRTZVN9Q+6hvMgPyrEZcFChjkzZyIpbjs6+NA1n+E0=;
  b=bbhmlFwUxs1qjxHS9dkxzN/HHcnKRxShVnZFfbfk4PM7Qkarq2mkCbgU
   rykLndMDP/fseretLDyY7OtvSBDwFFrHmgk5z7u46SBE1m5DoaDxSyLO8
   bwtyTkfVjqDlVJhZcm+sK6Ishi21Go76Mw3D8gryinotOjEHJKpfwW8Oa
   bqggK6DdQOi8CI0mPgebgy6RTB53hCTB687SL2o0tTzhGbSda80AqlEQj
   4ujAlmKlyZnxFIrx9BuJ6hCEacNthjq63le8Hd85F5UZPcA8GhRr3RP+m
   IG5nGcWis7rKVwEytBdtzrdmpfpDaTW0ktGx73I2Dikh7VVgtUWNrF8re
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265487184"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265487184"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 17:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="653135650"
Received: from test.bj.intel.com ([10.238.158.204])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jul 2022 17:42:40 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	will@kernel.org,
	kevin.tian@intel.com,
	jean-philippe@linaro.org,
	baolu.lu@linux.intel.com,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH] iommu/virtio: Add map/unmap_pages() callbacks implementation
Date: Tue, 12 Jul 2022 20:18:38 -0400
Message-Id: <20220713001838.17298-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
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
index 25be4b822aa0..d1626e3de7f8 100644
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
+	else if (!ret && mapped)
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

