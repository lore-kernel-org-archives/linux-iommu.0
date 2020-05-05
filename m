Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCC9C47256
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 09:24:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5C920721
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 09:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5C920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2E7AB22879;
	Tue,  5 May 2020 09:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zcf+ZKiwb9xp; Tue,  5 May 2020 09:24:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5866B204A7;
	Tue,  5 May 2020 09:24:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D66DFC088B;
	Tue,  5 May 2020 09:24:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30702C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 09:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 22115204A7
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 09:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id efGDVyVDqB8c for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 09:24:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 194D62047D
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 09:24:49 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id a2so1212705oia.11
 for <iommu@lists.linux-foundation.org>; Tue, 05 May 2020 02:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fA6tjdmApvG0BpsjkTdWv9/ZTQZ9vjPp82obp9l863E=;
 b=l83fcDYTq7Awnk2QCoCTpthD0JeQvn3ll9cI2EcKAd8QXxOqZW2kOt/37Kkupmz4B8
 UCHTgVLsCD0zK+g0l69VLN/arBDGdLP34JrqHhhuCk2MMRsqapeMs8XXyyyxqCt9uFVa
 8OEY7b8kCmqLX/h0o3dT5EefmhsgQ4Sm6TJF1oT1qCyejxXVoEJsmrsgchBRVSycd3Fk
 D4+nWkIhxGQ7/lnA0ljjo99ZZbL/LEIarl6LHgtUfl3nyZG2NwWGD8POkaugALHCj0WW
 hL9rkRBGYbVIVnj/LxtRVNfiDVcoK6ZT5W1ldPWHejrMVywb2IVJh21LsGY6j3kzKj94
 NxXA==
X-Gm-Message-State: AGi0PuZbuldx38Fx99I6DGMACOtHrTkd0i7oQHHAsjG6h5naxVEijJMh
 Qpf7dPXbtp+j1iC1PkktxmyKdQmn+hKoRv9DZu4=
X-Google-Smtp-Source: APiQypKOjAo7caYTLLrvaP2LfYH11Xj01QYaa+uBtqm/9mZJ41Mdkz0F6pXJ47B38HgwsYDHPLvoSnLN/Mh8S4elUzU=
X-Received: by 2002:aca:f541:: with SMTP id t62mr1674694oih.148.1588670688206; 
 Tue, 05 May 2020 02:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
 <CGME20200505084634eucas1p1e0ea160dd77afbf6d2f7e6154ded40d0@eucas1p1.samsung.com>
 <20200505084614.30424-1-m.szyprowski@samsung.com>
 <20200505084614.30424-18-m.szyprowski@samsung.com>
In-Reply-To: <20200505084614.30424-18-m.szyprowski@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 May 2020 11:24:37 +0200
Message-ID: <CAMuHMdVisnijasoxazj+6kUFM3UrTYkVo6kC1dxZv5zK0yD7TQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/25] drm: rcar-du: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 linaro-mm-sig@lists.linaro.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
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

Hi Marek,

On Tue, May 5, 2020 at 10:48 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
> numer of the created entries in the DMA address space. However the
> subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
> called with the original number of the entries passed to dma_map_sg. The
> sg_table->nents in turn holds the result of the dma_map_sg call as stated
> in include/linux/scatterlist.h. A common mistake was to ignore a result
> of the dma_map_sg function and don't use the sg_table->orig_nents at all.
>
> To avoid such issues, lets use common dma-mapping wrappers operating
> directly on the struct sg_table objects and adjust references to the
> nents and orig_nents respectively.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187

For the modern lore-users:
https://lore.kernel.org/r/20200505083926.28503-1-m.szyprowski@samsung.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
