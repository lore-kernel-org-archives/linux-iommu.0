Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A32C31E49
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 20:36:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26FC20665
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 20:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26FC20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 835F915DA;
	Thu, 13 Jun 2019 20:36:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9C38C15DA
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 20:36:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
	[209.85.167.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 007B976D
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 20:36:03 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id d11so135708lfb.4
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 13:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=z9pT9j7kn/J7EUGyq2uQP5wwtUmztL0xFNDiGg1L3+E=;
	b=X28ZM9CVfL1/IZCX56nKBG8fUWvxSBRAiNV1Tr3xOLP6PtS5crX7pE58A4/yvR7rL4
	Au2oTxuGHmRF6ROPrk4+o6t/P76pcUDDRxiMfuq73mfeA3uZyu8bRv7lcAJ3i7aJMtjP
	ElMK3kLciX4AifKnQMZIjrf3bTREorsZ6l9xAMwhhZvZ65pFNP3EclFfz7IgcnoFv/b9
	htssr6HmnXYYMYc1r5m5hATqM2+YLB01N4Nfpnqi441+0KV8DnRRTWTau7GXvotmAsSQ
	dqtZejZzoFelSoJLmUU6jqnz6AEZza8djzI/a0/9NPFOIIwk9sutjA9g+CfUB/YlsqsE
	BDJA==
X-Gm-Message-State: APjAAAXOBdtgj9Yh8OIn80eoqePtZJ9Yhx74hzPtmQq865RA/06ub1AE
	QtkYq7gPqABUmcyMwFb0fy4elV8p2xeG35yEqGY=
X-Google-Smtp-Source: APXvYqyOWgizpjNJBHEjXaulJf3xyZqsd/zF8eSxKDl95LQ2jEFxxsiGEU0nnfy+4XAHYrmPxUskeM/VT/LQIlrurTA=
X-Received: by 2002:ac2:597c:: with SMTP id h28mr7062073lfp.90.1560458162259; 
	Thu, 13 Jun 2019 13:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Jun 2019 22:35:44 +0200
Message-ID: <CAMuHMdXYqgPRX1WfUTRsKHhnSok5vfnr4AY36=vXoUvAxcNyWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Shimoda-san,

On Thu, Jun 13, 2019 at 5:37 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the commit 133d624b1cee ("dma: Introduce dma_max_mapping_size()")
> provides a helper function to get the max mapping size, we can use
> the function instead of the workaround code for swiotlb.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c

> @@ -1189,19 +1190,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         mmc->max_blk_size = TMIO_MAX_BLK_SIZE;
>         mmc->max_blk_count = pdata->max_blk_count ? :
>                 (PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
> -       mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> -       /*
> -        * Since swiotlb has memory size limitation, this will calculate
> -        * the maximum size locally (because we don't have any APIs for it now)
> -        * and check the current max_req_size. And then, this will update
> -        * the max_req_size if needed as a workaround.
> -        */
> -       if (swiotlb_max_segment()) {
> -               unsigned int max_size = (1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
> -
> -               if (mmc->max_req_size > max_size)
> -                       mmc->max_req_size = max_size;
> -       }
> +       mmc->max_req_size = min_t(unsigned int,
> +                                 mmc->max_blk_size * mmc->max_blk_count,
> +                                 dma_max_mapping_size(&pdev->dev));
>         mmc->max_seg_size = mmc->max_req_size;

I'm always triggered by the use of min_t() and other casts:
mmc->max_blk_size and mmc->max_blk_count are both unsigned int.
dma_max_mapping_size() returns size_t, which can be 64-bit.

 1) Can the multiplication overflow?
    Probably not, as per commit 2a55c1eac7882232 ("mmc: renesas_sdhi:
    prevent overflow for max_req_size"), but I thought I'd better ask.
 2) In theory, dma_max_mapping_size() can return a number that doesn't
    fit in 32-bit, and will be truncated (to e.g. 0), leading to max_req_size
    is zero?

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
