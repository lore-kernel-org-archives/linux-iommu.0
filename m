Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E0C433DF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 21:51:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B1C20575
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 21:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="O8JCadTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B1C20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0869625B04;
	Wed, 13 May 2020 21:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B3K+QM-Atwgm; Wed, 13 May 2020 21:51:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6717A21FEF;
	Wed, 13 May 2020 21:51:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 390BFC0178;
	Wed, 13 May 2020 21:51:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F3BEC016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 21:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4AA998862D
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 21:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ek5HE3QcC9+y for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 21:51:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0C6C08861C
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 21:51:13 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id h4so1218996ljg.12
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c4GzEKN4UHscMkRfgK/KmlmDtv9fIM50sPFyVikryKQ=;
 b=O8JCadTsQl0Tyvlb72GDnj5fWwBBQal84Q4eYowAUSAU0My9xiciKbQ5opOHnfwl9N
 Qb5nQGHUjnL79yJetrBRfHA673D+DtgS7C/OXM/Jj+mCy4cl51SspGMJvwVFVu8mQw/d
 E0lrDdlhkaMITXDJ0+azix8pePd4EjeDt5g7yhokYKopEAlRvUP/8w/RAInfA6caXo+K
 ruac9LVx6zmyBPRvtCJoQCkeekvevefrJdyMNUMDpe0/sCo9HnlDe3w74ikeYyTigQIj
 aG+tjvBV7Sqetjfnq4VJ/fo8MRHFgz35H6NVpzXrbNEzRfRmIydljGEGOXoJVfCSbwOl
 4D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c4GzEKN4UHscMkRfgK/KmlmDtv9fIM50sPFyVikryKQ=;
 b=KMbWkgGK0phmsTwoqYDqbP5RTcxrYZVY1lCeZM303AFobj2ttkugSVYnbTWJgHtx5g
 ounooHlBon85lwYwZ9kRJyvTH+gIo5ivBuyzI7/7MjJEPOcuykUcypfLVomgpVPCzvAD
 gNYvVZtgo/sgPVT60tScrQoouHSojQDew1QexTYwyOBbbYISEgPSFaImuz0uaHjQy1b6
 JG8yY3OnxFpObrtUl9lhstDy1eMb7mfedA/v9XnsnQCLxBU8i69VVUT4z2A+8GxZbZUp
 5eyInsKJ6kvTLJCyuI2ILTB5b9N146GwGx6aF3sEB+KOU3E0meAddbHekJmkFte9H/07
 je7w==
X-Gm-Message-State: AOAM531f+xhe8dwm918RnPeznzXH6V4p/opwf6d6GcysLsqYn1o54lVg
 hZizK84V3BxIbysEGCyYtAPoIqiZv1I5RxpyS2WWEA==
X-Google-Smtp-Source: ABdhPJxvVYUU3pLt0Fm0zZnTD0agcvWiYXLQjHfcp4jZKWPnJaLBh2OjEP0dKl4uakuItjfjxNR6jFpY0iO1wNvpqZc=
X-Received: by 2002:a2e:8047:: with SMTP id p7mr641481ljg.206.1589406671985;
 Wed, 13 May 2020 14:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200513133314eucas1p1a607b556e32887e7f5ca60eb09a476c6@eucas1p1.samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <20200513133245.6408-24-m.szyprowski@samsung.com>
In-Reply-To: <20200513133245.6408-24-m.szyprowski@samsung.com>
From: Eric Anholt <eric@anholt.net>
Date: Wed, 13 May 2020 14:51:00 -0700
Message-ID: <CADaigPV7sO1pKrspDya+3OLeX0b0mzkZdjb4ox+gQddsmfw0-w@mail.gmail.com>
Subject: Re: [PATCH v5 24/38] drm: v3d: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, May 13, 2020 at 6:33 AM Marek Szyprowski
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

Reviewed-by: Eric Anholt <eric@anholt.net>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
