Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19ABC433E1
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:26:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844DE206D4
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPaTvbRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844DE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4B5C0241A8;
	Tue, 28 Jul 2020 12:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hUvbFgjnd5D4; Tue, 28 Jul 2020 12:26:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BAC1223799;
	Tue, 28 Jul 2020 12:26:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 984D8C0050;
	Tue, 28 Jul 2020 12:26:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAAE5C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A2BD9237C8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pJ7-CAiUvXDQ for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 12:26:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 6D52023799
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:26:08 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id r4so15135941wrx.9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kayCVn9MsuawOdKRK4hWxW1GeSI+z+DswW471px/Xag=;
 b=IPaTvbRGHeW2M0hVvG7+j/QWEf1i7PxbJ0FqEGM4qQPWrIroNNipl4x0NCzvzPi5jc
 /k4DD4lKsORxN1tA5mNvXaaSckHcW9DmlpG5gM5RHOqOn6Z2FZCuJmBEFVdkZyBF/EJK
 Tp/H3DwEJifSv+KH4R2aN2fkKumDQEpTRBGdBieqpLuHQDe9MSS7cbSnRel+UeCGYwIE
 H52AVs4/+9rair/Pb1B0nHtsXYW15sWJKHWIoQBwEHrGFA2MBkWmz3pn+VLyVlRvTJZu
 NwPTGyTCwL20N8rnvnvvk4rhfj7kefWDv/n1YKK+DwPJQU3IvDEGFFrS7I+seGfVif7R
 ERxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kayCVn9MsuawOdKRK4hWxW1GeSI+z+DswW471px/Xag=;
 b=RE/IeMgIhFjXCyue7rf2OjQKTkBUDKPEuHyFRlHzJMASwnjn7qM4jnOErA19KBP2hi
 WZnuqhIQaejYdLmqxwC/8TK68+g/yfusE/upxybbbUaz2DSBDU9NeXPYMxXJJa3qMjj3
 ibadCdGsPTzrTN1DjC9cFmNJ9dQNu3dwDCBkBXgAdh4aqsrgv/uaXwnH+t8JbNfi1+BI
 OtOQv0d30TqrPKSBk+ycVBS5TIsDxl/H2NlgIv0o9NZpz/KD1V7tj16NZFpvs5qyXD3D
 8l+ey/wPJL2pbdbc3W60xJQp4lagEwkAvEIF5pezitqEgVSNTDxsRWXq/9HtNOfveVEY
 PWaQ==
X-Gm-Message-State: AOAM5328X8NZwxOpB+/dBkMYFcJcL9dlTyUM8XASHG5EFsND70vILJk2
 Qp0fQym1LiPY3s6jLPA3e/QVjEOnHCz/KVctzm+1FQ==
X-Google-Smtp-Source: ABdhPJzZsbpLgIfG9aVEuiEmI9Nt5mPmS42Fi85PRSEIEY7es+p/y7oc+c0vvLWJKlhnH43skIpUUoeJKjHfJRPb1hU=
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr24429675wrf.171.1595939166888; 
 Tue, 28 Jul 2020 05:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
In-Reply-To: <20200728120716.GA2507@lst.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 28 Jul 2020 17:55:30 +0530
Message-ID: <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
Subject: Re: dma-pool fixes
To: Christoph Hellwig <hch@lst.de>
Cc: jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, 28 Jul 2020 at 17:37, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 28, 2020 at 05:32:56PM +0530, Amit Pundir wrote:
> > > can you try these two patches?  The first one makes sure we don't apply
> > > physical address based checks for IOMMU allocations, and the second one
> > > is a slightly tweaked version of the patch from Nicolas to allow dipping
> > > into the CMA areas for allocations to expand the atomic pools.
> >
> > Sorry, verified a couple of times but these two patches are not working
> > for me. I'm stuck at the bootloader splash screen on my phone.
>
> Thanks for testing.  The only intended functional change compared to
> Fridays patch was the issue Nicolas pointed out.  Can you try this hack
> on top?

Yes, that worked.

>
>
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 83fda10394937b..88e40a022b6bfd 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -70,13 +70,14 @@ static bool cma_in_zone(gfp_t gfp)
>         size = cma_get_size(cma);
>         if (!size)
>                 return false;
> -
> +#if 0
>         /* CMA can't cross zone boundaries, see cma_activate_area() */
>         end = cma_get_base(cma) - memblock_start_of_DRAM() + size - 1;
>         if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
>                 return end <= DMA_BIT_MASK(zone_dma_bits);
>         if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
>                 return end <= DMA_BIT_MASK(32);
> +#endif
>         return true;
>  }
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
