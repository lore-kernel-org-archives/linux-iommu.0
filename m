Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB7C433F4
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC9A214F1
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bQa0yWL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC9A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8E3F85124;
	Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUR9zrTYsqrf; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3C4C587C28;
	Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29FA2C016E;
	Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA61C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 110CE22735
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SCdccIfO9g5e for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 28BB120502
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:27 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200618154025euoutp02184bab2e97859aee272c10de3ac837a0~ZrZtAM6hX1314513145euoutp02F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:40:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200618154025euoutp02184bab2e97859aee272c10de3ac837a0~ZrZtAM6hX1314513145euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592494825;
 bh=IwcN7HT+JUiCjrdqrw1qwR5B7c/UG3T+h59divjRKuo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bQa0yWL3tpE4TAAweGICtwH1O5PmCryqpjVdu0TdRrYcufZ4TRghu3zWddtzX3x9O
 5fGwGK64k1fiKAPEAHRXqPocmRpn5+KHO+5tTqZUfcAELlxH666ek06haukPx7Zrgo
 66WeO1D5U6hvSGV+o51ADBRv6piFQT1ZlB8mr0UM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200618154025eucas1p1bbec352e6eb778b3a44f8e1703ddfe0e~ZrZsscZph1545515455eucas1p1Z;
 Thu, 18 Jun 2020 15:40:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 85.60.60698.9EA8BEE5; Thu, 18
 Jun 2020 16:40:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200618154024eucas1p2e093781df622f8326297518f4eacd2fe~ZrZsdSY3K0501005010eucas1p2c;
 Thu, 18 Jun 2020 15:40:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200618154024eusmtrp1865efaf4ced0e5aa6b4e9b3c5a67e3dc~ZrZscoXLk2169821698eusmtrp1b;
 Thu, 18 Jun 2020 15:40:24 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-31-5eeb8ae99ba5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 36.E9.07950.8EA8BEE5; Thu, 18
 Jun 2020 16:40:24 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200618154024eusmtip14148cff89bfa17ed0df8ad6b9329bd76~ZrZrxSnWt0744107441eusmtip11;
 Thu, 18 Jun 2020 15:40:24 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/36] drm: panfrost: fix common struct sg_table related
 issues
