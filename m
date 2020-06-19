Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C3BC433FC
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B83A20EDD
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QR2d7BxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B83A20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39A0D87099;
	Fri, 19 Jun 2020 10:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HBw0_ltFu91b; Fri, 19 Jun 2020 10:37:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C1AED86F3C;
	Fri, 19 Jun 2020 10:37:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6C31C0865;
	Fri, 19 Jun 2020 10:37:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74473C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 41A8227D28
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWoKLhWx7a4H for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:37:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by silver.osuosl.org (Postfix) with ESMTPS id 6ED1027BB3
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:15 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103714euoutp016dca2db836618312862e480f372fd846~Z66RKe8iq1900119001euoutp01F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200619103714euoutp016dca2db836618312862e480f372fd846~Z66RKe8iq1900119001euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563034;
 bh=W7zLF4UUXLl3vJEsJx6vhSegl+oWVyV8PytRYNB6fZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QR2d7BxI/jIeluH3ZnirC06DEYGOLOUDWn2QSqJEfKRNwnbiiEdFL+sVPqYIkjwEl
 Xt8t6s/zIxesh+/f9Vxgd6v4jFf+0qvpo4HLuh6G0t1zb8ogYyQSeB2jRSMIgdnzyn
 pBOG0MSjnCdG7SB84abyGr3NRyZE2dhZIDEj6sKY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200619103713eucas1p2bfa7862b2eb60a04b431790c764bde0f~Z66QuutqJ2893928939eucas1p2n;
 Fri, 19 Jun 2020 10:37:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 69.9C.06318.9559CEE5; Fri, 19
 Jun 2020 11:37:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103713eucas1p2f4b6b66a376a72d1bf62ea6d92572045~Z66QNXq7E2893928939eucas1p2m;
 Fri, 19 Jun 2020 10:37:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103713eusmtrp1266e674f1f9b8cb645d8fe34cedcb8bc~Z66QMkd2F0959609596eusmtrp1c;
 Fri, 19 Jun 2020 10:37:13 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-83-5eec9559bd19
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.1B.06017.8559CEE5; Fri, 19
 Jun 2020 11:37:12 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103712eusmtip203eb7fcd2157d32e06df1b14b71da113~Z66PS0x6h3164531645eusmtip2b;
 Fri, 19 Jun 2020 10:37:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 29/36] staging: ion: remove dead code
