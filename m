Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A5BC433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE872418DD;
	Thu, 12 May 2022 03:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TJu08dmJ26a5; Thu, 12 May 2022 03:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 465BC41894;
	Thu, 12 May 2022 03:39:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FF1BC0032;
	Thu, 12 May 2022 03:39:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23EABC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2029E83E2E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4l2zuHgwpSgw for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06D8E83E35
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:38 +0000 (UTC)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220512033936epoutp042adaedd2a1aab328f49a2b719ed418bc~uPnLzNPIh0339303393epoutp04e
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220512033936epoutp042adaedd2a1aab328f49a2b719ed418bc~uPnLzNPIh0339303393epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652326776;
 bh=WjTsAdrWY0dkWNLPOOO99vSBJV7TfrewI9JGJplTWM4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MSB0hfbwdDDkJNT4NyP+Anc3OSZNztr65dmlwqM1njYmeUFUKDMR07MEZRCgamT/r
 rvwEwrQAEWutH98CBwwhyfgI2ZFlZEnYbw5cZfrSZ2/rxaVfJ/jhayrDZKCgEnq3l4
 6xINGO25FPFaWnplJ96keo0G9yk190zfr5OZ9LbA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20220512033936epcas5p105cccb9f2038d669a9a6b500bc4d051a~uPnLU3npb0859208592epcas5p1n;
 Thu, 12 May 2022 03:39:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4KzHZr1mLvz4x9Pp; Thu, 12 May
 2022 03:39:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B3.B6.09762.2718C726; Thu, 12 May 2022 12:39:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121442epcas5p26a997a19e8cc1de8eb23123500fb24fb~uC-pOfXzZ2113521135epcas5p2W;
 Wed, 11 May 2022 12:14:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220511121442epsmtrp26c0f0b618540a4848d536252f9dfa2c0~uC-pMwltY1138811388epsmtrp2N;
 Wed, 11 May 2022 12:14:42 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-59-627c81728975
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5E.09.08924.2B8AB726; Wed, 11 May 2022 21:14:42 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121441epsmtip2107e93ffb66f1250543c55022b8874ac~uC-npuxsZ0495604956epsmtip2x;
 Wed, 11 May 2022 12:14:41 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Subject: [PATCH V2 5/6] iommu: dma-iommu: add support for DMA_ATTR_LOW_ADDRESS
