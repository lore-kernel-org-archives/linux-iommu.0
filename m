Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEFEC433F5
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 05:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 209B741799;
	Tue, 29 Mar 2022 05:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dzseb8ZmYjS8; Tue, 29 Mar 2022 05:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D4124175D;
	Tue, 29 Mar 2022 05:40:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EBF1C001D;
	Tue, 29 Mar 2022 05:40:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9100C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97A15404F1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id McGGtW9jqV5k for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 05:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCF6F404EE
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648532423; x=1680068423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AnPaIsnG/p3ivIG6I+bXTOQ6EzNmHvly5wxHWTR6dqE=;
 b=iH2gxptkfQscOvWqq/oE/ZBy8AGEhydWitTqHaDi8OOv6B4yre5LEayt
 e3eCDZl3dRcbrIxs/olVXEjucvKmeg1z+fxKK+yaGqhihvN/v+mFxs/Zi
 1GD4hIe9sAlGu15S5O5YC7i3C3CSrbYNRIOs9m79iGgkE+VSWQ6ezMGnN
 4+66DQ+v9EdbKOz9miO75Kp89JUIOyhTOH+iMif6I/5ySmEWFf/2GM/kr
 swvchpSYk/OjZV1RykXXkYygdwPmlcGo7K9CtrsOnhAivKsWsb4YAH1ll
 LIZFYSoj1tFaZLPLci7tqD8MoUWr85naNikQiMaOaPzf+U8DDDKWdUxrs w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239099119"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="239099119"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 22:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; d="scan'208";a="694603589"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Date: Tue, 29 Mar 2022 13:37:52 +0800
Message-Id: <20220329053800.3049561-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
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

Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O page
table which is shared from CPU host VA. Add some helpers to get and
put an SVA domain and implement SVA domain life cycle management.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         |  7 +++
 drivers/iommu/iommu-sva-lib.h | 10 ++++
 drivers/iommu/iommu-sva-lib.c | 89 +++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 36f43af0af53..29c4c2edd706 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct iommu_sva_cookie;
 
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
+	struct iommu_sva_cookie *sva_cookie;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 8909ea1094e3..1a71218b07f5 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -10,6 +10,7 @@
 
 int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
 struct mm_struct *iommu_sva_find(ioasid_t pasid);
+struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
 
 /* I/O Page fault */
 struct device;
@@ -26,6 +27,8 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
+bool iommu_sva_domain_get_user(struct iommu_domain *domain);
+void iommu_sva_domain_put_user(struct iommu_domain *domain);
 
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
@@ -63,5 +66,12 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 {
 	return -ENODEV;
 }
+
+static inline bool iommu_sva_domain_get_user(struct iommu_domain *domain)
+{
+	return false;
+}
+
+static inline void iommu_sva_domain_put_user(struct iommu_domain *domain) { }
 #endif /* CONFIG_IOMMU_SVA */
 #endif /* _IOMMU_SVA_LIB_H */
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..78820be23f15 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -3,12 +3,21 @@
  * Helpers for IOMMU drivers implementing SVA
  */
 #include <linux/mutex.h>
+#include <linux/iommu.h>
+#include <linux/slab.h>
 #include <linux/sched/mm.h>
 
 #include "iommu-sva-lib.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
 static DECLARE_IOASID_SET(iommu_sva_pasid);
+static DEFINE_XARRAY_ALLOC(sva_domain_array);
+
+struct iommu_sva_cookie {
+	struct mm_struct *mm;
+	ioasid_t pasid;
+	refcount_t users;
+};
 
 /**
  * iommu_sva_alloc_pasid - Allocate a PASID for the mm
@@ -69,3 +78,83 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
+
+static struct iommu_domain *
+iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
+{
+	struct bus_type *bus = dev->bus;
+	struct iommu_sva_cookie *cookie;
+	struct iommu_domain *domain;
+	void *curr;
+
+	if (!bus || !bus->iommu_ops)
+		return NULL;
+
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	if (!cookie)
+		return NULL;
+
+	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!domain)
+		goto err_domain_alloc;
+
+	cookie->mm = mm;
+	cookie->pasid = mm->pasid;
+	refcount_set(&cookie->users, 1);
+	domain->type = IOMMU_DOMAIN_SVA;
+	domain->sva_cookie = cookie;
+	curr = xa_store(&sva_domain_array, mm->pasid, domain, GFP_KERNEL);
+	if (xa_err(curr))
+		goto err_xa_store;
+
+	return domain;
+err_xa_store:
+	domain->ops->free(domain);
+err_domain_alloc:
+	kfree(cookie);
+	return NULL;
+}
+
+static void iommu_sva_free_domain(struct iommu_domain *domain)
+{
+	xa_erase(&sva_domain_array, domain->sva_cookie->pasid);
+	kfree(domain->sva_cookie);
+	domain->ops->free(domain);
+}
+
+bool iommu_sva_domain_get_user(struct iommu_domain *domain)
+{
+	struct iommu_sva_cookie *cookie = domain->sva_cookie;
+
+	return refcount_inc_not_zero(&cookie->users);
+}
+
+void iommu_sva_domain_put_user(struct iommu_domain *domain)
+{
+	struct iommu_sva_cookie *cookie = domain->sva_cookie;
+
+	if (refcount_dec_and_test(&cookie->users))
+		iommu_sva_free_domain(domain);
+}
+
+static __maybe_unused struct iommu_domain *
+iommu_sva_get_domain(struct device *dev, struct mm_struct *mm)
+{
+	struct iommu_domain *domain;
+	ioasid_t pasid = mm->pasid;
+
+	if (pasid == INVALID_IOASID)
+		return NULL;
+
+	domain = xa_load(&sva_domain_array, pasid);
+	if (!domain)
+		return iommu_sva_alloc_domain(dev, mm);
+	iommu_sva_domain_get_user(domain);
+
+	return domain;
+}
+
+struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain)
+{
+	return domain->sva_cookie->mm;
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
