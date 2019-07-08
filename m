Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB4C606AF
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 12:03:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A27420665
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 12:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2aOuh4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A27420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B62E82501;
	Mon,  8 Jul 2019 12:03:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8F0A424E6
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 11:56:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
	[209.85.217.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2F34A88E
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 11:56:25 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id m8so7995267vsj.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 08 Jul 2019 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=INqtaKqgJbsCXfOBlyhjMGZiHQUnucRAJNFBEd5g9d0=;
	b=n2aOuh4+2HfLrrQ/AerkGk8nPcV0a9lHD1biMG5L8xAvYkxmgeLA8NS7F25S5q3m4/
	PCxVdgp2Jf8w+c1ts10xe7qmXFh+7oane/qyxsSzTyhYVjYlUWbx7mj0ICC6+bojcHJI
	0SINwngWRJuBqkIGoFi8LSLM9AAf4cWCut+tz8LeJrgv1RvYMMYGzCJDEIEEotA8Lx4T
	ExMvH2gvUGRMH8HhXJ4gQBnh9YRG72rx3rbZCAk4XKuIF2dvHFVtWbEZbGdLt8u1/62E
	wvQoT932jJjfBcNytTV6L5O68aaoqrXemfhwy6DrUlk5jFD5bypBb8QcMyuWa0IaOma9
	Ed1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=INqtaKqgJbsCXfOBlyhjMGZiHQUnucRAJNFBEd5g9d0=;
	b=A06nlNWZu9PJKHPiC2QvApl0+LRn9uu8o0ieqsgVCw49iAi531YpVMZfXWIkEBsYO6
	WdgLbk11846n/+nvyquGaAopNwVDJaniEiqml5Gdkk9ECB3CVDYHUv4pOaGy8zqmnuMe
	0SNMoVEQPGGKKeR4AhC0do93ohoKnj+bYC3IlTDtY+QADDwph1kBNR7aqoWMjMrxEekx
	cFIP/wiukq53raxPZrh1w2uXTDkhimhX+7yHXSD1mfVxYjUFbXhXFozw63Wk28kAOHbo
	yc9HMFPT4yMgrHR5oyihuPg0XvYukqIAx7mgbHSp3jc/dLe/WlqyiQA9lGOaaeXlzpRi
	osdw==
X-Gm-Message-State: APjAAAVdCZJIqiFCi7G8p7zTgenxhwLaYkqiMfwb5ExNZtRIUp5oQWKs
	qB+u4co3bQlUeQ8ZZ5U/8vXwkLcV/QW0oehBoiJSGQ==
X-Google-Smtp-Source: APXvYqzuMQxu5Q5w1+tmz7XnrX4NkraXYwW+cB7xG+jvVxMPoX8GHek6Jxl9SAJweTu5ja02CrA++IPVX9ipqF+7hMA=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr9881440vsp.165.1562586984367; 
	Mon, 08 Jul 2019 04:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190625092042.19320-1-hch@lst.de>
	<20190625092042.19320-2-hch@lst.de>
In-Reply-To: <20190625092042.19320-2-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2019 13:55:48 +0200
Message-ID: <CAPDyKFotnDCpt9k-r3D2uYRAzpFVA3woRQENLcNcDY0q8+8SVg@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, 25 Jun 2019 at 11:21, Christoph Hellwig <hch@lst.de> wrote:
>
> Just like we do for all other block drivers.  Especially as the limit
> imposed at the moment might be way to pessimistic for iommus.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

From your earlier reply, I decided to fold in the following
information to the changelog, as to clarify things a bit:

"This also means we are not going to set a bounce limit for the queue, in
case we have a dma mask. On most architectures it was never needed, the
major hold out was x86-32 with PAE, but that has been fixed by now."

Please tell, if you want me to change something.

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 3557d5c51141..e327f80ebe70 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -350,18 +350,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
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
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> --
> 2.20.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
