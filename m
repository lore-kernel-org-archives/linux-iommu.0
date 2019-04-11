Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7FC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB8D2084D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r257t7nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB8D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C1871239E;
	Thu, 11 Apr 2019 09:01:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0084F2207
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 09:01:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
	[209.85.217.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56C32F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 09:01:33 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id f22so3028922vso.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EnatT+jdtQF0JEB7Nk+rRsGXNIW2kJHlGBbezXEtsEA=;
	b=r257t7nJSEYG00c7JQwV7VQyIw1FZGynR2MOLhNuH/WY4PiuTQUVQkfPYFW1C7+scf
	0O/IY/861L6ydpdi0TEQJiJ1PjIudUbGY2rV4pYw8bmm6EbWYhUgg46GbBNasCMkO9uV
	s18KjfS5+l+gfUpRu++r1rByJbLgp2iXi1eoWxifCgroV1A3Mk9kY583ETL20WnOxgI4
	AS7D/cBatvjctVBm4nxRyqbFL70XToCY7rO70y2mkNC6yYFI4gVOhJNAC90mTIFe2g1k
	sWvHli5XY2xadk8UyM7D8BbSVGN8u/OSIprB9dzjL03U7SblELbxJGlc3Lsfh/Vu7k8N
	+21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EnatT+jdtQF0JEB7Nk+rRsGXNIW2kJHlGBbezXEtsEA=;
	b=C1K/FRwfgRB+oG2rTWrv031t8g9WVdIepF6q4xFMNmV4dlcUVGjctOhqZbxEGCsaxl
	x3s00GzFU/phsBCb6xaGuj+7qF1XE70G4aumziVfvVMDBwkEWbvAAK5wi/vi7blZQ95y
	9ATsAWzfA699ZgWLylToqpBPXAUrnnR0G57Sa8pK/Qn8WOxUuow/9SdYkdMjl4aofdwf
	E3fAhHDWE994TN8SKAV3CFKmrXtxlcBGKlLnN3DOj6O3pXWnK+tiCTppf+0X7qT68Tz/
	hf+yUeAU49K5XeQXiwLcO6kMokSae8D4NOa62J5US3W7I0JPvpaTyGJO/IYy0SXvT9fj
	B9cg==
X-Gm-Message-State: APjAAAXA1PcI6ol28MF8qtxRUhfNkVw6ZBQJKpkJ69vycg/wH+uD5EG6
	kahWPjTkTG6lgh73s1yLKocljFvSAJradIE/YUDWPg==
X-Google-Smtp-Source: APXvYqwDdqE/o2RrwREk77vUS27uHxKVdSVOxqXYu38QwsgxM0TJnvklLlUyfzHFzBWAhKjrwy0ny1645mJWeUzw0/I=
X-Received: by 2002:a67:fa04:: with SMTP id i4mr27302504vsq.18.1554973292450; 
	Thu, 11 Apr 2019 02:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411070948.29564-1-hch@lst.de>
	<20190411070948.29564-2-hch@lst.de>
In-Reply-To: <20190411070948.29564-2-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Apr 2019 11:00:56 +0200
Message-ID:
 <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
To: Christoph Hellwig <hch@lst.de>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411090056.qsdFLhIrvc5Rhi40t05Vl2ByeExChfNCdnYDku9Y8Js@z>

Hi Christoph,

On Thu, 11 Apr 2019 at 09:10, Christoph Hellwig <hch@lst.de> wrote:
>
> Just like we do for all other block drivers.  Especially as the limit
> imposed at the moment might be way to pessimistic for iommus.

I would appreciate some information in the changelog, as it's quite
unclear of what this change really means.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/core/queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7c364a9c4eeb..eb9c0692062c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -354,18 +354,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
>  static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       u64 limit = BLK_BOUNCE_HIGH;
>         unsigned block_size = 512;
>
> -       if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
> -               limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> -
>         blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
>         blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       blk_queue_bounce_limit(mq->queue, limit);
> +       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> +               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);

So this means we are not going to set a bounce limit for the queue, in
case we have a dma mask.

Why isn't that needed no more? Whats has changed?

>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> --
> 2.20.1
>

Kind regards
Uffe
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
