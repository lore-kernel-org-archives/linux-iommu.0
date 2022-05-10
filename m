Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D93BC433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 06:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E451E8199D;
	Tue, 10 May 2022 06:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uEyFhX7rUhaI; Tue, 10 May 2022 06:21:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C79908194C;
	Tue, 10 May 2022 06:21:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99B26C0039;
	Tue, 10 May 2022 06:21:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4965DC0039
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D533D819C8
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hkZfV4NpVFYu for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 06:21:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 364168191E
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 06:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652163672; x=1683699672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VjhNoKI6MtW1lOMCYZbpbYvPa5VAnC2OCUg7RydhhmI=;
 b=efSyjXrLxgOP88zxyAB8Fh6bqgd6SSFmPFMrvCwgSkHD+nJZMgjWXwVs
 gl66vlLEqJ5sZyxUKwfIRcFhFerLyGCEIsETDAvBlgrjQKSA1FQlYODRN
 dN+Da55lHyAFRiD0vbh2Mto9OFxjrVpfPU0IBCdmjeeor7vdHu05fQ/IN
 Zbw92ivZp6WaZ6q2mUIe88WZ0DBmZ/vX8A2OkRK5phUy8tCcJVky0y421
 lokbrYnR0NKP+pCe6Ztha8oC6Ne0A9+nu9UvsxgRY1r0cOZz61DcClhSy
 REOys9yQWoALMqjZFk4EcMzyBKTkuQ9sI0uyUQX3/EYdj4UTX6QPg4JM/ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266863688"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266863688"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 23:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="552636440"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:21:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 04/12] iommu/sva: Basic data structures for SVA
Date: Tue, 10 May 2022 14:17:30 +0800
Message-Id: <20220510061738.2761430-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

- struct iommu_domain (IOMMU_DOMAIN_SVA type)
  Represent a hardware pagetable that the IOMMU hardware could use for
  SVA translation. Multiple iommu domains could be bound with an SVA mm
  and each grabs a mm_count of the mm in order to make sure mm could
  only be freed after all domains have been unbound. A new mm field is
  added to struct iommu_domain and a helper is added to retrieve mm from
  a domain pointer.

- struct iommu_sva (existing)
  Represent a bond relationship between an SVA ioas and an iommu domain.
  If a bond already exists, it's reused and a reference is taken.

- struct dev_iommu::sva_bonds
  A pasid-indexed xarray to track the bonds happened on the device.

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 13 +++++++++++++
 drivers/iommu/iommu.c |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ab36244d4e94..2921e634491e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,9 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
+#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
+#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
+
 /*
  * This are the possible domain-types
  *
@@ -86,6 +89,8 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
+				 __IOMMU_DOMAIN_HOST_VA)
 
 struct iommu_domain {
 	unsigned type;
@@ -95,6 +100,9 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+#ifdef CONFIG_IOMMU_SVA
+	struct mm_struct *mm;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -380,6 +388,9 @@ struct dev_iommu {
 	struct iommu_device		*iommu_dev;
 	void				*priv;
 	unsigned int			pasid_bits;
+#ifdef CONFIG_IOMMU_SVA
+	struct xarray			sva_bonds;
+#endif
 };
 
 int iommu_device_register(struct iommu_device *iommu,
@@ -629,6 +640,8 @@ struct iommu_fwspec {
  */
 struct iommu_sva {
 	struct device			*dev;
+	struct iommu_domain		*domain;
+	refcount_t			users;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 16e8db2d86fc..1abff5fc9554 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -202,6 +202,9 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 		return NULL;
 
 	mutex_init(&param->lock);
+#ifdef CONFIG_IOMMU_SVA
+	xa_init(&param->sva_bonds);
+#endif
 	dev->iommu = param;
 	return param;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
