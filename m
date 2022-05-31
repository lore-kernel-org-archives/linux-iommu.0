Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C75C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 22:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 273FE408E4;
	Tue, 31 May 2022 22:19:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dbQbsxUInzMx; Tue, 31 May 2022 22:19:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E2A9D40932;
	Tue, 31 May 2022 22:19:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84EA8C0039;
	Tue, 31 May 2022 22:19:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D68AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D9EB607C0
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsB0btlTqnH5 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 22:19:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A04CC60783
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:19:46 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id p19so8739111wmg.2
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hg0Ilti18FAQE7cSSj65kaiJUUDYw0qPslbA3HQQNKk=;
 b=pk+7v8jwxc9qnUvijU0Bs2W142w7XcrD6mmGUUoIB2zJqfw/FLDe0qCku2APYiQsBh
 rHZS7M3SLTqcI74mnTo0pnYyPbyceYuIwYIpXM2KKE63i+ElxZrKSGZt0HAgb3LG2Sfl
 VEaTTKgdCrqF/AE7/RjdOauoCGLA2h+nvQnYAnlQMUomBB12RUT5SnAZ36uXx4DPpBb0
 9zvZ5npnBKue8wa2GiJn2WEq+ZcH1M7MaWs53s0hR6RsY9xKy05n9SMuFIH5iO42RsIJ
 Mw02aOJ8jd/IA/gBLGx8U3hOk9sjdQz95ookzg+NT+l4Qh+CiJmyLjIHJZdAUDuSvhhp
 42Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hg0Ilti18FAQE7cSSj65kaiJUUDYw0qPslbA3HQQNKk=;
 b=FtDnvS+aotIancZifLrCq4etS40C9pmukdEMarnMvciwHQUAwHCCqq5ARHXNSdQgpD
 0be5GSOwhNHUtKs283vlHB/QQbQAkBMPwTaztgBHBxExmuYeCACBcTOUyWsyJ+WEyQYG
 BlHVXAd18WJZaUPFLLYBV2JpNVT16oeplkHatz0g1Unksyi50hQUW7njwIIpMxbWFmq8
 LYHrwqTZ4ci77aA8HQi4ZTQ/ldGuUYmeo/sOwO88lPZxsfbKPVWJyFCAdLhvCgUUhM3N
 QJ1u5mawJ2D68WgG3CZlutqrlph8jq0Ip/SjHUxnUKjQgrTv+q0h4VXEWNWo1PEJW5Zz
 sRPQ==
X-Gm-Message-State: AOAM532nVAiJeDc1OO1lzNrPzeXK5cZ4AfdyT6jRP27mxxVBeIGmPcMz
 EWOULlQY+RX3A6e/Kt3vlgWN0zl01LfvgRc9eFE=
X-Google-Smtp-Source: ABdhPJw+pyjdZqhWopEnK7PgvgXcc+sdJo0v04GaqsNX69HfALfqNi2CQOn3upMxMB+y4fWzvrpat4zC3W3e7STVlkk=
X-Received: by 2002:a05:600c:6011:b0:398:fa3:c02d with SMTP id
 az17-20020a05600c601100b003980fa3c02dmr19146556wmb.183.1654035584709; Tue, 31
 May 2022 15:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220531215106.192271-1-robdclark@gmail.com>
 <39d1fa65-8e82-721c-171e-ef36bda1c561@arm.com>
In-Reply-To: <39d1fa65-8e82-721c-171e-ef36bda1c561@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 31 May 2022 15:19:45 -0700
Message-ID: <CAF6AEGuMN23hxe1+PES-F0rgXDnxi48OfbdHKasPGVnbFvQ8rw@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: Make things less spammy under memory pressure
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Clark <robdclark@chromium.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
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

On Tue, May 31, 2022 at 3:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-05-31 22:51, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Ratelimit the error msg to avoid flooding the console.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   kernel/dma/debug.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index f8ff598596b8..683966f0247b 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
> >
> >       rc = active_cacheline_insert(entry);
> >       if (rc == -ENOMEM) {
> > -             pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
> > +             pr_err_ratelimited("cacheline tracking ENOMEM, dma-debug disabled\n");
> >               global_disable = true;
>
> Given that it's supposed to disable itself entirely if it ever gets
> here, just how spammy is it exactly?

um, quite..  tbf that was in the context of a WIP igt test for
shrinker which was trying to cycle thru ~2x RAM size worth of GEM
buffers on something like 72 threads.  So it could just be threads
that had gotten past the dma_debug_disabled() check already before
global_disable was set to true?

I guess this could be pr_err_once() instead, then?

BR,
-R

> Thanks,
> Robin.
>
> >       } else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> >               err_printk(entry->dev, entry,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
