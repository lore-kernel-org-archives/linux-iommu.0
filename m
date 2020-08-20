Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B62C433E4
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:09:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3496A2184D
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 15:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3496A2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3FEE88185;
	Thu, 20 Aug 2020 15:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGWDi3hj73G4; Thu, 20 Aug 2020 15:09:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A57C87E88;
	Thu, 20 Aug 2020 15:09:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23B6BC07FF;
	Thu, 20 Aug 2020 15:09:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E873C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1B381203F6
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:09:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3H9GYfA9fGC3 for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 15:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id E9C0B204FE
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 15:09:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09BE1106F;
 Thu, 20 Aug 2020 08:09:09 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C78F3F6CF;
 Thu, 20 Aug 2020 08:09:05 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	joro@8bytes.org,
	linux@armlinux.org.uk
Subject: [PATCH 04/18] iommu/dma: Add temporary hacks for arch/arm
Date: Thu, 20 Aug 2020 16:08:23 +0100
Message-Id: <dd49f2e7873820fd215165d9facd523d0c1f5d11.1597931876.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1597931875.git.robin.murphy@arm.com>
References: <cover.1597931875.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, digetx@gmail.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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

In order to wrangle arch/arm over to iommu_dma_ops, we first need to
convert all its associated IOMMU drivers over to default domains, and
deal with users of its public dma_iommu_mappinng API. Since that can't
reasonably be done in a single patch, we've no choice but to go through
an ugly transitional phase. That starts with exposing some hooks into
iommu-dma's internals so that it can start to do most of the heavy
lifting.

Before you start thinking about how horrible that is, here's a zebra:
  ,
 c@
  `||||)\
   <  /

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..ab157d155bf7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -25,6 +25,19 @@
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
 
+#ifdef CONFIG_ARM
+#include <asm/dma-iommu.h>
+#endif
+static struct iommu_domain *__iommu_get_dma_domain(struct device *dev)
+{
+#ifdef CONFIG_ARM
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	if (mapping)
+		return mapping->domain;
+#endif
+	return iommu_get_dma_domain(dev);
+}
+
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
@@ -298,8 +311,11 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
  * avoid rounding surprises. If necessary, we reserve the page at address 0
  * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
  * any change which could make prior IOVAs invalid will fail.
+ *
+ * XXX: Not formally exported, but needs to be referenced
+ * from arch/arm/mm/dma-mapping.c temporarily
  */
-static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
+int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -456,7 +472,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 		size_t size)
 {
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_domain *domain = __iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, dma_addr);
@@ -478,7 +494,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_domain *domain = __iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, phys);
@@ -582,7 +598,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_domain *domain = __iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	bool coherent = dev_is_dma_coherent(dev);
@@ -678,7 +694,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 	if (dev_is_dma_coherent(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
+	phys = iommu_iova_to_phys(__iommu_get_dma_domain(dev), dma_handle);
 	arch_sync_dma_for_cpu(phys, size, dir);
 }
 
@@ -690,7 +706,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 	if (dev_is_dma_coherent(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
+	phys = iommu_iova_to_phys(__iommu_get_dma_domain(dev), dma_handle);
 	arch_sync_dma_for_device(phys, size, dir);
 }
 
@@ -831,7 +847,7 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_domain *domain = __iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
@@ -1112,12 +1128,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
 {
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_domain *domain = __iommu_get_dma_domain(dev);
 
 	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
 }
 
-static const struct dma_map_ops iommu_dma_ops = {
+/*
+ * XXX: Not formally exported, but needs to be referenced
+ * from arch/arm/mm/dma-mapping.c temporarily
+ */
+const struct dma_map_ops iommu_dma_ops = {
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.mmap			= iommu_dma_mmap,
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
