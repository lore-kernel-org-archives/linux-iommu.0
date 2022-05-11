Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE4CC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ABC883E45;
	Thu, 12 May 2022 03:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rwyQ9_7OGVBv; Thu, 12 May 2022 03:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 361D883E48;
	Thu, 12 May 2022 03:39:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD093C002D;
	Thu, 12 May 2022 03:39:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 556EAC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36C2783E2C
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cjGYd2YFByOn for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:39:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3626883E2E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:30 +0000 (UTC)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220512033926epoutp022acaee52f0af45ec462af27722609fac~uPnCcNxvH0237702377epoutp02n
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220512033926epoutp022acaee52f0af45ec462af27722609fac~uPnCcNxvH0237702377epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652326766;
 bh=eMIWhR8uQtGggYjCDN0lr+lgDTPrOMcUQeBzbQD6iV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=srXitg/gW87AYp9QWqe0xXB+oHnR0+lbckvp9ei43FTkDdvDHsWNIfhk2bxlziEP0
 qifZ7psl/Gj4CD9gFhVnKYJwvZsArk86YmU93zPHJ4U4GWBVK5aZffY3Hi/IrNNQ7+
 Mu4e+IJdUr0X2CVjZEd3RXpEFhOfWOzi0F6y34/U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220512033925epcas5p1a72d6da247e4e61a3d31320ce4f72dba~uPnBekPMX0859208592epcas5p1Y;
 Thu, 12 May 2022 03:39:25 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4KzHZY181Fz4x9Px; Thu, 12 May
 2022 03:39:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 65.A6.09762.2618C726; Thu, 12 May 2022 12:39:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa~uC-gp34bb2407524075epcas5p3B;
 Wed, 11 May 2022 12:14:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220511121433epsmtrp1aeae35ca879f756d5a6c87c4a0991b9a~uC-gntGqD0052800528epsmtrp1F;
 Wed, 11 May 2022 12:14:33 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-27-627c8162efb0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C8.0F.11276.9A8AB726; Wed, 11 May 2022 21:14:33 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121432epsmtip2a8f1106587c26da4260e75da3142b3f9~uC-fJ0j5G0270002700epsmtip2J;
 Wed, 11 May 2022 12:14:32 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Subject: [PATCH V2 2/6] iommu: iova: properly handle 0 as a valid IOVA address
Date: Wed, 11 May 2022 17:45:40 +0530
Message-Id: <20220511121544.5998-3-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmpm5SY02SwaenMhZfT/xmszjw/iCL
 xYN529gsFuy3tuicvYHdYtPja6wWa4/cZbdYtPULu8XBD09YLVrumDpweTw5OI/JY828NYwe
 O2fdZffYtKqTzWPzknqPyTeWM3r0bVnFGMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
 YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
 JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y9uybWwFVzUr3pw4w97A+EOxi5GDQ0LAROLk
 O7EuRi4OIYHdjBKd5z8yQTifGCX+HnzGAuF8Y5ToefsHyOEE63ix/QlU1V5GiUUfl7NCOC1M
 EgundDCDVLEJaEtsm34TrENEoIVRYu40e5AiZoGVjBJLbnWwgySEBQIkHu3czARiswioSixv
 +AzWwCtgI9E3fwo7xDp5idUbDoAN5RSwlZi04y8jyCAJgbfsEus7L7NDfOEi8fWDGES9sMSr
 41ugeqUkXva3QdnVEudu7WeD6O1glOh4uA4qYS9x4MocFpA5zAKaEut36UOEZSWmnloHdhuz
 AJ9E7+8nTBBxXokd80BskLVqEltX+EGEZSTOHLwCVeIh8fgAxCohgQmMEj9W32ecwCg3C2HD
 AkbGVYySqQXFuempxaYFxnmp5fBYS87P3cQIToFa3jsYHz34oHeIkYmD8RCjBAezkgjv/r6K
 JCHelMTKqtSi/Pii0pzU4kOMpsDwm8gsJZqcD0zCeSXxhiaWBiZmZmYmlsZmhkrivKfSNyQK
 CaQnlqRmp6YWpBbB9DFxcEo1MClnmxZv2dXy91r8io0BgUa51y7V/zq8VF1G/lXQpDsR8jwa
 XEUzr0799uvYkzN3QrwMzO1l6rfe27Tl3+qqR5kP9z9dXtB873Jl0CT2K//CzqxpKbyYc+tL
 TbiJcIbQHaPpH17yXhe6zOv2//3um0ek15bHrbxwSyYrVFp2X1jhrQr2EFH2a6nuzue9HDlt
 3myO+bFqf9PlTesL6hNnGuk4lB8z6tVVvt6z82dFY/7B1RZloh9Pz39/9prD8UebWTyXKoZF
 r+2dyS2wuPLVFRU3551ibaGGIgsf7GFXnvr9iFEoh8izCSFl000n7+yWst+/6lXb3xNzXoZ0
 ut3ek3p0goHHnCNijawSnZ8V6ucosRRnJBpqMRcVJwIA7wpDdAoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO7KFdVJBpvuaFh8PfGbzeLA+4Ms
 Fg/mbWOzWLDf2qJz9gZ2i02Pr7FarD1yl91i0dYv7BYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
 7Jx1l91j06pONo/NS+o9Jt9YzujRt2UVYwB7FJdNSmpOZllqkb5dAlfGtmXb2Aquala8OXGG
 vYHxh2IXIyeHhICJxIvtT5hAbCGB3YwS3y4rQMRlJJ7veMoCYQtLrPz3nL2LkQuopolJ4uCD
 jcwgCTYBbYlt02+ygCREBLoYJa5e3csK4jALrGWUeNW4hBGkSljAT+L1ls9sIDaLgKrE8obP
 YGN5BWwk+uZPYYdYIS+xesMBsKmcArYSk3b8ZYQ4yUZizuejzBMY+RYwMqxilEwtKM5Nzy02
 LDDMSy3XK07MLS7NS9dLzs/dxAgOUy3NHYzbV33QO8TIxMF4iFGCg1lJhHd/X0WSEG9KYmVV
 alF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUxWSW9se8KyMwrlDk+4
 ni12MsMs+ssfaTu3+IqrqY+CGQx8YgqWO+91sBXXWd7AZOJpw7ae50VQz/UI8cne5ebin3Uf
 Ts/tPfG19JOI+dQ4URfTR3IsHD/ZN1/bmT1linoo4w+X6G89VneWtLPLm5g9//3I+ONTGV0O
 hzWpx3r+/dUWqNztsfPhltPSVSF5m38wSvya93NmXNnnd7x3fdhNGzsqrDP/sv+YxN4pKXr9
 699nbuIOv0r7LFTXr42r+Pn9gtodOZk1CuH6Gl8nS2g/XXA62eBPULjFJ+VNy15tejFvrcPb
 eS5J72Or2lcbHuGfxdzJzbfj54zdWwS2MinO8ysXqnowoUGqfhrjASWW4oxEQy3mouJEAALs
 3RvCAgAA
