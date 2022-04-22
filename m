Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FBBC433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 14:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65AE94036A;
	Fri, 22 Apr 2022 14:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Y0HvzTVgrbo; Fri, 22 Apr 2022 14:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E42E403FF;
	Fri, 22 Apr 2022 14:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0935EC0039;
	Fri, 22 Apr 2022 14:40:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4690EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 337E382486
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjkDsKFRhjzb for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 06:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0FFA81DCB
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:45 +0000 (UTC)
X-UUID: 2105a45cd1364541aa541b5f2f03d188-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:29a0b2db-62f2-4906-b4f0-bc243d30d1fd, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:61,FILE:0,RULE:Release_Ham,A
 CTION:release,TS:41
X-CID-INFO: VERSION:1.1.4, REQID:29a0b2db-62f2-4906-b4f0-bc243d30d1fd, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:61,FILE:0,RULE:Release_UHam,AC
 TION:release,TS:41
X-CID-META: VersionHash:faefae9, CLOUDID:7639beef-06b0-4305-bfbf-554bfc9d151a,
 C
 OID:8c65ce02598c,Recheck:0,SF:13|15|28|100|16|18|48|101,TC:nil,Content:0,E
 DM:-3,File:nil,QS:0,BEC:nil
X-UUID: 2105a45cd1364541aa541b5f2f03d188-20220422
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <mark-pk.tsai@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1391016878; Fri, 22 Apr 2022 14:24:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 14:24:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Fri, 22 Apr 2022 14:24:40 +0800
To: <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
 <robin.murphy@arm.com>
Subject: [PATCH 1/2] dma-mapping: Add dma_release_coherent_memory to DMA API
Date: Fri, 22 Apr 2022 14:24:35 +0800
Message-ID: <20220422062436.14384-2-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Fri, 22 Apr 2022 14:40:41 +0000
Cc: yj.chiang@mediatek.com, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, mark-pk.tsai@mediatek.com,
 matthias.bgg@gmail.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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
From: Mark-PK Tsai via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add dma_release_coherent_memory to DMA API to allow dma
user call it to release dev->dma_mem when the device is
removed.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 include/linux/dma-map-ops.h |  3 +++
 kernel/dma/coherent.c       | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b3a4a6..53db9655efe9 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -166,6 +166,7 @@ static inline void dma_pernuma_cma_reserve(void) { }
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 		dma_addr_t device_addr, size_t size);
+void dma_release_coherent_memory(struct device *dev);
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 		dma_addr_t *dma_handle, void **ret);
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
@@ -177,6 +178,8 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 {
 	return -ENOSYS;
 }
+
+#define dma_release_coherent_memory(dev) (0)
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 375fb3c9538d..c21abc77c53e 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -74,7 +74,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	return ERR_PTR(-ENOMEM);
 }
 
-static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
+static void _dma_release_coherent_memory(struct dma_coherent_mem *mem)
 {
 	if (!mem)
 		return;
@@ -126,10 +126,16 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 
 	ret = dma_assign_coherent_memory(dev, mem);
 	if (ret)
-		dma_release_coherent_memory(mem);
+		_dma_release_coherent_memory(mem);
 	return ret;
 }
 
+void dma_release_coherent_memory(struct device *dev)
+{
+	if (dev)
+		_dma_release_coherent_memory(dev->dma_mem);
+}
+
 static void *__dma_alloc_from_coherent(struct device *dev,
 				       struct dma_coherent_mem *mem,
 				       ssize_t size, dma_addr_t *dma_handle)
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
