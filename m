Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B05C433DF
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 12:57:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65A2206D5
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 12:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s8y14ezW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65A2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9782088A8F;
	Fri, 22 May 2020 12:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7PWLyjUp8nXS; Fri, 22 May 2020 12:57:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A53788A05;
	Fri, 22 May 2020 12:57:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44990C0863;
	Fri, 22 May 2020 12:57:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9634FC0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 12:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 84BA3876FA
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 12:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8c25PNqoQRo2 for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 12:57:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8CDAB876D2
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 12:57:12 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200522125709euoutp01ab87650b7559b241af012f8d1e5d8135~RWwc2Y0Nb2995329953euoutp01J
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 12:57:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200522125709euoutp01ab87650b7559b241af012f8d1e5d8135~RWwc2Y0Nb2995329953euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1590152230;
 bh=YNTaZW2eCrOBB+/EZo2VHocehjAUUuW398emjA1vya4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s8y14ezWQp/obQT5eQzlHBx2D6Ufr/neV8oEDj4QmWuKnIp4m5g7xix59W6ecmC7N
 T/nvlIAf/rGSuF7c0Ti7mHHY3RlU0vsLq6Ckm1BJuAlLy2TKWKVYz0sK3Dutt+bWO8
 j/Kn/oVcRQpDbsN2pVw4bZHwV4KrnWb/mSs6tuA8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200522125709eucas1p2c9cc74a5e6327f14ff2fec8d00997ac0~RWwcNyFI80249702497eucas1p2n;
 Fri, 22 May 2020 12:57:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 58.BE.61286.52CC7CE5; Fri, 22
 May 2020 13:57:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200522125708eucas1p233b80b0741f087a84d47f24b6d91985f~RWwbxlE_S0903009030eucas1p2y;
 Fri, 22 May 2020 12:57:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200522125708eusmtrp2ce3887019627c346b790bcbe15a7947f~RWwbwTwIw1358513585eusmtrp2R;
 Fri, 22 May 2020 12:57:08 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-6f-5ec7cc252cc0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 3E.42.08375.42CC7CE5; Fri, 22
 May 2020 13:57:08 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200522125708eusmtip1f843fc2153bbac42a292dde233075588~RWwbEtm5i3030830308eusmtip1G;
 Fri, 22 May 2020 12:57:08 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 39/38] drm: xen: fix common struct sg_table related issues
Date: Fri, 22 May 2020 14:56:52 +0200
Message-Id: <20200522125652.18435-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513132114.6046-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURTNm5m2A2lhLChPMIKNmGAUJPIxCUowGjN+GCQxxBhBqkxYpIAt
 rYIfEEAgpRCEDwgg4gbYssm+uLCIxUgGWSSgRTajghCwQFmMVIap+HfuWd65uXk4Kn7Bc8TD
 o2JpeZQ0UsK3xhrfrvcdde3VBx0bNdmSmcw7hHyeX80jzY33UHJoZYFPPtN1I2TJa29yeWgS
 IWunh3nkYGsRn6x8MyYgF3ULPLJj8SuPXK3PRXxFVEVxBaAMT1sA9dJUglFNpgkeNZ6hR6i6
 JwnU581plModKQNU1+IQRrWNJvKprHotoJZq918QXrY+EUJHhqtouYdPsHVYkXEKi9kgbmf9
 mkcSQYGNGuA4JLzgj5azamCNi4lyANM0sxg3LANY+qXQMiwBONdbg6iB1XbC/KkZ5YQyABt0
 hfydiKmsFLAuPuEJ1fNqPovtibsA9mQKWRNKrCGQKe0RsIId4Qcfd+RsBzDCFaZWt2EsFhEn
 YRHzG+XqnKGupn0bW23xxoZ1HvsQJBgB1LYsCzjTGbhmnsA4bAdn9fUWfh80tzxAuEAygJNM
 pYAbNAAOJuUDzuUNDcwGn70HSrjB6lYPjj4F+yaSUe5MNnBkfhdLo1swpzHPQotgeqqYcx+C
 BfqqndqODwOW/SmY1tVmOVc2gNrMfiQbOBf8LysBQAscaKVCFkorPKPoW+4KqUyhjAp1vx4t
 qwVbf+r9pt7YDFYGrnUCAgcSoYho1QeJeVKVIk7WCSCOSuxFD227g8SiEGlcPC2PvipXRtKK
 TuCEYxIH0fFHM4FiIlQaS9+g6Rha/k9FcCvHRIAFCjGlMHXmSsJg3rqmZpbRaMTdScOB5y6t
 1+WQU2NU8ccn5r1ZQcHO8VW9PqXnIwwZvuW946tNpp+ky528g6fz5+r+9Dn5Od484hWGvPLP
 Kw9w2/OdSVUdkDh57k4x1Fz0D8hua9d+S+jyu48CXbBLpSo9i5b1+xvDUyIKiiWYIkzqeRiV
 K6R/AfS9l3RPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7oqZ47HGfxYoGPRe+4kk8XGGetZ
 Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFh9Wv2e1OPjhCavF
 9y2TmRx4PdbMW8PocWfpTkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj8MfrrB4
 7L7ZwObRt2UVo8fnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
 NimpOZllqUX6dgl6GXM+PWIp+CVQ0ffxLVMD4yy+LkZODgkBE4n/t3YwdzFycQgJLGWUmNe4
 mgkiISNxcloDK4QtLPHnWhcbRNEnRolVp5+zgSTYBAwlut5CJEQEOhklpnV/ZAdxmAX+MUmc
 2LsdbJSwgK/EsrUfwDpYBFQl2tbvZgGxeQVsJeac+80MsUJeYvWGA2A2J1D809afYKuFBGwk
 1rbOYZvAyLeAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYNxsO/Zz8w7GSxuDDzEKcDAq
 8fDu2H48Tog1say4MvcQowQHs5II70L+o3FCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWanA+M
 6bySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxqyz02X2Ts7561
 6b280cSlX37ILbB+toZpbzjXEcP7Vb+yA57YdfYbz6/qPLRV++U3sbovi0QvnOXQfax5806o
 k6ziy2m3J3YfT3jE4iD45fShHMe5+j8tlK+YPGu0tKtN6XT24HMOjeafW/Jk/7sb09ZwyU67
 7cB6d8oXjwOux5o80tp1eSuUWIozEg21mIuKEwHG6J9ksQIAAA==
X-CMS-MailID: 20200522125708eucas1p233b80b0741f087a84d47f24b6d91985f
X-Msg-Generator: CA
X-RootMTR: 20200522125708eucas1p233b80b0741f087a84d47f24b6d91985f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200522125708eucas1p233b80b0741f087a84d47f24b6d91985f
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200522125708eucas1p233b80b0741f087a84d47f24b6d91985f@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Daniel Vetter <daniel@ffwll.ch>, xen-devel@lists.xenproject.org,
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

Fix the code to refer to proper nents or orig_nents entries. This driver
reports the number of the pages in the imported scatterlist, so it should
refer to sg_table->orig_nents entry.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/

This patch has been resurrected on Oleksandr Andrushchenko request. The
patch was a part of v2 patchset, but then I've dropped it as it only
fixes the debug output, thus I didn't consider it so critical.
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index f0b85e0..ba4bdc5 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -215,7 +215,7 @@ struct drm_gem_object *
 		return ERR_PTR(ret);
 
 	DRM_DEBUG("Imported buffer of size %zu with nents %u\n",
-		  size, sgt->nents);
+		  size, sgt->orig_nents);
 
 	return &xen_obj->base;
 }
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
