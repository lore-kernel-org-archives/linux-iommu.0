Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4AFC433E0
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:14:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E6C23118
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E6C23118
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 55D20273D3;
	Thu,  7 Jan 2021 14:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKQ1YSn8iRPA; Thu,  7 Jan 2021 14:14:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C31AE204E3;
	Thu,  7 Jan 2021 14:14:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6D87C088B;
	Thu,  7 Jan 2021 14:14:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A3F2C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 51ED28736F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kolfXIkFLUIz for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 14:14:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com
 [209.85.166.170])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 084EA87367
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:14:22 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id b10so4839890ilr.4
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 06:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5EKjm5VT/QdJn/B1BYcuiBIUG9oQpN1/AMx3O8ZLC64=;
 b=LF4UpleR6FsIZbyEpjiLbQPE887zOCnrGlHR7ccv+cu7FlMU1Yo0SbefHfeSAgdlMR
 Ldk5bvNrxJgg/hf9f0gZ+xMoDsCQ22tTW1nM1jLgelWwGVg4lSQdm+o+adk3MQZrjP26
 oyA4A0yU9yq7NCGzqcSM5ysirka/OI141IFrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5EKjm5VT/QdJn/B1BYcuiBIUG9oQpN1/AMx3O8ZLC64=;
 b=Wda1eRo4fOfGFLw8T9CUPyIhefY0iiRIeziF8cDluqyYp3Ha0pFlVVbJgrrf4pZQG5
 3E1Lv01OZtnZM2eVwRm98ZA6/+e91rhVB6zvoxB27saq3/3JcU/jY0E4rZxFujKiaZ4j
 tRjacOaghpMiRSBqViV5QLY0EJSAmns6/all7xS7HTtU5OyFkTmFXSOXhmUiRLhCGVDb
 bYkWteEToBEpV/orvQY9nQkLZwLuHfpwsE35LHhEXBScBefUm8hTGdIIiLhQf/yguqU6
 8GtOlJZVQ4ZbCzmaEC0SSs91yUrgLeqos1yM4lxy3dOKeA6tT8M6zCZgoa3F4LxqIQJY
 xU7w==
X-Gm-Message-State: AOAM5300KhmsxNEIYw8kBRhPNhE8TDsatX4nUzl6LyutO8lV5+h0nvqz
 YKoFq2g/iUrCLddRTMjPDww4hK3ybmQ/EQ==
X-Google-Smtp-Source: ABdhPJy+hWbqjgLfJhmSHRK1vq8lSI8qgBMxhY86fVdPQcnSzqTGvbAB4rjVHMGObr59DQjqAYUHCA==
X-Received: by 2002:a05:6e02:8aa:: with SMTP id
 a10mr9003820ilt.157.1610028861123; 
 Thu, 07 Jan 2021 06:14:21 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com.
 [209.85.166.49])
 by smtp.gmail.com with ESMTPSA id c15sm4367047ils.87.2021.01.07.06.14.19
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jan 2021 06:14:19 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id 81so6209021ioc.13
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 06:14:19 -0800 (PST)
X-Received: by 2002:a6b:cd02:: with SMTP id d2mr1461830iog.4.1610028858785;
 Thu, 07 Jan 2021 06:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201208071320.GA1667627@google.com> <20201209111639.GB22806@lst.de>
In-Reply-To: <20201209111639.GB22806@lst.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 7 Jan 2021 15:14:08 +0100
X-Gmail-Original-Message-ID: <CANiDSCtsOdJUK3r_t8UNKhh7Px0ANNFJkuwM1fBgZ7wnVh0JFA@mail.gmail.com>
Message-ID: <CANiDSCtsOdJUK3r_t8UNKhh7Px0ANNFJkuwM1fBgZ7wnVh0JFA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To: ". Christoph Hellwig" <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
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

Hi Christoph

Happy new year!

On Wed, Dec 9, 2020 at 12:16 PM . Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Dec 08, 2020 at 04:13:20PM +0900, Sergey Senozhatsky wrote:
> > On (20/12/08 13:54), Tomasz Figa wrote:
> > >
> > > In any case, Sergey is going to share a preliminary patch on how the
> > > current API would be used in the V4L2 videobuf2 framework. That should
> > > give us more input on how such a helper could look.
> >
> > HUGE apologies for the previous screw up! I replied in the
> > gmail web-interface and that did not work out as expected
> > (at all, big times).
>
> Actually the previous mail was a mime multipart one, and the plain text
> version displayed just fine here.  My the gmail engineers finally learned
> something after all.
>
> > Another thing to notice is that the new API requires us to have two execution branches
> > in allocators - one for the current API; and one for the new API (if it's supported and
> > if user-space requested non-coherent allocation).
>
> So I think we do want these branches for coherent vs non-coherent as they
> have very different semantics and I do not think that hiding them under
> the same API helps people to understand those vastly different semantics.
>
> OTOH we should look into a fallback for DMA API instances that do not
> support the discontigous allocations.
>
> I think between your comments and those from Ricardo I have a good idea
> for a somewhat updated API.  I'll try to post something in the next days.

Did you have time to look into this?

No hurry, I just want to make sure that I didn't miss anything ;)

Best regards!



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
