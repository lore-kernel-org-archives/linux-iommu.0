Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A4C3A5A9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 18:59:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD17206B8
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hSRKM32i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD17206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 32A3187909;
	Mon,  4 May 2020 18:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lre32w5HvoWA; Mon,  4 May 2020 18:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D8AF878AE;
	Mon,  4 May 2020 18:59:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49A90C088C;
	Mon,  4 May 2020 18:59:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10E5AC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 18:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F3C2881B8E
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 18:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puRpgxJ4hg3V for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 18:58:36 +0000 (UTC)
X-Greylist: delayed 00:07:48 by SQLgrey-1.7.6
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EB4D387619
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 18:58:35 +0000 (UTC)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20200504185045epoutp0244d2f06896c88b216290f4ea745eb5c2~L5_CRrQ-10774607746epoutp02K
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 18:50:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20200504185045epoutp0244d2f06896c88b216290f4ea745eb5c2~L5_CRrQ-10774607746epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588618245;
 bh=BZxMq7nEovt9ZPvq4JsIht4gTej+25qFhhWAvHirSi8=;
 h=From:To:Cc:Subject:Date:References:From;
 b=hSRKM32ifFzkKfNxOEKYQVTgnVyeDM/w3oTKpIraEyvU8bbgQYCp2Dri9i2RgbPBT
 xs4JadBZfvyGxFwRVWXj6gbS+zmwUjVCuXz83g45n+lOpX7U5BZyeOSMmy74mbhL9I
 P8dQdmKH7nQQL2L0BdMep8u5cY+kt60o0JZ+k5ig=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20200504185043epcas5p3bacf90b50dda08bb43791f9e64f2a564~L5_BAw58V1421314213epcas5p3o;
 Mon,  4 May 2020 18:50:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D3.64.04736.30460BE5; Tue,  5 May 2020 03:50:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20200504185042epcas5p11447ae722d33bd00c7d002a9d1b8d6c1~L5_ABTZhL0449504495epcas5p1S;
 Mon,  4 May 2020 18:50:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200504185042epsmtrp2d5c1ac2df08fe2b444774ea86e61cb02~L5_AAmReM2092520925epsmtrp2M;
 Mon,  4 May 2020 18:50:42 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-71-5eb064039c95
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 39.4D.25866.20460BE5; Tue,  5 May 2020 03:50:42 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
 [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504185041epsmtip259645ec35515884eb07311d29d916a3f~L59_vNFex0931009310epsmtip22;
 Mon,  4 May 2020 18:50:41 +0000 (GMT)
From: Ajay Kumar <ajaykumar.rs@samsung.com>
To: iommu@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [RFC PATCH] drivers: iommu: reset cached node if dma_mask is changed
Date: Tue,  5 May 2020 00:07:59 +0530
Message-Id: <20200504183759.42924-1-ajaykumar.rs@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VRa0hTYRju2znunK22jlPsTYVo0UUldZRxILMrsej6J5Cg2UFP09rm2pw3
 CHSYMyk1i4wpw0Ca06lDVPJW29JCKItwpMjU5QVboKGGokG1HaN/z/M+F56Pj8Qk03gkmaXJ
 YXUaRiXlC/GuNzEHDmIZDkXix+ok2rnowun610fp+7UOgp6w/w6hXT9mQmjb+iOMHvD1EnRr
 dzVxgpTPuCw8ud1iR/Jus5eQty9VE/LHo1Ykr+hoQlf414TJGawqK5fVJaTcEGb6iycx7RfI
 99Z48SLUH16OBCRQh2H+1T2iHAlJCdWLwGwfRBxZQjBuW8c4sozA02r5q5DBSN9aKHfvQdDV
 WolzpIQHlu9PeIFePhUHXTVjeCAQTtGw6hMGPBjlQPDTWIwFPGHUZXhmnwpinNoLJd86+QEs
 oo6BtfED4vbtgmaHM7gCqLcEtPndm8IZsLpMOIfDwP+ug+BwJCwv9PO5QCWC2clfm+lmBFO+
 TxjnOg7OkbrgPIyKgbaehMAZo8TwcGOGxz1TBGWlEg7ug87GS1wwGt67RngclsNaU12wUEJd
 h6XBBrwKRZv/d9Yj1IR2slq9Wsnqk7SHNGxevJ5R6w0aZXx6trodBb8+9vxL1D58wY0oEkm3
 iVKX2xSSECZXX6B2IyAxabho9xGHQiLKYAoKWV12ms6gYvVuFEXi0h2iWGRTSCglk8PeZlkt
 q/un8khBZBGiBKWJ3qtjcTnlp2uS74bKnm+s4KaW/Kpza3kXTyLngCRPmMKsmwrPzu3JJPx9
 q0PWOeNolMEYOrG4dTyixUOLfek2Wb8hNcK+pWzYSKhb+At9Kx7aXJjWXRs/XzEEt74+UDwV
 iD0q+3bzzVnZ9GfnHTH7Yn8DFuUwKU9JcX0mI4vFdHrmD+w/0sn2AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42LZdlhJXpcpZUOcwaY+PYsD7w+yWCzYb23R
 OXsDu8W9Nf9ZLQ5+eMJqsfLXRGaLIw93s1us2zmJ3YHD48nBeUwea+atYfTYOesuu8emT5PY
 PSbfWM7o0bdlFWMAWxSXTUpqTmZZapG+XQJXxqvG+8wF1yUq7k6/y9LAuFeki5GDQ0LARGLP
 D8EuRk4OIYEdjBInPquA2BICMhLPdzxlgbCFJVb+e87excgFVNPEJPFrTScjSIJNQFti2/Sb
 YEUiAlYSR34eYwYpYhbYxigxr6GDCSQhLOArsebyTjYQm0VAVaLl5VYwm1fAVmL5irOMEBvk
 JVZvOMA8gZFnASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4MDS0trBuGfVB71D
 jEwcjIcYJTiYlUR4Fc02xAnxpiRWVqUW5ccXleakFh9ilOZgURLn/TprYZyQQHpiSWp2ampB
 ahFMlomDU6qBqWfuldU6c5YraXdqcN1Se9xcO+d3VVLQ/sP+i7ednMS6e8Idj5BFmlv2VH57
 c+npi+0Rh78vvWnKu37n5Xdtgk2f7y7oPzVBY+Pzh5/sg26diir9F/HHNbeLcd2nNo2JPFbz
 13kGxHBPSOPZ/tG2K96Qn5cv6AN7qF2zgXH9qrQoh7iTW54vvFn/JKHG663t6e8M246suG2y
 4pSz2HK5O3rM23nq/BZVerEs/nR3a+6piv28184q3qpZ9m6h0TJ9F72TWx1tT5Uq5X2Y8PLp
 Vun6s9Z6+/rDssvZLaeIJ2x8NTP40vPY5jWdDhac4rEWr3e6vr9d5hak9cleQHBJK6vazjkr
 bWLq0iWFitYWxCixFGckGmoxFxUnAgCBlO7LmwIAAA==
X-CMS-MailID: 20200504185042epcas5p11447ae722d33bd00c7d002a9d1b8d6c1
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20200504185042epcas5p11447ae722d33bd00c7d002a9d1b8d6c1
References: <CGME20200504185042epcas5p11447ae722d33bd00c7d002a9d1b8d6c1@epcas5p1.samsung.com>
X-Mailman-Approved-At: Mon, 04 May 2020 18:59:50 +0000
Cc: Sathyam Panda <sathya.panda@samsung.com>, shaik.ameer@samsung.com,
 robin.murphy@arm.com, Ajay Kumar <ajaykumar.rs@samsung.com>
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

The current IOVA allocation code stores a cached copy of the
first allocated IOVA address node, and all the subsequent allocations
have no way to get past(higher than) the first allocated IOVA range.

This causes issue when dma_mask for the master device is changed.
Though the DMA window is increased, the allocation code unaware of
the change, goes ahead allocating IOVA address lower than the
first allocated IOVA address.

This patch adds a check for dma_mask change in the IOVA allocation
function and resets the cached IOVA node to anchor node everytime
the dma_mask change is observed.

NOTE:
 This patch is needed to address the issue discussed in below thread:
 https://www.spinics.net/lists/iommu/msg43586.html

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Sathyam Panda <sathya.panda@samsung.com>
---
 drivers/iommu/iova.c | 17 ++++++++++++++++-
 include/linux/iova.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..0e99975036ae 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -44,6 +44,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
+	iovad->curr_limit_pfn = iovad->dma_32bit_pfn;
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
@@ -116,9 +117,20 @@ EXPORT_SYMBOL_GPL(init_iova_flush_queue);
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
 {
-	if (limit_pfn <= iovad->dma_32bit_pfn)
+	if (limit_pfn <= iovad->dma_32bit_pfn) {
+		/* re-init cached node if DMA limit has changed */
+		if (limit_pfn != iovad->curr_limit_pfn) {
+			iovad->cached32_node = &iovad->anchor.node;
+			iovad->curr_limit_pfn = limit_pfn;
+		}
 		return iovad->cached32_node;
+	}
 
+	/* re-init cached node if DMA limit has changed */
+	if (limit_pfn != iovad->curr_limit_pfn) {
+		iovad->cached_node = &iovad->anchor.node;
+		iovad->curr_limit_pfn = limit_pfn;
+	}
 	return iovad->cached_node;
 }
 
@@ -190,6 +202,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
 
+	if (limit_pfn != iovad->curr_limit_pfn)
+		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
+
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	if (limit_pfn <= iovad->dma_32bit_pfn &&
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a0637abffee8..be2220c096ef 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -73,6 +73,7 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	unsigned long	curr_limit_pfn;	/* Current max limit for this domain */
 	unsigned long	max32_alloc_size; /* Size of last failed allocation */
 	struct iova_fq __percpu *fq;	/* Flush Queue */
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
