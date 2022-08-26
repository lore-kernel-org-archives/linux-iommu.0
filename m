Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A133E8
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516274; x=1693052274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BlPDAsITnFdD30Pt137P5Fo8l26pHF5dP5Ti1dDDyHg=;
  b=Q8Isbr8cFXq3GKBA8QYsn6pqpuYkf63g5FlDrMK2j4aErCY04z5HBpKU
   H+uYfDgt+E2T4lf5RxcGbWhufupAS0cuVDZJWq4/ryucYikM7SBKTHfrH
   rcvsQWMafDIYHd5LQIT2dQD0nmFpoManGc7VDP4q5omwpFmkq05jiYv1Q
   LFsD/YTH3Q1egWxRTaYopJNzTNvlYfhySQH66FFVbucPWqFqXfxGRDnZg
   Qg6MaQwJbN+eEFxE2EJc24/0B+eH8GSeHuIlNWI9uG7TfwJazDoFWb8w1
   lHPMaHdev81NP9Q4+zfou7XzJEY6CPGb9EA6rfSX2wEl37irJKcrChqO9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320587310"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320587310"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747653"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:17:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v12 07/17] iommu: Try to allocate blocking domain when probing device
Date: Fri, 26 Aug 2022 20:11:31 +0800
Message-Id: <20220826121141.50743-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826121141.50743-1-baolu.lu@linux.intel.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate the blocking domain when probing devices if the driver supports
blocking domain allocation. Otherwise, revert to the previous behavior,
that is, use UNMANAGED domain instead when the blocking domain is needed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/iommu/iommu.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2c9488d966ab..e985f4d5895f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -318,6 +318,10 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
 
+	/* Try to allocate a blocking domain */
+	group->blocking_domain = __iommu_domain_alloc(dev->bus,
+						      IOMMU_DOMAIN_BLOCKED);
+
 	/*
 	 * If device joined an existing group which has been claimed, don't
 	 * attach the default domain.
@@ -1778,6 +1782,10 @@ int bus_iommu_probe(struct bus_type *bus)
 		/* Try to allocate default domain */
 		probe_alloc_default_domain(bus, group);
 
+		/* Try to allocate blocking domain */
+		group->blocking_domain =
+				__iommu_domain_alloc(bus, IOMMU_DOMAIN_BLOCKED);
+
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
 			continue;
@@ -3165,18 +3173,15 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
-	if (!group->blocking_domain) {
-		/*
-		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
-		 * create an empty domain instead.
-		 */
-		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
-		if (!group->blocking_domain)
-			return -EINVAL;
-	}
+	/*
+	 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
+	 * create an empty domain instead.
+	 */
+	group->blocking_domain = __iommu_domain_alloc(dev->dev->bus,
+						      IOMMU_DOMAIN_UNMANAGED);
+	if (!group->blocking_domain)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.25.1

