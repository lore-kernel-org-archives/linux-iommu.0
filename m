Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA10CC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66A2140B6E;
	Thu, 12 May 2022 03:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WuvoZv9O2mQj; Thu, 12 May 2022 03:39:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B5B3400B8;
	Thu, 12 May 2022 03:39:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFE12C0032;
	Thu, 12 May 2022 03:39:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4F26C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8056160BCA
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PP7sN-7EorSF for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F15460C0B
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:35 +0000 (UTC)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220512033932epoutp02d447b52fbbfdae9314452c6ee54ec1b0~uPnIMhMKL0304003040epoutp02X
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220512033932epoutp02d447b52fbbfdae9314452c6ee54ec1b0~uPnIMhMKL0304003040epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652326772;
 bh=h69GhjZ5aQZdvqmbJl+5HwMeprWIkkzTRr4CCQEkMTI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oKTRHIEluYU9doT34m43BIwStkKE1BaRVK3wBktBn/65iQbfubylcpH9UOsztVg79
 /KsxNzYCiXs/BAjwRbh9qBFXQ9vFScL7JFSAOt8MPBDQVevV9V3AdlfZMo6b7a5TOO
 ice86Pbm4sZIpqHmpF656S2ZV39yzRkmqMcYcVVM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220512033932epcas5p4ede7a161facac8a73dcee0ae0a2962bd~uPnHzgtbp1491014910epcas5p4i;
 Thu, 12 May 2022 03:39:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4KzHZk2jWWz4x9Pv; Thu, 12 May
 2022 03:39:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FF.A6.09762.C618C726; Thu, 12 May 2022 12:39:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20220511121439epcas5p493bf4b94c89c8a63fdc0586c89cea8df~uC-malgwA0360503605epcas5p4H;
 Wed, 11 May 2022 12:14:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220511121439epsmtrp232ded29eef6efdabdb915cd61665d55c~uC-mZvp9w1138811388epsmtrp2L;
 Wed, 11 May 2022 12:14:39 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-4b-627c816cc608
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 7D.09.08924.FA8AB726; Wed, 11 May 2022 21:14:39 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121438epsmtip29e536aedf6377692454be9516421f599~uC-k4pH6S0609306093epsmtip2r;
 Wed, 11 May 2022 12:14:38 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Subject: [PATCH V2 4/6] iommu: dma-iommu: refactor iommu_dma_alloc_iova()
Date: Wed, 11 May 2022 17:45:42 +0530
Message-Id: <20220511121544.5998-5-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmpm5uY02Swe1DTBZfT/xmszjw/iCL
 xYN529gsFuy3tuicvYHdYtPja6wWa4/cZbdYtPULu8XBD09YLVrumDpweTw5OI/JY828NYwe
 O2fdZffYtKqTzWPzknqPyTeWM3r0bVnFGMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
 YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
 JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE741XvJqaCM2oVvdM+sDYwdit0MXJySAiYSJzd
 s4Oli5GLQ0hgN6PE4ke/2CCcT4wSzxadZodwPjNKTN7fyAjTsql1CStEYhejxJQNW5ggnBYm
 iRsHrjOBVLEJaEtsm36TBcQWEWhhlJg7zR6kiFlgJaPEklsd7CAJYQFPiXsN38CKWARUJZp2
 fWQDsXkFbCT2bXjHDrFOXmL1hgPMIDangK3EpB1/GUEGSQh8ZJdY2/qdBaLIRaJ/+z4oW1ji
 1fEtUM1SEp/f7WWDsKslzt3azwbR3MEo0fFwHVSRvcSBK3OAmjmAztOUWL9LHyIsKzH11Dqw
 b5gF+CR6fz9hgojzSuyYB2JzANlqEltX+EGEZSTOHLwCVeIhcWnlPGioTGCUmNhzk3kCo9ws
 hA0LGBlXMUqmFhTnpqcWmxYY56WWw+MtOT93EyM4DWp572B89OCD3iFGJg7GQ4wSHMxKIrz7
 +yqShHhTEiurUovy44tKc1KLDzGaAgNwIrOUaHI+MBHnlcQbmlgamJiZmZlYGpsZKonznkrf
 kCgkkJ5YkpqdmlqQWgTTx8TBKdXA1P8gNaa+705km4x9dr97wD21w5VxxltW6Hb1zHZsu9sr
 VXTYbodcU0zEop71e941PGH8vvj79DP/3BoLpATy5n9+5PP8wXHTWzUv1l3i2nxt/2kdkaav
 aR+37ZQt6tijWjJJ6v0MK411dfUhucVpE14ejFV+daJloXYWh8sinZCtZ1uiZPk+fEyduu1V
 qXDFuSNqhbY/uo2nzMhr/f394vOjZc5h12dfCo8zPu4st2XNsp9bHhn1Oq405p22NeXZUpMZ
 Bn+fuQgt6n90n+9TGONfy7Ja/YQ/v7afn8BhIcL2SlXttN/TBs0L/xiv79KU7PYyfvbCx+pP
 uSJfhLPISzdukWcz5/iufPFrzTGBmUosxRmJhlrMRcWJAFLlqqkMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO76FdVJBj/PGFt8PfGbzeLA+4Ms
 Fg/mbWOzWLDf2qJz9gZ2i02Pr7FarD1yl91i0dYv7BYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
 7Jx1l91j06pONo/NS+o9Jt9YzujRt2UVYwB7FJdNSmpOZllqkb5dAlfGq95NTAVn1Cp6p31g
 bWDsVuhi5OSQEDCR2NS6hBXEFhLYwSjRu0UMIi4j8XzHUxYIW1hi5b/n7F2MXEA1TUwSHU3/
 GUESbALaEtum32QBSYgIdDFKXL26lxXEYRZYyyjxqnEJWJWwgKfEvYZvYKNYBFQlmnZ9ZAOx
 eQVsJPZteMcOsUJeYvWGA8wgNqeArcSkHX8ZIU6ykZjz+SjzBEa+BYwMqxglUwuKc9Nziw0L
 jPJSy/WKE3OLS/PS9ZLzczcxgsNUS2sH455VH/QOMTJxMB5ilOBgVhLh3d9XkSTEm5JYWZVa
 lB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU75Ema9ZR8HUPeJWt8z+
 zSh/tnvyJQtX2S6HF9buPjw+8zuW//L186+OWzzhxuVXHt7GSX0p/9k0lvBOD06oudvZtGN1
 s9s+1fm3YuLE2d9fX5WhvujWQhejPwUdx9rWtVRx2K2+9dHeuDE2zmtVskXrLRGfmTtL8uqe
 bA+ZOf9U+0xrOSeTe6vvbrz70uqW++cnjzbWrNlcM1Fhk8e2lw13iqaYfT1+xilJ1M+zfWHY
 hCVTPR/fvTY52HmVVeP3PeynI6Y/2CzXrTKnb2rpyoLzXYdbTjY/+f517STXlsKpjJlixlbz
 k39rxE35K6H98dF51zsPZu291vmT87rtUeuLvZLpKx/aF57pDC7rm6DEUpyRaKjFXFScCAA6
 g3LUwgIAAA==
