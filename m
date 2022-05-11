Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB74C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 03:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 900C960BCA;
	Thu, 12 May 2022 03:39:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gNEbRIGmbRbf; Thu, 12 May 2022 03:39:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7729B60784;
	Thu, 12 May 2022 03:39:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51B74C0032;
	Thu, 12 May 2022 03:39:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93E04C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 752C183E2E
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t1phaUk6z3bE for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:39:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E4E783E2C
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:45 +0000 (UTC)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20220512033943epoutp02a1daa6595ca1fdb218d14f577a544ecb~uPnR_vo-W0398503985epoutp02C
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 03:39:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20220512033943epoutp02a1daa6595ca1fdb218d14f577a544ecb~uPnR_vo-W0398503985epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652326783;
 bh=1yMoSleOG1G6F/u1i0Yl7I9fqLlbF/BiUVFK6eqgol4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ty5JNQf3OFz8NYI+92NMZMCUUpQNe3zFnarDvlMM8aJ+zDaJ9KL+pb8iAwFxsT4px
 A9m5O/r8QDR9d9+31ZUQAkFyj3oRxFvrPILqxdRCBRNOUgebcwJSMRaMDJMVQbhxy5
 Q4f412KEPEml5QIVcN703/bIh/bEHUbccm94z7SQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20220512033942epcas5p39e35d5f10a61b7e0a1541e4a983d5ca3~uPnRe6OFM2371723717epcas5p3S;
 Thu, 12 May 2022 03:39:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4KzHZx2QWnz4x9Q3; Thu, 12 May
 2022 03:39:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E9.B6.09762.5718C726; Thu, 12 May 2022 12:39:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20220511121445epcas5p377ef245c4f5a0bf282245877d2b922c8~uC-r0UHa_2165521655epcas5p3R;
 Wed, 11 May 2022 12:14:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220511121445epsmtrp2db83a2613791bdcbb633b8ee7a2844fd~uC-rzf3e51138811388epsmtrp2Q;
 Wed, 11 May 2022 12:14:45 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-64-627c8175874b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 7B.0F.11276.5B8AB726; Wed, 11 May 2022 21:14:45 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220511121444epsmtip2a7072acf22ec1a1971a8f32a89c86520~uC-qU4RTg0609306093epsmtip2s;
 Wed, 11 May 2022 12:14:44 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Subject: [PATCH V2 6/6] media: platform: s5p-mfc: use DMA_ATTR_LOW_ADDRESS
