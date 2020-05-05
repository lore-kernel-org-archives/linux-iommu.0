Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B8C47247
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C26F206B9
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DHxZnZZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C26F206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 77D61237C8;
	Tue,  5 May 2020 08:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7rRh+i6qZ4XQ; Tue,  5 May 2020 08:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2A60C233D8;
	Tue,  5 May 2020 08:46:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17B08C0175;
	Tue,  5 May 2020 08:46:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3F18C088C
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9C5E189576
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mF4dH1m8AKzx for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 08:46:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4E1FC89572
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:37 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505084635euoutp02ed9f87fc8514505ae2281236b66ea1b5~MFX0n8iHR2628726287euoutp02o
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200505084635euoutp02ed9f87fc8514505ae2281236b66ea1b5~MFX0n8iHR2628726287euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588668395;
 bh=X1nfXo9cKl5fZa4V0fEIOhdnztemn3SkVlBP/IKvYMM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DHxZnZZhzB87q0MaRgzOaDvTUBuffCayHv1TcoTZkEm1Lf0g0hxWUPlI/JqMSsqym
 bwUdbVfPEAydzc28NygvW48tOXMv5mzWEqUU9Asajzixk2wauUbDt4/DPuL41AEJYv
 lOS0Hd67xbhFaAkuSpvy+b1WRZVGEv691iQcuHdk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200505084635eucas1p1430db2477f49d3cf561d94133968dfdf~MFX0O-FJj0601906019eucas1p1Q;
 Tue,  5 May 2020 08:46:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.CF.61286.BE721BE5; Tue,  5
 May 2020 09:46:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084634eucas1p105456f28d9a7935190478546e566975f~MFXzzjxXz2431924319eucas1p17;
 Tue,  5 May 2020 08:46:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505084634eusmtrp11ef8f84e63f6a30b0427888ceadddb01~MFXzy2UGA0942509425eusmtrp1R;
 Tue,  5 May 2020 08:46:34 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-b4-5eb127ebc36b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.21.07950.AE721BE5; Tue,  5
 May 2020 09:46:34 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084634eusmtip1ccdc14d70b1dfb490ab87a4d3135453d~MFXzP2Bdu0580805808eusmtip1-;
 Tue,  5 May 2020 08:46:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/25] dmabuf: fix common struct sg_table related issues