Date: Thu, 18 Jun 2020 17:39:37 +0200
Message-Id: <20200618153956.29558-17-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSW0hTcRjnv7OdHc3FaQr+UclYFJTmBQ0OzLSL4ekhktxDRZkrT1Oam+yo
 ZS95W+SaQ/NBkagRknnPaWtpmo7pjOkUFZu30rSLmmh5KxHX5pn29vt+3+/yPXwYwm/h+GDJ
 sjRKIRNLBag7W9/113psVjUfHzKQu4cosH5gEQ2l9RzCri9CiKHVRZSorO5kEdr3QmJlaIpF
 6KaHOcRg8xOUqDVNcAn7OwOX6Fia4RCa2gH0JI+seVoDSMNEOSBb17RsUleVj5Jv1iY55OdH
 ZhbZWH6fHNuaRshiWwUgW0ayUFLTVAXIZd3+WI8r7hGJlDQ5g1IERya4J7VUjaKpPfDu118W
 bhbo9lIBNwzi4bCxZB1VAXeMj78E8K0+3zWsALhhUANmWAZw+mMfZ8eyvmx0LSoA7Kn/jexa
 WjVjiFOF4qFQtaBCndgLVwLYXeDhFCH4DAva/tRuR3niItinNjmiMIyNH4JDXUInzcMj4dLr
 RsC0+cPqV+3bmW4O3mJWcpw5ELdyYX/3kEsUDU0rzxAGe8I5cxOXwX7QUqxmM4ZcAKestVxm
 UAM4mFPqcgvhuHUDdV6B4EdgfXMwQ5+COYYFrpOG+F5oW9jnpBEHfKwvQRiaBx8+4DPqw7DM
 XLdb29E/4DqHhLP9ldtFfLwIwN4vAYXAv+x/lxaAKuBNpdMpEooOk1F3gmhxCp0ukwTdlKfo
 gOOlLFvmVQNo27xhBDgGBB68H6L5eD5HnEFnphgBxBCBF+90ryWez0sUZ96jFPLrinQpRRuB
 L8YWePPCns9e4+MScRp1m6JSKcXOloW5+WQBdWjHXER7Xbz0rLAmDrkYbs/zy95sD2gAZT3V
 InX0eZspzq5sm/wWg4px+WjjeHUyTg5OXVg0kBWhuhGt7ZbvkujATEtg3kYIECklXp6Jx2Xf
 +2xR61fP0YWLxVGXEjSBWPLImc6SEf/LcvBzOLb8xCe9tEsUk738wnYQE7DpJHHoUURBi/8B
 /a4TOk4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7ovul7HGSybYGrRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFv/37GC3OPjhCatF
 39pLbA68HmvmrWH02HF3CaPH3m8LWDw2repk89j+7QGrx/3u40wem5fUe9z+95jZY/KN5Ywe
 u282sHn0bVnF6PF5k1wAT5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
 TUpqTmZZapG+XYJexu5Vt9gKzkhUPP14mr2B8YRIFyMnh4SAicT3z4cYuxi5OIQEljJKrNq3
 hhkiISNxcloDK4QtLPHnWhcbRNEnRome9nWMIAk2AUOJrrcQCRGBTkaJad0f2UESzAJvmCQu
 XY0AsYUFgiRO3LoGNJWDg0VAVeLKMWuQMK+AncSHrZsZIRbIS6zecABsMSdQ/PTxVrDFQgK2
 Es8/tLFNYORbwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBmth37uWUHY9e74EOMAhyM
 Sjy8L0JexwmxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0E0TmaVEk/OB
 8ZxXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHx0LzAfpscs/Dv
 d5Yk35PmammMXHfFN01OYXrC/uvPJWInTZe+U7+zIVMpa/rZ1Qdu9p7+Fux5mXetU6XfhK6f
 1/6pxZw+VCvh/ivXZ7duXeT9b48D9maLmzcHnv/o8DQzazl/xDPfZ4IMTGn7FYMy3BykQxgL
 o5N1LFTXeT66xj+tZ47m3PlKLMUZiYZazEXFiQAFAmGNrwIAAA==
X-CMS-MailID: 20200618154024eucas1p2e093781df622f8326297518f4eacd2fe
X-Msg-Generator: CA
X-RootMTR: 20200618154024eucas1p2e093781df622f8326297518f4eacd2fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154024eucas1p2e093781df622f8326297518f4eacd2fe
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
 <CGME20200618154024eucas1p2e093781df622f8326297518f4eacd2fe@eucas1p2.samsung.com>
Cc: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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

The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
returns the number of the created entries in the DMA address space.
However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
dma_unmap_sg must be called with the original number of the entries
passed to the dma_map_sg().

struct sg_table is a common structure used for describing a non-contiguous
memory buffer, used commonly in the DRM and graphics subsystems. It
consists of a scatterlist with memory pages and DMA addresses (sgl entry),
as well as the number of scatterlist entries: CPU pages (orig_nents entry)
and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg()
function.

To avoid such issues, lets use a common dma-mapping wrappers operating
directly on the struct sg_table objects and use scatterlist page
iterators where possible. This, almost always, hides references to the
nents and orig_nents entries, making the code robust, easier to follow
and copy/paste safe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index ac5d0aa80276..ba8450ea04d0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -41,8 +41,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 
 		for (i = 0; i < n_sgt; i++) {
 			if (bo->sgts[i].sgl) {
-				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
-					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
+				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
+						  DMA_BIDIRECTIONAL, 0);
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 0a339c6fbfaa..fd294f6a7d3b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -253,7 +253,7 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
 	u64 start_iova = iova;
 
-	for_each_sg(sgt->sgl, sgl, sgt->nents, count) {
+	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
 		size_t len = sg_dma_len(sgl);
 
@@ -517,10 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_pages;
 
-	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret)
 		goto err_map;
-	}
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
