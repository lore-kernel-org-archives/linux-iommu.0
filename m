Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85816C25AEB
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 20:16:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5253960F4A
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 20:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5253960F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FBF883B54;
	Thu, 29 Jul 2021 20:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G6KeRARGwuzI; Thu, 29 Jul 2021 20:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C50983B4B;
	Thu, 29 Jul 2021 20:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71EE1C0026;
	Thu, 29 Jul 2021 20:16:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D4DC001A
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 20:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4497060A56
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 20:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wl7vGtVZ0ll1 for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 20:16:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DFF460A53
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=HMmFCnKiUdZs8XdQrQe+q8n2y8J+pVaubqcncKbrGOc=; b=A77gCyW0d5juDnc7b5J4XOqhxW
 HC57NwrmUkwURjzWQkN9Syh/0vIuAlf3WMVmAPjrtxJ1fn92qxbnJNpgU1MccuVhE2XKvFuqbZ6yb
 s4fF0FP/eLp622wLZAXdLOs1988jAnkVr1m669v4Wlf/syuBk3Ho8Vj55j4bEOpC9EfUgEe0FssYq
 VKgfZMT9ybpjeOvebQMfL0EgOvY+EEEFuQo48AhmPiedYHvJjPv7Cdm5M5k8eo/gt/Fsie7h1kOto
 JwLBrYfbP2HP/+Y3m8ecKhNp5avb4GgJLw2mTfAo1TzqbqlE1K6UMF2u4lpxSzKwZa6Gnvq+ycvAH
 IkOANShw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1m9CRh-0008VM-Ts; Thu, 29 Jul 2021 14:15:59 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1m9CRU-0001Tt-QD; Thu, 29 Jul 2021 14:15:44 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Thu, 29 Jul 2021 14:15:28 -0600
Message-Id: <20210729201539.5602-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729201539.5602-1-logang@deltatee.com>
References: <20210729201539.5602-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, sbates@raithlin.com,
 martin.oliveira@eideticom.com, logang@deltatee.com, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, geoff@infradead.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 10/21] powerpc/iommu: return error code from .map_sg() ops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geoff Levand <geoff@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Stephen Bates <sbates@raithlin.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Martin Oliveira <martin.oliveira@eideticom.com>

The .map_sg() op now expects an error code instead of zero on failure.

Propagate the error up if vio_dma_iommu_map_sg() fails.

ppc_iommu_map_sg() may fail either because of iommu_range_alloc() or
because of tbl->it_ops->set(). The former only supports returning an
error with DMA_MAPPING_ERROR and an examination of the latter indicates
that it may return arch-specific errors (for example,
tce_buildmulti_pSeriesLP()). Hence, coalesce all of those errors into
-EIO, per the documentation on dma_map_sgtable().

Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/kernel/iommu.c             | 4 ++--
 arch/powerpc/platforms/ps3/system-bus.c | 2 +-
 arch/powerpc/platforms/pseries/vio.c    | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 2af89a5e379f..a8ec4fe42817 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -473,7 +473,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 	BUG_ON(direction == DMA_NONE);
 
 	if ((nelems == 0) || !tbl)
-		return 0;
+		return -EINVAL;
 
 	outs = s = segstart = &sglist[0];
 	outcount = 1;
@@ -599,7 +599,7 @@ int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		if (s == outs)
 			break;
 	}
-	return 0;
+	return -EIO;
 }
 
 
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 1a5665875165..c54eb46f0cfb 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -663,7 +663,7 @@ static int ps3_ioc0_map_sg(struct device *_dev, struct scatterlist *sg,
 			   unsigned long attrs)
 {
 	BUG();
-	return 0;
+	return -EINVAL;
 }
 
 static void ps3_sb_unmap_sg(struct device *_dev, struct scatterlist *sg,
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index e00f3725ec96..e31e59c54f30 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -560,7 +560,8 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 	for_each_sg(sglist, sgl, nelems, count)
 		alloc_size += roundup(sgl->length, IOMMU_PAGE_SIZE(tbl));
 
-	if (vio_cmo_alloc(viodev, alloc_size))
+	ret = vio_cmo_alloc(viodev, alloc_size);
+	if (ret)
 		goto out_fail;
 	ret = ppc_iommu_map_sg(dev, tbl, sglist, nelems, dma_get_mask(dev),
 			direction, attrs);
@@ -577,7 +578,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 	vio_cmo_dealloc(viodev, alloc_size);
 out_fail:
 	atomic_inc(&viodev->cmo.allocs_failed);
-	return 0;
+	return ret;
 }
 
 static void vio_dma_iommu_unmap_sg(struct device *dev,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
