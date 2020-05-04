Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C69DC4725D
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFDF2075B
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ebuomvrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFDF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D160923077;
	Mon,  4 May 2020 12:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSFaTbmPqX7J; Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1C10523109;
	Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C428C088F;
	Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7304BC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 69B0A88AD3
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EWrykf+v2eMl for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B8DD588896
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:21 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200504125420euoutp0274b944a1b61821b99564769a55b70ca4~L1G2ETjlt1778917789euoutp02g
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200504125420euoutp0274b944a1b61821b99564769a55b70ca4~L1G2ETjlt1778917789euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588596860;
 bh=d/1uwckI2LVANWOApzJOszkd0Tkvdz5gHxgS8c8MqOw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EbuomvrcSqpyA9CJ16VWzzg38G7GGVOcPgfe6SYUlhp0tskQWdOxy+V7MfP8LGEnF
 gqwZFShBq9x5dseBlb9UIlDVfQKT3AZNN2hVHHqiPAr0poHPmTjD+CmL3TVrETAgDl
 wZVHgt/sdzj6HB4qK5JTxvD7vvt38ankqemAfrqY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200504125420eucas1p259d8e02645d32e31dd06502636b01373~L1G1xK19p2427724277eucas1p22;
 Mon,  4 May 2020 12:54:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id F9.12.60698.B7010BE5; Mon,  4
 May 2020 13:54:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125419eucas1p2de6a2146cc694e4fa8e9c11024447cc6~L1G1UKToi2250922509eucas1p28;
 Mon,  4 May 2020 12:54:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200504125419eusmtrp2239857300b7c46b27106b5e68e931f14~L1G1TcJ1N2826928269eusmtrp2W;
 Mon,  4 May 2020 12:54:19 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-58-5eb0107bf329
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.69.08375.B7010BE5; Mon,  4
 May 2020 13:54:19 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200504125418eusmtip23875c85a2a18c6a8af6c482be9c87e21~L1G0pFKZs0350403504eusmtip27;
 Mon,  4 May 2020 12:54:18 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/21] drm: vmwgfx: fix sg_table nents vs. orig_nents misuse
Date: Mon,  4 May 2020 14:53:52 +0200
Message-Id: <20200504125359.5678-14-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUgUUQDGezO7s+OxNa2CL62EpZSkPDBqQpPUiIHClIjEyNp0UNNdt13P
 TDLNKHUrE/NIdEvN8tbWu/XWVSvTFFMyPCmMTPOs8Gin0frv977jffB4OCpQcY1xP0kQLZOI
 AoSYLqey/de7AxFEqaf127v2pKK7EyHLUku45HplIkr2L85g5IuCNoRUNtiRC/1jCFk+McAl
 v7W2A7KvNgMji1o/8cim2UkuOd/Vjh3jU4WZhYBSLyk5VNXSKJcaidcg1MucG9THtQmUShrM
 A1TdUBRG3VPlA2q+fDf1PWsac9Xz0LX3pgP8QmiZlcMlXd/Zz4mIdI0fllBRzo0C43pxQAeH
 xEG43DuAMiwgngMY/0YSB3S1vADgck8uhzXmARxqcd0spKc1oWwoD8AGzaONkLaxEHuaYYyw
 gXHTcRjDhkQsgB0KfaaAEmsITFpNRxjDgHCDU8vZPIY5xF7YeLPnr84njsLk2QLArpnCgtJG
 7RqO62j1NIU5cw8kuniw6fEUxmaOw9GMUg7LBvCrRsVjeSdcr8lC2EIMgGPdRTz2kABgX3Tq
 xoIdHO7+jTELKLEPltRasbIjTIxWAUaGxFY4OL2dkVEtPqxMQVmZD+/cFrBpM5iuKf4329Tz
 HmWZgon1kzz2sVoAVKx2ch4A0/T/Y0oA8oERHSwX+9ByWwkdaikXieXBEh9Lr0BxOdD+pddr
 msVqUL9yuRkQOBDq893nSzwFXFGIPFzcDCCOCg351be0Et9bFH6NlgVelAUH0PJmYIJzhEZ8
 26dTFwSEjyiI9qdpKS3bdBFcxzgKPClzj9w27B3Tle2tcCbGHaf1pSk+8da1BveDk9fVTmcM
 doT694Y4mG3JMN3VeM5izzOXn+5h7aHnvxwpLoowd1nJNHQ9oZyRjvzIzc9Rjjuoa/aPHToZ
 7hw1eiVjqcOlziS73qzCY3Fu8pSXa2RV24fDTm1WdtKYuVfqqxI39fWzdUKO3FdkY4HK5KI/
 ovJ1VkcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7rVAhviDDbcVbLoPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC3eHDnGaHF51xw2i7VH7rJbHPzwhNXi
 86ljbA68HmvmrWH02PttAYvH9m8PWD3udx9n8ti8pN7j9r/HzB6Tbyxn9Nh9s4HNo2/LKkaP
 z5vkPN7Nf8sWwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
 llqkb5egl/Hh2USmgn+8FT1bN7E2MD7i7mLk5JAQMJGYNfMgcxcjF4eQwFJGiev79rNDJGQk
 Tk5rYIWwhSX+XOtigyj6xCjRdOUEI0iCTcBQoustREJEoJNRYlr3R3YQh1mghVli75t/bCBV
 wgL+Ej8/TmUBsVkEVCUONF5gArF5BWwlpn5YzQixQl5i9YYDQHdwcHACxWf2qoOEhQTyJe4+
 /ccygZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBY2Xbs5+YdjJc2Bh9iFOBgVOLh
 jfi8Pk6INbGsuDL3EKMEB7OSCO+OFqAQb0piZVVqUX58UWlOavEhRlOgmyYyS4km5wPjOK8k
 3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PU3alm7+OCHZfwsMTs
 a5rNtGdu7oR204pqu1ajR68naMctcQrbu3+78S891+s3rz9af2iKc6ho+JWcyd/Nz8w5sbDx
 xQJ5loVxnM425Vs4tt6ZHlDYZvd0e8n+kxFsG3Y81PF3/yd8+sjrV6EXMtkfVe5i2rjmrZzK
 tA9HLKJs37k9cTR54+ysxFKckWioxVxUnAgAVtyVu6sCAAA=
X-CMS-MailID: 20200504125419eucas1p2de6a2146cc694e4fa8e9c11024447cc6
X-Msg-Generator: CA
X-RootMTR: 20200504125419eucas1p2de6a2146cc694e4fa8e9c11024447cc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125419eucas1p2de6a2146cc694e4fa8e9c11024447cc6
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
 <20200504125359.5678-1-m.szyprowski@samsung.com>
 <CGME20200504125419eucas1p2de6a2146cc694e4fa8e9c11024447cc6@eucas1p2.samsung.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
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
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index bf0bc46..a5fd128 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -362,7 +362,7 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
 
-	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
+	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.orig_nents,
 		DMA_BIDIRECTIONAL);
 	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
 }
@@ -449,10 +449,10 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
 		if (unlikely(ret != 0))
 			goto out_sg_alloc_fail;
 
-		if (vsgt->num_pages > vmw_tt->sgt.nents) {
+		if (vsgt->num_pages > vmw_tt->sgt.orig_nents) {
 			uint64_t over_alloc =
 				sgl_size * (vsgt->num_pages -
-					    vmw_tt->sgt.nents);
+					    vmw_tt->sgt.orig_nents);
 
 			ttm_mem_global_free(glob, over_alloc);
 			vmw_tt->sg_alloc_size -= over_alloc;
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
