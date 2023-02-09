Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83363C
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917121; x=1707453121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuvtSsjfgtshayUX3b2mNkbueVkgFv+rHHiWUBqIZho=;
  b=Roq74EabZzgjtw6Wvy5mqD5ArLMbDzwp6hLfpCxb3GhrMm4UQI3b9Dt5
   LJwY0POLLntG6lT15YnKlrSfBwp8jF4slxoiw3h+IKsuvEsm/ZfvXMHJi
   uOyoMnV1j8b0ugFHk3PqrGPS/Tuuexj3l511lvUrlI6gkl7abTN2cE7+Q
   bST9X4IeN5Ab3S4vNa+Gx9PPjXvyFgkz2YwnFJ+5Yyu2h7i39qhkuZyZP
   Eb/xxJrkPocTiPaNH5MGMZMYYsLkPxONEsJgMrP/SFAsQY6zM9bzzKTKy
   a+5ZnRmLfgEczzRuPFojibKYnrK0Ea53pg5ZXFwxsE/TpcN1ZzNqUMn59
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298610"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298610"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447449"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447449"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:00 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
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
	baolu.lu@linux.intel.com
Subject: [PATCH 02/17] iommu: Add nested domain support
Date: Wed,  8 Feb 2023 20:31:38 -0800
Message-Id: <20230209043153.14964-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new domain type for a user space I/O address, which is nested
on top of another user space address represented by a UNMANAGED domain. The
mappings of a nested domain are managed by user space software, therefore
it's unnecessary to have map/unmap callbacks. But the updates of the PTEs
in the nested domain page table must be propagated to the caches on both
IOMMU (IOTLB) and devices (DevTLB).

The nested domain is allocated by the domain_alloc_user op, and attached
to the device through the existing iommu_attach_device/group() interfaces.

An new domain op, named iotlb_sync_user is added for the userspace to flush
the hardware caches for a nested domain through iommufd. No wrapper for it
as it's only supposed to be used by iommufd.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 214e3eb9bc86..f6db50f85a20 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -67,6 +67,9 @@ struct iommu_domain_geometry {
 
 #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 
+#define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed IOVA nested on
+					      a stage-2 translation        */
+
 /*
  * This are the possible domain-types
  *
@@ -92,6 +95,7 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
+#define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
 
 struct iommu_domain {
 	unsigned type;
@@ -321,6 +325,7 @@ struct iommu_ops {
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
+ * @iotlb_sync_user: Flush hardware TLBs caching user space IO mappings
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -350,6 +355,8 @@ struct iommu_domain_ops {
 			       size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
+	void (*iotlb_sync_user)(struct iommu_domain *domain,
+				void *user_data);
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
-- 
2.34.1

