Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5CDC433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 05:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 056D560B15;
	Thu, 21 Apr 2022 05:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kWBxaAIQimV1; Thu, 21 Apr 2022 05:24:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8E1560EDE;
	Thu, 21 Apr 2022 05:24:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B69BC002F;
	Thu, 21 Apr 2022 05:24:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E695C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 05:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D87941998
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 05:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XQVQU25DlN1v for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 05:24:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66C4A4199F
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 05:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650518661; x=1682054661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oOm9XxSAvjsIn2c8MokEAyzVLqoj5HVQWpjQQnLfMOk=;
 b=QeWFdXK8gYIPCzlw8v3fAr+eyXWaVU3nwtvkIkHj0uZPyGQ5E/wuq1UZ
 HauOMZEAahbDN9h1WFInV4sZWtO/8S8WrzUgcTZPxPW5X2clUIxXR9bXx
 3g6rYuvOKfkycO7uTMpGOyUuDBxMpqAL4T54zdgq+B3PcURhkI4IUfeqY
 DsH5Skstd4r6ziG5q+z6NFEcziTmATtV4WEye/owZ5+b+SF/jnS/txDB0
 0pjSJ51YvXzmaqi+wfz7DNT4AGXIoitJn0PRVPDOQ3sASXEOyOyayHpQk
 c5Yq2TFKuZuXc1q9496RYjFliQ4zKPiUkpA/7qJNzAbiEui6hqQIELczQ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244176708"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; d="scan'208";a="244176708"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2022 22:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; d="scan'208";a="702944112"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 22:24:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v4 04/12] iommu/sva: Basic data structures for SVA
Date: Thu, 21 Apr 2022 13:21:13 +0800
Message-Id: <20220421052121.3464100-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Use below data structures for SVA implementation in the IOMMU core:

- struct iommu_sva_ioas
  Represent the I/O address space shared with an application CPU address
  space. This structure has a 1:1 relationship with an mm_struct. It
  grabs a "mm->mm_count" refcount during creation and drop it on release.

- struct iommu_domain (IOMMU_DOMAIN_SVA type)
  Represent a hardware pagetable that the IOMMU hardware could use for
  SVA translation. Multiple iommu domains could be bound with an SVA ioas
  and each grabs a refcount from ioas in order to make sure ioas could
  only be freed after all domains have been unbound.

- struct iommu_sva
  Represent a bond relationship between an SVA ioas and an iommu domain.
  If a bond already exists, it's reused and a reference is taken.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         | 14 +++++++++++++-
 drivers/iommu/iommu-sva-lib.h |  1 +
 drivers/iommu/iommu-sva-lib.c | 18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fe7d9ee2bc2b..14c3b2197b35 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct iommu_sva_ioas;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -64,6 +65,9 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
+#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
+#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
+
 /*
  * This are the possible domain-types
  *
@@ -86,6 +90,8 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
+				 __IOMMU_DOMAIN_HOST_VA)
 
 struct iommu_domain {
 	unsigned type;
@@ -95,6 +101,7 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	struct iommu_sva_ioas *sva_ioas;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -622,7 +629,12 @@ struct iommu_fwspec {
  * struct iommu_sva - handle to a device-mm bond
  */
 struct iommu_sva {
-	struct device			*dev;
+	struct device		*dev;
+	struct iommu_sva_ioas	*sva_ioas;
+	struct iommu_domain	*domain;
+	/* Link to sva ioas's bonds list */
+	struct list_head	node;
+	refcount_t		users;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 8909ea1094e3..9c5e108e2c8a 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -10,6 +10,7 @@
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
+struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
 
 /* I/O Page fault */
 struct device;
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..d524a402be3b 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -3,6 +3,8 @@
  * Helpers for IOMMU drivers implementing SVA
  */
 #include <linux/mutex.h>
+#include <linux/iommu.h>
+#include <linux/slab.h>
 #include <linux/sched/mm.h>
 
 #include "iommu-sva-lib.h"
@@ -10,6 +12,22 @@
 static DEFINE_MUTEX(iommu_sva_lock);
 static DECLARE_IOASID_SET(iommu_sva_pasid);
 
+struct iommu_sva_ioas {
+	struct mm_struct *mm;
+	ioasid_t pasid;
+
+	/* Counter of domains attached to this ioas. */
+	refcount_t users;
+
+	/* All bindings are linked here. */
+	struct list_head bonds;
+};
+
+struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain)
+{
+	return domain->sva_ioas->mm;
+}
+
 /**
  * iommu_sva_alloc_pasid - Allocate a PASID for the mm
  * @mm: the mm
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
