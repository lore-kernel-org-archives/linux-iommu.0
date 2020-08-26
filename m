Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5227C433F2
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9ED520738
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H/n4Er4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ED520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 96CF486BA8;
	Wed, 26 Aug 2020 06:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1xpqF3HMEADD; Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 19B8F86A01;
	Wed, 26 Aug 2020 06:35:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB541C088B;
	Wed, 26 Aug 2020 06:35:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 865EEC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BB8687C69
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TIe2tOEVI1iO for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 158D187BCA
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:38 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200826063536euoutp020f37dda71cef28ef0cbb605a426271d6~uvetm0RBQ1512715127euoutp02N
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 06:35:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200826063536euoutp020f37dda71cef28ef0cbb605a426271d6~uvetm0RBQ1512715127euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1598423736;
 bh=zV96V2vYwfqZCBn3pFDPDrE8ppfbK/CRdkHj1ScotiE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H/n4Er4QPzOzSuBCHYZw4AYdG8dzKqwLbK2C1KNnt8kEf5IkDGqbuauGQXqFYLQ2V
 VMfRbqh9brPDqXDLT4hVn/UbhQkA27zpzPvVBtWtX/ksqJF1Q99MhZMy1V1mfdmCtz
 7PcZYNW/Pcqu9bWFPtJ/+AuDgvOvuYIT4bPmax7g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200826063536eucas1p25c5d5de87b71359b29111176bb2cee4a~uvetR1RSu0398703987eucas1p2c;
 Wed, 26 Aug 2020 06:35:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id F3.33.06456.7B2064F5; Wed, 26
 Aug 2020 07:35:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200826063535eucas1p1a98e3295a64f14d475371ac0b003782f~uveswhcCT1942019420eucas1p1p;
 Wed, 26 Aug 2020 06:35:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200826063535eusmtrp137e167fd92381384774e4ac4e5ac322a~uvesv43Nj1091110911eusmtrp1V;
 Wed, 26 Aug 2020 06:35:35 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-c7-5f4602b7af8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.D0.06314.7B2064F5; Wed, 26
 Aug 2020 07:35:35 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200826063534eusmtip21435f3c414f0a9927d8816cfb94d420e~uvesM5GtN0092200922eusmtip2z;
 Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 13/32] drm: omapdrm: use common helper for extracting
 pages array