Date: Wed, 11 May 2022 17:45:44 +0530
Message-Id: <20220511121544.5998-7-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmum5pY02SwadLlhZfT/xmszjw/iCL
 xYN529gsFuy3tuicvYHdYtPja6wWa4/cZbdYtPULu8XBD09YLVrumDpweTw5OI/JY828NYwe
 O2fdZffYtKqTzWPzknqPyTeWM3r0bVnFGMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
 YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
 JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y9mO/4wFF3grJly4ytLAeJi7i5GTQ0LARGJ3
 wze2LkYuDiGB3YwSHUfPM0M4nxglvly4yAhSJSTwjVHi4W1NmI4v1xZCFe1llNh5cwMThNPC
 JNFw5gULSBWbgLbEtuk3wWwRgRZGibnT7EGKmAVWMkosudXB3sXIwSEs4CXxeCIbSA2LgKrE
 5Ql3WUFsXgEbiQsP/7FDbJOXWL3hADOIzSlgKzFpx19GkDkSAh/ZJVaePsMCUeQi0bymnxnC
 FpZ4dXwLVLOUxOd3e9kg7GqJc7f2s0E0dwA9+nAdVJG9xIErc1hADmIW0JRYv0sfIiwrMfXU
 OiYQm1mAT6L39xMmiDivxI55IDYHkK0msXWFH0RYRuLMwStQJR4SX48shAbKBEaJT7NXsExg
 lJuFsGEBI+MqRsnUguLc9NRi0wLjvNRyeKwl5+duYgSnQC3vHYyPHnzQO8TIxMF4iFGCg1lJ
 hHd/X0WSEG9KYmVValF+fFFpTmrxIUZTYABOZJYSTc4HJuG8knhDE0sDEzMzMxNLYzNDJXHe
 U+kbEoUE0hNLUrNTUwtSi2D6mDg4pRqYNus2GexLn/W31bb8sRN7wuFXiossGn2TlsSzC3+9
 s5jJR/+/qexRQZu+d9t04h5M/z6l5l3cPOlfetaxnouWLVh1Vi5huv3+t3azy0zuSTvF/J6s
 Jb9n0auTrVZeRxMv95pXqdc4vkipfvvuhK7LihcKa960z3LN4Pp641jfvimz379cURG5Y9Oj
 OLfZ7HPzk9RdVBt/lNj0pJjbHTh4LGiiidCMz0x//nPVFuX1rJ4kYLstpksi03mxAHNy8NO1
 +g9rYnbuvrVzregFm+1T3Wy4UwN+/fnq7Wm0fdWZjKCcQs6n855fyP0y/WG/4Y0FXLk7bt4T
 exxgNf3om8KAhdWFPd6nHxyzvSTN95KhXImlOCPRUIu5qDgRAA6ypxAKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO7WFdVJBj07NSy+nvjNZnHg/UEW
 iwfztrFZLNhvbdE5ewO7xabH11gt1h65y26xaOsXdouDH56wWrTcMXXg8nhycB6Tx5p5axg9
 ds66y+6xaVUnm8fmJfUek28sZ/To27KKMYA9issmJTUnsyy1SN8ugStj2Y7/jAUXeCsmXLjK
 0sB4mLuLkZNDQsBE4su1hcxdjFwcQgK7GSWeLpnOCJGQkXi+4ykLhC0ssfLfc3aIoiYmiSV3
 voEVsQloS2ybfpMFJCEi0MUocfXqXlYQh1lgLaPEq8YlQFUcHMICXhKPJ7KBNLAIqEpcnnCX
 FcTmFbCRuPDwHzvEBnmJ1RsOMIPYnAK2EpN2/AVbIARUM+fzUeYJjHwLGBlWMUqmFhTnpucW
 GxYY5qWW6xUn5haX5qXrJefnbmIEh6mW5g7G7as+6B1iZOJgPMQowcGsJMK7v68iSYg3JbGy
 KrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmhTvZ//k4nu5gX7hj
 0UkWk4pNe/f7/Xjz6/2KiJyLAmVBJa+/FZ6b1zrh6y3fMy43GpjKMpd2ayv0zrgR0LCHqbr2
 zGwtr8lXxFm0Dgj3WE7Y7X6t/HnjnELnzuBTR52cL3xn2nD7RcfKTsu3fxhjFZfoiLzZKjz1
 jFRT8y59QQ03Mz2futBnN72aVEN2KJ5pcbk1wTD7ieYrj1sfv1hqFjJx/dyR9NXl+pO3U9kP
 yxzQUrq7cOsU0YeLzXaE5N1jmj0/Ka1/1tSoR4nL7t8/GMAim/jxUlKN8Ik/C/7mzw2XadFy
 Sy/wW5+8vWWJ6uciaWctXfHV9eKaIlfsToWtLdkctjYnYE/q9LDV/rqXlViKMxINtZiLihMB
 khuMksICAAA=
X-CMS-MailID: 20220511121445epcas5p377ef245c4f5a0bf282245877d2b922c8
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220511121445epcas5p377ef245c4f5a0bf282245877d2b922c8
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121445epcas5p377ef245c4f5a0bf282245877d2b922c8@epcas5p3.samsung.com>
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

S5P-MFC driver relied on the way the ARM DMA-IOMMU glue code worked -
mainly it relied on the fact that the allocator used first-fit algorithm
and the first allocated buffer were at 0x0 DMA/IOVA address. This is not
true for the generic IOMMU-DMA glue code that will be used for ARM
architecture soon, so limit the dma_mask to size of the DMA window the
hardware can use and add the needed DMA attribute to force proper IOVA
allocation of the firmware buffer.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index 761341934925..15c9c2273561 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1196,8 +1196,12 @@ static int s5p_mfc_configure_common_memory(struct s5p_mfc_dev *mfc_dev)
 	if (!mfc_dev->mem_bitmap)
 		return -ENOMEM;
 
-	mfc_dev->mem_virt = dma_alloc_coherent(dev, mem_size,
-					       &mfc_dev->mem_base, GFP_KERNEL);
+	/* MFC v5 can access memory only via the 256M window */
+	if (exynos_is_iommu_available(dev) && !IS_MFCV6_PLUS(mfc_dev))
+		dma_set_mask_and_coherent(dev, SZ_256M - 1);
+
+	mfc_dev->mem_virt = dma_alloc_attrs(dev, mem_size, &mfc_dev->mem_base,
+					    GFP_KERNEL, DMA_ATTR_LOW_ADDRESS);
 	if (!mfc_dev->mem_virt) {
 		bitmap_free(mfc_dev->mem_bitmap);
 		dev_err(dev, "failed to preallocate %ld MiB for the firmware and context buffers\n",
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
