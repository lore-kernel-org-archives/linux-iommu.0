Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F1C43458
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13151206FA
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BK9H79oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13151206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8CD7896B1;
	Thu, 18 Jun 2020 15:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RTnAlvnaujJ4; Thu, 18 Jun 2020 15:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E85B68968C;
	Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5BEFC0892;
	Thu, 18 Jun 2020 15:40:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D494CC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CCD4187C27
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JkXyQ8jP6W90 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D48787C2E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:36 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154034euoutp0192dd18bd2cfe84f1708126f0e4106205~ZrZ1ixsRW1845018450euoutp01I
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200618154034euoutp0192dd18bd2cfe84f1708126f0e4106205~ZrZ1ixsRW1845018450euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494834;
 bh=W7zLF4UUXLl3vJEsJx6vhSegl+oWVyV8PytRYNB6fZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BK9H79oDkWmiuPF87QV55zDSO4C2L3RbTM3oiSAQcD7dOERsvHFGByChcVBSl1obJ
 6jFjuTeWeJZHqSmQEShVuWw4QFRU/MKX86GhvyToqh+P7HNL87KH19EFZpI4HQe6vw
 ebaDdCUyKJrBr2t/ompkGZZRtGJF30/yNxMslDys=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200618154034eucas1p200b642aad46f9f3dadb0b4d779961134~ZrZ05QFtV0500605006eucas1p28;
 Thu, 18 Jun 2020 15:40:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id AB.60.60698.1FA8BEE5; Thu, 18
 Jun 2020 16:40:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154033eucas1p1d061fbc72e2eed8d475ab170f9a2fbf0~ZrZ0kWFUk1545515455eucas1p1h;
 Thu, 18 Jun 2020 15:40:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200618154033eusmtrp18f40620951e8b03018ca5f7fe0349d57~ZrZ0jmufx2230622306eusmtrp1I;
 Thu, 18 Jun 2020 15:40:33 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-46-5eeb8af11c95
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 8F.E9.07950.1FA8BEE5; Thu, 18
 Jun 2020 16:40:33 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154032eusmtip12f8eaf6349a9de5197cc02bcf8153741~ZrZzqdGAz2806328063eusmtip1H;
 Thu, 18 Jun 2020 15:40:32 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 28/36] staging: ion: remove dead code
Date: Thu, 18 Jun 2020 17:39:49 +0200
Message-Id: <20200618153956.29558-29-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzu7D52Z66uS+pQkbUwe/rAoENFmEUc6B/BQKw0r3mxSKdtviqi
 9baplSlkkrVKXb6aL5bNqWXWylcPbWipaQ9rjlJTo6SszWv53/f7Hr/vx+EwhGyEms/sV8Tx
 SgUXJaedSMPjn8/WDGtsod7JI+tRWutTERr8/ZZGZVl6Ch3/uhT9MaQTyNQ8LkbtY4M0OnlL
 T6OCokcipK3bgPLV7qjA9EOERtv7RKj8vYVCbcarNCpp6BYjQ7GaQg+GPlCosXtEjLSWcbGf
 KzZUGyhcfK0Y4N85wwTuqX1I4prvWhLf+DZG4S6LicZ3v/dSuC6nWIzfpphFuCL3GH4z8Z7A
 GR06gKs71TQerH1F4/OVhSDAZafTxgg+an8Cr/TaFOa0b8yYS8XanJPS2ztpNTg3UwMkDGTX
 Qos2k9QAJ0bG3gbQ1P9tahgF8GdKCSEMIwD2dHwg/0X6G8qmBB2AWacypyMV6nbC4aJZH6j5
 oqEd2JU9DeCTNGeHiWBTKWgtLZ0U5rAIvh4+IXZgknWHPXkDwIGl7CZ471S6SKhzg0Wl9yeX
 Sux8k/k05VgE2SsMLDivEwumrdAwmg0EPAcOmCun+IWwKSOVFAInAexrLRELQyqAbSeyphIb
 YFfruP0kxn7fCqg3egn0Zvip7j5w0JCdBTu+uDhowg4vGS4TAi2FyWdkgnsZzDbf+V/74PlL
 QsAYGt/YKOGF0gEc7GoBF4Fb9nSZFoBCMI+PV0VH8ipfBZ/oqeKiVfGKSM+9MdHlwP4VmybM
 Y1Wg9ld4PWAZIHeWft5hC5VRXILqUHQ9gAwhd5X6tzSFyqQR3KHDvDJmjzI+ilfVgwUMKZ8n
 9b1pDZGxkVwcf4DnY3nlP1XESOarAZ9vPbj8SCB51vtjQ6HNvzxt94Uobl2IzK3Xs9f6InFb
 qV9HAOcx5DHDRR3utaX34Vp9LVmfEqc7npe5oDGszTM4yGsoqUL+buLoEmOgT2vyubmh24ck
 4MVLi7Uvoc2w+sAu0zbJ7ODrjRM5T4ICVupqFAv1jUEJVSGLm1NWVS3KkJOqfZzPSkKp4v4C
 KvQFAYYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7ofu17HGTy8omLRe+4kk8X7v/fZ
 LDbOWM9q0fhO2eL/tonMFnvO/GK3uPL1PZtF8+L1bBYrVx9lsliw39piWYOqxco9P5gsvlx5
 yGSx6fE1VovLu+awWaw9cpfdYtuaBlaLgx+esFqcuvuZ3WLBtV/sDiIe23ZvY/VYM28No8ff
 uR+ZPe7tO8zisffbAhaPhZ++snrcubaHzWP7twesHvvnrmH3uN99nMlj85J6j9v/HjN7TL6x
 nNFj980GNo/3+66yefRtWcUYIBilZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
 qqRvZ5OSmpNZllqkb5egl/F11xLWgtc8FROv3GRrYOzk7mLk5JAQMJF4dmQjM4gtJLCUUeL5
 wSiIuIzEyWkNrBC2sMSfa11sXYxcQDWfGCVeT9kA1sAmYCjR9RYiISLQySgxrfsjO4jDLDCD
 VWLdgXvsIFXCAhYStz42gdksAqoS95a+YgSxeQXsJHa2TGSCWCEvsXrDAbCpnEDx08dbWSFO
 spV4/qGNbQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBEbrt2M8tOxi73gUfYhTg
 YFTi4X0R8jpOiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqc
 D0weeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGPUEubtXTN8g
 sOd1HP+nN69mJRaITfZyf6XR22582vTcPrdnCbtdJzD8je6f9rOo+zi38qZcH9kn1o6Clm4i
 Aa6z7s/aG8ylEGIy9/hvKRHJmr0Vy7bl8N+pfxUrKBW9bAFj3XmVx6KnHK5WmCQyOZeu3Sv3
 sWVbzcnLNln2gdOY76Y+7cr4oMRSnJFoqMVcVJwIAKInuRrmAgAA
X-CMS-MailID: 20200618154033eucas1p1d061fbc72e2eed8d475ab170f9a2fbf0
X-Msg-Generator: CA
X-RootMTR: 20200618154033eucas1p1d061fbc72e2eed8d475ab170f9a2fbf0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154033eucas1p1d061fbc72e2eed8d475ab170f9a2fbf0
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154033eucas1p1d061fbc72e2eed8d475ab170f9a2fbf0@eucas1p1.samsung.com>
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