Date: Fri, 19 Jun 2020 12:36:29 +0200
Message-Id: <20200619103636.11974-30-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe1BMURyes3fvY9M2t7U4EybWY8azUjgj09DIHMYYTMPQiMWdalSytyIz
 xlJWUtEDTVS7KpRekqWHKFKUNG12anox/IEkPTbVqOx2N/77ft/jfL855zCEbIB0YAKCQzlV
 sDJQQdmI9a9H36/af/2Hr3N97mIU1/hGhPrGuyn0MKWQROd/LkKT+gQCVTSM0ajF1EehyMxC
 CuU8qBEh7XN3dFe9BOVUjIjQUMsnESr+bCSRoew2hfJfddJIn6cmUdWvLyR62zlII61xjN4k
 x/pyPYnz0vMAHk/rJ3BX5UsxfjasFWPdgInEHcYKCj8Z/kji52l5NO6+UivCj7LO4faJzwRO
 ar0HcHmbmsJ9lR8oHF+SC3bZH7DZeIwLDAjnVE4eh238TWVZZEiP7emEljZKDS7PiAESBrJu
 UJf9SBQDbBgZex/ArtK3QBiGALwx2G9VBgHsSImhpiMJaRlW4R6AvboR0b9IoT6Dtrgo1gXG
 9AoJOXsRwLo4W4uJYGNJ+K2oyCwwzEwWwejsnRaPmF0Ck7NjCQuWsh6wdTKZENoc4YOiF1NY
 YuZ7oqpIyzmQ1TFQ01tOCqYtMKOhz4pnwu+1JbSA58H6pFixEIgE8FNjPi0MsQAaLqQAweUO
 OxrHpjYi2GWwsMxJoDfDnMbHwEJD1g629tpbaMIME/U3CYGWwmiNTHAvham1Bf9qq5qarftj
 2FZaQgkXlABgZPpL+hpwTP1fpgUgF8zhwvggP453DeZOreaVQXxYsN/qoyeCioH5J9ZP1Jqe
 gso/R6oBywCFrfSrd4+vjFSG8xFB1QAyhEIu9XxX7yuTHlNGnOFUJw6pwgI5vhrMZcSKOVLX
 O98Oylg/ZSh3nONCONW0KmIkDmrwbN+sc45zVzYZtems2yzz+3j/riyTOIk1XqlOJ0flxl3q
 moF4g/P28ZUP1xrm70kslWrIX21nI/Y2+MQrZabd/YlHvVf4FHmGNU9Otj/GMjdtJpD4bDBs
 dViwx8vRwTlKN7RQzysuDa97s63JbrmcnW0Y3L9jfXFNQV3D1Tu31ijEvL/SZTmh4pV/AYin
 7PWFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7oRU9/EGdx+bmPRe+4kk8X7v/fZ
 LDbOWM9q0fhO2eL/tonMFnvO/GK3uPL1PZtF8+L1bBYrVx9lsliw39piWYOqxco9P5gsvlx5
 yGSx6fE1VovLu+awWaw9cpfdYtuaBlaLgx+esFqcuvuZ3WLBtV/sDiIe23ZvY/VYM28No8ff
 uR+ZPe7tO8zisffbAhaPhZ++snrcubaHzWP7twesHvvnrmH3uN99nMlj85J6j9v/HjN7TL6x
 nNFj980GNo/3+66yefRtWcUYIBilZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
 qqRvZ5OSmpNZllqkb5egl/F11xLWgtc8FROv3GRrYOzk7mLk5JAQMJGYOHc+UxcjF4eQwFJG
 iSPbVzJCJGQkTk5rYIWwhSX+XOtigyj6xCixZe5pFpAEm4ChRNdbiISIQCejxLTuj+wgDrPA
 DFaJdQfuATkcHMICFhIdS/1AGlgEVCWmLO1hBrF5BewkbvyfwgyxQV5i9YYDYDYnUPx1y0Gw
 zUICthLLF7xnnsDIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZghG479nPLDsaud8GH
 GAU4GJV4eF+EvI4TYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6CjJjJL
 iSbnA5NHXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxrz6IJso
 0buhAj+bHB44ri3fdHHT396nmQvvd1xYFrLK+Ny16fW7D7fq72N/P6V+v7XcrmNaSzZ/c7mr
 dvy35dziDdol0dWXL62siZtVx3M7fNJSnXX/XjQcca9vl2OfHsEUfs6y+/OE6JCURepsis8f
 He/XjXmx7fSKg7PindPn/t9+Im1JdooSS3FGoqEWc1FxIgBPMRjI5gIAAA==
X-CMS-MailID: 20200619103713eucas1p2f4b6b66a376a72d1bf62ea6d92572045
X-Msg-Generator: CA
X-RootMTR: 20200619103713eucas1p2f4b6b66a376a72d1bf62ea6d92572045
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103713eucas1p2f4b6b66a376a72d1bf62ea6d92572045
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103713eucas1p2f4b6b66a376a72d1bf62ea6d92572045@eucas1p2.samsung.com>
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, Christian Brauner <christian@brauner.io>,
 Daniel Vetter <daniel@ffwll.ch>, Joel Fernandes <joel@joelfernandes.org>,
 Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

ion_heap_pages_zero() function is not used at all, so remove it to
simplify the ion_heap_sglist_zero() function later.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/staging/android/ion/ion.h      | 1 -
 drivers/staging/android/ion/ion_heap.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 74914a266e25..c199e88afc6c 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -177,7 +177,6 @@ void ion_heap_unmap_kernel(struct ion_heap *heap, struct ion_buffer *buffer);
 int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 		      struct vm_area_struct *vma);
 int ion_heap_buffer_zero(struct ion_buffer *buffer);
-int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot);
 
 /**
  * ion_heap_init_shrinker
diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 0755b11348ed..9c23b2382a1e 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -145,15 +145,6 @@ int ion_heap_buffer_zero(struct ion_buffer *buffer)
 	return ion_heap_sglist_zero(table->sgl, table->nents, pgprot);
 }
 
-int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot)
-{
-	struct scatterlist sg;
-
-	sg_init_table(&sg, 1);
-	sg_set_page(&sg, page, size, 0);
-	return ion_heap_sglist_zero(&sg, 1, pgprot);
-}
-
 void ion_heap_freelist_add(struct ion_heap *heap, struct ion_buffer *buffer)
 {
 	spin_lock(&heap->free_lock);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