X-CMS-MailID: 20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa@epcas5p3.samsung.com>
Cc: pankaj.dubey@samsung.com, alim.akhtar@samsung.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Marek Szyprowski <m.szyprowski@samsung.com>

Zero is a valid DMA and IOVA address on many architectures, so adjust the
IOVA management code to properly handle it. A new value IOVA_BAD_ADDR
(~0UL) is introduced as a generic value for the error case. Adjust all
callers of the alloc_iova_fast() function for the new return value.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/iommu/dma-iommu.c | 16 +++++++++-------
 drivers/iommu/iova.c      | 13 +++++++++----
 include/linux/iova.h      |  1 +
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1ca85d37eeab..16218d6a0703 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -605,7 +605,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long shift, iova_len, iova = 0;
+	unsigned long shift, iova_len, iova = IOVA_BAD_ADDR;
 
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
 		cookie->msi_iova += size;
@@ -625,11 +625,13 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		iova = alloc_iova_fast(iovad, iova_len,
 				       DMA_BIT_MASK(32) >> shift, false);
 
-	if (!iova)
+	if (iova == IOVA_BAD_ADDR)
 		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
 				       true);
 
-	return (dma_addr_t)iova << shift;
+	if (iova != IOVA_BAD_ADDR)
+		return (dma_addr_t)iova << shift;
+	return DMA_MAPPING_ERROR;
 }
 
 static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
@@ -688,7 +690,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	size = iova_align(iovad, size + iova_off);
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
-	if (!iova)
+	if (iova == DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
@@ -799,7 +801,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 
 	size = iova_align(iovad, size);
 	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
-	if (!iova)
+	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_pages;
 
 	if (sg_alloc_table_from_pages(sgt, pages, count, 0, size, GFP_KERNEL))
@@ -1204,7 +1206,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	}
 
 	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
-	if (!iova) {
+	if (iova == DMA_MAPPING_ERROR) {
 		ret = -ENOMEM;
 		goto out_restore_sg;
 	}
@@ -1516,7 +1518,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		return NULL;
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
-	if (!iova)
+	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
 	if (iommu_map(domain, iova, msi_addr, size, prot))
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145..ae0fe0a6714e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -429,6 +429,8 @@ EXPORT_SYMBOL_GPL(free_iova);
  * This function tries to satisfy an iova allocation from the rcache,
  * and falls back to regular allocation on failure. If regular allocation
  * fails too and the flush_rcache flag is set then the rcache will be flushed.
+ * Returns a pfn the allocated iova starts at or IOVA_BAD_ADDR in the case
+ * of a failure.
 */
 unsigned long
 alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
@@ -447,7 +449,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 		size = roundup_pow_of_two(size);
 
 	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
-	if (iova_pfn)
+	if (iova_pfn != IOVA_BAD_ADDR)
 		return iova_pfn;
 
 retry:
@@ -456,7 +458,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 		unsigned int cpu;
 
 		if (!flush_rcache)
-			return 0;
+			return IOVA_BAD_ADDR;
 
 		/* Try replenishing IOVAs by flushing rcache. */
 		flush_rcache = false;
@@ -831,7 +833,7 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 				       unsigned long limit_pfn)
 {
 	struct iova_cpu_rcache *cpu_rcache;
-	unsigned long iova_pfn = 0;
+	unsigned long iova_pfn = IOVA_BAD_ADDR;
 	bool has_pfn = false;
 	unsigned long flags;
 
@@ -858,6 +860,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
 
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 
+	if (!iova_pfn)
+		return IOVA_BAD_ADDR;
+
 	return iova_pfn;
 }
 
@@ -873,7 +878,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 	unsigned int log_size = order_base_2(size);
 
 	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
-		return 0;
+		return IOVA_BAD_ADDR;
 
 	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 320a70e40233..46b5b10c532b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -21,6 +21,7 @@ struct iova {
 	unsigned long	pfn_lo; /* Lowest allocated pfn */
 };
 
+#define IOVA_BAD_ADDR	(~0UL)
 
 struct iova_rcache;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
