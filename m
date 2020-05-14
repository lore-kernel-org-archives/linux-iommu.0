Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B088C433E1
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 13:51:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FA9205CB
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 13:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="10yB1NOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FA9205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C668722FEE;
	Thu, 14 May 2020 13:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tBn7e+Lss6t; Thu, 14 May 2020 13:51:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 56226226B7;
	Thu, 14 May 2020 13:51:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48A59C0178;
	Thu, 14 May 2020 13:51:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDE9C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 748828795B
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGgB43UUfOTH for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 13:51:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EF1C5876C9
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:51:40 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD96E2070A
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589464300;
 bh=U4WS7dpPUSnHoDDXd9I/RGkZKydgvH6uscT6wgd5yaA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=10yB1NOW59ZFLk88tVol6JSCXSW16g5KS52gy+76Le+Tx7PliiJwrDveF5QUp3aAc
 f61hKPaNOqkKM/2+UmfCiYuO4Jfs+HSy+dc4Gmiq0HieYQPdWNpKME8aLXz7MuovlT
 /hy6GRU1SUPCaSfNSwajP+sQsgP/LEet6da+KIJY=
Received: by mail-ot1-f54.google.com with SMTP id k110so2389407otc.2
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 06:51:40 -0700 (PDT)
X-Gm-Message-State: AOAM531KvgTNKUMcMcWMdxw7R4BVl3ivL8FCIO3DCJqcBbHFquBJ0ZcW
 qSHAzN7Ns1/rmSwXnJofmhxnf9eDTiZtVbOE/Q==
X-Google-Smtp-Source: ABdhPJzQUESjwS7Ih36p4leA1o497JSOSd1+5C+3ygMzeFo3qlL7lPTUyx4LBbQ+Ukd+XPHe6ro8V61dxXyaOPE9BZM=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr3620806oth.192.1589464299942; 
 Thu, 14 May 2020 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200513133310eucas1p176c920345e7f05f670e26e330b358d7f@eucas1p1.samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <20200513133245.6408-19-m.szyprowski@samsung.com>
In-Reply-To: <20200513133245.6408-19-m.szyprowski@samsung.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 May 2020 08:51:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLwEB_YMzDDQ=nt0_Tq-BGGFEW64BagPN-FbDeOnLpYCA@mail.gmail.com>
Message-ID: <CAL_JsqLwEB_YMzDDQ=nt0_Tq-BGGFEW64BagPN-FbDeOnLpYCA@mail.gmail.com>
Subject: Re: [PATCH v5 19/38] drm: panfrost: fix common struct sg_table
 related issues
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 13, 2020 at 8:33 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
>
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
>
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
>
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
> For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 7 +++----
>  2 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
