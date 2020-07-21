Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2674CC433E0
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:15:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC87A2068F
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bw5qLVhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC87A2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A9B3087FC4;
	Tue, 21 Jul 2020 08:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AzQDPp-qPrIM; Tue, 21 Jul 2020 08:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 048B387FB0;
	Tue, 21 Jul 2020 08:15:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D499AC089F;
	Tue, 21 Jul 2020 08:15:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 563F1C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 07:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4991E25DA8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 07:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ufua5IWtLdDv for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 07:22:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id E6AED25BF8
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 07:22:27 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id f2so20070340wrp.7
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6mDt5kpJwMymYRqRaKvVOgNHH4S840KB1Q5qo8lJK+0=;
 b=bw5qLVhwEPApJIrN/Od0X5ERx0RDO466+X493IFt0rXA/P4fBmJPsCu3QySCOrGThs
 wdkqhdDfdWaZlpCe4mRNB+29J1pPcrBQrkjXOKOJpN9m8pEDCLq2pjVXFUEgi2AxVdvC
 dng3OJA5cj+QorM5salBcPEY6IEAzDqnMMqRujGUhGDIyePZTjkeic3K/m8JzspgclvQ
 tvT0Dq4hgrhg08KwifNAzzs5BqSxzRVv7geSSYDtE4NXQleFE3TnuvA9kdYZxuTSsvkq
 ZlbENIeUi25Qw4Tx7tlbJJHXgLzzOiYjtFrUhuuyY5VdD4sw/cDDX92KTObc9VbiLEQb
 u3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6mDt5kpJwMymYRqRaKvVOgNHH4S840KB1Q5qo8lJK+0=;
 b=JwSoBmVx4g0FvVX/HdPyWr2pXl+0qUdLoZqxe0WhvoYeNY72vvtlBxKJeg8kJ3Wy4L
 Adbaa7tSEewP0g4qt4daIuQ7p6zHciusELZIDtMlW3v3ipdr9itcxoUGu9Y5eVfAB013
 AEC73yQTHAq+AF+epCHyrLntD4Kbr4IrFoC97nTiOcGETipyLbqf3XcbP6t4Hubrhspp
 Avi1oCEQ2YxfARLilLQjDRPb4vOb0OVQUEDrtXsRJICThtwETXxjiCimNTlU5Fnukypb
 30/0ttZABwtJ79zoOja4pxYRDDqR3I+lwb2tWOYIRyLtCPDaYX8NzMD1Kpz5dyN5z0Ar
 qUTw==
X-Gm-Message-State: AOAM532Rgv+5IuUjoGolr7NDDYb4RI5UzQ0wE/mrXNKoTzlkLSP1HVWp
 LnYmD0eT9TT5d21rACJMuF3j93xm1ipIbP6FeKMqCw==
X-Google-Smtp-Source: ABdhPJzg0r2NZuAxysESnJp5XGQlor6++234SGZEwSzn9eOy1cmWLxft/eGYyuiWJNhNzm0VuRS4dJaaQVFZkLwiK9w=
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr3977421wrf.171.1595316146210; 
 Tue, 21 Jul 2020 00:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200708164936.9340-1-nsaenzjulienne@suse.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 21 Jul 2020 12:51:50 +0530
Message-ID: <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
X-Mailman-Approved-At: Tue, 21 Jul 2020 08:15:29 +0000
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, 8 Jul 2020 at 22:43, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. So stop using it.
>
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")

Hi Nicolas,

I see a boot regression with this commit d9765e41d8e9 "dma-pool:
Do not allocate pool memory from CMA" on my Xiaomi Poco F1
(Qcom sdm845) phone running v5.8-rc6. I can't boot past the
bootloader splash screen with this patch.

Phone boots fine if I revert this patch. I carry only one out of tree
dts patch https://lkml.org/lkml/2020/6/25/52. And since this is a stock
phone, I don't have access to serial/dmesg logs until I boot to AOSP
(adb) shell.

Any thoughts as to what might be going wrong here? I'd be happy to
help debug things. For what it's worth, I don't see this regression on
other two sdm845 devices (db845c and Pixel 3) I tested on.

Regards,
Amit Pundir

> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> An more costly alternative would be adding an option to
> dma_alloc_from_contiguous() so it fails when the allocation doesn't fall
> in a specific zone.
>
>  kernel/dma/pool.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 8cfa01243ed2..4bc1c46ae6ef 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -6,7 +6,6 @@
>  #include <linux/debugfs.h>
>  #include <linux/dma-direct.h>
>  #include <linux/dma-noncoherent.h>
> -#include <linux/dma-contiguous.h>
>  #include <linux/init.h>
>  #include <linux/genalloc.h>
>  #include <linux/set_memory.h>
> @@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>
>         do {
>                 pool_size = 1 << (PAGE_SHIFT + order);
> -
> -               if (dev_get_cma_area(NULL))
> -                       page = dma_alloc_from_contiguous(NULL, 1 << order,
> -                                                        order, false);
> -               else
> -                       page = alloc_pages(gfp, order);
> +               page = alloc_pages(gfp, order);
>         } while (!page && order-- > 0);
>         if (!page)
>                 goto out;
> @@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>         dma_common_free_remap(addr, pool_size);
>  #endif
>  free_page: __maybe_unused
> -       if (!dma_release_from_contiguous(NULL, page, 1 << order))
> -               __free_pages(page, order);
> +       __free_pages(page, order);
>  out:
>         return ret;
>  }
> --
> 2.27.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