Date: Wed, 11 May 2022 17:45:43 +0530
Message-Id: <20220511121544.5998-6-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmpm5RY02SwddL/BZfT/xmszjw/iCL
 xYN529gsFuy3tuicvYHdYtPja6wWa4/cZbdYtPULu8XBD09YLVrumDpweTw5OI/JY828NYwe
 O2fdZffYtKqTzWPzknqPyTeWM3r0bVnFGMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
 YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
 JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE749a6eYwFa/Urep+/YWlgnKfexcjJISFgIrFw
 1wXGLkYuDiGB3YwS0z/8ZoFwPjFKzJ92lxnC+QyUedvJAtOy78wTVhBbSGAXo8Sl1XoQRS1M
 Etfm32QCSbAJaEtsm34TrEFEoIVRYu40e5AiZoGVjBJLbnWwgySEBQIk7vQ8BrNZBFQl9n65
 AjaVV8BG4v3Ty8wQ2+QlVm84AGZzCthKTNrxF+xYCYGP7BILp79m62LkAHJcJFomB0DUC0u8
 Or6FHcKWkvj8bi8bhF0tce7WfjaI3g5GiY6H66CK7CUOXJnDAjKHWUBTYv0ufYiwrMTUU+vA
 nmEW4JPo/f2ECSLOK7FjHogNslZNYusKP4iwjMSZg1egSjwkVu45wQoJlAmMEts/TGGcwCg3
 C2HDAkbGVYySqQXFuempxaYFxnmp5fBYS87P3cQIToFa3jsYHz34oHeIkYmD8RCjBAezkgjv
 /r6KJCHelMTKqtSi/Pii0pzU4kOMpsDwm8gsJZqcD0zCeSXxhiaWBiZmZmYmlsZmhkrivKfS
 NyQKCaQnlqRmp6YWpBbB9DFxcEo1MAn1qSQu3Jj85IaXdViC36JL09Jvz/ru8SHZ+Geb1rrn
 lVNU1nr/uHYuSXDpkUtNfhcqzwsUbFySd3Rdyizb6lOL5HdU9lkcqswW1fJQuFhSnbswOOVY
 g4k085OaFwu3F/OuY8jtTk3e9Pme8YaZrH1rOvU1/tWuaHq37NFFg4vnNeIzPsu3zjt35FoZ
 37aDQje9LGbF9ynpnvjvzcLM8cAz8Yq8m22hVjuHfOvkzc01pqWB01ee0c6QaJldfS6978u5
 B8/uO3LFfQixqk4JbJn7tc0xV8O65syJxqunPNor8hKm2z/bsP3Egz4Bdr24tpis4BkftE+v
 /rI+x5DhBN/dnmd39vCXls41qD73WYmlOCPRUIu5qDgRAFH+GiYKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO6mFdVJBlc7DC2+nvjNZnHg/UEW
 iwfztrFZLNhvbdE5ewO7xabH11gt1h65y26xaOsXdouDH56wWrTcMXXg8nhycB6Tx5p5axg9
 ds66y+6xaVUnm8fmJfUek28sZ/To27KKMYA9issmJTUnsyy1SN8ugSvj1rp5jAVr9St6n79h
 aWCcp97FyMkhIWAise/ME9YuRi4OIYEdjBKtL68wQSRkJJ7veMoCYQtLrPz3nB2iqIlJYnHv
 R3aQBJuAtsS26TdZQBIiAl2MElev7gUbxSywllHiVeMSRpAqYQE/icOn+8A6WARUJfZ+ucIK
 YvMK2Ei8f3qZGWKFvMTqDQfAbE4BW4lJO/6C9QoB1cz5fJR5AiPfAkaGVYySqQXFuem5xYYF
 Rnmp5XrFibnFpXnpesn5uZsYwYGqpbWDcc+qD3qHGJk4GA8xSnAwK4nw7u+rSBLiTUmsrEot
 yo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBSSqavV9/am3J5V0y6sFc
 d6I8eOd5b9p47M/sF9+0FRyqbq6UteORk70nfX7p9z8eB2stYh7F3VDwN1x3Jqfer37FfOGr
 oRHR7BOucr7q5frP4/BlX8z+VY57Hj37G1emuHXO+90S/TcOBUx12R8TJXrnoNq/2anXN+/m
 ktpvueWz9ZIVRg9vlteYyWcJahUGmxXemyAhv6bdcsnE7v0/+k/P/pq9xvzLhZD+S0nXilKv
 n3M3uvLM+9qJT3+1Ml9fsOGzOJyhl//hteCGj+FPW+YFLF5wZavM2vBJG6Ye7z8n7Ft1+1f/
 rtoethdmv0Q8SwpCiwOnPVCo+uTw0O+Wa9RX8craqAshee9+yCQvylViKc5INNRiLipOBACM
 ISiVwwIAAA==
X-CMS-MailID: 20220511121442epcas5p26a997a19e8cc1de8eb23123500fb24fb
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511121442epcas5p26a997a19e8cc1de8eb23123500fb24fb
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121442epcas5p26a997a19e8cc1de8eb23123500fb24fb@epcas5p2.samsung.com>
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

Implement support for the DMA_ATTR_LOW_ADDRESS DMA attribute. If it has
been set, call alloc_iova_first_fit() instead of the alloc_iova_fast() to
allocate the new IOVA from the beginning of the address space.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/iommu/dma-iommu.c | 50 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cb235b40303c..553c5b863e19 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -601,6 +601,18 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 }
 
 #define DMA_ALLOC_IOVA_COHERENT		BIT(0)