Date: Wed, 26 Aug 2020 08:32:57 +0200
Message-Id: <20200826063316.23486-14-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+c7Zzs50s+MU/FJRGBSUpElBhwyt0DpEQnQzjNSVB5WcyqaW
 /tM0FZvOSyapZY4QbN4znctMc6WzzBXeWGpeUDHNaeWlEnLteMz++73P+7zv8/Lx4aionuuM
 R8XE07IYSbQYs+Fou34b9+mQE6H7M2sQUmV8i5BPi+q4pEWbj5IDq0sYqanqREh1uw+5MjCJ
 kA1TQ1yyv+UhRta8+cwjO75Nc8m6smHsqICqflQNqJdrag7VvDbBpcazDAj1rPwWNbIxhVIF
 pgpAvfikwKicxkpAGUzNCLXc4HbGNtjmSDgdHZVIy7x8w2wiB0sLsbgi25uLcxpUAdL5SsDH
 IXEQjr/PR5TABhcRTwD8MrTGY4sVAFNyVRy2WAYw4/sQ99/IcknqVqMCwLRRC7o9sjhRjzAu
 jPCGSrMSY9iRSAewWyVgTCihR2Bj+iCHaTgQF6FhXbHJHGIXzGmwAIaFhC/U9uo4bJw7rKp/
 hTLMt+qGrFyM1dt4cP6dvRLgVvaHC812rOwA5w2NPJZdYU9B9ualkLgN4KSxhscW2QD2pxYB
 1uUDR43rGLMIJfbAuhYvVj4Gm5R3MHa/HTSZ7RkZteJd7X2UlYUwM0PEunfDEkPtdmzHx74t
 CwX1ZX7s8+QD2DE4juYB95L/WWoAKoETnSCXRtBy7xj6hqdcIpUnxER4XouVNgDrP+rZMPzQ
 gdW+q3pA4EAsEKqxgFARV5IoT5LqAcRRsaPweG9PiEgYLklKpmWxobKEaFquBy44R+wkPPB4
 7oqIiJDE09dpOo6W/esiON9ZAWrGdIVpivKl9Z8egR+ahydK9WNdrh7eoufJfuO/ZnsFywun
 khQmpXQ2iPDgtwrMl4tP1xLV9y4F+rsoZ5pyNW3t5wI07cUPvoZ1h1jy/pSlp0SDUmxn5yG1
 W+vGzOuVw3FZquDzZy/oRnYECuFKm2p+HTHrfRHaGEROD59cEnPkkRLvvahMLvkL9KqiU0MD
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7rbmdziDZ6ul7foPXeSyWLjjPWs
 Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZrH2yF12i4MfnrBarJ9/i82B
 x2PNvDWMHnu/LWDx2P7tAavH/e7jTB6bl9R73P73mNlj8o3ljB67bzawefRtWcXocfzGdiaP
 z5vkArij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S
 9DKuzp3KVjCDu+Ldy5XMDYytnF2MnBwSAiYSn2c1sXQxcnEICSxllPj4ZD4zREJG4uS0BlYI
 W1jiz7UuNoiiT4wSS9f8YwJJsAkYSnS9hUiICHQySkzr/sgO4jALnGCSuLd3PiNIlbBAiMTj
 Vf1sIDaLgKpE36b/YHFeATuJbWd3sECskJdYveEA2GpOoPjxboh6IQFbidNrZzBPYORbwMiw
 ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBGth37uXkH46WNwYcYBTgYlXh4F7C5xguxJpYV
 V+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp0FETmaVEk/OB8ZtXEm9oamhuYWlo
 bmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoExsOiDYNk3/0OXvWLWz4q67dmUrb6B
 h9/cZ4OJcxyv+7qbGV/T93p37+MymdNfVcg6bfuaa6eX1Vt/ZVyY2iq8fd9EnkUfny7L8a1Q
 mHBTsNyq+/xmr4LpRi92vQrfnvxcbaFE3vEyuRefedJbJfUj7HfrTi+dcXRuVNCNzyHFAsFJ
 Ox6qBWkosRRnJBpqMRcVJwIARoD5MKcCAAA=
X-CMS-MailID: 20200826063535eucas1p1a98e3295a64f14d475371ac0b003782f
X-Msg-Generator: CA
X-RootMTR: 20200826063535eucas1p1a98e3295a64f14d475371ac0b003782f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063535eucas1p1a98e3295a64f14d475371ac0b003782f
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063535eucas1p1a98e3295a64f14d475371ac0b003782f@eucas1p1.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
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

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index d0d12d5dd76c..ff0c4b0c3fd0 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1297,10 +1297,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
 	} else {
 		/* Create pages list from sgt */
-		struct sg_page_iter iter;
 		struct page **pages;
 		unsigned int npages;
-		unsigned int i = 0;
+		unsigned int ret;
 
 		npages = DIV_ROUND_UP(size, PAGE_SIZE);
 		pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
@@ -1311,14 +1310,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		}
 
 		omap_obj->pages = pages;
-
-		for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
-			pages[i++] = sg_page_iter_page(&iter);
-			if (i > npages)
-				break;
-		}
-
-		if (WARN_ON(i != npages)) {
+		ret = drm_prime_sg_to_page_addr_arrays(sgt, pages, NULL,
+						       npages);
+		if (WARN_ON(ret)) {
 			omap_gem_free_object(obj);
 			obj = ERR_PTR(-ENOMEM);
 			goto done;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
