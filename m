Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DD1FB3
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196667; x=1721732667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jdb8ZB5daKdGFPrTc/NRXCndQLaxOJW2ZTy0hfrrfYc=;
  b=fjHIzrOrRzupqlZFG2RCDXfzCekm2Ib755nk1e5jR6UR6YKLkgLZmWgz
   Mo9WjC2Su+yKj4/EhH17DcA3ucFgQ9Iw1ZLc36u2OYu3E/ORJ+rpUekzD
   krwq6BXAqD8YPfGyVx4TNvJsJG7FHEVy2zygqqrQOFT2T5nk8HjGNuP2F
   Zr32KuKMEgaOCPPOak/U3wLeB4UAJjuMUx1G4JykNiyrh29T1MsEIMv1i
   2gSWUj73cR1KAgNkuUtmHZxGFBGy2QmlXAQDyNGN8ig432xk0b7n5ti+8
   pN/vXIuCpUHQc/hytCYAXA1T4dBgqhHEQpej+OHeGTGGEJWC/6TahgvWt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013317"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775871"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775871"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:22 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com
Subject: [PATCH v3 12/17] iommufd/selftest: Add .get_resv_regions() for mock_dev
Date: Mon, 24 Jul 2023 04:04:01 -0700
Message-Id: <20230724110406.107212-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes mock_dev to report resv_regions.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 271c6c261eb4..e40780db88b5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -292,6 +292,32 @@ static void mock_domain_set_plaform_dma_ops(struct device *dev)
 	 */
 }
 
+static void iommufd_test_get_resv_regions(struct device *dev,
+					  struct list_head *head)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct interval_tree_node *reserved, *next;
+
+	down_read(&mdev->reserved_rwsem);
+	for (reserved = interval_tree_iter_first(&mdev->reserved_itree, 0, ULONG_MAX);
+	     reserved; reserved = next) {
+		struct iommu_resv_region *resv;
+
+		next = interval_tree_iter_next(reserved, 0, ULONG_MAX);
+		/* Only adds IOMMU_RESV_DIRECT so far */
+		resv = iommu_alloc_resv_region(reserved->start,
+					       reserved->last + 1 - reserved->start,
+					       IOMMU_READ | IOMMU_WRITE,
+					       IOMMU_RESV_DIRECT,
+					       GFP_ATOMIC);
+		if (!resv)
+			break;
+
+		list_add_tail(&resv->list, head);
+	}
+	up_read(&mdev->reserved_rwsem);
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -299,6 +325,7 @@ static const struct iommu_ops mock_ops = {
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
 	.capable = mock_domain_capable,
+	.get_resv_regions = iommufd_test_get_resv_regions,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
-- 
2.34.1

