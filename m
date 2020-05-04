Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41068C54E4A
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB2F20757
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dKSgYnbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB2F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D703888093;
	Mon,  4 May 2020 12:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifXRg8Dhbf9m; Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B554F88259;
	Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C6AC0175;
	Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17521C088E
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F22182563C
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ssF1moUme7cm for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 4B43D23077
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:26 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200504125424euoutp025c1322dd4c51d4466f5aa984b98c1070~L1G6SqS2n1960119601euoutp02G
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200504125424euoutp025c1322dd4c51d4466f5aa984b98c1070~L1G6SqS2n1960119601euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588596864;
 bh=OfDvq7QhD2ccXim65GDD0KiajVxCHZdmwkhCxnNXzfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dKSgYnbIyfzh7IPxZqpqXivisIWfXSYuVRHIFScXEDBb2IV7ssvDggqxbgsosZwIR
 ADSpr7gtwg+q43+zbZGxT7UGdNCS6iVrCn7pC63BfduWrAEUbJb0q7xvJsOTP9H52o
 8+NjDPXGTuyL/9BnOuHk/bsBVUPR3ijJNmI14tkc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200504125424eucas1p265dac1ad69e1ea2930fc0557ed015feb~L1G6API-H2430824308eucas1p2j;
 Mon,  4 May 2020 12:54:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 8F.12.60698.08010BE5; Mon,  4
 May 2020 13:54:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200504125424eucas1p16cb0c33de857e1f470173c66710c088b~L1G5gslZD0158001580eucas1p18;
 Mon,  4 May 2020 12:54:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200504125424eusmtrp2abcaac47d2beda8a33b6c7d1fccdbe34~L1G5f-b3I2826928269eusmtrp2e;
 Mon,  4 May 2020 12:54:24 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-66-5eb010806d8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.79.08375.F7010BE5; Mon,  4
 May 2020 13:54:24 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125423eusmtip2b1449c35e65efe0155ceb69b562955af~L1G4sFsXM0350503505eusmtip2Q;
 Mon,  4 May 2020 12:54:23 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/21] media: pci: fix common ALSA DMA-mapping related code
Date: Mon,  4 May 2020 14:53:58 +0200
Message-Id: <20200504125359.5678-20-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSW0wTQRTN7HbbpeniUmuYgIppREUjSNBkI4qa+LEffvBjfCQiFRZEaSFd
 QNGP8lCjhVYE0UJ8oBLB8iqlgqLSimJFQxFBBAUVeSikqLGUgEGwy6L+nXPuOffMTAZHpTbM
 D09QpTBqlSJRLhQL6p9NO9ZnkKaoDXmGQErnaEWoWkMNRs3VX0CpLvd3IXWnogWhOor6BVSJ
 NZya6BpAKPNgN0Z1Nl4RUrmmuxhV9bRfRN02zyDU4x9D2HZvuvJaJaAfTZYIaLPxnJBumPyE
 0R9z7AhdV6qh388OonRBTxmgH/RmCGm9xQhol3k5/cLtEkVK9ou3xDKJCWmMOiQiWnz449dJ
 UfJb3+Nnc26gGcAq0wIvHJIbYWVmG6YFYlxKlgM4cmkW5ckEgKeHihGeuAAs+zbsseHzEbcR
 5/UyAD89/I39SzTZOxBur5AMhdpxrZDDMvI0gM91Es6EknoU1ukNgBssJiNhm+WWiMMCMhAO
 tX6e1wlyK6z64hLxBwyAFSYbyjV7efQi3WpuDyS7RdA5cVHAe3bCYb0N8HgxHLNbFrJL4dz9
 6wgfyAZwwFEl4kkugJ1ZhoVEOOxz/BJyDSgZBGsaQ3h5B6xz6EX8lb1hz7gPJ6MemF9/GeVl
 Ap49I+Xdq2Cxvfpf7eNXr1Ee03DE9GHhgZ4AqMu2InkgoPh/WQkARuDLpLLKeIYNUzHHglmF
 kk1VxQfHJCnNwPOvXs7a3fdA08yhZkDiQC4h9rpqoqSYIo1NVzYDiKNyGXHvlEciYhXpJxh1
 0kF1aiLDNgN/XCD3JcJujh6QkvGKFOYowyQz6r9TBPfyywCP9AHulct77l/P+lEYXV5aHKey
 JGx2WpceGTPF/aTaN9HBvcrvM7feyC+3pZ9fpunzeXdyz24kTmbdZ8rTanahLpvB4SrNdBOw
 ducNon3RCqNztNC/yzZVEKyszv+KNEgS9Y1ZWUv8WoLWTEesu9oxtTJt1214pakwZpvGKa6V
 C9jDitC1qJpV/AFq4JfpUwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7oNAhviDPbLW/SeO8lksXHGelaL
 /9smMltc+fqezWLl6qNMFhdn3mWxWLDf2uLLlYdMFpseX2O1uLxrDptFz4atrBZrj9xlt1i2
 6Q+TxcEPT1gd+DzWzFvD6LH32wIWj02rOtk8tn97wOpxv/s4k8fmJfUet/89ZvaYfGM5o8fu
 mw1sHn1bVjF6fN4k53Hq62f2AJ4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsj
 UyV9O5uU1JzMstQifbsEvYz7L76xF1wXr+joXsjcwLhfpIuRg0NCwETi6yqOLkYuDiGBpYwS
 OxefZ+li5ASKy0icnNbACmELS/y51sUGUfSJUeLKsodgRWwChhJdbyESIgKdjBLTuj+ygzjM
 AtOYJRY2PmcDqRIW8JOYPqMNzGYRUJV4cvIRI4jNK2Arsfb5Z3aIFfISqzccYAY5iRMoPrNX
 HSQsJJAvcffpP5YJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbOtmM/N+9gvLQx
 +BCjAAejEg9vxOf1cUKsiWXFlbmHGCU4mJVEeHe0AIV4UxIrq1KL8uOLSnNSiw8xmgLdNJFZ
 SjQ5HxjXeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGJk775ef
 TSw/G37zz+mj0+dd/Kslu8mm0aP/zEOP+y2caV7+8xS3R548k6V9lk9/ZUcPv1fEo0VS2X6d
 C+/qlv9K2m+1SrVm+34Pk3+r6iZLBSsV3nn/teD0tNqQtZXbfhcd3Ka68YSbsS/3p+cn1SuK
 3t7paa5VOdXefLMyau6nlbx7Fj2+uVyJpTgj0VCLuag4EQD2QRAGswIAAA==
