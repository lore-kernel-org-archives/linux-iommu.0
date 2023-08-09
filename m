Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F26182D4
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585441; x=1723121441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Ne5/6sMClEOpGghoXh4tELZayLADaZI9iSbfRL/ce4=;
  b=nNWm4/d/4NwAd2aR9Zn77f43cZCSTzkoZtFmnfq1HJk/pUml2ynMHdUK
   tsuhusx0BDI3bHZr4BtNqwO8jzJH+8GaqCEr+hpvEaynz271tTSgf4NO2
   b5rwiOwLKAX7Sr3sTajDO4b4ziaAVXFCCoAiyvXX6wrLi2caPS2tcMW4M
   t7TVrgM042WpC5j7YCpasf+Bc5MaLZHAF+Rs9MNXSTbqRzYBgLWI3QinA
   tcJ1k1BslOkX/+L4+aYZTf8P8jyCukVxlP1TEO6GotVmh39zqqu9/PzeP
   YtxlQxr2XgtaYuLN+TvJo4FvzG544GJ7KkH901iXU4qEouyDjXHrK7s/r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821748"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521809"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521809"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: YueHaibing <yuehaibing@huawei.com>,
	Yanfei Xu <yanfei.xu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] iommu: Prevent RESV_DIRECT devices from blocking domains
Date: Wed,  9 Aug 2023 20:48:02 +0800
Message-Id: <20230809124806.45516-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU_RESV_DIRECT flag indicates that a memory region must be mapped
1:1 at all times. This means that the region must always be accessible to
the device, even if the device is attached to a blocking domain. This is
equal to saying that IOMMU_RESV_DIRECT flag prevents devices from being
attached to blocking domains.

This also implies that devices that implement RESV_DIRECT regions will be
prevented from being assigned to user space since taking the DMA ownership
immediately switches to a blocking domain.

The rule of preventing devices with the IOMMU_RESV_DIRECT regions from
being assigned to user space has existed in the Intel IOMMU driver for
a long time. Now, this rule is being lifted up to a general core rule,
as other architectures like AMD and ARM also have RMRR-like reserved
regions. This has been discussed in the community mailing list and refer
to below link for more details.

Other places using unmanaged domains for kernel DMA must follow the
iommu_get_resv_regions() and setup IOMMU_RESV_DIRECT - we do not restrict
them in the core code.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20230724060352.113458-2-baolu.lu@linux.intel.com
---
 include/linux/iommu.h |  2 ++
 drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4cb584b08b81..9ed139bf111f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -414,6 +414,7 @@ struct iommu_fault_param {
  * @max_pasids:  number of PASIDs this device can consume
  * @attach_deferred: the dma domain attachment is deferred
  * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
+ * @require_direct: device requires IOMMU_RESV_DIRECT regions
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -428,6 +429,7 @@ struct dev_iommu {
 	u32				max_pasids;
 	u32				attach_deferred:1;
 	u32				pci_32bit_workaround:1;
+	u32				require_direct:1;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 738fee1a24f7..49e96a267a2b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1032,14 +1032,12 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 	unsigned long pg_size;
 	int ret = 0;
 
-	if (!iommu_is_dma_domain(domain))
-		return 0;
-
-	BUG_ON(!domain->pgsize_bitmap);
-
-	pg_size = 1UL << __ffs(domain->pgsize_bitmap);
+	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
 	INIT_LIST_HEAD(&mappings);
 
+	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
+		return -EINVAL;
+
 	iommu_get_resv_regions(dev, &mappings);
 
 	/* We need to consider overlapping regions for different devices */
@@ -1047,13 +1045,17 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 		dma_addr_t start, end, addr;
 		size_t map_size = 0;
 
+		if (entry->type == IOMMU_RESV_DIRECT)
+			dev->iommu->require_direct = 1;
+
+		if ((entry->type != IOMMU_RESV_DIRECT &&
+		     entry->type != IOMMU_RESV_DIRECT_RELAXABLE) ||
+		    !iommu_is_dma_domain(domain))
+			continue;
+
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
-		if (entry->type != IOMMU_RESV_DIRECT &&
-		    entry->type != IOMMU_RESV_DIRECT_RELAXABLE)
-			continue;
-
 		for (addr = start; addr <= end; addr += pg_size) {
 			phys_addr_t phys_addr;
 
@@ -2182,6 +2184,21 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 {
 	int ret;
 
+	/*
+	 * If the device requires IOMMU_RESV_DIRECT then we cannot allow
+	 * the blocking domain to be attached as it does not contain the
+	 * required 1:1 mapping. This test effectively excludes the device
+	 * being used with iommu_group_claim_dma_owner() which will block
+	 * vfio and iommufd as well.
+	 */
+	if (dev->iommu->require_direct &&
+	    (new_domain->type == IOMMU_DOMAIN_BLOCKED ||
+	     new_domain == group->blocking_domain)) {
+		dev_warn(dev,
+			 "Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
+		return -EINVAL;
+	}
+
 	if (dev->iommu->attach_deferred) {
 		if (new_domain == group->default_domain)
 			return 0;
-- 
2.34.1