X-CMS-MailID: 20220511121439epcas5p493bf4b94c89c8a63fdc0586c89cea8df
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511121439epcas5p493bf4b94c89c8a63fdc0586c89cea8df
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121439epcas5p493bf4b94c89c8a63fdc0586c89cea8df@epcas5p4.samsung.com>
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

Change the parameters passed to iommu_dma_alloc_iova(): the dma_limit can
be easily extracted from the parameters of the passed struct device, so
replace it with a flags parameter, which can later hold more information
about the way the IOVA allocator should do it job. While touching the
parameter list, move struct device to the second position to better match
the convention of the DMA-mapping related functions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/iommu/dma-iommu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 16218d6a0703..cb235b40303c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -600,12 +600,16 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
+#define DMA_ALLOC_IOVA_COHERENT		BIT(0)
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
-		size_t size, u64 dma_limit, struct device *dev)
+		struct device *dev, size_t size, unsigned int flags)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long shift, iova_len, iova = IOVA_BAD_ADDR;
+	u64 dma_limit = (flags & DMA_ALLOC_IOVA_COHERENT) ?
+			dev->coherent_dma_mask : dma_get_mask(dev);
 
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
 		cookie->msi_iova += size;
@@ -675,7 +679,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, u64 dma_mask)
+		size_t size, int prot, unsigned int flags)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -689,7 +693,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	size = iova_align(iovad, size + iova_off);
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+	iova = iommu_dma_alloc_iova(domain, dev, size, flags);
 	if (iova == DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
@@ -800,7 +804,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		return NULL;
 
 	size = iova_align(iovad, size);
-	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+	iova = iommu_dma_alloc_iova(domain, dev, size, DMA_ALLOC_IOVA_COHERENT);
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_pages;
 
@@ -963,7 +967,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	dma_addr_t iova, dma_mask = dma_get_mask(dev);
+	dma_addr_t iova;
 
 	/*
 	 * If both the physical buffer start address and size are
@@ -1001,7 +1005,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, size, prot, 0);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
@@ -1205,7 +1209,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, dev, iova_len, 0);
 	if (iova == DMA_MAPPING_ERROR) {
 		ret = -ENOMEM;
 		goto out_restore_sg;
@@ -1264,8 +1268,7 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			dma_get_mask(dev));
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO, 0);
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -1375,7 +1378,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		return NULL;
 
 	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
-			dev->coherent_dma_mask);
+			DMA_ALLOC_IOVA_COHERENT);
 	if (*handle == DMA_MAPPING_ERROR) {
 		__iommu_dma_free(dev, size, cpu_addr);
 		return NULL;
@@ -1517,7 +1520,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, dev, size, 0);
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
