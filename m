Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB85C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 22:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7E3A81423;
	Tue, 15 Feb 2022 22:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1tluk1OivjC; Tue, 15 Feb 2022 22:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC957813EE;
	Tue, 15 Feb 2022 22:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B391C001A;
	Tue, 15 Feb 2022 22:43:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADB7FC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 22:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DB5B41580
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 22:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EV5yZU8Yx59g for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 22:43:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E55C941573
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 22:43:49 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id y9so655231pjf.1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2j3UCpWXBi4AmTzt5oXDEwOkgC+VwKfMNXNXsfNIBmg=;
 b=FNK69IXTJfKEfKcxbgiNQJ278OO5Vc0E/LupRMcQeZziacWg4+sb7MPa9on9wQcLN4
 1EtIUJLal3PKTMo/4IHdERnN2BbFrG+SatuEkIc3riHBQ1xgxv0UvXzpIEKavsWrEWVe
 BpSH9KGFrjh+I93D8yNdjmJz2ToU/pdoTeKRjlOSnv+h7N1Sd6h9FT3C7vg+44q6Uypr
 cTnSHaLV1EWf0eRnJREY/FSgDXES+v6dpy+kXtkeAhiPZfNbUZA30G2Ii6+ZHS1V8skT
 lJO0bS3Ho6nL4tnsUn3OhWXyR5Kogoa2MMXKaDTXYAdwCjE2wmwnKRPqHLqRn7bxF/jx
 ddpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2j3UCpWXBi4AmTzt5oXDEwOkgC+VwKfMNXNXsfNIBmg=;
 b=iLnpa+7w+jRwSInXNyI3vghogvIQ/0ZDv0u9I2iWCxasPJgpauYkqGw0aazEgfFPb7
 +GOsrgkgx+VXLYBC8zbpgwtrazRCXbsXvqqdgxxvT7haKAloCjnoW7j6JypkLgjxi+HT
 mEe1Zod49uA9bJACWQrY+GQBdvBrFUFn2xqZcqkQ4k3DDX+XYgDtV6dPq1Np4XLUNcdz
 B73fusZEGMEXx2qMVb2KHZYC7wCWV8/nQmiJ80ZAr/cfFe5tCfVS2N8X0mSqshbgKkyE
 fr+xwkNg3LRXLmrJUsV2OUdeBBD4W9vsHu523qvVw/Xw0XDaIAqI7ru3hpGGypernM1m
 0GVQ==
X-Gm-Message-State: AOAM530W9CX8OcA2CpQ6dKQe39aH79ZhKiU9RcsiX2G+ZA885q+6fbdh
 MbzaiQcf+XT4jUSrLoIgWGg=
X-Google-Smtp-Source: ABdhPJz3Fjg8GVi3oVTBznPycf5n3SEn1rJ/8aJnPoOKEXjBQtMPgcCQ82B4vweHkQbw8eVddZ8djg==
X-Received: by 2002:a17:90b:4b4c:b0:1b8:b4fe:3353 with SMTP id
 mi12-20020a17090b4b4c00b001b8b4fe3353mr6977023pjb.113.1644965029242; 
 Tue, 15 Feb 2022 14:43:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q21sm42538461pfu.104.2022.02.15.14.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Feb 2022 14:43:48 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dma-contiguous: Prioritize restricted DMA pool over shared
 DMA pool
Date: Tue, 15 Feb 2022 14:43:44 -0800
Message-Id: <20220215224344.1779145-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: robh@kernel.org, opendmb@gmail.com, Robin Murphy <robin.murphy@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 jim2101024@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 tientzu@chromium.org, will@kernel.org, Christoph Hellwig <hch@lst.de>
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

Some platforms might define the same memory region to be suitable for
used by a kernel supporting CONFIG_DMA_RESTRICTED_POOL while maintaining
compatibility with older kernels that do not support that. This is
achieved by declaring the node this way;

	cma@40000000 {
		compatible = "restricted-dma-pool", "shared-dma-pool";
		reusable;
		...
	};

A newer kernel would leverage the 'restricted-dma-pool' compatible
string for that reserved region, while an older kernel would use the
'shared-dma-pool' compatibility string.

Due to the link ordering between files under kernel/dma/ however,
contiguous.c would try to claim the region and we would never get a
chance for swiotlb.c to claim that reserved memory region.

To that extent, update kernel/dma/contiguous.c in order to check
specifically for the 'restricted-dma-pool' compatibility string when
CONFIG_DMA_RESTRICTED_POOL is enabled and give up that region such that
kernel/dma/swiotlb.c has a chance to claim it.

Similarly, kernel/dma/swiotlb.c is updated to remove the check for the
'reusable' property because that check is not useful. When a region is
defined with a compatible string set to 'restricted-dma-pool', no code
under kernel/dma/{contiguous,coherent}.c will match that region since
there is no 'shared-dma-pool' compatible string. If a
region is defined with a compatible string set as above with both
'restricted-dma-pool" *and* 'shared-dma-pool' however, checking for
'reusable' will prevent kernel/dma/swiotlb.c from claiming the region
while it is still perfectly suitable since contiguous.c gave it up.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/dma/contiguous.c | 7 +++++++
 kernel/dma/swiotlb.c    | 3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..3c418af6d306 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -416,6 +416,13 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+	if (of_flat_dt_is_compatible(node, "restricted-dma-pool")) {
+		pr_warn("Giving up %pa for restricted DMA pool\n", &rmem->base);
+		return -ENOENT;
+	}
+#endif
+
 	if ((rmem->base & mask) || (rmem->size & mask)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
 		return -EINVAL;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1e7ea160b43..9d6e4ae74d04 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -883,8 +883,7 @@ static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
 {
 	unsigned long node = rmem->fdt_node;
 
-	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
-	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	if (of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
 	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
