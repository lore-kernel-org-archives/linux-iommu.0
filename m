Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C4C433F8
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881C320C09
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PE4LzYrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881C320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6EEF320029;
	Fri, 19 Jun 2020 10:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnAgFlfEnLTE; Fri, 19 Jun 2020 10:37:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 28C9827D23;
	Fri, 19 Jun 2020 10:37:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07C58C089E;
	Fri, 19 Jun 2020 10:37:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3AFC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 31D17877A8
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uxjsxn0oWzSu for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 10:37:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9841687700
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:03 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200619103702euoutp017bf204018f62fd54413e5c35fcd08b24~Z66GIjK3R1849718497euoutp01Q
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 10:37:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200619103702euoutp017bf204018f62fd54413e5c35fcd08b24~Z66GIjK3R1849718497euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1592563022;
 bh=dgA8N0ViLqnC/QZEgzrc3l/K0+XnEV3AJx7m2vhhZ9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PE4LzYrd6uUeRXWdQDMTvPW9GqCB6ekBU9J8Qoubhl8dQOzjiNqcV9zSmL8glBmeo
 Z3VrxMRzIU4yVUYeER6z/WG7WmAkMvm0RYHU5i8NcGkItj4uCx8g16SQh2o7irjg/w
 jYic7ujGMnDiKD/2vhagIskbRa5QW7Pt4w83WziA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200619103701eucas1p2e4008a7ddd1cda75ce7e7ff09ce39677~Z66Fnmrb81674116741eucas1p2F;
 Fri, 19 Jun 2020 10:37:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id E3.9D.05997.D459CEE5; Fri, 19
 Jun 2020 11:37:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103701eucas1p2323797b812f4d8c28e851aa80938a8dc~Z66FRTVYO1675016750eucas1p2B;
 Fri, 19 Jun 2020 10:37:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200619103701eusmtrp1774c5f529632baeace94574dc976e819~Z66FQf2tk0959609596eusmtrp19;
 Fri, 19 Jun 2020 10:37:01 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-df-5eec954da907
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.EA.06314.D459CEE5; Fri, 19
 Jun 2020 11:37:01 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200619103700eusmtip2d0ed865fa41b3cff8d1f2c9dc2e59af7~Z66Egh1F90302603026eusmtip2N;
 Fri, 19 Jun 2020 10:37:00 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/36] drm: mediatek: use common helper for extracting
 pages array
Date: Fri, 19 Jun 2020 12:36:12 +0200
Message-Id: <20200619103636.11974-13-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djP87q+U9/EGby9p2HRe+4kk8XGGetZ
 LRb19rJY/N82kdniytf3bBYrVx9lsliw39riy5WHTBabHl9jtbi8aw6bxeXmi4wWa4/cZbdo
 ajG2uHvvBIvFwQ9PWB34PdbMW8PosffbAhaPnbPusntsWtXJ5rH92wNWj/vdx5k8Ni+p97j9
 7zGzx+Qbyxk9dt9sYPPo/2vg0bdlFaPH501yAbxRXDYpqTmZZalF+nYJXBldf3cwFzzgrLgx
 4TVzA+MUji5GTg4JAROJfRefs3cxcnEICaxglOi7cYMFwvnCKNG47wlU5jOjxMquN0wwLRMe
 tEElljNKHNt2lAmu5ee0fhaQKjYBQ4mut11sILaIQCujxIleHpAiZoE9zBKLdv0CKxIWCJfY
 MXkhWBGLgKrE1WcPwWxeATuJd1fuMUOsk5dYveEAmM0JFH/dcpAVZJCEwD12iX1dj1ghilwk
 Ti3aDHWfsMSr41vYIWwZidOTe1ggGpoZJR6eW8sO4fQwSlxumsEIUWUtcefcL6DVHED3aUqs
 36UPEXaUuPj4AxNIWEKAT+LGW0GQMDOQOWnbdGaIMK9ER5sQRLWaxKzj6+DWHrxwCep+D4ld
 mx4xQkJoIqPEwq+bmCcwys9CWLaAkXEVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYAo7
 /e/4lx2Mu/4kHWIU4GBU4uF9EfI6Tog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWpRfnxRaU5
 qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MLoe0VEs0vow/Yj62gNv/n7jV6/f
 uVLn+t0nW9ealazxtox8qyXIsfzR3MxZtU9uP18h4KfrUyapEywRb9dqUtyw4G+Vs1id/J+/
 x5g+T1Iws4mrm7N8UZf5HpVDFw8tYTqQ0f1b2VxFxrYnrU7kSNL6CT2RXD5zFcNCGMMaFb7G
 rt/BtfZMhxJLcUaioRZzUXEiAOfsqZNdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7q+U9/EGezby2vRe+4kk8XGGetZ
 LRb19rJY/N82kdniytf3bBYrVx9lsliw39riy5WHTBabHl9jtbi8aw6bxeXmi4wWa4/cZbdo
 ajG2uHvvBIvFwQ9PWB34PdbMW8PosffbAhaPnbPusntsWtXJ5rH92wNWj/vdx5k8Ni+p97j9
 7zGzx+Qbyxk9dt9sYPPo/2vg0bdlFaPH501yAbxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpG
 JpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehldf3cwFzzgrLgx4TVzA+MUji5GTg4JAROJCQ/a
 2LsYuTiEBJYySrR8W80CkZCRODmtgRXCFpb4c62LDaLoE6PEqiUNbCAJNgFDia63EAkRgU5G
 iWndH8FGMQscY5bY+Pg9cxcjB4ewQKjEj6lSIA0sAqoSV589BGvmFbCTeHflHjPEBnmJ1RsO
 gNmcQPHXLQfBNgsJ2EosX/CeeQIj3wJGhlWMIqmlxbnpucWGesWJucWleel6yfm5mxiB8bTt
 2M/NOxgvbQw+xCjAwajEw/si5HWcEGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNS
 iw8xmgIdNZFZSjQ5HxjreSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4
 OKUaGB3WVyc3PZl5bHXAA231uvZ716c8qFxcsv7wnCrnR1LmXxL3SzGxaD+t3ZoyITJYPty2
 p5nN3f53T2yxd0/pneBrWsEPW2pe/u5d1nzqnPu3FRGfZyReXmvOxJP7xmLCUYsV37b6JiUf
 jP1hvGK1ufAih+RdltvCP14+lrNJs7PB94W79dtkMSWW4oxEQy3mouJEAJFjdsu9AgAA
X-CMS-MailID: 20200619103701eucas1p2323797b812f4d8c28e851aa80938a8dc
X-Msg-Generator: CA
X-RootMTR: 20200619103701eucas1p2323797b812f4d8c28e851aa80938a8dc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103701eucas1p2323797b812f4d8c28e851aa80938a8dc
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103701eucas1p2323797b812f4d8c28e851aa80938a8dc@eucas1p2.samsung.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-mediatek@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
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

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 3654ec732029..0583e557ad37 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -233,9 +233,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
 	struct sg_table *sgt;
-	struct sg_page_iter iter;
 	unsigned int npages;
-	unsigned int i = 0;
 
 	if (mtk_gem->kvaddr)
 		return mtk_gem->kvaddr;
@@ -249,11 +247,8 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 	if (!mtk_gem->pages)
 		goto out;
 
-	for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
-		mtk_gem->pages[i++] = sg_page_iter_page(&iter);
-		if (i > npages)
-			break;
-	}
+	drm_prime_sg_to_page_addr_arrays(sgt, mtk_gem->pages, NULL, npages);
+
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
