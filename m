Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383371FB3
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196652; x=1721732652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TwNnGQoy/O9RF24KvlNH55AuSnmg4Ro5e8QjmX39PRQ=;
  b=iQXJeqmQYcmI4Nstm6AmlEU+92iGrzXGsUjMGK/K5KN5GidxnICek8Bi
   U1Gt1GLLpVve9XT2RQB57fEFGf329FJ8KEmscOZkdWQY3z+ENqzBh9Siu
   AEzxlQleoCi2Xx1CGR6RDRW4DHrBoRNIFVqz+pvRJBHTL7NyYLS1BokWb
   ktEUAYX1yCGB2iLEh8gnBcRUTLA4NZ3OcC6aT5KOk4n5SqgwONE39dg9t
   jJhZZXVvcvr/+me5qptbEvO3TTGmUZNPBfwPqXM7rDCQre5q/skKZPGSt
   naLod57IjxyCXrb8T5QYmGYLU48PRbpPC13k64fA69qpXwxm9okVmrpYy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013240"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013240"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775757"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775757"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:11 -0700
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
Subject: [PATCH v3 02/17] iommu: Add nested domain support
Date: Mon, 24 Jul 2023 04:03:51 -0700
Message-Id: <20230724110406.107212-3-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new domain type for a user I/O page table, which is nested
on top of another user space address represented by a UNMANAGED domain. The
mappings of a nested domain are managed by user space software, therefore
it's unnecessary to have map/unmap callbacks. But the updates of the PTEs
in the nested domain page table must be propagated to the caches on both
IOMMU (IOTLB) and devices (DevTLB).

The nested domain is allocated by the domain_alloc_user op, and attached
to the device through the existing iommu_attach_device/group() interfaces.

A new domain op, named cache_invalidate_user is added for the userspace to
flush the hardware caches for a nested domain through iommufd. No wrapper
for it, as it's only supposed to be used by iommufd.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ecbec2627b63..b8f09330b64e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -66,6 +66,9 @@ struct iommu_domain_geometry {
 
 #define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
 
+#define __IOMMU_DOMAIN_NESTED	(1U << 5)  /* User-managed address space nested
+					      on a stage-2 translation        */
+
 #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
 /*
  * This are the possible domain-types
@@ -92,6 +95,7 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
+#define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
 
 struct iommu_domain {
 	unsigned type;
@@ -350,6 +354,10 @@ struct iommu_ops {
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
+ * @cache_invalidate_user: Flush hardware TLBs caching user space IO mappings
+ * @cache_invalidate_user_data_len: Defined length of input user data for the
+ *                                  cache_invalidate_user op, being sizeof the
+ *                                  structure in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
@@ -379,6 +387,9 @@ struct iommu_domain_ops {
 			       size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
+	int (*cache_invalidate_user)(struct iommu_domain *domain,
+				     void *user_data);
+	const size_t cache_invalidate_user_data_len;
 
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
 				    dma_addr_t iova);
-- 
2.34.1