+#define DMA_ALLOC_IOVA_FIRST_FIT	BIT(1)
+
+static unsigned int dma_attrs_to_alloc_flags(unsigned long attrs, bool coherent)
+{
+	unsigned int flags = 0;
+
+	if (coherent)
+		flags |= DMA_ALLOC_IOVA_COHERENT;
+	if (attrs & DMA_ATTR_LOW_ADDRESS)
+		flags |= DMA_ALLOC_IOVA_FIRST_FIT;
+	return flags;
+}
 
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		struct device *dev, size_t size, unsigned int flags)
@@ -625,13 +637,23 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
 
 	/* Try to get PCI devices a SAC address */
-	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
-		iova = alloc_iova_fast(iovad, iova_len,
-				       DMA_BIT_MASK(32) >> shift, false);
+	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev)) {
+		if (unlikely(flags & DMA_ALLOC_IOVA_FIRST_FIT))
+			iova = alloc_iova_first_fit(iovad, iova_len,
+						    DMA_BIT_MASK(32) >> shift);
+		else
+			iova = alloc_iova_fast(iovad, iova_len,
+					      DMA_BIT_MASK(32) >> shift, false);
+	}
 
-	if (iova == IOVA_BAD_ADDR)
-		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
-				       true);
+	if (iova == IOVA_BAD_ADDR) {
+		if (unlikely(flags & DMA_ALLOC_IOVA_FIRST_FIT))
+			iova = alloc_iova_first_fit(iovad, iova_len,
+						    dma_limit >> shift);
+		else
+			iova = alloc_iova_fast(iovad, iova_len,
+						dma_limit >> shift, true);
+	}
 
 	if (iova != IOVA_BAD_ADDR)
 		return (dma_addr_t)iova << shift;
@@ -779,6 +801,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 	struct iova_domain *iovad = &cookie->iovad;
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	unsigned int flags = dma_attrs_to_alloc_flags(attrs, true);
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
 	struct page **pages;
 	dma_addr_t iova;
@@ -804,7 +827,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		return NULL;
 
 	size = iova_align(iovad, size);
-	iova = iommu_dma_alloc_iova(domain, dev, size, DMA_ALLOC_IOVA_COHERENT);
+	iova = iommu_dma_alloc_iova(domain, dev, size, flags);
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_pages;
 
@@ -964,6 +987,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
 	int prot = dma_info_to_prot(dir, coherent, attrs);
+	unsigned int flags = dma_attrs_to_alloc_flags(attrs, false);
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
@@ -1005,7 +1029,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, size, prot, 0);
+	iova = __iommu_dma_map(dev, phys, size, prot, flags);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
@@ -1152,6 +1176,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct iova_domain *iovad = &cookie->iovad;
 	struct scatterlist *s, *prev = NULL;
 	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
+	unsigned int flags = dma_attrs_to_alloc_flags(attrs, false);
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
@@ -1209,7 +1234,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = iommu_dma_alloc_iova(domain, dev, iova_len, 0);
+	iova = iommu_dma_alloc_iova(domain, dev, iova_len, flags);
 	if (iova == DMA_MAPPING_ERROR) {
 		ret = -ENOMEM;
 		goto out_restore_sg;
@@ -1268,7 +1293,8 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO, 0);
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
+			dma_attrs_to_alloc_flags(attrs, false));
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -1357,6 +1383,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	unsigned int flags = dma_attrs_to_alloc_flags(attrs, true);
 	struct page *page = NULL;
 	void *cpu_addr;
 
@@ -1377,8 +1404,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!cpu_addr)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
-			DMA_ALLOC_IOVA_COHERENT);
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot, flags);
 	if (*handle == DMA_MAPPING_ERROR) {
 		__iommu_dma_free(dev, size, cpu_addr);
 		return NULL;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