Date: Tue,  5 May 2020 10:46:08 +0200
Message-Id: <20200505084614.30424-19-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHeXcuOxMnp03xzSJhpmaQF1I4oEhhwQG/9CHKxKyVBy/plB1n
 GYVWamFqpuW1TLTyfptmoqXOnEtHanOJlcvLSspLSl7SAm3zqH37P7/n/zz/h5eXQEQqzI4I
 l8Uycpk0UoJboM09a/2HZpwbgt0n9CIqvb+XRzXk1WHURvN9hNIvz+NURZWaRxV3eFNTn3oR
 akk/waOUxmGMGmp9hFNp9S8wqqbbwKdUC18xqs+wyD9iRVcXVQP69UoxSo8Ov8LplyvjGD12
 V8OjG58m0J/XjQidPVIG6LaPiTg93/4BpzOaKgG9qNx3wjLQwieEiQyPY+RuvuctwmaTxDFT
 tlc6241YIhgTpwIBAUlPaMjsxlKBBSEiywFsXV3jc8USgIlLGYArFgEsVKt52yOTpatbjTIA
 H/fqeTsjbZNZqNmFkx4wdS4VN2trMhnAt+mWZhNCJiGwsuPGZkNM+sOGomlg1ijpCDOSBza5
 kPSFP4sbcS7OHlbVdyJmLTBxo24UNy+CpI4PBzeMfM50DFbPKzFOi+G0pmmL74Xa7DSUG7gF
 4ER/DZ8r0gAcupkHOJc3HO3/Y1pLmO5zgXWtbhw+Cstul/LMGJJWcGRulxkjJpnVnItwWAjv
 pIg4txMs0NTuxKoGdQinaajtNaDcC6kBrDWo0UxgX/A/rBiASmDLKNioUIb1kDGXXVlpFKuQ
 hbpejI5SAtPH0q5rfrWAZd2FLkASQGIpDFisCxZh0jg2PqoLQAKRWAufr9YHi4Qh0virjDz6
 nFwRybBdYA+BSmyFh0t+nBWRodJY5hLDxDDy7S6PENglAqff7iMxXoEH/EbGU46PlVBvIhqC
 r/W17H6WnZ9TMSM7qUNUQd/D7522cRuvcegKCvVRyPTi8I4SpV/A8nBlgJfAbSYDTn5TnXnX
 4rPg6Ekm/HWN6LEpNOSwX8b9HuySS/Y7NU1fd47P9xe8Rx5qHATlWhfFqUnVrNZxINcQ+USC
 smFSj4OInJX+A6wn6sBUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7qv1DfGGfS/tbDoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2eHbrJLPFlysPmSw2Pb7GanF51xw2i54NW1kt1h65y25x
 8MMTVotTdz+zO/B5rJm3htFj77cFLB53ru1h89j+7QGrx/3u40wem5fUe9z+95jZY/KN5Ywe
 u282sHm833eVzaNvyypGj8+b5AJ4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
 jEyV9O1sUlJzMstSi/TtEvQy3rQIFzwTrziw7zFrA+N94S5GTg4JAROJR4t/MHYxcnEICSxl
 lGh78oEFIiEjcXJaAyuELSzx51oXG0TRJ0aJf7evs4Ek2AQMJbreQiREBDoZJaZ1f2QHcZgF
 epglLi38wghSJSzgLbFx3iswm0VAVaKv9TxYN6+AncS7BZvZIFbIS6zecIAZxOYEij++dAcs
 LiRQKPHh/HfWCYx8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTGz7ZjP7fsYOx6F3yI
 UYCDUYmHd8PX9XFCrIllxZW5hxglOJiVRHiX/dgQJ8SbklhZlVqUH19UmpNafIjRFOioicxS
 osn5wNjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAmLejnseS
 uX6K+KLSZiHJL0LPmgvezGpc+XlXWsS8ZQdyppm0qL7KC5qye+Li052MU94cdmOQZXJpNg2V
 Y20UnvAoQpGr1ZXvW7zVhn/S95XdCmbqhgRp8Hru/Jxt/rd6x5tZgmWHOc9sMDnuPz+Gt+OP
 pFDzi/jynS6nGVJkPx/ayMJq4BOjxFKckWioxVxUnAgA/Ej4drUCAAA=
X-CMS-MailID: 20200505084634eucas1p105456f28d9a7935190478546e566975f
X-Msg-Generator: CA
X-RootMTR: 20200505084634eucas1p105456f28d9a7935190478546e566975f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084634eucas1p105456f28d9a7935190478546e566975f
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084634eucas1p105456f28d9a7935190478546e566975f@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Sumit Semwal <sumit.semwal@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of the entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. A common mistake was to ignore a result
of the dma_map_sg function and don't use the sg_table->orig_nents at all.

To avoid such issues, lets use common dma-mapping wrappers operating
directly on the struct sg_table objects and adjust references to the
nents and orig_nents respectively.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187
---
 drivers/dma-buf/heaps/heap-helpers.c | 13 ++++++-------
 drivers/dma-buf/udmabuf.c            |  7 +++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index 9f964ca..be9523a 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -140,13 +140,12 @@ struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
 				      enum dma_data_direction direction)
 {
 	struct dma_heaps_attachment *a = attachment->priv;
-	struct sg_table *table;
-
-	table = &a->table;
+	struct sg_table *table = &a->table;
+	int ret;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
-		table = ERR_PTR(-ENOMEM);
+	ret = dma_map_sgtable(attachment->dev, table, direction);
+	if (ret)
+		table = ERR_PTR(ret);
 	return table;
 }
 
@@ -154,7 +153,7 @@ static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
 				   struct sg_table *table,
 				   enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sgtable(attachment->dev, table, direction);
 }
 
 static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index acb26c6..5bcbf7a 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -63,10 +63,9 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 					GFP_KERNEL);
 	if (ret < 0)
 		goto err;
-	if (!dma_map_sg(dev, sg->sgl, sg->nents, direction)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(dev, sg, direction);
+	if (ret < 0)
 		goto err;
-	}
 	return sg;
 
 err:
@@ -78,7 +77,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sg(dev, sg->sgl, sg->nents, direction);
+	dma_unmap_sgtable(dev, sg, direction);
 	sg_free_table(sg);
 	kfree(sg);
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
