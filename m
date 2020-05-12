Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94F2C81853
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0D720714
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TCJGbQsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0D720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 844518701F;
	Tue, 12 May 2020 09:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KIOUXsHy0QPT; Tue, 12 May 2020 09:01:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE20187122;
	Tue, 12 May 2020 09:01:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A03AEC0893;
	Tue, 12 May 2020 09:01:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9BD6C088E
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9AF2788291
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vPCL0aqonCAS for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:01:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 14FAC88376
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:30 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512090128euoutp0265d3833f7571cf5dbd15f9fa4384987e~OPF0Clh2x0482404824euoutp024
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:01:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200512090128euoutp0265d3833f7571cf5dbd15f9fa4384987e~OPF0Clh2x0482404824euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589274088;
 bh=BArEnwlZV6yXcbVCJZm10TtidFE3Koqpc+04N057bYI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TCJGbQsufbbvzgUKGojWZ/NMRdRmmO6fayzjE+MXhJE9ckxDKLXldC5LsS0NwCe92
 G/Vku+kfIyLI0TiXMJSLmZ/SE2RQ2Wqb6WOP7Uf0EYjtAAXMPa+AxL/qAyGFqv4Z8p
 lEgSM3LeHEX3XAQw7Kkz8JLexVt0eAoMBstuTl5c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200512090128eucas1p27fe6fe11596863115806d57d4e3a87ea~OPFzxT5Bd1372813728eucas1p2e;
 Tue, 12 May 2020 09:01:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A6.32.60679.8E56ABE5; Tue, 12
 May 2020 10:01:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200512090128eucas1p2cf31bfdca3b096585ba9f2741ef08ce0~OPFzb9Eku2110421104eucas1p2O;
 Tue, 12 May 2020 09:01:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512090128eusmtrp1a81d3b11ff6134e7f5d1e37fb26ae025~OPFzbKWPm0183401834eusmtrp12;
 Tue, 12 May 2020 09:01:28 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-d9-5eba65e8f74e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 68.03.07950.7E56ABE5; Tue, 12
 May 2020 10:01:27 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512090127eusmtip14b6982a0ff8e934c7db2200583cbc90a~OPFy6Z7r31181011810eusmtip1v;
 Tue, 12 May 2020 09:01:27 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 34/38] misc: fastrpc: fix common struct sg_table related
 issues
Date: Tue, 12 May 2020 11:00:54 +0200
Message-Id: <20200512090058.14910-34-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTURzn3Hu3XcXZbS520EhaKJXko/xwwdKEPlxKeuEnwcfUi1pOZddH
 huHwEbp8TvOVmqig+cjyrUNsQzebMJ+JPURFkTVTAx/gI2vzan77/X+P/++cw8FRwQDHHo+K
 iadlMZJoMdca69bujl0z0v1B7vVGIZlr+IyQf5RaHvmxrI1D/u0uRMnp7Q0umV7XxiXfNQ8j
 ZM2gF7k1vYiQ7UszHHKqv5JLtg7N8Uj172XObT7VUt0CqP09JaAGdmowqmdngUMNVrXwqPlX
 OoTqqE+lvh8uoVTRbAOgVF/lXCqvswlQm+0XHtoEWN8Mp6OjEmmZm3eIdeSIqQuNyxY80zYW
 Y3JQcEYBrHBIeMLCfCOqANa4gGgE8I1eCdhhC8CpsTkOO2wCmNW5zT2JZKfVI6zQAGDVQsZp
 ZGW5C7W4uIQHVKwpjhJCIhPAkVwbiwklTAisrszmWAQ7wh9qB9Q8C8YIJ7gv/4JYMJ/whvKd
 oeM6R9j84dPRUiszP//2ALMsgoSeBzdrizHWdAeO/2o6DthBk66Tx+LzcLQo5ziQDuCioZXH
 Djnm66WVAdblBX8Y9sxp3Hy+K7Ct342lfeFaq55noSFhC2fXzlpo1AyV3aUoS/Nh1ksB63aG
 Fbr3/2vV45MoiymoUJmO33EYQE2vBisAjhWnZTUANAERncBII2jmegyd5MpIpExCTIRrWKy0
 HZg/1eihbqsX9B+EagCBA7EN3929L0jAkSQyyVINgDgqFvIzoswUP1yS/JyWxQbLEqJpRgMc
 cEws4t+o/RkoICIk8fRTmo6jZScqglvZy0FOtKQndap8KWo0ySe/yku/futSx2O/8gn/dbnU
 eFFIuQRezsusVaka9nZX933vMaLcRr/clJmJ8uIHxklRsPSbwKE0xFDqXOLiFZCz2uetU50L
 9Yi975xCrvhKN+Kzwmwb/FdeiOaRoQTlvM/4ob71ruG1Z8kjpyemwGD1cJ0YYyIlHldRGSP5
 B2crIfpQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7ovUnfFGezgs+g9d5LJ4u+kY+wW
 G2esZ7X4v20is8WVr+/ZLJoXr2ezWLn6KJPFgv3WFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHw
 wxNWB16PNfPWMHr8/jWJ0WPvtwUsHtu/PWD12D93DbvH/e7jTB6bl9R73P73mNlj8o3ljB67
 bzawefRtWcXo8XmTXABPlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
 SmpOZllqkb5dgl7GiVdbmQs6hSqOrZjC0sA4gb+LkZNDQsBEorNpCVMXIxeHkMBSRonfZ66w
 QiRkJE5Oa4CyhSX+XOtigyj6xCjx/eVNNpAEm4ChRNdbiISIQCejxLTuj+wgDrPAJyaJI9dO
 g1UJCwRJvFw7jwXEZhFQlfjdcJUJxOYVsJNo+HaEDWKFvMTqDQeYQWxOoPj9+X/A6oUECiUe
 XX3LMoGRbwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAqNl27OeWHYxd74IPMQpwMCrx
 8HYY7YwTYk0sK67MPcQowcGsJMLbkgkU4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5HxgROeV
 xBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBs9csTUfGN9CrfMj38
 kdii24cSUt3Dt3tcMbl6tn7VszyObX4Cz658XTdBMM9wjc0vmznKyrmJr1+4THm/eG6rdpvt
 tFlCnE2nVy5bvK7OjKdmGaOi4snK0wIVTd8+Ks8qkrhlO7PO5onfqaSXf7cEPl55t1316+Kb
 9Qu1So1fsxTtVrjlFdmoxFKckWioxVxUnAgAqkItvLACAAA=
X-CMS-MailID: 20200512090128eucas1p2cf31bfdca3b096585ba9f2741ef08ce0
X-Msg-Generator: CA
X-RootMTR: 20200512090128eucas1p2cf31bfdca3b096585ba9f2741ef08ce0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090128eucas1p2cf31bfdca3b096585ba9f2741ef08ce0
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <CGME20200512090128eucas1p2cf31bfdca3b096585ba9f2741ef08ce0@eucas1p2.samsung.com>
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
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
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