X-CMS-MailID: 20200504125424eucas1p16cb0c33de857e1f470173c66710c088b
X-Msg-Generator: CA
X-RootMTR: 20200504125424eucas1p16cb0c33de857e1f470173c66710c088b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125424eucas1p16cb0c33de857e1f470173c66710c088b
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125424eucas1p16cb0c33de857e1f470173c66710c088b@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-media@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/media/pci/cx23885/cx23885-alsa.c | 2 +-
 drivers/media/pci/cx25821/cx25821-alsa.c | 2 +-
 drivers/media/pci/cx88/cx88-alsa.c       | 2 +-
 drivers/media/pci/saa7134/saa7134-alsa.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-alsa.c b/drivers/media/pci/cx23885/cx23885-alsa.c
index df44ed7..3f366e4 100644
--- a/drivers/media/pci/cx23885/cx23885-alsa.c
+++ b/drivers/media/pci/cx23885/cx23885-alsa.c
@@ -129,7 +129,7 @@ static int cx23885_alsa_dma_unmap(struct cx23885_audio_dev *dev)
 	if (!buf->sglen)
 		return 0;
 
-	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->sglen, PCI_DMA_FROMDEVICE);
+	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->nr_pages, PCI_DMA_FROMDEVICE);
 	buf->sglen = 0;
 	return 0;
 }
diff --git a/drivers/media/pci/cx25821/cx25821-alsa.c b/drivers/media/pci/cx25821/cx25821-alsa.c
index 3016164..c40304d 100644
--- a/drivers/media/pci/cx25821/cx25821-alsa.c
+++ b/drivers/media/pci/cx25821/cx25821-alsa.c
@@ -193,7 +193,7 @@ static int cx25821_alsa_dma_unmap(struct cx25821_audio_dev *dev)
 	if (!buf->sglen)
 		return 0;
 
-	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->sglen, PCI_DMA_FROMDEVICE);
+	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->nr_pages, PCI_DMA_FROMDEVICE);
 	buf->sglen = 0;
 	return 0;
 }
diff --git a/drivers/media/pci/cx88/cx88-alsa.c b/drivers/media/pci/cx88/cx88-alsa.c
index 7d7acee..3c6fe6c 100644
--- a/drivers/media/pci/cx88/cx88-alsa.c
+++ b/drivers/media/pci/cx88/cx88-alsa.c
@@ -332,7 +332,7 @@ static int cx88_alsa_dma_unmap(struct cx88_audio_dev *dev)
 	if (!buf->sglen)
 		return 0;
 
-	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->sglen,
+	dma_unmap_sg(&dev->pci->dev, buf->sglist, buf->nr_pages,
 		     PCI_DMA_FROMDEVICE);
 	buf->sglen = 0;
 	return 0;
diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index 544ca57..398c47f 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -313,7 +313,7 @@ static int saa7134_alsa_dma_unmap(struct saa7134_dev *dev)
 	if (!dma->sglen)
 		return 0;
 
-	dma_unmap_sg(&dev->pci->dev, dma->sglist, dma->sglen, PCI_DMA_FROMDEVICE);
+	dma_unmap_sg(&dev->pci->dev, dma->sglist, dma->nr_pages, PCI_DMA_FROMDEVICE);
 	dma->sglen = 0;
 	return 0;
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
