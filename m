Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E8FC3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 20:11:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248C62086C
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 20:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248C62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E99F01293;
	Thu, 15 Aug 2019 20:09:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B2BDD125E
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 20:09:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 50C9D8A7
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 20:09:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Aug 2019 13:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; d="scan'208";a="188596215"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 13:09:42 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 06/19] iommu: Introduce cache_invalidate API
Date: Thu, 15 Aug 2019 13:13:12 -0700
Message-Id: <1565900005-62508-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Yi L Liu <yi.l.liu@linux.intel.com>

In any virtualization use case, when the first translation stage
is "owned" by the guest OS, the host IOMMU driver has no knowledge
of caching structure updates unless the guest invalidation activities
are trapped by the virtualizer and passed down to the host.

Since the invalidation data are obtained from user space and will be
written into physical IOMMU, we must allow security check at various
layers. Therefore, generic invalidation data format are proposed here,
model specific IOMMU drivers need to convert them into their own format.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c      |  10 +++++
 include/linux/iommu.h      |  14 ++++++
 include/uapi/linux/iommu.h | 110 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 155ebef..6228d5d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1719,6 +1719,16 @@ void iommu_detach_pasid_table(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
 
+int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+			   struct iommu_cache_invalidate_info *inv_info)
+{
+	if (unlikely(!domain->ops->cache_invalidate))
+		return -ENODEV;
+
+	return domain->ops->cache_invalidate(domain, dev, inv_info);
+}
+EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8c64065..28f1a8c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -230,6 +230,7 @@ struct iommu_sva_ops {
  * @page_response: handle page request response
  * @attach_pasid_table: attach a pasid table
  * @detach_pasid_table: detach the pasid table
+ * @cache_invalidate: invalidate translation caches
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -296,6 +297,8 @@ struct iommu_ops {
 	int (*page_response)(struct device *dev,
 			     struct iommu_fault_event *evt,
 			     struct iommu_page_response *msg);
+	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
+				struct iommu_cache_invalidate_info *inv_info);
 
 	unsigned long pgsize_bitmap;
 };
@@ -407,6 +410,9 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 extern int iommu_attach_pasid_table(struct iommu_domain *domain,
 				    struct iommu_pasid_table_config *cfg);
 extern void iommu_detach_pasid_table(struct iommu_domain *domain);
+extern int iommu_cache_invalidate(struct iommu_domain *domain,
+				  struct device *dev,
+				  struct iommu_cache_invalidate_info *inv_info);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -959,6 +965,14 @@ int iommu_attach_pasid_table(struct iommu_domain *domain,
 static inline
 void iommu_detach_pasid_table(struct iommu_domain *domain) {}
 
+static inline int
+iommu_cache_invalidate(struct iommu_domain *domain,
+		       struct device *dev,
+		       struct iommu_cache_invalidate_info *inv_info)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 0f9d249..919ea02 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -203,4 +203,114 @@ struct iommu_pasid_table_config {
 	};
 };
 
+/* defines the granularity of the invalidation */
+enum iommu_inv_granularity {
+	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective invalidation */
+	IOMMU_INV_GRANU_PASID,	/* PASID-selective invalidation */
+	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation */
+	IOMMU_INV_GRANU_NR,	/* number of invalidation granularities */
+};
+
+/**
+ * struct iommu_inv_addr_info - Address Selective Invalidation Structure
+ *
+ * @flags: indicates the granularity of the address-selective invalidation
+ * - If the PASID bit is set, the @pasid field is populated and the invalidation
+ *   relates to cache entries tagged with this PASID and matching the address
+ *   range.
+ * - If ARCHID bit is set, @archid is populated and the invalidation relates
+ *   to cache entries tagged with this architecture specific ID and matching
+ *   the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - If neither PASID or ARCHID is set, global addr invalidation applies.
+ * - The LEAF flag indicates whether only the leaf PTE caching needs to be
+ *   invalidated and other paging structure caches can be preserved.
+ * @archid: architecture-specific ID
+ * @pasid: process address space ID
+ * @addr: first stage/level input address
+ * @granule_size: page/block size of the mapping in bytes
+ * @nb_granules: number of contiguous granules to be invalidated
+ */
+struct iommu_inv_addr_info {
+#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
+#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
+#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
+	__u32	flags;
+	__u32	archid;
+	__u64	pasid;
+	__u64	addr;
+	__u64	granule_size;
+	__u64	nb_granules;
+};
+
+/**
+ * struct iommu_inv_pasid_info - PASID Selective Invalidation Structure
+ *
+ * @flags: indicates the granularity of the PASID-selective invalidation
+ * - If the PASID bit is set, the @pasid field is populated and the invalidation
+ *   relates to cache entries tagged with this PASID and matching the address
+ *   range.
+ * - If the ARCHID bit is set, the @archid is populated and the invalidation
+ *   relates to cache entries tagged with this architecture specific ID and
+ *   matching the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - At least one of PASID or ARCHID must be set.
+ * @archid: architecture-specific ID
+ * @pasid: process address space ID
+ */
+struct iommu_inv_pasid_info {
+#define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
+#define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
+	__u32	flags;
+	__u32	archid;
+	__u64	pasid;
+};
+
+/**
+ * struct iommu_cache_invalidate_info - First level/stage invalidation
+ *     information
+ * @version: API version of this structure
+ * @cache: bitfield that allows to select which caches to invalidate
+ * @granularity: defines the lowest granularity used for the invalidation:
+ *     domain > PASID > addr
+ * @padding: reserved for future use (should be zero)
+ * @pasid_info: invalidation data when @granularity is %IOMMU_INV_GRANU_PASID
+ * @addr_info: invalidation data when @granularity is %IOMMU_INV_GRANU_ADDR
+ *
+ * Not all the combinations of cache/granularity are valid:
+ *
+ * +--------------+---------------+---------------+---------------+
+ * | type /       |   DEV_IOTLB   |     IOTLB     |      PASID    |
+ * | granularity  |               |               |      cache    |
+ * +==============+===============+===============+===============+
+ * | DOMAIN       |       N/A     |       Y       |       Y       |
+ * +--------------+---------------+---------------+---------------+
+ * | PASID        |       Y       |       Y       |       Y       |
+ * +--------------+---------------+---------------+---------------+
+ * | ADDR         |       Y       |       Y       |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ *
+ * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument other than
+ * @version and @cache.
+ *
+ * If multiple cache types are invalidated simultaneously, they all
+ * must support the used granularity.
+ */
+struct iommu_cache_invalidate_info {
+#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
+	__u32	version;
+/* IOMMU paging structure cache */
+#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
+#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
+#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
+#define IOMMU_CACHE_INV_TYPE_NR		(3)
+	__u8	cache;
+	__u8	granularity;
+	__u8	padding[2];
+	union {
+		struct iommu_inv_pasid_info pasid_info;
+		struct iommu_inv_addr_info addr_info;
+	};
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
