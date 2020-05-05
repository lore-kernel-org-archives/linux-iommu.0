Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F0C47263
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD8B2075A
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kapv75gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D5BE788164;
	Tue,  5 May 2020 08:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XV1XKCLsAVM7; Tue,  5 May 2020 08:46:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B9E587E5B;
	Tue,  5 May 2020 08:46:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19651C088E;
	Tue,  5 May 2020 08:46:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF80EC088E
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D835787B36
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8NdyYzlYJYUT for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 08:46:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4CA318666D
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:39 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200505084637euoutp01af1b05e89618141957a41fe8e9330559~MFX2mpII10379303793euoutp01O
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 08:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200505084637euoutp01af1b05e89618141957a41fe8e9330559~MFX2mpII10379303793euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1588668398;
 bh=wQWCLDgkzEAKWWbFtPWbi4gxIoOTq7jQENUDLHFuvtE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kapv75gZCOgtgNo2UsnLWcby7LZDq1YkIaUIvkG4SkRAeRx0hENKEbOmSwxs0Wj8d
 yXS6G/4VWG1BKOJ4Fip+uZPUbjmo4GuWgs7fk8FFH0l6kr3RluWN8K1y0g9B7k+mzQ
 1BJ2a7n+91/IU+uLrtV9Sy8Ve7Fq7UGfvg1M3Cbg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200505084637eucas1p1297f42df3c287917c2c0544c7e16b4d6~MFX2SMuf32430724307eucas1p13;
 Tue,  5 May 2020 08:46:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 8A.CF.61286.DE721BE5; Tue,  5
 May 2020 09:46:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c~MFX18i2791348613486eucas1p2o;
 Tue,  5 May 2020 08:46:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200505084637eusmtrp156559f615bad8ffc826c55f36f635cd2~MFX175TQi0969509695eusmtrp1C;
 Tue,  5 May 2020 08:46:37 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ba-5eb127eda261
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.31.07950.DE721BE5; Tue,  5
 May 2020 09:46:37 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200505084636eusmtip1c82086af8bba62a51d3ac39d5c0e7684~MFX1WUA2u0521305213eusmtip1I;
 Tue,  5 May 2020 08:46:36 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/25] misc: fastrpc: fix common struct sg_table related
 issues
Date: Tue,  5 May 2020 10:46:11 +0200
Message-Id: <20200505084614.30424-22-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUgTYRzHee52t/NlcZ2CTxZJgywl38joyJKiovOPMkzCiqyVhy+5KTu1
 lKSRGDVfMC0yUxnTpfk2nbLClPmSLl8xHdOYUWYYaqvwrTSyNi/tv8/v+8Lvx8NDoFQr5k7E
 ypJYuUwSL8YdBfru5UEf666GSH910Q46Z7AHoX/ndwvphkItRv/R30dp0+I3nM4o0+L0s+ou
 hFYZgugF0wRC6ybNGD3SXIzTta/eCen275+wwyKmprQGML9W8gHTuqQSMM+XPmCMoaRGyLzP
 MiJMY/ktxrI6iTIFYxWAeflWgTO5TVWAmddtP+183vFgFBsfm8LK/YIvO8Y0DCwLE6dEN/RD
 eagC9DgpgQMByUBoHnuIK4EjQZGVAE7OqgE/LABo6ez/N8wDqOivE6xXqnpqBbxRAeDnriXh
 RuVj/RSwp3AyACqtStzOrmQmgK9znO0hlJxBYGnxPcxuuJDhsP2NGrGzgNwJLT2GNV1EBsP2
 mWmMX+cBq+vbUDs72PTJ4fG1ayHZK4RzjzUIHzoGK0cXcJ5d4IyxScjzNthXkC3gCxkATgzW
 CvkhG8CR24WATwXB8cEVW5uw3ecFtc1+vHwEmr8OYXYZkpvgmHWzXUZtmK9/hPKyCN69Q/Fp
 T1hkrNtY2z40jPLMwPkWA8q/UBeAo1YNlgc8iv4vUwFQBdzYZE4azXIBMva6LyeRcsmyaN+r
 CVIdsH2qvlXj3AuwOHylA5AEEDuLIua1kRQmSeFSpR0AEqjYVfT0Z30kJYqSpKax8oRL8uR4
 lusAWwmB2E20Vz19kSKjJUnsNZZNZOXrLkI4uCtAGjeWHhcSUu49GuDQGxGqtezTeXqdKVP5
 6M3yLVl7xhOT+08eeuAv8w7jTilM1ZlhnmfVndWam+WNIZaBXKrDYmLJH+eCVko9oj32Bx6P
 qv1yYdVJ7d6G+CykU7O7E5+YjmpK/GZOaGRllFdSZoVVkq4Ut6jDVYYDPiY8NE4s4GIkAd6o
 nJP8BVF1RjhQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7pv1TfGGRz5zGXRe+4kk8XfScfY
 LTbOWM9q8X/bRGaLK1/fs1k0L17PZrFy9VEmiwX7rS2+XHnIZLHp8TVWi8u75rBZrD1yl93i
 4IcnrA68HmvmrWH0+P1rEqPH3m8LWDy2f3vA6rF/7hp2j/vdx5k8Ni+p97j97zGzx+Qbyxk9
 dt9sYPPo27KK0ePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
 m5TUnMyy1CJ9uwS9jI1nf7IXPOOt2HZhAnMD40nuLkZODgkBE4lVJ9eydDFycQgJLGWU6Pux
 jBkiISNxcloDK4QtLPHnWhcbRNEnRokb33awgSTYBAwlut5CJEQEOhklpnV/ZAdxmAU+MUkc
 uXYarEpYIEji7NlzTCA2i4CqxO2T+8HG8grYSRx89RJqhbzE6g0HwFZzAsUfX7oD1iskUCjx
 4fx31gmMfAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExs22Yz+37GDsehd8iFGAg1GJ
 h3fD1/VxQqyJZcWVuYcYJTiYlUR4l/3YECfEm5JYWZValB9fVJqTWnyI0RToqInMUqLJ+cCY
 ziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwNgu/CScU/HPrP+b
 8mJYTxhv/WifKa14eI5QTXGof8wdBSG1QCMd+8dKPHvnb1+fovBsCn/VWS5ZpSs7/JqrJ9j+
 PvxHT2aboU9au8LMulj2C5b/FeVDWnzf1B67zRXgbyE1+QU7g4ruTPXA7c8Wbtp83ePL6vo4
 i7A2uZAnb/feM7QImOznoMRSnJFoqMVcVJwIABoHAhCxAgAA
X-CMS-MailID: 20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c
X-Msg-Generator: CA
X-RootMTR: 20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <CGME20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c@eucas1p2.samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e3e085e..0a3e02aa 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -518,7 +518,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	table = &a->sgt;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents, dir))
+	if (!dma_map_sgtable(attachment->dev, table, dir))
 		return ERR_PTR(-ENOMEM);
 
 	return table;
@@ -528,7 +528,7 @@ static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
 				  struct sg_table *table,
 				  enum dma_data_direction dir)
 {
-	dma_unmap_sg(attach->dev, table->sgl, table->nents, dir);
+	dma_unmap_sgtable(attach->dev, table, dir);
 }
 
 static void fastrpc_release(struct dma_buf *dmabuf)
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
