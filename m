Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4FCC433E1
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 14:20:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF67820639
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 14:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dV/u8lgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF67820639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B150A876A0;
	Wed, 19 Aug 2020 14:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MonQcLkH0fK; Wed, 19 Aug 2020 14:20:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EFE1286E88;
	Wed, 19 Aug 2020 14:20:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1AF1C07FF;
	Wed, 19 Aug 2020 14:20:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B294DC0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 14:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9954D8780D
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 14:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8t0Kj11meg3W for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 14:20:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DF4CB876A0
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 14:20:04 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id cq28so18258414edb.10
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Js4y14Ghs6Bq4zdQYDVHKruVAGVzHlKISQN4bMebSg=;
 b=dV/u8lgzRJf9R13RTyQNVA0z7K0gpop908KdbH7mh1lom7wOwawyDuMH4lJJUnAt3N
 ER1Hz91rD7vCxhZyzb6LHpsKYbaB2LKK6Ns95j0nfjmJX5hZXauljIjL3//YJqgWaxRv
 97QHf+SgHVXKKphnPxr8+LnwmzFET6Ce2ARqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Js4y14Ghs6Bq4zdQYDVHKruVAGVzHlKISQN4bMebSg=;
 b=CyUjBjzwmjkALysc08YWwR9A+/JjvlNQiRDnoXvPNKdrZ+xDgxP5p0RUbz2L0TQW1R
 Yi7lyFF42yqWzc/qwAdUtLqFE5Y50EH+HpaFhn0IHdJd1kLMQvIZzKuTl49uvzfPJxD1
 PVfZSbQolX9139rp1lQF99KLH3W3Qw/Hi8ioCh/Wi9YEy3e1oKykow9gotfDMJvWBEy9
 pD7hDBfvi4Mqkt3z9W8lYBqYBNVwxHkz3/2lFEwWxrfEBiCv/pj1ev0sXSOFADzxXbWF
 yVowG17dzTRblcOEsWEMs/Kk8y6YC233bM02BpOQs3YnSdgiEdYJCSLMI+facuZ5J5Z+
 2LwQ==
X-Gm-Message-State: AOAM530Bd8FQey32OpsS55ODJdHbtJhSvUrKVyHg4orYaw/E/yW1a1Uf
 W3lENju/n98bielmh076wijYvRbiHoSMEg==
X-Google-Smtp-Source: ABdhPJyN1PUus8rImoP279gAxXi2a+B1mNIY2w7dqOaHLcXRM+wL7NJYqGmNZ6M2+LoDA4x7BG2wmw==
X-Received: by 2002:aa7:da0e:: with SMTP id r14mr25294080eds.236.1597846803077; 
 Wed, 19 Aug 2020 07:20:03 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41])
 by smtp.gmail.com with ESMTPSA id eb11sm12706369edb.76.2020.08.19.07.20.02
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 07:20:02 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id 88so21726673wrh.3
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 07:20:02 -0700 (PDT)
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr24104550wrn.385.1597846328915; 
 Wed, 19 Aug 2020 07:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <62e4f4fc-c8a5-3ee8-c576-fe7178cb4356@arm.com>
 <CAAFQd5AcCTDguB2C9KyDiutXWoEvBL8tL7+a==Uo8vj_8CLOJw@mail.gmail.com>
 <20200819135738.GB17098@lst.de>
In-Reply-To: <20200819135738.GB17098@lst.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 19 Aug 2020 16:11:52 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BvpzJTycFvjntmX9W_d879hHFX+rJ8W9EK6+6cqFaVMA@mail.gmail.com>
Message-ID: <CAAFQd5BvpzJTycFvjntmX9W_d879hHFX+rJ8W9EK6+6cqFaVMA@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To: Christoph Hellwig <hch@lst.de>
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Aug 19, 2020 at 3:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 19, 2020 at 02:49:01PM +0200, Tomasz Figa wrote:
> > With the default config it doesn't, but with
> > CONFIG_DMA_NONCOHERENT_CACHE_SYNC enabled it makes dma_pgprot() keep
> > the pgprot value as is, without enforcing coherence attributes.
>
> Which isn't selected on arm64, and that is for a good reason.
>
> > AFAIK dma_cache_sync() isn't the only way to perform the cache
> > synchronization.
>
> Yes, it is the only documented way to do it.  And if you read the whole
> series instead of screaming you'd see that it provides a proper way
> to deal with non-coherent memory which will also work with arm64.
> instead of screaming
>

I'm sorry if I have offended you in any way, but would also appreciate
it if a less aggressive tone was directed towards me as well.

I have valid reasons to object to this patch, as stated in my previous
emails. The fact that the original feature has problems is of course
another story and, as I mentioned too, I'm willing to look into fixing
them.

I'm of course happy to review the rest of the series and even more
happy to help migrating this code to whatever is added there, as long
as the functionality is preserved.

> > By the way, as a videobuf2 reviewer, I'd appreciate being CC'd on any
> > series related to the subsystem-facing DMA API changes, since
> > videobuf2 is one of the biggest users of it.
>
> The cc list is too long - I cc lists and key maintainers.  As a reviewer
> should should watch your subsystems lists closely.

Well, I guess we can disagree on this, because there is no clear
policy. I'm listed in the MAINTAINERS file for the subsystem and I
believe the purpose of the file is to list the people to CC on
relevant patches. We're all overloaded with work and having to look
through the huge volume of mailing lists like linux-media doesn't help
and thus I'd still appreciate being added on CC.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
