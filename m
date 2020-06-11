Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E225C433E1
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5352720792
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="acPfkpj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5352720792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4457D89671;
	Thu, 11 Jun 2020 19:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVjbUiz23czY; Thu, 11 Jun 2020 19:20:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C5D1B89603;
	Thu, 11 Jun 2020 19:20:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B318CC0865;
	Thu, 11 Jun 2020 19:20:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3F8C0865
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 12116203C9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCyE1MYIGPCz for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by silver.osuosl.org (Postfix) with ESMTPS id B40272040F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id s23so3095790pfh.7
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=lhV8nqMz2laEO7u8yeQgJHEMBabnXS8HLs+yCx8wYRg=;
 b=acPfkpj5/yf9SgDo/GgAHtc3dF88Ku0aHGKDg+7QAde4yPirke3PsVjTLGiw8CNyf5
 rG2TeN3/YsFrowdQObRuyE5KZUNGYQVgTkHLC5YVK8hbZFVPU41QPkfdZek2TuIS8jYr
 ha+G7dTRNoOt34arFuaABOYl6byG3HiaAuYlznexIvZnxhEGlzwcKiZRIkAfeiQ90QJd
 XVezjcdXyBaGIsvdXilWU970/byi5P9BHFgT2xwISkH5IxvDu8aL50gDfuG5xWuMAcp9
 ELWXt3Nr8CCIuG0NFyi1OsB8GLXXelexcGBOZV9WWFbayorCcW+7+9CT1EypI2M0tCut
 Ys+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=lhV8nqMz2laEO7u8yeQgJHEMBabnXS8HLs+yCx8wYRg=;
 b=C1ne7i/iddGdAXBa3447nXCFraDf2h3lfGSyrcpuypECJUajVIchjTBAShz75f6WIq
 3cZtO9+kF8rYNq0JI1dpegKLrDfy4rMivm2mxPvLEAGKhdGRVAuBQ3ssBkGCEvEtqMWr
 WMNQvqJlhu2vri6MVZRhK9ZskLL4vUmaPM4MZSo9M4XaccYoAHdtwM05WYPgg7yt7Rpe
 LQ4uL0QvVAP85u75r0eEN2mdRpDqmZdhnG42iQoS2jsfDErYOnYhCbQ62SxdZbc3wu4A
 6Gbi/aIPJokw3JDqXj3dlVCNmJHEQZXaVhSZ73h2xuOrcsrymAgPBy+PuNfR9tq6sBWE
 HsSg==
X-Gm-Message-State: AOAM533beRFSSinU4m1QduuMXihS0i5x3CU67aUmu/6GfQ7NURf4Q8zO
 B5Hhk90ORS2ax3mGGU9qxrpGow==
X-Google-Smtp-Source: ABdhPJyh//Vnh2AOGbnU3pCU/jktEq7WXa1uG41bJSj6sWvqbsCFopBl8iIs0tjZMjC2tSJ5wleAQQ==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr3450720pge.131.1591903233130; 
 Thu, 11 Jun 2020 12:20:33 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id z24sm3714630pfk.29.2020.06.11.12.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 12:20:32 -0700 (PDT)
Date: Thu, 11 Jun 2020 12:20:32 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: [patch for-5.8 4/4] dma-direct: add missing set_memory_decrypted()
 for coherent mapping
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111220010.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Thomas Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When a coherent mapping is created in dma_direct_alloc_pages(), it needs
to be decrypted if the device requires unencrypted DMA before returning.

Fixes: 3acac065508f ("dma-mapping: merge the generic remapping helpers
into dma-direct")
Cc: stable@vger.kernel.org # 5.5+
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -195,6 +195,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
+		if (force_dma_unencrypted(dev)) {
+			err = set_memory_decrypted((unsigned long)ret,
+						   1 << get_order(size));
+			if (err)
+				goto out_free_pages;
+		}
 		memset(ret, 0, size);
 		goto done;
 	}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
